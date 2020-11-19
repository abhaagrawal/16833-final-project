%% Unit Tests
%   Script to house tests for files in this folder
%   If it runs till completion then all tests passed
%% Test prediction_step
x = [0 0 0 0 0 0]';
m = [1 2 3 0 0 0]';
nx = [1 2 3 0 0 0]';
ax = prediction_step(x,[],m);
assert(all(eq(nx,ax)));

x = [0 0 0 0 0 pi]'; %rotz(180)
m = [1 2 3 0 0 0]';
nx = [-1 -2 3 0 0 pi]';
ax = prediction_step(x,[],m);
assert(all(eq(nx,ax)));

%% Test that eular_mat2vec is inverse of eylar_xyz
xyz = [0 0 0];
eular_mat2vec(eular_xyz(xyz(1),xyz(2),xyz(3)));
assert(all(eq(xyz,eular_mat2vec(eular_xyz(xyz(1),xyz(2),xyz(3))))))
xyz = [1 0 0];
eular_mat2vec(eular_xyz(xyz(1),xyz(2),xyz(3)));
assert(all(eq(xyz,eular_mat2vec(eular_xyz(xyz(1),xyz(2),xyz(3))))))
xyz = [0 1 0];
eular_mat2vec(eular_xyz(xyz(1),xyz(2),xyz(3)));
assert(all(eq(xyz,eular_mat2vec(eular_xyz(xyz(1),xyz(2),xyz(3))))))
xyz = [0 0 1];
eular_mat2vec(eular_xyz(xyz(1),xyz(2),xyz(3)));
assert(all(eq(xyz,eular_mat2vec(eular_xyz(xyz(1),xyz(2),xyz(3))))))
xyz = [1 -1 1];
eular_mat2vec(eular_xyz(xyz(1),xyz(2),xyz(3)));
assert(all(eq(xyz,eular_mat2vec(eular_xyz(xyz(1),xyz(2),xyz(3))))))
disp("All tests passed!");