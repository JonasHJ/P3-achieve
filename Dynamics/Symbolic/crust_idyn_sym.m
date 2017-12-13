clear;clc;close all

syms m1 m2 m3 l1 l2 l3 lc1 lc2 lc3 theta1 theta2 theta3 d_theta1 d_theta2 d_theta3 g

% Rotation matrices acounting for the joints rotation
R1 = rotz(theta1);
R2 = roty(theta2);
R23 = roty(theta2+theta3);

% The Inertia Tensor multiplied with the rotation that affects it.
I1 = R1*sym('i1_%d%d', [3 3]);
I2 = R1*R2*sym('i2_%d%d', [3 3]);
I3 = R1*R23*sym('i3_%d%d', [3 3]);

% The gravity vector
G = [0; 0; -g]; % g = 9.815

% Direction vectors
rc1 = R1*[0; 0; lc1];
r1_2 = R1*[0; 0; l1];
rc2 = R1*R2*[0; 0; lc2];
r2_3 = R1*R2*[0; 0; l2];
rc3 = R1*R23*[0; 0; lc3];
r3_4 = R1*R23*[0; 0; l3]; % End-effector

% LINK 1 - rotational motion
omega1 = R1*[0; 0; d_theta1];
v1 = 0;
K(1) = 1/2*omega1.'*I1*omega1;
P_ref(1) = m1*G.'*(-rc1);
P(1) = -m1*G.'*rc1 + P_ref(1); % = 0

% LINK 2 - general motion
omega2 = omega1 + R1*[0; d_theta2; 0];
v2 = v1 + cross(omega1, r1_2);
vc2 = v2 + cross(omega2, rc2);
K(2) = 1/2*m2*(vc2.'*vc2) + 1/2*omega2.'*I2*omega2;
P_ref(2) = m2*G.'*([0;0;-lc2]);
P(2) = -m2*G.'*rc2 + P_ref(2);

% LINK 3 - general motion
omega3 = omega2 + R1*[0; d_theta3; 0];
v3 = v2 + cross(omega2, r2_3);
vc3 = v3 + cross(omega3, rc3);
K(3) = 1/2*m3*(vc3.'*vc3) + 1/2*omega3.'*I3*omega3;
P_ref(3) = m3*G.'*([0;0;-(lc3+l2)]); 
P(3) = -m3*G.'*(r2_3 + rc3) + P_ref(3);

% Lagrange
La = sum(K) - sum(P);

% Clean up
clearvars K P P_ref vc3 v3 omega3 vc2 v2 omega2 v1 omega1 rc3 r2_3 rc2 r1_2 rc1 R23 R2 R1

%%%% TAU 1 %%%%
tau_eq1(1) = diff(La, d_theta1);
tau_eq2(1) = diff(La, theta1);
%%%% TAU 2 %%%%
tau_eq1(2) = diff(La, d_theta2);
tau_eq2(2) = diff(La, theta2);
%%%% TAU 3 %%%%
tau_eq1(3) = diff(La, d_theta3);
tau_eq2(3) = diff(La, theta3);

% Make dependant on time
syms t1(t) t2(t) t3(t) d_t1(t) d_t2(t) d_t3(t)

% Here the non-time dependant variables is substituded out with the time
% dependant
equations = [tau_eq1(1), tau_eq2(1), tau_eq1(2), tau_eq2(2), tau_eq1(3), tau_eq2(3)];
vars_old = [theta1, theta2, theta3, d_theta1, d_theta2, d_theta3];
vars_new = [t1(t), t2(t), t3(t), d_t1(t), d_t2(t), d_t3(t)];
equations = subs(equations, vars_old, vars_new);

% Here the Lagrange equation is finalized by differentiating relative to time
tau(1) = diff(equations(1), t) - equations(2);
tau(2) = diff(equations(3), t) - equations(4);
tau(3) = diff(equations(5), t) - equations(6);

% Makes tau a 3x1 vector
tau = simplify(tau.');

% Clean up
syms th1 th2 th3 v1 v2 v3 a1 a2 a3

clearvars La equations vars_new vars_old tau_eq1 tau_eq2 theta3 theta2 theta1 d_theta3 d_theta2 d_theta1 

%% Isolation of the individual terms M, V and G

% Here the expression is now converted back into non-time dependant
% variables
vars_old_test = [t1(t), t2(t), t3(t), d_t1(t), d_t2(t), d_t3(t), diff(d_t1(t), t), diff(d_t2(t), t), diff(d_t3(t), t)];
vars_new_test = [th1, th2, th3, v1, v2, v3, a1, a2, a3];

tau1_test = simplify(subs(tau(1), vars_old_test, vars_new_test));
tau2_test = simplify(subs(tau(2), vars_old_test, vars_new_test));
tau3_test = simplify(subs(tau(3), vars_old_test, vars_new_test));

%%%% Mass Matrix
M = crust_getMass_sym([tau1_test, tau2_test, tau3_test]);

%%%% Velocity terms
V = crust_getVelocity_sym([tau1_test, tau2_test, tau3_test]);

%%%% Gravity terms
G = crust_getGravity_sym([tau1_test, tau2_test, tau3_test]);

%% Output EoM terms
M
V
G



