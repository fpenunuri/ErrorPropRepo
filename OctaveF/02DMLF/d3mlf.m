%fr = d3mlf(f,x,y,z,q)
%output variables
%fr: third order directional derivative of function f 
%   input variables
%f: F = f(q) is a user defined function (F can be row vector, column 
%   vector, matrix, etc)
%x, y, z: vectors along the which the directional derivative is computed
%q: the argument of function f. It is also the point where the directional
%   derivative is evaluated

function fr = d3mlf(f,x,y,z,q)
    fr = 0.5.*(d32mlf(f,x+y,z,q) - d32mlf(f,x,z,q) - d32mlf(f,y,z,q));
end

function fr = d32mlf(f,x,z,q)    
    fr = (d31mlf(f,x+z,q) + d31mlf(f,z-x,q) - 2.*d31mlf(f,z,q))./6;
end

function fr = d31mlf(f,x,q)
    eps1 =  dual3(0,1,0,0);
    fqd = f(q + eps1.*x);
    fr = fqd.f3;
end
