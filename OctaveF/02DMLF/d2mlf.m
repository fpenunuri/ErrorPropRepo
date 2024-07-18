%fr = d2mlf(f,x,y,q)
%output variables
%fr: second order directional derivative of function f 
%   input variables
%f: F = f(q) is a user defined function (F can be row vector, column 
%   vector, matrix, etc)
%x, y: vectors along the which the directional derivative is computed
%q: the argument of function f. It is also the point where the directional
%   derivative is evaluated
%Note: d2mlf(f,x,q) = d2mlf(f,x,x,q)
%This function corresponds to the computer implementation of Eq. 90 (or 71 
%for the scalar case) from https://doi.org/10.1016/j.jocs.2024.102217.

function fr = d2mlf(f,x,varargin)
    if (nargin == 4)
        y = varargin{1};
        q = varargin{2};
        fr = 0.5.*(d21mlf(f,x+y,q) - d21mlf(f,x,q) - d21mlf(f,y,q));
    elseif (nargin == 3)
        q = varargin{1};
        fr = d21mlf(f, x, q);
    else
        error('Invalid number of input arguments');
    end
end

%The second-rank directional derivative needs two vectors; however, since 
%the two vectors are equal, we only use one argument v. Instead of defining
%d21mlf(f,v,v,q) we use d21mlf(f,v,q)
function fr = d21mlf(f,v,q)
    eps1 =  dual2(0,1,0);
    fqd = f(q + eps1.*v);
    fr = fqd.f2;
end



