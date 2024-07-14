addpath('./01DualNumbersF','./02DMLF','./03AuxiliarDualFun','./04ErrorP')
addpath('./05MechF','06FunEx')


%EXAMPLE SPHERICAL 4R MECHANISM
%eta1 = pi/2; phi1 = 0; psi = 0; alpha1 = pi/2; alpha2 = pi/6; 
%alpha3 = pi/2; alpha4 = pi/2; beta = 0; gm = 0;

parvnum = [1.570814, 0.000018,0.270544,0.994839,0.401429,0.820339,0.925033, ...
0.230678,0.474378];
pvc = num2cell(parvnum,1);
[eta1,phi1,psi,alpha1,alpha2,alpha3,alpha4,beta,gm]=pvc{:};

%vector of parameters independent of time
parv = [eta1,phi1,psi,alpha1,alpha2,alpha3,alpha4,beta,gm];


%errors
da=5e-4; %this presicion (in meters) can be easy achieved when constructing
         %a mechanism

%dth = 0; deta1 = 0; dphi1 = 0; dpsi = 0;
%dalpha1 = da; dalpha2 = da; dalpha3 = da; dalpha4 = da;
%dbeta = 0; dgm = 0;
dth = 0; deta1 = da; dphi1 = da; dpsi = da;
dalpha1 = da; dalpha2 = da; dalpha3 = da; dalpha4 = da;
dbeta = da; dgm = da;

%vector of errors, including in the generalized coordinate th, which is 
%taken as 0. We also do not consider errors on x0,y0 and psi.

dq0pv = dth;
dparv = [deta1,dphi1,dpsi,dalpha1,dalpha2,dalpha3,dalpha4,dbeta,dgm]; 
dqparv = [dq0pv,dparv]; %error on generalized coordinates and parameters

q0p = 1.1; 
q1p = 1; %constant angular velocity; thus, q2p, q3p, q4p are zero
q2p = 0; 
q3p = 0;

%Error propagation on kinematic quantities using directional derivatives.
%The directional derivatives are computed with dual numbers. See equations
%10,14,15,16 of the paper


ndcp = ceil(abs(log10(da))) +1;
disp('error propagation using dual numbers')
disp('The input angle is')
disp(q0p)

%error propagation on position
DF0 = ErrorFD(@CouplerPointSPH4R,q0p,parv,dqparv);

disp('error propagation on the position')
print_mat(DF0,ndcp)

%error propagation on velocity
DF1 = ErrorVD(@CouplerPointSPH4R,q1p,q0p,parv,dqparv);
disp('error propagation on the velocity')
print_mat(DF1,ndcp)

%this calculation may be slow
%error propagation on acceleration
%DF2 = ErrorAD(@CouplerPointSPH4R,q2p,q1p,q0p,parv,dqparv);
%disp('error propagation on the acceleration')
%print_mat(DF2,ndcp)

%this calculation may be slow
%error propagation on jerk
%DF3 = ErrorJD(@CouplerPointSPH4R,q3p,q2p,q1p,q0p,parv,dqparv);
%disp('error propagation on the jerk')
%print_mat(DF3,ndcp)
disp('----------')

%with this approach also the error propagation from position to jounce/snap
%can be efficiently computed
q4p = 0;
[DF,DV,DA,DJ,DS] = ErrorPKinQDCSA(@CouplerPointSPH4R,q4p,q3p,q2p,q1p,...
    q0p,parv,dq0pv,dparv);

disp('Deterministic error propagation using dual numbers and the CSA method')
disp('error propagation on the position')
print_mat(DF,ndcp)

disp('error propagation on the velocity')
print_mat(DV,ndcp)

disp('error propagation on the acceleration')
print_mat(DA,ndcp)

disp('error propagation on the jerk')
print_mat(DJ,ndcp)

disp('error propagation on the jounce/snap')
print_mat(DS,ndcp)
