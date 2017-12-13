function [ V ] = crust_getVelocity_sym( tau )

% Variables to be substituted
syms g th1 th2 th3 v1 v2 v3 a1 a2 a3
mass_vars_old = [g, th1, th2, th3, v1, v2, v3, a1, a2, a3];

% Velocity terms
V(1,1) = subs(tau(1), mass_vars_old, [0, th1, th2, th3, v1, v2, v3, 0, 0, 0]);
V(2,1) = subs(tau(2), mass_vars_old, [0, th1, th2, th3, v1, v2, v3, 0, 0, 0]);
V(3,1) = subs(tau(3), mass_vars_old, [0, th1, th2, th3, v1, v2, v3, 0, 0, 0]);

V = simplify(V);

vel_vars_old = [v1^2, v2^2, v3^2, v1*v2, v1*v3, v2*v3];

% Coriolis coefficients
B(1,1) = collect(subs(V(1), vel_vars_old, [0, 0, 0, v1*v2, 0, 0]), v1*v2)/(v1*v2);
B(1,2) = collect(subs(V(1), vel_vars_old, [0, 0, 0, 0, v1*v3, 0]), v1*v3)/(v1*v3);
B(1,3) = collect(subs(V(1), vel_vars_old, [0, 0, 0, 0, 0, v2*v3]), v2*v3)/(v2*v3);

B(2,1) = collect(subs(V(2), vel_vars_old, [0, 0, 0, v1*v2, 0, 0]), v1*v2)/(v1*v2);
B(2,2) = collect(subs(V(2), vel_vars_old, [0, 0, 0, 0, v1*v3, 0]), v1*v3)/(v1*v3);
B(2,3) = collect(subs(V(2), vel_vars_old, [0, 0, 0, 0, 0, v2*v3]), v2*v3)/(v2*v3);

B(3,1) = collect(subs(V(3), vel_vars_old, [0, 0, 0, v1*v2, 0, 0]), v1*v2)/(v1*v2);
B(3,2) = collect(subs(V(3), vel_vars_old, [0, 0, 0, 0, v1*v3, 0]), v1*v3)/(v1*v3);
B(3,3) = collect(subs(V(3), vel_vars_old, [0, 0, 0, 0, 0, v2*v3]), v2*v3)/(v2*v3);

B = simplify(B);

% Centrifugal coefficients
C(1,1) = collect(subs(V(1), vel_vars_old, [v1^2, 0, 0, 0, 0, 0]), v1^2)/v1^2;
C(1,2) = collect(subs(V(1), vel_vars_old, [0, v2^2, 0, 0, 0, 0]), v2^2)/v2^2;
C(1,3) = collect(subs(V(1), vel_vars_old, [0, 0, v3^2, 0, 0, 0]), v3^2)/v3^2;

C(2,1) = collect(subs(V(2), vel_vars_old, [v1^2, 0, 0, 0, 0, 0]), v1^2)/v1^2;
C(2,2) = collect(subs(V(2), vel_vars_old, [0, v2^2, 0, 0, 0, 0]), v2^2)/v2^2;
C(2,3) = collect(subs(V(2), vel_vars_old, [0, 0, v3^2, 0, 0, 0]), v3^2)/v3^2;

C(3,1) = collect(subs(V(3), vel_vars_old, [v1^2, 0, 0, 0, 0, 0]), v1^2)/v1^2;
C(3,2) = collect(subs(V(3), vel_vars_old, [0, v2^2, 0, 0, 0, 0]), v2^2)/v2^2;
C(3,3) = collect(subs(V(3), vel_vars_old, [0, 0, v3^2, 0, 0, 0]), v3^2)/v3^2;

C = simplify(C);

V = B*[v1*v2; v1*v3; v2*v3] + C*[v1^2; v2^2; v3^2];

end

