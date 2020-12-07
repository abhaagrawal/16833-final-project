function visualize_two_state(state1,state2,name)
%visualize_state Creates plots of a state vector
%   State is in [tx ty tz rx ry rz]'
%   State is 6 x num_state

max_dim = max(state2(1:3,:),[],'all');
min_dim = min(state2(1:3,:),[],'all');
%xlim([min_dim max_dim])
%ylim([min_dim max_dim])
%zlim([min_dim max_dim])
close all
fig_3d = figure;
hold on;
plot3(state1(1,:),state1(2,:),state1(3,:));
plot3(state2(1,:),state2(2,:),state2(3,:),'rx');
plot3(state1(1,1),state1(2,1),state1(3,1),'go');
plot3(state1(1,end),state1(2,end),state1(3,end),'ro');
plot3(state2(1,1),state2(2,1),state2(3,1),'go');
plot3(state2(1,end),state2(2,end),state2(3,end),'ro');
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



image_folder = 'images';
mkdir(image_folder);
saveas(fig_3d,strcat(image_folder,'/',name,'3d'),'fig')
saveas(fig_3d,strcat(image_folder,'/',name,'3d'),'png')

%close all
end

