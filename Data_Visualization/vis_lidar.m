addPaths
if ~exist('date','var')
    date = "2014-06-25-16-22-15";
end
scans = get_lidar(date,1);

%% Construct odom
num_scans = size(scans,1);
odom = zeros(num_scans-1,6); % [tx ty tz rx ry rz]
for i = 1:size(odom,1)
    rig3d = pcregistericp(scans{i+1},scans{i});
    eul = rotm2eul(rig3d.Rotation,'XYZ');
    odom(i,:) = [rig3d.Translation eul];
end
state = odometryToState(zeros(6,1),odom);
visualize_state(state,"lidar");

if(0)
figure
min = 1;
max = 2;
x = 1;
y = 2;
z = 3;
largest_limits = zeros(3,2);
largest_limits(:,max) = -inf;
largest_limits(:,min) =  inf;
cur_limits = zeros(3,2);
for i = 1:size(scans,1)
    fprintf("Point Cloud %d\n",i);
    pcshow(scans{i});
    xlabel("X")
    ylabel("Y")
    zlabel("Z")
    drawnow
    
    cur_limits(x,:) = xlim;
    cur_limits(y,:) = ylim;
    cur_limits(z,:) = zlim;
    for i = 1:3
        if cur_limits(i,min) < largest_limits(i,min)
            largest_limits(i,min) = cur_limits(i,min);
        end
        if cur_limits(i,max) > largest_limits(i,max)
            largest_limits(i,max) = cur_limits(i,max);
        end
    end
    xlim(largest_limits(x,:));
    ylim(largest_limits(y,:));
    zlim(largest_limits(z,:));
    
    % Use largest limits
    
end
end