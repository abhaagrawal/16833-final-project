function [odom] = ...
    inverse_prediction_step(start_state,end_state)
%INVERSE_PREDICTION_STEP Summary of this function goes here
%   Detailed explanation goes here
odom = end_state-start_state;
end

