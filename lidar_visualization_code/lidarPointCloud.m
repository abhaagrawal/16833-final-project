timestamp = '1447410491783624';
directory_path = '/Users/obiadubor/Desktop/Fall 20/Robot Localization & Mapping/Capstone/code/data/2015-11-13/2015-11-13-10-28-08/ldmrs';
pointcloud = LoadVelodyneBinary(directory_path, timestamp);
% size(pointcloud)
x_point_coords = pointcloud(1,:);
y_point_coords = pointcloud(2,:);
z_point_coords = pointcloud(3,:);
% ray_levels = csv_pointcloud(3,:);

% hold on 
% scatter(x_point_coords, y_point_coords,1)
% scatter3(x_point_coords, y_point_coords,z_point_coords,1);
xlabel('x');
ylabel('y');
zlabel('z');
PlayVelodyne(directory_path, 'bin_ptcld');
