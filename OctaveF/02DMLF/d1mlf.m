%fr = d1mlf(f,v,q)
%output variables
%fr: first order directional derivative of function f 
%   input variables
%f: F = f(q) is a user defined function (F can be row vector, column 
%   vector, matrix, etc)
%v: vector along the directional derivative is computed
%q: the argument of function f. It is also the point where the directional
%   derivative is evaluated
%This function corresponds to the computer implementation of Eq. 86 (or 66 
%for the scalar case) from https://doi.org/10.1016/j.jocs.2024.102217.

function fr = d1mlf(f,v,q)
    eps1 =  dual1(0,1);
    fqd = f(q + eps1.*v);
    fr = fqd.f1;
end
