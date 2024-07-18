%fr = d4mlf(f,x,y,z,w,q)
%output variables
%fr: fourth order directional derivative of function f 
%   input variables
%f: F = f(q) is a user defined function (F can be row vector, column 
%   vector, matrix, etc)
%x, y, z, w: vectors along the which the directional derivative is computed
%q: the argument of function f. It is also the point where the directional
%   derivative is evaluated
%Note: d4mlf(f,x,q) = d4mlf(f,x,x,x,x,q)
%This function corresponds to the computer implementation of Eq. 93 (or 79 
%for the scalar case) from https://doi.org/10.1016/j.jocs.2024.102217.

function fr = d4mlf(f,x,varargin)
    if (nargin == 6)
        y = varargin{1};
        z = varargin{2};
        w = varargin{3};
        q = varargin{4};
        fr = 0.5.*(d43mlf(f,x+y,z,w,q) - d43mlf(f,x,z,w,q) - ...
        d43mlf(f,y,z,w,q));
    elseif (nargin == 3)
        q = varargin{1};
        fr = d41mlf(f, x, q);
    else
        error('Invalid number of input arguments');
    end
end


function fr = d43mlf(f,x,z,w,q)
    fr = 0.5.*(d42mlf(f,x,z+w,q) - d42mlf(f,x,z,q) - d42mlf(f,x,w,q));
end

function fr = d42mlf(f,x,z,q)    
    d4xzp = d41mlf(f, x + z, q);
    d4xzm = d41mlf(f, x - z, q);
    fr = (d4xzp + d4xzm - 2.*d41mlf(f,x,q) - 2.*d41mlf(f,z,q))./12;
end

%The fourth-rank directional derivative needs four vectors; however, since 
%the four vectors are equal, we only use one argument v. Instead of 
%defining d41mlf(f,v,v,v,v,q) we use d41mlf(f,v,q)
function fr = d41mlf(f,x,q)
    eps1 =  dual4(0,1,0,0,0);
    fqd = f(q + eps1.*x);
    fr = fqd.f4;
end
