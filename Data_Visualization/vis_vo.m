%% visualize visual odometry
if ~exist('date','var')
    date = "2014-06-25-16-22-15";
end
[vo,vo_time,scale] = get_vo(date);


%% Calculate
vo(:,4:6) = vo(:,4:6)/scale; % Remove scaling from rotation values
state = odometryToState(zeros(6,1),vo);
pos = state(1:3,:)/scale; % Remove scaling from translation values
vo_state(1:3,:) = state(1:3,:)/scale;
visualize_state(pos,"vo");
%% Plot fancy
if (0)
max_dim = max(pos(1:3,:),[],'all');
min_dim = min(pos(1:3,:),[],'all');
for i = 1:size(pos,2)
    plot3(pos(1,1:i),pos(2,1:i),pos(3,1:i))
    grid on
    
    %xlim([min_dim max_dim])
    %ylim([min_dim max_dim])
    %zlim([min_dim max_dim])
    pause(0.000001)
end
end
% Limit axis
%ylim(xlim-(sum(xlim)/2));
%xlim(xlim-(sum(xlim)/2));
%
