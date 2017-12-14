% Simscape(TM) Multibody(TM) version: 5.0

% This is a model data file derived from a Simscape Multibody Import XML file using the smimport function.
% The data in this file sets the block parameter values in an imported Simscape Multibody model.
% For more information on this file, see the smimport function help page in the Simscape Multibody documentation.
% You can modify numerical values, but avoid any other changes to this file.
% Do not add code to this file. Do not edit the physical units shown in comments.

%%%VariableName:smiData


%============= RigidTransform =============%

%Initialize the RigidTransform structure array by filling in null values.
smiData.RigidTransform(7).translation = [0.0 0.0 0.0];
smiData.RigidTransform(7).angle = 0.0;
smiData.RigidTransform(7).axis = [0.0 0.0 0.0];
smiData.RigidTransform(7).ID = '';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(1).translation = [284.84470464668993 164.48008647766881 96.175073283074511];  % mm
smiData.RigidTransform(1).angle = 2.6929216432527241e-15;  % rad
smiData.RigidTransform(1).axis = [1 0 0];
smiData.RigidTransform(1).ID = 'B[part3_xout-4:-:part4_xout-4]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(2).translation = [1.7461587731304462e-12 -2.7711166694643907e-13 25.700000000003776];  % mm
smiData.RigidTransform(2).angle = 3.3306690738754704e-15;  % rad
smiData.RigidTransform(2).axis = [1 0 0];
smiData.RigidTransform(2).ID = 'F[part3_xout-4:-:part4_xout-4]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(3).translation = [86.443608744977666 57.494685305428696 85.05609656788279];  % mm
smiData.RigidTransform(3).angle = 1.6960507695169971e-15;  % rad
smiData.RigidTransform(3).axis = [0.065459303729518289 0.99785523977942148 5.5392093122288862e-17];
smiData.RigidTransform(3).ID = 'B[part2_xout-4:-:part3_xout-4]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(4).translation = [65.044704646690136 164.48008647766846 96.825073283077629];  % mm
smiData.RigidTransform(4).angle = 6.8043630020060767e-15;  % rad
smiData.RigidTransform(4).axis = [0.97898041973760497 0.20395425411200149 6.7930412665618207e-16];
smiData.RigidTransform(4).ID = 'F[part2_xout-4:-:part3_xout-4]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(5).translation = [0 0 3.3861802251067274e-12];  % mm
smiData.RigidTransform(5).angle = 5.4764688790130212e-16;  % rad
smiData.RigidTransform(5).axis = [-0.62361141589589753 0.78173448303392234 -1.3348853128485798e-16];
smiData.RigidTransform(5).ID = 'B[part1_xout-4:-:part2_xout-4]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(6).translation = [33.643608744980902 57.494685305429925 54.256096567879894];  % mm
smiData.RigidTransform(6).angle = 2.0943951023931962;  % rad
smiData.RigidTransform(6).axis = [0.57735026918962618 0.57735026918962606 0.57735026918962518];
smiData.RigidTransform(6).ID = 'F[part1_xout-4:-:part2_xout-4]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(7).translation = [-46.106820619868138 139.63296696438027 107.49602721632701];  % mm
smiData.RigidTransform(7).angle = 0;  % rad
smiData.RigidTransform(7).axis = [0 0 0];
smiData.RigidTransform(7).ID = 'RootGround[part1_xout-4]';


%============= Solid =============%
%Center of Mass (CoM) %Moments of Inertia (MoI) %Product of Inertia (PoI)

%Initialize the Solid structure array by filling in null values.
smiData.Solid(4).mass = 0.0;
smiData.Solid(4).CoM = [0.0 0.0 0.0];
smiData.Solid(4).MoI = [0.0 0.0 0.0];
smiData.Solid(4).PoI = [0.0 0.0 0.0];
smiData.Solid(4).color = [0.0 0.0 0.0];
smiData.Solid(4).opacity = 0.0;
smiData.Solid(4).ID = '';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(1).mass = 0.7890368783715711;  % kg
smiData.Solid(1).CoM = [0.79843383352874275 -0.7984338360780272 -24.648229306481923];  % mm
smiData.Solid(1).MoI = [2099.4742372242545 2099.4742358873 3341.8600003106553];  % kg*mm^2
smiData.Solid(1).PoI = [14.025890486912129 -14.025890542690181 12.64992831623052];  % kg*mm^2
smiData.Solid(1).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = 'part1_xout*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(2).mass = 0.18481027081513934;  % kg
smiData.Solid(2).CoM = [64.321049649829575 57.491680566732256 54.637265176785874];  % mm
smiData.Solid(2).MoI = [81.033067953256875 129.95679577381918 114.07371738064076];  % kg*mm^2
smiData.Solid(2).PoI = [-0.0040441775798608463 -2.3304761323988674 0.0064550112023840063];  % kg*mm^2
smiData.Solid(2).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(2).opacity = 1;
smiData.Solid(2).ID = 'part2_xout*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(3).mass = 0.21480000000000002;  % kg
smiData.Solid(3).CoM = [215.58049974372366 163.64515419218003 68.440363666057749];  % mm
smiData.Solid(3).MoI = [67.144354691948735 1368.603890691388 1333.1040767409445];  % kg*mm^2
smiData.Solid(3).PoI = [-0.04757812851574194 -4.6130885073464558 -8.2606953091557713];  % kg*mm^2
smiData.Solid(3).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(3).opacity = 1;
smiData.Solid(3).ID = 'part3_xout*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(4).mass = 0.33003302893361136;  % kg
smiData.Solid(4).CoM = [129.6655713834962 -0.81513645372020582 2.1470296570497219e-06];  % mm
smiData.Solid(4).MoI = [196.06883471385899 1228.1249204645169 1134.0307551472147];  % kg*mm^2
smiData.Solid(4).PoI = [1.7076153825316306e-05 -5.2915141344166139e-06 4.0462561948394402];  % kg*mm^2
smiData.Solid(4).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(4).opacity = 1;
smiData.Solid(4).ID = 'part4_xout*:*Default';


%============= Joint =============%
%X Revolute Primitive (Rx) %Y Revolute Primitive (Ry) %Z Revolute Primitive (Rz)
%X Prismatic Primitive (Px) %Y Prismatic Primitive (Py) %Z Prismatic Primitive (Pz) %Spherical Primitive (S)
%Constant Velocity Primitive (CV) %Lead Screw Primitive (LS)
%Position Target (Pos)

%Initialize the RevoluteJoint structure array by filling in null values.
smiData.RevoluteJoint(3).Rz.Pos = 0.0;
smiData.RevoluteJoint(3).ID = '';

smiData.RevoluteJoint(1).Rz.Pos = 9.0396800984067226e-29;  % deg
smiData.RevoluteJoint(1).ID = '[part3_xout-4:-:part4_xout-4]';

smiData.RevoluteJoint(2).Rz.Pos = -5.0888874903416003e-14;  % deg
smiData.RevoluteJoint(2).ID = '[part2_xout-4:-:part3_xout-4]';

smiData.RevoluteJoint(3).Rz.Pos = 1.8157039851947058e-13;  % deg
smiData.RevoluteJoint(3).ID = '[part1_xout-4:-:part2_xout-4]';

