function [vo,time,vo_scale] = get_vo()
%GET_VO Returns visual odometry information scaled by vo_scale
addPaths
data_dir = "..\data\2015-11-13-10-28-08_vo\2015-11-13-10-28-08\vo\";
coord_doc = "vo-coord.csv";
time_doc = "vo-time.csv";
scaled_coord_doc = "vo-coord-scaled.csv";
zero_origin_time_doc = "vo-time-zero-origin.csv";
zero_origin_time_scaled_doc = "vo-time-zero-origin-scaled.csv";
vo_scale = 10000;
time_scale = 1000000;
coord_path = strcat(data_dir,coord_doc);
time_path = strcat(data_dir,time_doc);
% Call python script to scale the data
system(strcat("python Pre_Processing/csv_scale.py ",coord_path,...
    " ",string(vo_scale)," -o ",scaled_coord_doc));

% Call python script to zero origin the data
system(strcat("python Pre_Processing/csv_zero_origin.py ",time_path,...
    " -o ",zero_origin_time_doc));

% Call python script to scale origin the data
system(strcat("python Pre_Processing/csv_scale.py ",zero_origin_time_doc,...
    " ",string(time_scale)," -o ",zero_origin_time_scaled_doc,...
    " --div "));

vo = readmatrix(scaled_coord_doc);
time = readmatrix(zero_origin_time_scaled_doc);
end

