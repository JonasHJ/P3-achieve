% Declares all the static variables specific for the CrustCrawler

global g l1 lc1 m1 l2 lc2 m2 l3 lc3 m3
global I1 I2 I3 
global Kv Kp

% Velocity and position gains for the control system
Kv = 2*0.99*3.25;
Kp = 3.25^2;

g = 9.815; % [m/s^2] gravity constant

%======================================  link 1
l1 = 0.065; % [m] length
lc1 = 0.03167744; % [m] Center of Mass (in Z-direction)
m1 = 0.18481027; % [kg] mass

% Inertia tensor 1
i1_11 = 0.00031543;     i1_12 = 0.00000000;	i1_13 = -0.00000002;
i1_21 = 0.00000000;     i1_22 = 0.00042781;	i1_23 = 0.00000456;
i1_31 = -0.00000002;    i1_32 = 0.00000456;	i1_33 = 0.00008106;
I1 = [i1_11, i1_12, i1_13; 
      i1_21, i1_22, i1_23; 
      i1_31, i1_32, i1_33];

  
%======================================  link 2
l2 = 0.22; % [m] length
lc2 = 0.15053580; % [m] Center of Mass (in Z-direction)
m2 = 0.21480000; % [kg] mass

% Intertia tensor 2
i2_11 = 0.00623621;     i2_12 = 0.00000000; i2_13 = -0.00001874;
i2_21 = 0.00000000;     i2_22 = 0.00769713;	i2_23 = 0.00001319;
i2_31 = -0.00001874;	i2_32 = 0.00001319;	i2_33 = 0.00006731;
I2 = [i2_11, i2_12, i2_13; 
      i2_21, i2_22, i2_23; 
      i2_31, i2_32, i2_33];

%======================================  link 3
l3 = 0.2779; % [m] length
lc3 = 0.12966557; % [m] Center of Mass (in Z-direction)
m3 = 0.33003303; % [kg] mass

% Inertia tensor 3
i3_11 = 0.00677702;     i3_12 = 0.00000000;	i3_13 = -0.00003893;
i3_21 = 0.00000000;     i3_22 = 0.00635728; i3_23 = 0.00000000;
i3_31 = -0.00003893;    i3_32 = 0.00000000;	i3_33 = 0.00019629;
I3 = [i3_11, i3_12, i3_13; 
      i3_21, i3_22, i3_23; 
      i3_31, i3_32, i3_33];

% Clear unnecessary vars
clearvars i1_11 i1_12 i1_13 i1_21 i1_22 i1_23 i1_31 i1_32 i1_33
clearvars i2_11 i2_12 i2_13 i2_21 i2_22 i2_23 i2_31 i2_32 i2_33
clearvars i3_11 i3_12 i3_13 i3_21 i3_22 i3_23 i3_31 i3_32 i3_33