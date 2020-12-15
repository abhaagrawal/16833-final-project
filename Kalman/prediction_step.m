function [next_state] = prediction_step(state,covariance,meas)
%PREDICTION_STEP Predict the next step given a state and a VO measurement
%   Translate then rotate

% Current state
pos = state(1:3,1);
state_rotx = state(4,1);
state_roty = state(5,1);
state_rotz = state(6,1);
%rot = eular_xyz(state_rotx,state_roty,state_rotz);
rot = eul2rotm(state(4:6,1)',"XYZ");
% State update from measurement
delta_pos = meas(1:3,1);
delta_rotx = meas(4,1);
delta_roty = meas(5,1);
delta_rotz = meas(6,1);
%delta_rot = eular_xyz(delta_rotx,delta_roty,delta_rotz);
delta_rot = eul2rotm(meas(4:6,1)',"XYZ");
next_state = zeros(6,1);

% Calculate next step
next_state(1:3) = pos + rot * delta_pos;
next_state(4:6) = rotm2eul(delta_rot * rot, "XYZ");
end

