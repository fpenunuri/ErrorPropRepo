%FVAJS = KinQ04(f,q4p,q3p,q2p,q1p,q0p,pars)
%output variables
%FVAJS: tensor with the n-th order derivative of f; n=0,1,2,3,4
%
%input variables
%f: the function to differentiate. F = f(q, pars), F is defined by the user
%it could be a quantity with any number of indices. Nevertheless ussually 
%is a vector or a matrix. The vector q stores the generalized coordinates, 
%pars is an optional parameter independent of time.
%q4p,q3p,q2p,q1p,q0p: vectors that store, the time derivatives of 
%the generalized coordinates. Deppending of how is the f function coded, 
%all the vectors can be row or column vectors.
%qkp=(d/dt)^k q; k = 0,1,2,3,4.
%pars: optional vector storing other parameters independent of time, 
%which is the same argument that appears in the function f
function fr = KinQ04(f,q4p,q3p,q2p,q1p,q0p,pars)
  taux = dual4(0,1,0,0,0);
  Xt = q0p + taux.*q1p + taux.^2 .* q2p./2 + taux.^3 .* q3p./6 + ...
       taux.^4 .* q4p./24;
  
  fr = f(Xt,pars);
  rango = numel(size(fr));
  fr = cat(rango+1,fr.f0,fr.f1,fr.f2,fr.f3,fr.f4);
end
