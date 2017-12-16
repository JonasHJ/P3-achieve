clear;clc;close all

% Forward kinematic test
q = [pi/5 -pi/2 -pi/5];
T = crust_fkine(q);
Pos = [T(1,4), T(2,4), T(3,4)]

% Inverse kinematic test
[q, validSol, q_all] = crust_ikine_test(Pos);

for i=1:size(q,1)
    theta_q = q(i,:).*180/pi
    T_q = crust_fkine(q(i,:));
    pos_q = [T_q(1,4), T_q(2,4), T_q(3,4)];
end

% Trajectory test

P1 = [0.2779, 0, 0.22]; % Home
P2 = [0.33717, 0.35905, -0.03826]; % Mouth
plot = 1; % 0 = don't plot, 1 = show plot
crust_traj(P1, P2, 5, plot)
