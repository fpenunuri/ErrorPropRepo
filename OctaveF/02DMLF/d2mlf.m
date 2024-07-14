%fr = d2mlf(f,x,y,q)
%output variables
%fr: second order directional derivative of function f 
%   input variables
%f: F = f(q) is a user defined function (F can be row vector, column 
%   vector, matrix, etc)
%x, y: vectors along the which the directional derivative is computed
%q: the argument of function f. It is also the point where the directional
%   derivative is evaluated

function fr = d2mlf(f,x,y,q)
    fr = 0.5.*(d21mlf(f,x+y,q) - d21mlf(f,x,q) - d21mlf(f,y,q));
end

function fr = d21mlf(f,v,q)
    eps1 =  dual2(0,1,0);
    fqd = f(q + eps1.*v);
    fr = fqd.f2;
end

