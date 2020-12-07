%% Sanity Check: Make sure it runs
date = "2014-06-25-16-22-15";
get_ins(date);
get_vo(date);
get_lidar(date,0);
get_lidar(date,1);
get_gps(date);

disp("Data Acquisition Unit Tests: Passed")