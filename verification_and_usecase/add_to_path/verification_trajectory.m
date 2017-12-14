function [ out ] = verification_trajectory( t )
%3 (3x1) vectors are created for position velocity and acceleration for
%each joint. They are all 0 degrees by default.
theta = zeros([3,1]);
dtheta = zeros([3,1]);
ddtheta = zeros([3,1]);

%Gravity Test. Joint 2 is set to 90 degrees, so that gravity acts on link 2
%and 3.
%theta(2)=pi/2;

%First sinusoidal test on joint 1, where joint 2 is 90 degrees.
theta(1)=sin(t);
dtheta(1)=cos(t);
ddtheta(1)=-sin(t);
theta(2)=pi/2;

%Second sinusoidal test on joint 2.
%theta(2)=sin(t);
%dtheta(2)=cos(t);
%ddtheta(2)=-sin(t);

%Third sinusoidal test on joint 3
%theta(3)=sin(t);
%dtheta(3)=cos(t);
%ddtheta(3)=-sin(t);

out = [theta,dtheta,ddtheta];
end

