%% Grab Data
date = "2014-06-25-16-22-15";
[vo,vo_time,scale] = get_vo(date);
scans = get_lidar(date,1);

%% Calculate Vo State
vo(:,4:6) = vo(:,4:6)/scale; % Remove scaling from rotation values
state = odometryToState(zeros(6,1),vo);
vo_state(1:3,:) = state(1:3,:)/scale; % Remove scaling from translation values

num_scans = size(scans,1);