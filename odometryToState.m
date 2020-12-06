function [state] = odometryToState(initial_state,odom)
%ODOMETRYTOSOLUTION takes in odometry and returns a state vector
%   [state] = odometryToState(initial_state,odom)
%
%   State is in [tx ty tz rx ry rz]'
%   State is 6 x num_odom+1
%   Odom is in [tx ty tz rx ry rz]'
%   Odom is num_odom x 6
    state = zeros(6,size(odom,1)+1);
    state(:,1) = initial_state;
    for i = 1:size(odom,1)
        meas = odom(i,:);
        state(:,i+1) = prediction_step(state(:,i),[],meas');
    end
end