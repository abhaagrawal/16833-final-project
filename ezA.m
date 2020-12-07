%%
vo_freq = 16;
lidar_freq = 12.5;
ins_freq = 50;
gps_freq = 5;
milli = 1000000;
merge_step_size = 0.2;%0.5; %m
alpha = 0.984; % 1 == vo, 0 == lidar
close all
%% Grab Data
if ~exist('DATA_IS_LOADED','var') || ~DATA_IS_LOADED
    fprintf("Loading Data... ")
    date = "2014-06-25-16-22-15";
    [vo,vo_time,scale] = get_vo(date);
    [scans,lidar_time] = get_lidar(date,1);
    [ins,ins_time] = get_ins(date);
    [gps, gps_time] = get_gps(date);
    [first_time,first_ind] = ...
        min([vo_time(1),lidar_time(1),vo_time(1)]);
    [last_time,last_ind] = ...
        max([vo_time(end),lidar_time(end),vo_time(end)]);
    
    vo_time_s = (vo_time-first_time)/milli;
    lidar_time_s = (lidar_time-first_time)/milli;
    ins_time_s = (ins_time-first_time)/milli;
    gps_time_s = (gps_time-first_time)/milli;
    DATA_IS_LOADED = 1;
    fprintf("Done!\n")
    
    vo(:,4:6) = vo(:,4:6)/scale; % Remove scaling from rotation values
    %vo_state = odometryToState([0,0,0,0,0,-pi/2]',vo);
    vo_state = odometryToState(zeros(6,1),vo);
    vo_state(1:3,:) = vo_state(1:3,:)/scale; % Remove scaling from translation values
    vo(:,1:3) = vo(:,1:3)/scale;
end
%% ??????

% How close lidar and vo need to be to count as same time
vo_lidar_time_epsilon = 2*abs((1/vo_freq) - (1/lidar_freq));
gps_lidar_time_epsilon = 2*abs((1/gps_freq) - (1/lidar_freq));
ins_lidar_time_epsilon = 2*abs((1/ins_freq) - (1/lidar_freq));

next_lidar_scan_index = 1;
global_pointcloud = [];

% Lidar starts before vo, bypass early measuremnts
while lidar_time_s(next_lidar_scan_index) < vo_time_s(1)
    next_lidar_scan_index = next_lidar_scan_index + 1;
end
initial_lidar_scan_index = next_lidar_scan_index;

% Keep track of state since vo and lidar last aligned
state_at_last_sync = [];
vo_index_at_last_sync = [];
state_at_each_timestep = [];
error = [];
lidar_state = [];
last_gps_idx = 1;
nan_flag = 0;

%disp(vo_state(:,end))
% Loop through each vo state
for i = 1:size(vo_state,2)-1
%for i = 1:2
    
    if next_lidar_scan_index > size(scans,1)
        new_state_estimate = state_at_last_sync + vo_state(:,i) - vo_state(:,i-1);
        %prediction_step(state_at_last_sync,[],vo_stat);
        state_at_each_timestep = [state_at_each_timestep,new_state_estimate];
        state_at_last_sync = new_state_estimate;
%         for j = last_gps_idx:size(gps_time,1)
%             %disp(gps_time(j) - vo_time(j))
%             if (abs(gps_time_s(j) - vo_time_s(i)) < gps_lidar_time_epsilon)
%                 error = [error ; norm((ins(1:3,j)-ins(1:3,1))-new_state_estimate(1:3,1))];
%                 %error = [error ; norm((gps(1:3,j)-gps(1:3,1))-new_state_estimate(1:3,1))];
%                 last_gps_idx = j+1;
%                 break;
%             end
%         end
        continue;
    end
    
    % If vo_time in s is close to next lidar scan
    if abs(vo_time_s(i) - lidar_time_s(next_lidar_scan_index)) < vo_lidar_time_epsilon    
        vo_index_at_last_sync = i;
        % IF first time set global point cloud to new scan
        if next_lidar_scan_index == initial_lidar_scan_index
            % Calculate transform to global frame for lidar scan from vo
            R = eul2rotm(vo_state(4:6,i)');
            T = vo_state(1:3,i);
            aff = eye(4);
            aff(1:3,1:3) = R;
            aff(4,1:3) = T;
            vo_aff3d = affine3d(aff);    
            % Transform lidar scan to global frame
            state_at_last_sync = vo_state(:,i);% + [0,0,0,0,0,-pi/2]'
            
            new_points_global = ...
                pctransform(scans{next_lidar_scan_index},vo_aff3d);
            global_pointcloud = new_points_global;
            next_lidar_scan_index = next_lidar_scan_index + 1;
            continue
        end
    % Else merge into global pointcloud

        % COMPLEMENTARY FILTER
        % Get transform from lidar
        % Get diff in state from last sync via vo

        %vo_state_diff = state_at_last_sync - vo_state(:,i);
        vo_state_diff = vo_state(:,i) - vo_state(:,vo_index_at_last_sync) ;
%          vo_state_diff = zeros(6,1);
%          for j = vo_index_at_last_sync:i-1
%              vo_state_diff = prediction_step(vo_state_diff,[],...
%                  vo(j,:)');
%          end

        % Get diff in state from last sync via lidar
        rig3d = pcregistericp(global_pointcloud, scans{next_lidar_scan_index});
        lidar_state_diff = [rig3d.Translation rotm2eul(rig3d.Rotation)]';
        
        lidar_state = [lidar_state,lidar_state_diff];

        % Apply filter
        comp = alpha*vo_state_diff + (1-alpha)*lidar_state_diff;

        % Predict our new state
        new_state_estimate = ...
            prediction_step(state_at_last_sync,[],comp);

        % Create affine3d transformation
        R = eul2rotm(new_state_estimate(4:6,1)');
        T = new_state_estimate(1:3,1);
        aff = eye(4);
        aff(1:3,1:3) = R;
        aff(4,1:3) = T;
        comp_aff3d = affine3d(aff);    

        % Trasnform scan to global coords
        new_points_global = ...
            pctransform(scans{next_lidar_scan_index},vo_aff3d);

        % Update global pointcloud
        global_pointcloud = ...
             pcmerge(global_pointcloud,new_points_global,merge_step_size);

        % Update last
        state_at_last_sync = new_state_estimate;
        state_at_each_timestep = [state_at_each_timestep ,new_state_estimate];
        
        % Compare with GPS data
        for j = last_gps_idx:size(gps_time,1)
            %disp(gps_time(j) - vo_time(j))
            if (abs(gps_time_s(j) - vo_time_s(i)) < gps_lidar_time_epsilon)
                %error = [error ; norm((ins(1:3,j)-ins(1:3,1))-new_state_estimate(1:3,1))];
                error = [error ; norm((gps(1:3,j)-gps(1:3,1))-new_state_estimate(1:3,1))];
                last_gps_idx = j+1;
                break;
            end
        end

        % Update next scan
        next_lidar_scan_index = next_lidar_scan_index + 1;
        
        % If there are not more scans then break
%         if next_lidar_scan_index > size(scans,1)
%             break
%         end
    end
end

pcshow(global_pointcloud)
disp(error)
visualize_two_state(ins, state_at_each_timestep,"error");

