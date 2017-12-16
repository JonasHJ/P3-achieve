function dd_theta = ForwardDyn(u)
%%  Inputs
    tau = u(1:3);     % motor torques
    theta = u(4:6);   % joint velocity
    d_theta = u(7:9); % displacement

%% coefficients of dynamic equation

    % Inertia matrix
    M = crust_getInertia(theta);
    
    % Velocity term
    V = crust_getVelocity([theta, d_theta]);

    % Gravity terms
    G = crust_getGravity(theta);



    % [tau - V(theta, d_theta) - G(theta)]

    torque = tau - V - G;

    dd_theta = M\torque % inv(M)*torque
end