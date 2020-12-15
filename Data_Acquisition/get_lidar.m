function [scans,time] = get_lidar(date,use_raw)
% GET_LIDAR Returns the lidar data
%       [scans,time] = get_lidar(date,use_raw)
%       Points is of type cell
%       Points has dimension num_scans x 1
%       Each entry in points is a pointcloud
%       Time is num_scans x 1
assert(nargin >= 1, "Please provide a date")
if nargin < 2
    use_raw = false;
end

if contains(system_dependent('getos'),"Windows")
    data_dir = sprintf("Data\\%s\\",date);
else
    data_dir = sprintf("Data/%s/",date);
end
if use_raw
    xyz_doc = "lidar.csv";
else
    xyz_doc = "lidar_icp.csv";
end
time_doc = "lidar_timestamps.csv";
pts_per_time_doc = "lidar_points_per_timestep.csv";

xyz_path = strcat(data_dir,xyz_doc);
time_path = strcat(data_dir,time_doc);
pts_per_time_path = strcat(data_dir,pts_per_time_doc);

xyz = readmatrix(xyz_path);
if use_raw
    if size(xyz,1)<size(xyz,2)
        xyz = xyz';
    end
    xyz = xyz(:,1:3);
    assert(size(xyz,1)>size(xyz,2),"Expect each row to be an entry");
end
pts_per_time = readmatrix(pts_per_time_path);
num_scans = numel(pts_per_time);
scans = cell([num_scans 1]);

% Seperate xyz into 1 pointcloud per timestep
cur_index = 1;
for i = 1:num_scans
    next_index = cur_index+pts_per_time(i);
    scans{i,1} = pointCloud(xyz(cur_index:next_index-1,:));
    cur_index = next_index;
end

time = readmatrix(time_path);

% There is an error in the first scan
milli = 1000000;
ld = time(2:end) - time(1:end-1);
ld = ld/milli;
%assert(all(ld > 0))
%assert(any(~[ld > 1]))
if eq(date,"2015-11-13-10-28-08")
time = time(2:end);
scans = scans(2:end,1);
end
end