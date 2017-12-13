function [F, Fv, Fa] = crust_traj( P1, P2, t_f, plot )
% This function takes start point, end point, time from start to finish and
% plot as input and return the desired trajectory of 9 values, which is position, velocity and
% acceleration of each joint.

%P1 [m] Start point
%P2 [m] End point

% t_f [s] Time from start to finish


% Choosing which inverse kinematic solution that are used for the starting position of the trajectory.
q_i = crust_ikine(P1);
q_i = q_i(1,:); % First solution chosen

% Choosing which inverse kinematic solution that are used to throughout the trajectory.
q_f = crust_ikine(P2);
q_f = q_f(1,:);

% Initial velocity and acceleration
J_i_v = 0; % [rad/s] Velocity of joint space
J_i_a = 0; % [rad/s^2] Acceleration of joint space

% Final velocity and acceleration
J_f_v = J_i_v; % Same to fit concurrent points
J_f_a = J_i_a; 

% Six linear equations of six unknows are listed below 
% and are depending on initial position, velocity, acceleration and time
% as well as the final position, velocity, acceleration and time.
a0 = q_i;
a1 = J_i_v;
a2 = J_i_a./2;
a3 = (20*q_f - 20*q_i - (8*J_f_v + 12*J_i_v)*t_f - (3*J_i_a - J_f_a)*t_f^2)./(2*t_f^3);
a4 = (30*q_i - 30*q_f + (14*J_f_v + 16*J_i_v)*t_f + (3*J_i_a - 2*J_f_a)*t_f^2)./(2*t_f^4);
a5 = (12*q_f - 12*q_i - (6*J_f_v + 6*J_i_v)*t_f - (J_i_a - J_f_a)*t_f^2)./(2*t_f^5);

% The symbolic trajectory is calculated below
syms t;
F = a0 + a1*t + a2*t^2 + a3*t^3 + a4*t^4 + a5*t^5;
Fv = diff(F, t);
Fa = diff(Fv, t);

% Here the trajectory is plotted into a figure.
if(plot)
    subplot(3,1,1); fplot(F(1),[0 t_f]); hold on;
    title('Displacement'); xlabel('Time [s]'); ylabel('Displacement [rad]');

    subplot(3,1,2);fplot(Fv(1),[0 t_f]);hold on;
    title('Velocity'); xlabel('Time [s]'); ylabel('Velocity [rad/s]');

    subplot(3,1,3);fplot(Fa(1),[0 t_f]);
    title('Acceleration'); xlabel('Time [s]'); ylabel('Acceleration [rad/s²]');
end

end
