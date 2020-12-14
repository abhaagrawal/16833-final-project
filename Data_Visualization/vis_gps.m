%% visualize gps ins
% Shows gps inertial solution data
if ~exist('date','var')
    date = "2014-06-25-16-22-15";
end
[gps,time] = get_gps(date);
visualize_state(gps,"gps_ins");