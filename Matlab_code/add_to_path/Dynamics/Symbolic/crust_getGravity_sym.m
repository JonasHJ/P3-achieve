function [ G ] = crust_getGravity_sym( tau )
% This function returns a 3x1 gravity expression vector by inputting the
% 3x1 tau expression vector

syms g th1 th2 th3 v1 v2 v3 a1 a2 a3
vars_old = [g, th1, th2, th3, v1, v2, v3, a1, a2, a3];

G(1,1) = subs(tau(1), vars_old, [g, th1, th2, th3, 0, 0, 0, 0, 0, 0]);
G(2,1) = subs(tau(2), vars_old, [g, th1, th2, th3, 0, 0, 0, 0, 0, 0]);
G(3,1) = subs(tau(3), vars_old, [g, th1, th2, th3, 0, 0, 0, 0, 0, 0]);

G = simplify(G);

end

