%% visualize visual odometry
if ~exist('date','var')
    date = "2014-06-25-16-22-15";
end
[vo,vo_time,scale] = get_vo(date);


%% Calculate
vo(:,4:6) = vo(:,4:6)/scale; % Remove scaling from rotation values
state = odometryToState(zeros(6,1),vo');
pos = state(1:3,:)/scale; % Remove scaling from translation values
vo_state(1:3,:) = state(1:3,:)/scale;
visualize_state(pos,"vo");