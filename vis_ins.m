%% visualize gps ins
[ins,time] = get_ins();
pos = ins';

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
title("3D view of path from gps-inertial ")

fig_xy = figure;
plot(pos(2,:),pos(1,:))
hold on
plot(pos(2,1),pos(1,1),'go')
plot(pos(2,end),pos(1,end),'ro')
hold off;
legend("Path","Start","Finish")
legend('Location','southwest')
xlabel("X (m)")
ylabel("Y (m)")
title("Car Path from INS. Top View")

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
title("Car Path from INS. Side view (looking in +y direction)")

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
%close all