addpath('./01DualNumbersF','./02DMLF','./04ErrorP','./05MechF','06FunEx')

%MBDSM---modificar esto
x0  = 0;
y0  = 0;
psi = 0;

r1  = 1.05394;
r2  = 0.42387;
r3  = 0.91424;
r4  = 0.59891;
rcx = 0.37059;
rcy = 0.39934;

%vector of parameters independent of time
parv = [x0, y0, r1, r2, r3, r4, rcx, rcy, psi];

%To exemplify we only consider errors on the legths of the links
da=5e-4; %this presicion (in meters) can be easy achieved when constructing
         %a mechanism

dth = 0; dx0 = 0; dy0 = 0; dpsi = 0;
dr1 = da; dr2 = da; dr3 = da; dr4 = da; drcx = da; drcy = da;

%vector of errors, including in the generalized coordinate th, which is 
%taken as 0. We also do not consider errors on x0,y0 and psi.
dqparv = [dth,dx0,dy0,dr1,dr2,dr3,dr4,drcx,drcy,dpsi]; 

mx=4;
thvx = linspace(0,2*pi,mx);

m = mx-1;
thv = thvx(1:m); %several values for the generalized coordinate (1 DOF)

q0pm = thv';
q1pm = ones(m,1);  %constant angular velocity for crank
q2pm = zeros(m,1); %hence, zero angular acceleration, etc
q3pm = zeros(m,1);

%Error propagation on kinematic quantities using directional derivatives.
%The directional derivatives are computed with dual numbers. See equations
%10,14,15,16 of the paper
%
%Since both, the CouplerPoint4R and the ErrorPKinQDCSA functions are 
%vectorized, we pass directly matrices as arguments
parvm = repmat(parv,[m,1]);     %parameters
dqparvm = repmat(dqparv,[m,1]); %errors on coordinates and parameters

%error propagation on position
DF0 = ErrorFD(@CouplerPoint4R,q0pm,parvm,dqparvm);

%error propagation on velocity
DF1 = ErrorVD(@CouplerPoint4R,q1pm,q0pm,parvm,dqparvm);

%error propagation on acceleration
DF2 = ErrorAD(@CouplerPoint4R,q2pm,q1pm,q0pm,parvm,dqparvm);

%error propagation on jerk
DF3 = ErrorJD(@CouplerPoint4R,q3pm,q2pm,q1pm,q0pm,parvm,dqparvm);

%Unlike the above functions, in the ErrorPKinQDCSA functions, the errors on
%generalized coordinates and parameters are sepparated.
%
%since both, the CouplerPoint4R and the ErrorPKinQDCSA functions are 
%vectorized, we pass directly matrices as arguments


dq0pm = repmat(dqparv(1),[m,1]); % errors on q (which are 0)
dparm = repmat(dqparv(2:end),[m,1]); %errors on the parameters

%In this function the kinematic quantities are computed with dual numbers
%while the variaton on parameters are conducted by the complex steep 
%approximation method
[DF,DV,DA,DJ] = ErrorPKinQ03DCSA(@CouplerPoint4R,q3pm,q2pm,q1pm,...
   q0pm,parvm,dq0pm,dparm);


%with this, also the error propagation on the jounce/snap
%can be computed
%q4pm = zeros(m,1);
%[DF,DV,DA,DJ,DS] = ErrorPKinQDCSA(@CouplerPoint4R,q4pm,q3pm,q2pm,q1pm,...
%    q0pm,parvm,dq0pm,dparm);

%MC error propagation
if exist('OCTAVE_VERSION', 'builtin')
    pkg load statistics; %<--- for Octave
end
%

%The functions ErrPropMCNormal and ErrPropMCUniform are not vectorized
mr = 1000; %to conduct the statistics
DFU=zeros(m,2); DVU=zeros(m,2); DAU=zeros(m,2); DJU=zeros(m,2);
DFN=zeros(m,2); DVN=zeros(m,2); DAN=zeros(m,2); DJN=zeros(m,2);

for k=1:length(thv)
   %auxiliar function which computes position, velocity, acceleration and 
   %jerk. The functions ErrPropMCNormal and ErrPropMCUniform are not 
   %vectorized so, we pass as arguments each one of the rows of qjpm, 
   %j=1,2,3,0
   pvaj = @(q,pars) KinQ03(@CouplerPoint4R,q3pm(k,:),q2pm(k,:),...
       q1pm(k,:),q,pars);

   DKQ03N = ErrPropMCNormal(pvaj,q0pm(k,:),parvm(k,:),dq0pm(k,:),...
       dparm(k,:),mr,'mat');
    
   DKCN = num2cell(DKQ03N,2);
   [DFN(k,:),DVN(k,:),DAN(k,:),DJN(k,:)] = DKCN{:};
   
   %sometimes  MC with a normal distribution can give NANS values
   %We can use a uniform distribution instead. For small values of da, 
   %varNormal = 3 varUniform (See appendix of the paper)
   DKQ03U = ErrPropMCUniform(pvaj,q0pm(k,:),parvm(k,:),dq0pm(k,:),...
       dparm(k,:),mr,'mat');
   
   DKCU = num2cell(DKQ03U,2);
   [DFU(k,:),DVU(k,:),DAU(k,:),DJU(k,:)] = DKCU{:};
end

ndcp = ceil(abs(log10(da))) +1;
disp('error propagation using dual numbers')
disp('The input angles are')
disp(thv)

disp('error propagation on the position')
print_mat(DF0,ndcp)

disp('error propagation on the velocity')
print_mat(DF1,ndcp)

disp('error propagation on the acceleration')
print_mat(DF2,ndcp)

disp('error propagation on the jerk')
print_mat(DF3,ndcp)
disp('----------')

disp('error propagation using dual numbers and the CSA method')
disp('error propagation on the position')
print_mat(DF,ndcp)

disp('error propagation on the velocity')
print_mat(DV,ndcp)

disp('error propagation on the acceleration')
print_mat(DA,ndcp)

disp('error propagation on the jerk')
print_mat(DJ,ndcp)
disp('----------')

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





