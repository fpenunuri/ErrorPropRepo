addpath('./01DualNumbersF','./02DMLF','./03AuxiliarDualFun','./04ErrorP')
addpath('./05MechF','06FunEx')

%EXAMPLE SPHERICAL 4R MECHANISM
%vector of parameters independent of time
%parv = [eta1,phi1,psi,alpha1,alpha2,alpha3,alpha4,beta,gm];
parv = [1.570814, 0.000018,0.270544,0.994839,0.401429,0.820339,0.925033, ...
0.230678,0.474378];

%errors
da=5e-4; %this presicion (in meters) can be easy achieved when constructing
         %a mechanism

dth = 0; deta1 = da; dphi1 = da; dpsi = da;
dalpha1 = da; dalpha2 = da; dalpha3 = da; dalpha4 = da;
dbeta = da; dgm = da;

%vectors of errors
dq0pv = dth;
dparv = [deta1,dphi1,dpsi,dalpha1,dalpha2,dalpha3,dalpha4,dbeta,dgm]; 

q0p = 1.1; 
q1p = 1; %constant angular velocity; thus, q2p, q3p, q4p are zero
q2p = 0; 
q3p = 0;
q4p = 0;

%The functions ErrPropMCNormal and ErrPropMCUniform are not vectorized
%For a large mr, the calculation may be slow (specially in Octave)
mr = 300; %To conduct the statistics, this is for illustrative purposes, 
          %increase this value for better results

%The CouplerPointSPH4R function produces a ket vector. Since this function 
%is not vectorized, and since the ErrPropMCNormal function uses the 
%vectorizef2a function, we define the below auxiliary function.
bra_CouplerPointSPH4R = @(q,pars) transpose(CouplerPointSPH4R(q,pars));

%Kinematic quantities as function of q and pars.
pvaj = @(q,pars) KinQ04(bra_CouplerPointSPH4R,q4p,q3p,q2p,q1p,q,pars);

if exist('OCTAVE_VERSION', 'builtin')
    pkg load statistics; %<--- for Octave
end

DKQ04N = ErrPropMCNormal(pvaj,q0p,parv,dq0pv,dparv,mr,'vec');
DKCN = num2cell(DKQ04N,2);
[DFN,DVN,DAN,DJN,DSN] = DKCN{:};

ndcp = ceil(abs(log10(da))) + 1;

disp('Error propagation using the MC method.')
disp('Normal distribution case.')
disp('error propagation on the position')
print_mat(DFN,ndcp)

disp('error propagation on the velocity')
print_mat(DVN,ndcp)

disp('error propagation on the acceleration')
print_mat(DAN,ndcp)

disp('error propagation on the jerk')
print_mat(DJN,ndcp)

disp('error propagation on the jounce/snap')
print_mat(DSN,ndcp)
disp('----------')

DKQ04U = ErrPropMCUniform(pvaj,q0p,parv,dq0pv,dparv,mr,'vec');
DKCU = num2cell(DKQ04U,2);
[DFU,DVU,DAU,DJU,DSU] = DKCU{:};

disp('Error propagation using the MC method.')
disp('Uniform distribution case.')
disp('error propagation on the position')
print_mat(DFU,ndcp)

disp('error propagation on the velocity')
print_mat(DVU,ndcp)

disp('error propagation on the acceleration')
print_mat(DAU,ndcp)

disp('error propagation on the jerk')
print_mat(DJU,ndcp)

disp('error propagation on the jounce/snap')
print_mat(DSU,ndcp)
disp('----------')



