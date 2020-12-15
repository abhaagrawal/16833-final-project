date = "2015-11-13-10-28-08"
for i = 3:7
    system(sprintf("move %s_%d.csv lidar_%d.csv",date,i,i))
    system(sprintf("move %s_%d_timestamp.csv lidar_%d_timestamp.csv",date,i,i))
    system(sprintf("move %s_%d_points_per_timestep.csv lidar_%d_points_per_timestep.csv",date,i,i))
end
    