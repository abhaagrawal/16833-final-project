function [odom] = stateToOdometry(state)
%STATETOODOMETRY Convert state to odometry
%   [odom] = stateToOdometry(state)
%
%   state is 6 x num_states
%   odom is 6 x num_states-1
%
%   state ordering is in eular xyz
%   [tx ty tz rx ry rz]'

assert(size(state,1)==6,"State should have 6 rows");
assert(size(state,2)>=2,"State mus have atleast 2 entries");
num_states = size(state,2);

odom = state(:,2:num_states)-state(:,1:num_states-1);
end

