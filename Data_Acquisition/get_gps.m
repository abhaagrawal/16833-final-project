function [gps,time,time_scale] = get_gps(date)
%GET_INS Get gps and inertial solution
%   INS is absolute positions
%   [ins,time] = get_ins()
%   ins is 6 x num_states
%   time is num_states x 1
assert(nargin == 1, "Please provide a date")
if contains(system_dependent('getos'),"Windows")
    data_dir = sprintf("Data\\%s\\",date);
else
    data_dir = sprintf("Data/%s/",date);
end
coord_doc = "gps-pose.csv";
time_doc = "gps-time.csv";
zero_origin_time_doc = "gps-time-zero-origin.csv";
zero_origin_time_scaled_doc = "gps-time-zero-origin_scaled.csv";
time_path = strcat(data_dir,time_doc);
coord_path = strcat(data_dir,coord_doc);
zero_origin_time_path = strcat(data_dir,zero_origin_time_doc);
zero_origin_time_scaled_path = strcat(data_dir,zero_origin_time_scaled_doc);
time_scale = 1000000;
% Call python script to zero origin the data
% assert(system(strcat("python Pre_Processing/csv_zero_origin.py ",time_path,...
%     " -o ",zero_origin_time_path)) == 0);
% 
% % Call python script to scale origin the data
% assert(system(strcat("python Pre_Processing/csv_scale.py ",zero_origin_time_path,...
%     " ",string(time_scale)," -o ",zero_origin_time_scaled_path,...
%     " --div ")) == 0);

% time = readmatrix(zero_origin_time_scaled_doc);
gps = readmatrix(coord_path)';

time_scale = 1;
time = readmatrix(time_path);
end

