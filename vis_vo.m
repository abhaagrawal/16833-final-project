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


%%
pos = zeros(4,size(vo,1)+1);
rot = eye(3);
for i = 1:size(vo,1)
    H = [rot zeros(3,1); zeros(1,3) 1];
    pos(:,i+1) = pos(:,i) + H * [vo(i,1:3) 1]';
    %pos(:,i+1) = H * pos(:,i);
    rot = rotz(rad2deg(vo(i,6)/scale))...
        * roty(rad2deg(vo(i,5)/scale))...
        * rotx(rad2deg(vo(i,4)/scale)) * rot;
    
    %plot3(pos(1,1:i),pos(2,1:i),pos(3,1:i))
    %grid on
    %xlabel("X")
    %ylabel("Y")
    %zlabel("Z")
    %pause(0.001)
end

plot3(pos(1,:),pos(2,:),pos(3,:))
grid on
xlabel("X")
ylabel("Y")
zlabel("Z")
% Limit axis
%ylim(xlim-(sum(xlim)/2));
%xlim(xlim-(sum(xlim)/2));
%
