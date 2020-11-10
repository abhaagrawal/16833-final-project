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
pos = zeros(4,size(vo,1)+1);
rot = eye(3);

%%
for i = 1:size(vo,1)
    H = [rot vo(i,1:3)'; 0 0 0 1];
    pos(:,i+1) = H * pos(:,i);
    rot = rotz(rad2deg(vo(i,6)))...
        * roty(rad2deg(vo(i,5)))...
        * rotx(rad2deg(vo(i,4))) * rot;
end

plot3(state(1,:),state(2,:),state(3,:))

% Limit axis
ylim(xlim-(sum(xlim)/2));
xlim(xlim-(sum(xlim)/2));

