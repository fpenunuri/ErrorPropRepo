%fr = d3mlf(f,x,y,z,q)
%output variables
%fr: third order directional derivative of function f 
%   input variables
%f: F = f(q) is a user defined function (F can be row vector, column 
%   vector, matrix, etc)
%x, y, z: vectors along the which the directional derivative is computed
%q: the argument of function f. It is also the point where the directional
%   derivative is evaluated
%Note: d3mlf(f,x,q) = d3mlf(f,x,x,x,q)
%This function corresponds to the computer implementation of Eq. 91 (or 72 
%for the scalar case) from https://doi.org/10.1016/j.jocs.2024.102217.

function fr = d3mlf(f,x,varargin)
    if (nargin == 5)
        y = varargin{1};
        z = varargin{2};
        q = varargin{3};
        fr = 0.5.*(d32mlf(f,x+y,z,q) - d32mlf(f,x,z,q) - d32mlf(f,y,z,q));
    elseif (nargin == 3)
        q = varargin{1};
        fr = d31mlf(f, x, q);
    else
        error('Invalid number of input arguments');
    end
end


function fr = d32mlf(f,x,z,q)    
    fr = (d31mlf(f,x+z,q) + d31mlf(f,z-x,q) - 2.*d31mlf(f,z,q))./6;
end

%The third-rank directional derivative needs three vectors; however, since 
%the three vectors are equal, we only use one argument v. Instead of 
%defining d31mlf(f,v,v,v,q) we use d31mlf(f,v,q)
function fr = d31mlf(f,x,q)
    eps1 =  dual3(0,1,0,0);
    fqd = f(q + eps1.*x);
    fr = fqd.f3;
end
