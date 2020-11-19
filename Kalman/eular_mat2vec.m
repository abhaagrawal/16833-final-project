function [vec] = eular_mat2vec(rot)
%EULAR_MAT2VEC Get aular angles from a rotation matrix
%   Returns roll, pith, yaw. x points forward z points up
%   Equations taken from http://planning.cs.uiuc.edu/node103.html
alpha = atan2(rot(2,1),rot(1,1));
beta = atan2(-rot(3,1),sqrt(rot(3,2)^2 + rot(3,3)^2));
gamma = atan2(rot(3,2),rot(3,3));
vec = [gamma beta alpha];
end

