%[DF,DV,DA,DJ] = ErrorPKinQ03DCSA(f,q3p,q2p,q1p,q0p,parv,dq0p,dparv)
%output variables
%DF: error propagation on the position vector
%DV: error propagation on the velocity vector
%DA: error propagation on the acceleration vector
%DJ: error propagation on the jerk vector
%
%Input variables
%f: a function F=f(q,parv), this is the position vector as function of the
%   generalized coordinates q and some other parameters pars, independent 
%   of time
%q3p,q2p,q1p,q0p: vectors that store, the time derivatives of the 
%   generalized coordinates.
%parv: other parameters independent of time, is the same argument of
%   function f.
%dq0p: Errors or uncertainties on the generalized coordinates, usually 
%   assumed to be zero
%dparv: error or uncertainties on the parameters independent of time
%
%Due to the complex steep approximation method, this only works for real 
%valued functions. For the complex case use ErrorFD, ErrorVD, ErrorAD, 
%ErrorJD, for error propagation on the 0th, 1th, 2th, and 3th time 
%derivatives of f.
%This function is vectorized in q3p,q2p,q1p,q0p,parv,dparv (although f will 
%dictate the kind of arguments)
%
function [DF,DV,DA,DJ] = ErrorPKinQ03DCSA(f,q3p,q2p,q1p,q0p,parv,dq0p,dparv)
  h=5e-14; %For the first-order derivative, the CSA method does not suffer
           %from cancellation errors; we can use a very small h
  
  [m,n]=size(parv);
  cerom = zeros(m,n);
  ih = 1i*h*ones(m,1);
  ihm = cerom;
  ihm(:,1) = ih;
  %considering errors on parameters
  suma = (dparv(:,1).*imag(KinQ03(f,q3p,q2p,q1p,q0p,parv+ihm)/h)).^2;
  for k=2:n
    ihm = cerom;
    ihm(:,k) = ih;
    suma = suma + (dparv(:,k).*...
                   imag(KinQ03(f,q3p,q2p,q1p,q0p,parv+ihm))/h).^2;
  end

  [m,n]=size(q0p);
  cerom = zeros(m,n);
  ih = 1i*h*ones(m,1);
  ihm = cerom;
  ihm(:,1) = ih;
  
  %also considering error on coordinates
  suma = suma + ...
         (dq0p(:,1).*imag(KinQ03(f,q3p,q2p,q1p,q0p+ihm,parv)/h)).^2;

  for k=2:n
    ihm = cerom;
    ihm(:,k) = ih;
    suma = suma + (dq0p(:,k).*...
                   imag(KinQ03(f,q3p,q2p,q1p,q0p+ihm,parv))/h).^2;
  end

  fr = sqrt(suma); %this is essentially the error propagation 
                   %(Eq. 5 of the paper for kinematic quantities)
  
  %to give result in convenient form
  sx = size(fr);
  rng = numel(sx);
  indx = repmat({':'},1,rng);
  nout=4;
  frc = cell(1,nout);
  for k=1:nout
    indx{end} = k;
    frc{k} = fr(indx{:});
  end
  
  [DF,DV,DA,DJ] = frc{:};
end


