%% Test 1: Predict & Inerse Predict
start_state = [5 5 5 0 0 0]';
odom = [1 2 3 pi pi 0]';
odom_expected = [1 2 3 0 0 pi]';
end_state_expected = [6 7 8 0 0 pi]';
end_state_experimental = prediction_step(start_state,[],odom);
odom_experimental = ...
    inverse_prediction_step(start_state,end_state_experimental);
assert(all(odom_expected == odom_experimental))
assert(all(end_state_expected == end_state_experimental))

disp("Kalman Unit Tests: Passed")