%% visualize visual odometry

data_dir = "..\data\2015-11-13-10-28-08_vo\2015-11-13-10-28-08\vo\";
coord_doc = "vo-coord.csv";
scaled_coord_doc = "vo-coord-scaled.csv";
scale = 10000;
coord_path = strcat(data_dir,coord_doc);

% Call python script to scale the data
system(strcat("python csv_scale.py ",coord_path,...
    " ",string(scale)," -o ",scaled_coord_doc));

vo = readmatrix(scaled_coord_doc);

%% Calculate
pos = zeros(4,size(vo,1)+1);
rot = eye(3);
for i = 1:size(vo,1)
    H = [rot zeros(3,1); zeros(1,3) 1];
    pos(:,i+1) = pos(:,i) + H * [vo(i,1:3) 1]';
    %pos(:,i+1) = H * pos(:,i);
    rot = rotz(rad2deg(vo(i,6)/scale))...
        * roty(rad2deg(vo(i,5)/scale))...
        * rotx(rad2deg(vo(i,4)/scale)) * rot;
end
pos = pos / scale;

%% Plot and save figures
close all
fig_3d = figure;
plot3(pos(1,:),pos(2,:),pos(3,:));
hold on;
plot3(pos(1,1),pos(2,1),pos(3,1),'go');
plot3(pos(1,end),pos(2,end),pos(3,end),'ro');
legend("Path","Start","Finish")
hold off
xlabel("X (m)")
ylabel("Y (m)")
zlabel("Z (m)")
grid on
title("3D view of path from visual odometry ")

fig_xy = figure;
plot(pos(1,:),pos(2,:))
hold on
plot(pos(1,1),pos(2,1),'go')
plot(pos(1,end),pos(2,end),'ro')
hold off;
legend("Path","Start","Finish")
legend('Location','southwest')
xlabel("X (m)")
ylabel("Y (m)")
title("Car Path from VO. Top View")

fig_xz = figure;
plot(pos(1,:),pos(3,:))
hold on
plot(pos(1,1),pos(3,1),'go')
plot(pos(1,end),pos(3,end),'ro')
hold off
legend("Path","Start","Finish")
legend('Location','northwest')
xlabel("X (m)")
ylabel("Z (m)")
title("Car Path from VO. Side view (looking in +y direction)")

fig_yz = figure;
plot(pos(2,:),pos(3,:))
hold on
plot(pos(2,1),pos(3,1),'go')
plot(pos(2,end),pos(3,end),'ro')
hold off
legend("Path","Start","Finish")
xlabel("Y (m)")
ylabel("Z (m)")
title("Car Path from VO. Side view (looking in -x direction)")

image_folder = 'images';
mkdir(image_folder);
saveas(fig_3d,strcat(image_folder,'/vo_3d'),'fig')
saveas(fig_3d,strcat(image_folder,'/vo_3d'),'png')
saveas(fig_xy,strcat(image_folder,'/vo_xy'),'fig')
saveas(fig_xy,strcat(image_folder,'/vo_xy'),'png')
saveas(fig_xz,strcat(image_folder,'/vo_xz'),'fig')
saveas(fig_xz,strcat(image_folder,'/vo_xz'),'png')
saveas(fig_yz,strcat(image_folder,'/vo_yz'),'fig')
saveas(fig_yz,strcat(image_folder,'/vo_yz'),'png')
close all
%% Plot fancy

max_dim = max(pos(1:3,:),[],'all');
min_dim = min(pos(1:3,:),[],'all');
for i = 1:size(pos,2)
    plot3(pos(1,1:i),pos(2,1:i),pos(3,1:i))
    grid on
    
    %xlim([min_dim max_dim])
    %ylim([min_dim max_dim])
    %zlim([min_dim max_dim])
    pause(0.00001)
end
% Limit axis
%ylim(xlim-(sum(xlim)/2));
%xlim(xlim-(sum(xlim)/2));
%
