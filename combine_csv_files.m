% combine lidar csv files
lidar_data_1 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_1.csv');
lidar_data_3 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_3.csv');
lidar_data_4 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_4.csv');
lidar_data_5 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_5.csv');
lidar_data_6 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_6.csv');
lidar_data_7 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_7.csv');

all_lidar_data = [lidar_data_1;lidar_data_3;lidar_data_4; ...
                    lidar_data_5; lidar_data_6; lidar_data_7]; % Concatenate vertically
csvwrite('Data/lidar_data', all_lidar_data);

lidar_pts_per_timestep_1 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_1_points_per_timestep.csv');
lidar_pts_per_timestep_3 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_3_points_per_timestep.csv');
lidar_pts_per_timestep_4 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_4_points_per_timestep.csv');
lidar_pts_per_timestep_5 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_5_points_per_timestep.csv');
lidar_pts_per_timestep_6 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_6_points_per_timestep.csv');
lidar_pts_per_timestep_7 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_7_points_per_timestep.csv');

all_lidar_timestep = [lidar_pts_per_timestep_1;lidar_pts_per_timestep_3; ...
                        lidar_pts_per_timestep_4; lidar_pts_per_timestep_5; ...
                        lidar_pts_per_timestep_6; lidar_pts_per_timestep_7]; % Concatenate vertically
csvwrite('Data/lidar_pts_per_timestep', all_lidar_timestep);

lidar_timestamp_1 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_1_timestamp.csv');
lidar_timestamp_3 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_3_timestamp.csv');
lidar_timestamp_4 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_4_timestamp.csv');
lidar_timestamp_5 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_5_timestamp.csv');
lidar_timestamp_6 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_6_timestamp.csv');
lidar_timestamp_7 = csvread('Data/2015-11-13-10-28-08/2015-11-13-10-28-08_6_timestamp.csv');

all_lidar_timestamp = [lidar_timestamp_1;lidar_timestamp_3; ...
                        lidar_timestamp_4; lidar_timestamp_5; ...
                        lidar_timestamp_6; lidar_timestamp_7]; % Concatenate vertically
csvwrite('Data/lidar_timestamps', all_lidar_timestamp);