function [q, validSol, q_all] = crust_ikine_test( Pos )
% This function takes the position of the end-effector as input and returns a nx3 matrix where n is 
% possible solutions and 3 is number of joint
% angles ordered as [theta1, theta2, theta3].
% P is a position vector for the desired reach point
% Pos = [X; Y; Z]

% Measurements of each link on the CrustCrawler
l(1) = 0; % [m]
l(2) = 0.22;
l(3) = 0.2779; %0.1473

% Position of wrist
pw_x = Pos(1);
pw_y = Pos(2);
pw_z = Pos(3);

solutions = 4; % Number of solutions
validSol = true(1,solutions); % Keep track of what solutions are valid

% **Theta 1, which is explained in the report in section 6 'Modelling'**
theta1(1:2) = atan2(pw_y, pw_x);
theta1(3:4) = pi+atan2(pw_y, pw_x);

% **Theta 3, which is explained in the report in section 6 'Modelling'**
r(1:2) = sqrt(pw_x^2+pw_y^2);
r(3:4) = -r(1:2); % When elbow goes back over the shoulder
h = -pw_z;

c3 = (r.^2 + h^2 - l(2)^2 - l(3)^2)./(2*l(2)*l(3));
s3 = sqrt(1-c3.^2);

% Check if it's a valid solution
for i = 1:solutions
    if(~isreal(s3(i))) % If s3 is NOT a real number
        validSol(i) = false; % Solution is not valid
        s3(i) = 0; % Set s3 to non-imaginary, since we already know it's invalid
    end
end

theta3([1,3]) = atan2(s3([1,3]), c3([1,3])); % Elbow down
theta3([2,4]) = atan2(-s3([2,4]), c3([2,4])); % Elbow up

% **Theta 2, which is explained in the report in section 6 'Modelling'**
k1 = l(2)+l(3)*cos(theta3);
k2 = l(3)*sin(theta3);

theta2 = atan2(k1*h-k2.*r, k1.*r+k2*h)+pi/2;


% All solution (even if out-of-range or out-of-reach) [row=solutions, col=joint angels]
q_all = wrapToPi([theta1', theta2', theta3']); % [rad]


% ----------------------------------------
% Limits on joints
A_lim(:,:,1) = [-180, 180]; % [deg]
A_lim(:,:,2) = [-180, 180];
A_lim(:,:,3) = [-180, 180];
A_lim = A_lim.*pi/180; % [deg] to [rad]

% Find out-of-range solutions (Run through all joints)
for i=1:3
    % If any (:) solution for joint (i) is lower than min or higher than
    % max, set ind to 1
    ind = q_all(:,i) < min(A_lim(:,:,i)) | q_all(:,i) > max(A_lim(:,:,i)); 
    
    validSol(ind) = false; % If any solution was out-of-range set it to invalid solution
end


q = q_all(validSol,:); % [rad] Only the valid solutions
end