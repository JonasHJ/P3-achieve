function out = p2p_traj( t )

% P1 [m] Starting point
% P2 [m] Ending point
% t_f [s] Time from start to finish

P1 = [ 0, 0, 0.4978]; % Start position
P2 = [ 0.05693, 0.17521,  0.19906]; % End position

% End time
current_system = get_param(0, 'CurrentSystem');
t_f = str2double(get_param(current_system, 'StopTime')); % Get stop time of simulation

% Choosing the inverse kinematic solution which then are used
% for executing the trajectory.
solution = 2;

% The inverse kinematic solution is chosen for the starting point
q_i = crust_ikine(P1);
q_i = q_i(solution,:);

% The inverse kinematic solution is chosen for the ending point
q_f = crust_ikine(P2);
q_f = q_f(solution,:);

% Initial Vel. and Acc.
J_i_v = 0; % [rad/s] Velocity of joint space
J_i_a = 0; % [rad/s^2] Acceleration of joint space

% Final velocity and acceleration
J_f_v = 0;
J_f_a = 0;

% Below is shown the nine trajectory outputs, which is listed as position, velocity and
% acceleration of all joints.
F = q_i + J_i_v*t + (J_i_a*t^2)/2 + (t^5*((J_f_a - J_i_a)*t_f^2 + (- 6*J_f_v - 6*J_i_v)*t_f + 12.*q_f - 12.*q_i))/(2*t_f^5) + (t^3*((J_f_a - 3*J_i_a)*t_f^2 + (- 8*J_f_v - 12*J_i_v)*t_f + 20.*q_f - 20.*q_i))/(2*t_f^3) - (t^4*((2*J_f_a - 3*J_i_a)*t_f^2 + (- 14*J_f_v - 16*J_i_v)*t_f + 30.*q_f - 30.*q_i))/(2*t_f^4);
Fv = J_i_v + J_i_a*t + (5*t^4*((J_f_a - J_i_a)*t_f^2 + (- 6*J_f_v - 6*J_i_v)*t_f + 12.*q_f - 12.*q_i))/(2*t_f^5) + (3*t^2*((J_f_a - 3*J_i_a)*t_f^2 + (- 8*J_f_v - 12*J_i_v)*t_f + 20.*q_f - 20.*q_i))/(2*t_f^3) - (2*t^3*((2*J_f_a - 3*J_i_a)*t_f^2 + (- 14*J_f_v - 16*J_i_v)*t_f + 30.*q_f - 30.*q_i))/t_f^4;
Fa = J_i_a + (10*t^3*((J_f_a - J_i_a)*t_f^2 + (- 6*J_f_v - 6*J_i_v)*t_f + 12.*q_f - 12.*q_i))/t_f^5 - (6*t^2*((2*J_f_a - 3*J_i_a)*t_f^2 + (- 14*J_f_v - 16*J_i_v)*t_f + 30.*q_f - 30.*q_i))/t_f^4 + (3*t*((J_f_a - 3*J_i_a)*t_f^2 + (- 8*J_f_v - 12*J_i_v)*t_f + 20.*q_f - 20.*q_i))/t_f^3;

out = [F, Fv, Fa];
end
