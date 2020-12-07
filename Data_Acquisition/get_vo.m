function [vo,time,vo_scale] = get_vo(date)
%GET_VO Returns visual odometry information scaled by vo_scale
% [vo,time,vo_scale] = get_vo(date)
% vo is num_vo x 6
% time is num_vo x 1
% vo_scale is the amount that vo is multiplied by
addPaths
assert(nargin == 1, "Please provide a date")
%data_dir = "..\data\2015-11-13-10-28-08_vo\2015-11-13-10-28-08\vo\";
if contains(system_dependent('getos'),"Windows")
    data_dir = sprintf("Data\\%s\\",date);
else
    data_dir = sprintf("Data/%s/",date);
end
coord_doc = "vo-coord.csv";
time_doc = "vo-time.csv";
scaled_coord_doc = "vo-coord-scaled.csv";
zero_origin_time_doc = "vo-time-zero-origin.csv";
zero_origin_time_scaled_doc = "vo-time-zero-origin-scaled.csv";
vo_scale = 10000;

coord_path = strcat(data_dir,coord_doc);
time_path = strcat(data_dir,time_doc);
scaled_coord_path = strcat(data_dir,scaled_coord_doc);
zero_origin_time_path = strcat(data_dir,zero_origin_time_doc);
zero_origin_time_scaled_path = strcat(data_dir,zero_origin_time_scaled_doc);
% Call python script to scale the data
system(strcat("python Pre_Processing/csv_scale.py ",coord_path,...
    " ",string(vo_scale)," -o ",scaled_coord_path));

time_scale = 1000000;
% Call python script to zero origin the data
%assert(system(strcat("python Pre_Processing/csv_zero_origin.py ",time_path,...
%    " -o ",zero_origin_time_path)) == 0);

% Call python script to scale origin the data
%assert(system(strcat("python Pre_Processing/csv_scale.py ",zero_origin_time_path,...
%    " ",string(time_scale)," -o ",zero_origin_time_scaled_path,...
%    " --div ")) == 0);
% time = readmatrix(zero_origin_time_scaled_doc);

vo = readmatrix(scaled_coord_path);
time = readmatrix(time_path);

end

