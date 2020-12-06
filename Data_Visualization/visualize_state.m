function visualize_state(state,name)
%visualize_state Creates plots of a state vector
%   State is in [tx ty tz rx ry rz]'
%   State is 6 x num_odom+1

max_dim = max(state(1:3,:),[],'all');
min_dim = min(state(1:3,:),[],'all');
%xlim([min_dim max_dim])
%ylim([min_dim max_dim])
%zlim([min_dim max_dim])
close all
fig_3d = figure;
plot3(state(1,:),state(2,:),state(3,:));
hold on;
plot3(state(1,1),state(2,1),state(3,1),'go');
plot3(state(1,end),state(2,end),state(3,end),'ro');
legend("Path","Start","Finish")
hold off
xlabel("X (m)")
ylabel("Y (m)")
zlabel("Z (m)")
grid on
title("3D view of path")
xlim([min_dim max_dim])
ylim([min_dim max_dim])
zlim([min_dim max_dim])

fig_xy = figure;
plot(state(2,:),state(1,:))
hold on
plot(state(2,1),state(1,1),'go')
plot(state(2,end),state(1,end),'ro')
hold off;
legend("Path","Start","Finish")
legend('Location','southwest')
xlabel("X (m)")
ylabel("Y (m)")
title("Car Path. Top View")

fig_xz = figure;
plot(state(1,:),state(3,:))
hold on
plot(state(1,1),state(3,1),'go')
plot(state(1,end),state(3,end),'ro')
hold off
legend("Path","Start","Finish")
legend('Location','northwest')
xlabel("X (m)")
ylabel("Z (m)")
title("Car Path. Side view (looking in +y direction)")

fig_yz = figure;
plot(state(2,:),state(3,:))
hold on
plot(state(2,1),state(3,1),'go')
plot(state(2,end),state(3,end),'ro')
hold off
legend("Path","Start","Finish")
xlabel("Y (m)")
ylabel("Z (m)")
title("Car Path. Side view (looking in -x direction)")

image_folder = 'images';
mkdir(image_folder);
saveas(fig_3d,strcat(image_folder,'/',name,'3d'),'fig')
saveas(fig_3d,strcat(image_folder,'/',name,'3d'),'png')
saveas(fig_xy,strcat(image_folder,'/',name,'xy'),'fig')
saveas(fig_xy,strcat(image_folder,'/',name,'xy'),'png')
saveas(fig_xz,strcat(image_folder,'/',name,'xz'),'fig')
saveas(fig_xz,strcat(image_folder,'/',name,'xz'),'png')
saveas(fig_yz,strcat(image_folder,'/',name,'yz'),'fig')
saveas(fig_yz,strcat(image_folder,'/',name,'yz'),'png')
%close all
end

