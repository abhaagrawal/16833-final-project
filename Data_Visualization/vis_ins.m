%% visualize gps ins
% Shows gps inertial solution data
if ~exist('date','var')
    date = "2014-06-25-16-22-15";
end
[ins,time] = get_ins(date);
visualize_state(ins,"gps_ins");
