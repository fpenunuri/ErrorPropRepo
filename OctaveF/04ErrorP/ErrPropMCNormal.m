%Error propagation using randomly normally distributed points.
%DF = ErrPropMCNormal(f,q0p,parv,dq0p,dparv,m,argk)
%output variables
%DF: Error propagation on function f
%Input variables
%f: a function F=f(q,parv), this is the 'position' vector as function of
%   the generalized coordinates q and some other parameters pars, indepen-
%   dent of time
%q0p: row-vector that stores the values for the generalized coordinates
%parv: row-vector with parameters independent of time, is the same argument 
%   of function f.
%dq0p: row-vector with the errors or uncertainties on the generalized 
%    coordinates, usually assumed to be zero
%dparv: row-vector with the error or uncertainties on the parameters 
%    independent of time
%m: number of random realizations
%argk: argument to specify if f accept matrices or vectors as arguments.
%
function fr=ErrPropMCNormal(f,q0p,parv,dq0p,dparv,m,argk)
  Xm=normrnd(kron(parv,ones(m,1)),kron(dparv,ones(m,1)));
  q0pm=normrnd(kron(q0p,ones(m,1)),kron(dq0p,ones(m,1)));
  if(strcmpi(argk,'mat'))
    mvals=f(q0pm,Xm);
  elseif(strcmpi(argk,'vec'))
    aux = f(q0p,parv);
    if(size(aux,1) ~= 1)
      sr0 = 'For this case, the function argument ';
      sr1 = 'must have 1 as its first dimension. ';
      sr2 = 'Type ''help vectorizef2a'' for more information';
      error([sr0,sr1,sr2])
    end
    faux = vectorizef2a(f);
    mvals = faux(q0pm,Xm);
  else
    error("argk in ErrPropMCNormal function must be 'mat' or 'vec'");
  end
  fr=sqrt(var(mvals,1));
end

