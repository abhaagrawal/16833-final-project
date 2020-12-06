%% visualize gps ins
% Shows gps inertial solution data
[ins,time] = get_ins();
visualize_state(ins,"gps_ins")