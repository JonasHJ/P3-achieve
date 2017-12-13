function M = crust_getInertia( theta )
% This function calculates the mass matrix term M(theta) in the EoM where theta
% is a 3x1 vector [theta1; theta2; theta3] in radians. 


% The global variables below is imported from Workspace which recieves the
% variables from ImportVars.m
global l2 lc2 m2 lc3 m3
global I1 I2 I3


% Below is the all terms in the dynamic equation which multiplies with
% dd_theta in the EoM and is a function of theta.
%
% First column consist of all terms multiplied with acceleration of the first joint(dd_theta_1)
% First row consist of all acceleration terms in the tau_1 term
% Thereby M11 consists of all terms multiplied with dd_theta1 in the tau_1
% term.
M11 = I1(3,3) + I3(3,3)*cos(theta(2) + theta(3)) - I3(1,3)*sin(theta(2) + theta(3)) + (l2^2*m3)/2 + (lc2^2*m2)/2 + (lc3^2*m3)/2 + I2(3,3)*cos(theta(2)) - I2(1,3)*sin(theta(2)) - (lc3^2*m3*cos(2*theta(2) + 2*theta(3)))/2 - (l2^2*m3*cos(2*theta(2)))/2 - (lc2^2*m2*cos(2*theta(2)))/2 + l2*lc3*m3*cos(theta(3)) - l2*lc3*m3*cos(2*theta(2) + theta(3));
M12 = I2(2,3)/2 + I3(2,3)/2 + (I2(3,2)*cos(theta(1))*cos(theta(2)))/2 - (I2(1,2)*cos(theta(1))*sin(theta(2)))/2 - (I2(3,1)*cos(theta(2))*sin(theta(1)))/2 + (I2(1,1)*sin(theta(1))*sin(theta(2)))/2 + (I3(3,2)*cos(theta(1))*cos(theta(2))*cos(theta(3)))/2 - (I3(1,2)*cos(theta(1))*cos(theta(2))*sin(theta(3)))/2 - (I3(1,2)*cos(theta(1))*cos(theta(3))*sin(theta(2)))/2 - (I3(3,1)*cos(theta(2))*cos(theta(3))*sin(theta(1)))/2 + (I3(1,1)*cos(theta(2))*sin(theta(1))*sin(theta(3)))/2 + (I3(1,1)*cos(theta(3))*sin(theta(1))*sin(theta(2)))/2 - (I3(3,2)*cos(theta(1))*sin(theta(2))*sin(theta(3)))/2 + (I3(3,1)*sin(theta(1))*sin(theta(2))*sin(theta(3)))/2;
M13 = I3(2,3)/2 + (I3(3,2)*cos(theta(1))*cos(theta(2))*cos(theta(3)))/2 - (I3(1,2)*cos(theta(1))*cos(theta(2))*sin(theta(3)))/2 - (I3(1,2)*cos(theta(1))*cos(theta(3))*sin(theta(2)))/2 - (I3(3,1)*cos(theta(2))*cos(theta(3))*sin(theta(1)))/2 + (I3(1,1)*cos(theta(2))*sin(theta(1))*sin(theta(3)))/2 + (I3(1,1)*cos(theta(3))*sin(theta(1))*sin(theta(2)))/2 - (I3(3,2)*cos(theta(1))*sin(theta(2))*sin(theta(3)))/2 + (I3(3,1)*sin(theta(1))*sin(theta(2))*sin(theta(3)))/2;
M22 = m3*l2^2 + 2*m3*cos(theta(3))*l2*lc3 + m2*lc2^2 + m3*lc3^2 + I2(2,2)*cos(theta(1)) + I3(2,2)*cos(theta(1)) - I2(2,1)*sin(theta(1)) - I3(2,1)*sin(theta(1));
M23 = m3*lc3^2 + l2*m3*cos(theta(3))*lc3 + I3(2,2)*cos(theta(1)) - I3(2,1)*sin(theta(1));
M33 = m3*lc3^2 + I3(2,2)*cos(theta(1)) - I3(2,1)*sin(theta(1));

% Inertia matrix in the EoM with all elements above inserted.
M = [M11 M12 M13;
     M12 M22 M23;
     M13 M23 M33];

end

