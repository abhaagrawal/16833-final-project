function [ins,time,time_scale] = get_ins(date)
%GET_INS Get gps and inertial solution
%   INS is absolute positions
%   [ins,time] = get_ins()
%   ins is 6 x num_states
%   time is num_states x 1
assert(nargin == 1, "Please provide a date")
%data_dir = "..\data\2015-11-13-10-28-08_gps\2015-11-13-10-28-08\gps\";
if contains(system_dependent('getos'),"Windows")
    data_dir = sprintf("Data\\%s\\",date);
else
    data_dir = sprintf("Data/%s/",date);
end
coord_doc = "ins-pose.csv";
time_doc = "ins-time.csv";
zero_origin_time_doc = "time-zero_origin.csv";
zero_origin_time_scaled_doc = "time-zero_origin_scaled.csv";
time_path = strcat(data_dir,time_doc);
coord_path = strcat(data_dir,coord_doc);
% time_scale = 1000000;
% % Call python script to zero origin the data
% system(strcat("python Pre_Processing/csv_zero_origin.py ",time_path,...
%     " -o ",zero_origin_time_doc));
% 
% % Call python script to scale origin the data
% system(strcat("python Pre_Processing/csv_scale.py ",zero_origin_time_doc,...
%     " ",string(time_scale)," -o ",zero_origin_time_scaled_doc,...
%     " --div "));
% 
% time = readmatrix(zero_origin_time_scaled_doc);
ins = readmatrix(coord_path)';
time_scale = 1;
time = readmatrix(time_path);
end

