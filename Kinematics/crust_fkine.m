function [T, A] = crust_fkine( theta )
% This function recieves theta as input and returns a (4,4) matrix with Denavit Hartenberg transformation matrix
% for Crustcrawler
% theta = [q1 q2 q3]

% Defining number of links on the CrustCrawler
links = 3;

% DH Parameters
theta(2) = theta(2)-pi/2;

alpha(1) = 0;
alpha(2) = -pi/2;
alpha(3) = 0;

a(1) = 0;
a(2) = 0;
a(3) = 0.22;

d(1) = 0;
d(2) = 0;
d(3) = 0;

% General transform matrix
T = eye(4); % Define a 4x4 identity matrix to be able to multiply it
A = zeros(4,4,links);
for i=1:links
    % Create the individual transformation matrix
    A(:,:,i) = [     cos(theta(i)),               -sin(theta(i)),              0,                a(i);
       sin(theta(i))*cos(alpha(i)),  cos(theta(i))*cos(alpha(i)), -sin(alpha(i)), -sin(alpha(i))*d(i);
       sin(theta(i))*sin(alpha(i)),  cos(theta(i))*sin(alpha(i)),  cos(alpha(i)),  cos(alpha(i))*d(i);
                                 0,                            0,              0,                   1];
    
    % Multiply it to the general transformation matrix
    T = T*A(:,:,i);
end


T_EE = transl([0.2779 0 0]);

T = T*T_EE;

end

