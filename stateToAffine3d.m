function [aff3d] = stateToAffine3d(state)
%STATETOAFFINE3D Turns a 6 x 1 state into an affine3d object
%   state == [x y z rx ry rz]
assert(all(size(state) == [6 1]),"State must be 6 x 1");

R = eul2rotm(state(4:6,1)');
T = state(1:3,1);
aff = eye(4);
aff(1:3,1:3) = R;
aff(4,1:3) = T;
aff3d = affine3d(aff);    
end

