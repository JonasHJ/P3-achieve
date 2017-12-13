function [ M ] = crust_getMass_sym( tau )
% This function takes the tau 3x1 expression vector as input and returns a
% 3x3 mass matrix.


syms g th1 th2 th3 v1 v2 v3 a1 a2 a3
mass_vars_old = [g, th1, th2, th3, v1, v2, v3, a1, a2, a3];

M(1,1) = collect(subs(tau(1), mass_vars_old, [0, th1, th2, th3, 0, 0, 0, a1, 0, 0]), a1)/a1;
M(1,2) = collect(subs(tau(1), mass_vars_old, [0, th1, th2, th3, 0, 0, 0, 0, a2, 0]), a2)/a2;
M(1,3) = collect(subs(tau(1), mass_vars_old, [0, th1, th2, th3, 0, 0, 0, 0, 0, a3]), a3)/a3;

M(2,1) = collect(subs(tau(2), mass_vars_old, [0, th1, th2, th3, 0, 0, 0, a1, 0, 0]), a1)/a1;
M(2,2) = collect(subs(tau(2), mass_vars_old, [0, th1, th2, th3, 0, 0, 0, 0, a2, 0]), a2)/a2;
M(2,3) = collect(subs(tau(2), mass_vars_old, [0, th1, th2, th3, 0, 0, 0, 0, 0, a3]), a3)/a3;

M(3,1) = collect(subs(tau(3), mass_vars_old, [0, th1, th2, th3, 0, 0, 0, a1, 0, 0]), a1)/a1;
M(3,2) = collect(subs(tau(3), mass_vars_old, [0, th1, th2, th3, 0, 0, 0, 0, a2, 0]), a2)/a2;
M(3,3) = collect(subs(tau(3), mass_vars_old, [0, th1, th2, th3, 0, 0, 0, 0, 0, a3]), a3)/a3;

M = simplify(M);
end

