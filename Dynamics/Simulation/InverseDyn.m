function tau = InverseDyn(u)
%%  Inputs
    theta = u(1:3);     % joint displacement
    d_theta = u(4:6);   % velocity
    dd_theta = u(7:9);  % acceleration

%%  coefficients of dynamic equation

    % Inertia matrix
    M = crust_getInertia(theta);

    % Velocity term
    V = crust_getVelocity([theta, d_theta]);

    % Gravity terms
    G = crust_getGravity(theta);

    
    tau = M*dd_theta + V + G;
end