% combine lidar csv files
lidar_data_1 = readmatrix('Data/2015-08-17-13-30-19/lidar_1.csv');
lidar_data_2 = readmatrix('Data/2015-08-17-13-30-19/lidar_2.csv');
lidar_data_3 = readmatrix('Data/2015-08-17-13-30-19/lidar_3.csv');
lidar_data_4 = readmatrix('Data/2015-08-17-13-30-19/lidar_4.csv');

all_lidar_data = [lidar_data_1;lidar_data_2;lidar_data_3; ...
                    lidar_data_4]; % Concatenate vertically
writematrix(all_lidar_data,'Data/2015-08-17-13-30-19/lidar_data.csv');

lidar_pts_per_timestep_1 = readmatrix('Data/2015-08-17-13-30-19/lidar_1_points_per_timestep.csv');
lidar_pts_per_timestep_2 = readmatrix('Data/2015-08-17-13-30-19/lidar_2_points_per_timestep.csv');
lidar_pts_per_timestep_3 = readmatrix('Data/2015-08-17-13-30-19/lidar_3_points_per_timestep.csv');
lidar_pts_per_timestep_4 = readmatrix('Data/2015-08-17-13-30-19/lidar_4_points_per_timestep.csv');

all_lidar_timestep = [lidar_pts_per_timestep_1;lidar_pts_per_timestep_2; ...
                        lidar_pts_per_timestep_3; lidar_pts_per_timestep_4]; % Concatenate vertically
writematrix(all_lidar_timestep,'Data/2015-08-17-13-30-19/lidar_pts_per_timestep.csv');

lidar_timestamp_1 = readmatrix('Data/2015-08-17-13-30-19/lidar_1_timestamp.csv');
lidar_timestamp_2 = readmatrix('Data/2015-08-17-13-30-19/lidar_2_timestamp.csv');
lidar_timestamp_3 = readmatrix('Data/2015-08-17-13-30-19/lidar_3_timestamp.csv');
lidar_timestamp_4 = readmatrix('Data/2015-08-17-13-30-19/lidar_4_timestamp.csv');

all_lidar_timestamp = [lidar_timestamp_1;lidar_timestamp_2; ...
                        lidar_timestamp_3; lidar_timestamp_4]; % Concatenate vertically
writematrix(all_lidar_timestamp,'Data/2015-08-17-13-30-19/lidar_timestamps.csv');