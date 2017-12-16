function G = crust_getGravity( theta )
% This function calculates the gravity term G(theta) in the EoM where theta
% is a 3x1 vector [theta1; theta2; theta3] in radians. 


% The global variables below is imported from Workspace which recieves the
% variables from ImportVars.m
global g l2 lc2 m2 lc3 m3


% The G term below is the gravity term in the EoM consisting of all terms
% including gravity
G = [0;
     -g*(l2*m3*sin(theta(2)) + lc2*m2*sin(theta(2)) + lc3*m3*sin(theta(2) + theta(3)));
     -g*lc3*m3*sin(theta(2) + theta(3))];

end

