function [ out ] = p2p_traj_3d( t )

J_i_v = [0,0,0]; % [rad/s] Initial velocity of joint space
J_f_v = [0,0,0]; % Final velocity

J_i_a = [0,0,0]; % [rad/s^2] Initial acceleration of joint space
J_f_a = [0,0,0]; % Final acceleration

%Vector with the time for each of the six trajectories, all trajectories
%are 3 seconds
t_f_vec = [3,3,3,3,3,3];

%P1 is initial position
%P2 is final position

if t <= t_f_vec(1) % Do first trajectory to beverage if time < 3 [s]

    P1 = [ 0.2779, 0, 0.22]; %Initial position (0,0,pi/2) radians
    P2 = [-0.091,  -0.402, -0.187]; %Final position where beverage is
    t_f = t_f_vec(1); %Final time for trajectory 3 [s]
    solution = 1; %Use inverse kinematic solution 1 for both positions.
    
elseif t <= t_f_vec(1) + t_f_vec(2) 
    % Else do second trajectory to via point if time < 6 [s]
    
    P1 = [-0.091,  -0.402, -0.187]; %Beverage position
    P2 = [0.2779, 0, 0.22]; %Via point position
    t = t - t_f_vec(1); %Reset time to "0" (t-3)
    t_f = t_f_vec(2); %Final time for trajectory 3 [s]
    solution = 1; %Use inverse kinematic solution 1 for both positions.
    J_f_v(1) = 0.48*5/3; %Set a final velocity for smooth movement through via point
    J_f_a(1) = -0.33; %Set a final acceleration for smooth movement through via point
    
elseif t <= t_f_vec(1) + t_f_vec(2) + t_f_vec(3) 
    % Else do third trajectory to user if time < 9 [s]

    P1 = [0.2779, 0, 0.22]; % Via position
    P2 = [ 0.337,   0.359, -0.038]; % User position 
    t = t - t_f_vec(1)-t_f_vec(2);
    t_f = t_f_vec(3); 
    solution = 1; 
    J_i_v(1) = 0.48*5/3;%Set a initial velocity for smooth movement through via point
    J_i_a(1) = -0.33; %Set a initial acceleration for smooth movement through via point
    
    
elseif t <= t_f_vec(1) + t_f_vec(2) + t_f_vec(3) + t_f_vec(4) 
    % Else do fourth trajectory to via point if time < 12 [s]
    
    P1 = [0.337,   0.359, -0.038]; %User position
    P2 = [0.2779, 0, 0.22]; %Via position
    t = t - t_f_vec(1)-t_f_vec(2)-t_f_vec(3); 
    t_f = t_f_vec(4); 
    solution = 1;
    J_f_v(1) = -0.48*5/3; %Set a final velocity for smooth movement through via point
    J_f_a(1) = -0.33; %Set a final acceleration for smooth movement through via point
    
    
    
elseif t <=  t_f_vec(1) + t_f_vec(2) + t_f_vec(3) + t_f_vec(4) + t_f_vec(5) 
    % Else do fifth trajectory to via point if time < 15 [s]
    
    P1 = [0.2779, 0, 0.22]; % Via position
    P2 = [-0.091,  -0.402, -0.187]; % Original position of beverage
    t = t - t_f_vec(1)-t_f_vec(2)-t_f_vec(3)-t_f_vec(4);
    t_f = t_f_vec(5);
    solution = 1;
    J_i_v(1) = -0.48*5/3; %Set an initial velocity for smooth movement through via point 
    J_i_a(1) = -0.33;%Set a an initial acceleration for smooth movement through via point
    
elseif t <=  t_f_vec(1) + t_f_vec(2) + t_f_vec(3) + t_f_vec(4) + t_f_vec(5) + t_f_vec(6) 
    % Else do sixth trajectory to via point if time < 15 [s]
    
    
    P1 = [-0.091,  -0.402, -0.187]; % Position of beverage
    P2 = [ 0.2779, 0, 0.22]; % Initial position (0,0,pi/2)
    t = t - t_f_vec(1) - t_f_vec(2) - t_f_vec(3) - t_f_vec(4) - t_f_vec(5);
    t_f = t_f_vec(6);
    solution = 1;

else
    %Here no trajectory is used. When the movement is finished, it should
    %simply stay in the final position
    P_f = [ 0.2779, 0, 0.22];
    solution = 1;
    q_f = crust_ikine(P_f);
    F = q_f(solution,:);
    Fv = [0,0,0];
    Fa = [0,0,0];
    
end
%If time is less than 18 [s], calculate the trajectory. (movement is
%finished after 18 [s].
if t <=  t_f_vec(1) + t_f_vec(2) + t_f_vec(3) + t_f_vec(4) + t_f_vec(5) + t_f_vec(6)
%Convert initial xyz to joint position
q_i = crust_ikine(P1);
q_i = q_i(solution,:);
%Do the same for final position
q_f = crust_ikine(P2);
q_f = q_f(solution,:);

%Calculate next trajectory point... F=(3x1)position Fv=(3x1)velocity Fa=(3x1)acceleration 
F = q_i + J_i_v*t + (J_i_a*t^2)/2 + (t^5*((J_f_a - J_i_a)*t_f^2 + (- 6*J_f_v - 6*J_i_v)*t_f + 12.*q_f - 12.*q_i))/(2*t_f^5) + (t^3*((J_f_a - 3*J_i_a)*t_f^2 + (- 8*J_f_v - 12*J_i_v)*t_f + 20.*q_f - 20.*q_i))/(2*t_f^3) - (t^4*((2*J_f_a - 3*J_i_a)*t_f^2 + (- 14*J_f_v - 16*J_i_v)*t_f + 30.*q_f - 30.*q_i))/(2*t_f^4);
Fv = J_i_v + J_i_a*t + (5*t^4*((J_f_a - J_i_a)*t_f^2 + (- 6*J_f_v - 6*J_i_v)*t_f + 12.*q_f - 12.*q_i))/(2*t_f^5) + (3*t^2*((J_f_a - 3*J_i_a)*t_f^2 + (- 8*J_f_v - 12*J_i_v)*t_f + 20.*q_f - 20.*q_i))/(2*t_f^3) - (2*t^3*((2*J_f_a - 3*J_i_a)*t_f^2 + (- 14*J_f_v - 16*J_i_v)*t_f + 30.*q_f - 30.*q_i))/t_f^4;
Fa = J_i_a + (10*t^3*((J_f_a - J_i_a)*t_f^2 + (- 6*J_f_v - 6*J_i_v)*t_f + 12.*q_f - 12.*q_i))/t_f^5 - (6*t^2*((2*J_f_a - 3*J_i_a)*t_f^2 + (- 14*J_f_v - 16*J_i_v)*t_f + 30.*q_f - 30.*q_i))/t_f^4 + (3*t*((J_f_a - 3*J_i_a)*t_f^2 + (- 8*J_f_v - 12*J_i_v)*t_f + 20.*q_f - 20.*q_i))/t_f^3;

end
%Return position, velocity and acceleration to control system.
out = [F, Fv, Fa];

end