addpath('./01DualNumbersF','./02DMLF','03AuxiliarDualFun','./04ErrorP')
addpath('./05MechF','06FunEx')

BC = 0.7;
CD = 0.5;
da = 5e-4;

th0p = pi/2; phi0p = 0; s0p = 0.2; bth0p = 0;
th1p = 1; phi1p = 1; s1p = 1; bth1p = 1;

q0p = [th0p,phi0p,s0p,bth0p];
q1p = [th1p,phi1p,s1p,bth1p];
q2p = [1,0,2,1];
q3p = [0.1,0.2,0.3,0.4];

parv = [BC,CD];

disp('--Deterministic-Dual, without using the CSA method--')
%error on generalized coordinates (taken as 0) and parameters
dqparv = [0,0,0,0,da,da];

%error propagation on position
DF0 = ErrorFD(@rposDX,q0p,parv,dqparv);
ndcp = ceil(abs(log10(da))) + 1;
disp('error propagation on the position')
print_mat(DF0,ndcp)

%error propagation on velocity
DF1 = ErrorVD(@rposD,q1p,q0p,parv,dqparv);
disp('error propagation on the velocity')
print_mat(DF1,ndcp)

%this calculation may be slow
%error propagation on acceleration
%DF2 = ErrorAD(@rposD,q2p,q1p,q0p,parv,dqparv);
%disp('error propagation on the acceleration')
%print_mat(DF2,ndcp)

%this calculation may be slow
%error propagation on jerk
%DF3 = ErrorJD(@rposD,q3p,q2p,q1p,q0p,parv,dqparv);
%disp('error propagation on the jerk')
%print_mat(DF3,ndcp)
disp('----------')


%This method is much more efficient because it avoids many of the 
%unnecessary computations found in the previous method. Kinematic 
%quantities are computed with a single evaluation using dual numbers, 
%while parameter variations are conducted using the complex step 
%approximation method
dq0p = dqparv(1:4);
dpar = dqparv(5:end);

[DF,DV,DA,DJ] = ErrorPKinQ03DCSA(@rposD,q3p,q2p,q1p,...
    q0p,parv,dq0p,dpar);
disp('Deterministic error propagation using dual numbers and the CSA method')
disp('error propagation on the position')
print_mat(DF,ndcp)

disp('error propagation on the velocity')
print_mat(DV,ndcp)

disp('error propagation on the acceleration')
print_mat(DA,ndcp)

disp('error propagation on the jerk')
print_mat(DJ,ndcp)


%To calculate error propagation from position to jounce/snap, uncomment the 
%code below
% q4p = [0.1,0.2,0.3,0.4];
% [DF,DV,DA,DJ,DJS] = ErrorPKinQDCSA(@rposD,q4p,q3p,q2p,q1p,...
%      q0p,parv,dq0p,dpar);
% 
% disp('Deterministic error propagation using dual numbers and the CSA method')
% disp('error propagation on the position')
% print_mat(DF,ndcp)
% 
% disp('error propagation on the velocity')
% print_mat(DV,ndcp)
% 
% disp('error propagation on the acceleration')
% print_mat(DA,ndcp)
% 
% disp('error propagation on the jerk')
% print_mat(DJ,ndcp)
% 
% disp('error propagation on the jounce/snap')
% print_mat(DJS,ndcp)
