%fr = d1mlf(f,v,q)
%output variables
%fr: first order directional derivative of function f 
%   input variables
%f: F = f(q) is a user defined function (F can be row vector, column 
%   vector, matrix, etc)
%v: vector along the directional derivative is computed
%q: the argument of function f. It is also the point where the directional
%   derivative is evaluated
function fr = d1mlf(f,v,q)
    eps1 =  dual1(0,1);
    fqd = f(q + eps1.*v);
    fr = fqd.f1;
end
