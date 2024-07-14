addpath('./01DualNumbersF','03AuxiliarDualFun','./04ErrorP')
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

%error on generalized coordinates (taken as 0) and parameters
dqparv = [0,0,0,0,da,da];
DOF=4;
dq0p=dqparv(1:DOF);
dpar=dqparv(DOF+1:end);

%The functions ErrPropMCNormal and ErrPropMCUniform are not vectorized
%For a large mr, the calculation may be slow (specially in Octave)
mr = 500; %to conduct the statistics

%kinematic quantities as function of q and pars
pvaj = @(q,pars) KinQ03(@rposD,q3p,q2p,q1p,q,pars);

if exist('OCTAVE_VERSION', 'builtin')
    pkg load statistics; %<--- for Octave
end
%rposD is not 'vectorized'
DKQ03N = ErrPropMCNormal(pvaj,q0p,parv,dq0p,dpar,mr,'vec');

DKCN = num2cell(DKQ03N,2);
[DFN,DVN,DAN,DJN] = DKCN{:};

%We can use a uniform distribution instead. For small values of da, 
%varNormal = 3 varUniform (See appendix of the paper)
DKQ03U = ErrPropMCUniform(pvaj,q0p,parv,dq0p,dpar,mr,'vec');

DKCU = num2cell(DKQ03U,2);
[DFU,DVU,DAU,DJU] = DKCU{:};

ndcp = ceil(abs(log10(da))) + 1;

disp('error propagation using the MC method')
disp('Normal distribution case')
disp('error propagation on the position')
print_mat(DFN,ndcp)

disp('error propagation on the velocity')
print_mat(DVN,ndcp)

disp('error propagation on the acceleration')
print_mat(DAN,ndcp)

disp('error propagation on the jerk')
print_mat(DJN,ndcp)
disp('----------')

disp('error propagation using the MC method')
disp('Uniform distribution case')
disp('error propagation on the position')
print_mat(DFU,ndcp)

disp('error propagation on the velocity')
print_mat(DVU,ndcp)

disp('error propagation on the acceleration')
print_mat(DAU,ndcp)

disp('error propagation on the jerk')
print_mat(DJU,ndcp)



