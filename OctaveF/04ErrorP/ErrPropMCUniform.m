%Error propagation using uniformly randomly distributed points.
%DF = ErrPropMCUniform(f,q0p,parv,dq0p,dparv,m,argk)
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

function fr=ErrPropMCUniform(f,q0p,parv,dq0p,dparv,m,argk)
    bL=parv - dparv;
    bU=parv + dparv;
    randP=X0(m,bL,bU);
    
    bL=q0p - dq0p;
    bU=q0p + dq0p;
    randQ=X0(m,bL,bU);
    
    if(strcmpi(argk,'mat'))
        mvals=f(randQ,randP);
    elseif(strcmpi(argk,'vec'))
    aux = f(q0p,parv);
    if(size(aux,1) ~= 1)
      sr0 = 'For this case, the function argument ';
      sr1 = 'must have 1 as its first dimension. ';
      sr2 = 'Type ''help vectorizef2a'' for more information';
      error([sr0,sr1,sr2])
    end
        faux=vectorizef2a(f);
        mvals=faux(randQ,randP);
    else
        error("argk in ErrPropMCUniform function must be 'mat' or 'vec'");
    end
    fr=sqrt(var(mvals,1,1))*sqrt(3);   
end

%to generate m random vectors in V(bL,bU)
function fr=X0(m,bL,bU)
    fr=bL + rand(m,size(bL,2)).*(bU-bL);
end


