function [scans] = get_lidar(use_raw)
% GET_LIDAR Returns the lidar data
%       Points is of type cell
%       Points has dimension num_scans x 1
%       Each entry in points is a pointcloud
if nargin < 1
    use_raw = false;
end

data_dir = "robotcar-dataset-sdk-3.1\python\";
if use_raw
    xyz_doc = "2014-05-06-12-54-54.csv";
else
    xyz_doc = "2014-05-06-12-54-54_icp.csv";
end
pts_per_time_doc = "2014-05-06-12-54-54_points_per_timestep.csv";

xyz_path = strcat(data_dir,xyz_doc);
pts_per_time_path = strcat(data_dir,pts_per_time_doc);

xyz = readmatrix(xyz_path);
if use_raw
    xyz = xyz';
    xyz = xyz(:,1:3);
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

end