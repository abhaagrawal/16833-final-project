%% visualize gps ins
% Shows gps inertial solution data
date = "2014-06-25-16-22-15";
[gps,time] = get_gps(date);
visualize_state(gps,"gps_ins");