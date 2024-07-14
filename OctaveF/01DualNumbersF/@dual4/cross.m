%cross(A,B,dim) product
%The elements of A and B can be dual4 numbers
%|A> = |A0> + |A1> eps + |A2> eps2 + |A3> eps3 + |A4> eps4; |B> = ...
%As in the conjg and abs functions, here, the dual parts are (df)* not
%d(f*)

%F. Penunuri
%UADY
function fr = cross(varargin)
if(nargin==2)
    A = varargin{1};
    B = varargin{2};    
    fr = cross2argsd4(A,B);
elseif(nargin==3)
    A = varargin{1};
    B = varargin{2};    
    dim = varargin{3};        
    fr = cross3argsd4(A,B,dim);        
else
    error('wrong number of arguments in dual4/cross function')          
end
end

function fr = cross3argsd4(A,B,dim)
if(isa(A,'dual4') && isa(B,'dual4'))
    A0 = A.f0; A1 = A.f1; A2 = A.f2; A3 = A.f3; A4 = A.f4;
    B0 = B.f0; B1 = B.f1; B2 = B.f2; B3 = B.f3; B4 = B.f4;
    fr0 = cross(A0,B0,dim);
    fr1 = cross(A1,B0,dim) + cross(A0,B1,dim);
    fr2 = cross(A0,B2,dim) + 2.*cross(A1,B1,dim) + cross(A2,B0,dim);
    fr3 = cross(A0,B3,dim) + 3.*cross(A1,B2,dim) + 3.*cross(A2,B1,dim) + ...
      cross(A3,B0,dim);
  
    fr4 = cross(A0,B4,dim) + 4.*cross(A1,B3,dim) + 6.*cross(A2,B2,dim) + ...
      4.*cross(A3,B1,dim) + cross(A4,B0,dim);
  
    fr  = dual4(fr0,fr1,fr2,fr3,fr4);
elseif(isa(A,'dual4') && ~(isa(B,'dual4')))
    B = dual4(B);
    A0 = A.f0; A1 = A.f1; A2 = A.f2; A3 = A.f3; A4 = A.f4;
    B0 = B.f0; B1 = B.f1; B2 = B.f2; B3 = B.f3; B4 = B.f4;
    fr0 = cross(A0,B0,dim);
    fr1 = cross(A1,B0,dim) + cross(A0,B1,dim);
    fr2 = cross(A0,B2,dim) + 2.*cross(A1,B1,dim) + cross(A2,B0,dim);
    fr3 = cross(A0,B3,dim) + 3.*cross(A1,B2,dim) + 3.*cross(A2,B1,dim) + ...
      cross(A3,B0,dim);
  
    fr4 = cross(A0,B4,dim) + 4.*cross(A1,B3,dim) + 6.*cross(A2,B2,dim) + ...
      4.*cross(A3,B1,dim) + cross(A4,B0,dim);
  
    fr  = dual4(fr0,fr1,fr2,fr3,fr4);
elseif(~(isa(A,'dual4')) && isa(B,'dual4'))
    A = dual4(A);
    A0 = A.f0; A1 = A.f1; A2 = A.f2; A3 = A.f3; A4 = A.f4;
    B0 = B.f0; B1 = B.f1; B2 = B.f2; B3 = B.f3; B4 = B.f4;
    fr0 = cross(A0,B0,dim);
    fr1 = cross(A1,B0,dim) + cross(A0,B1,dim);
    fr2 = cross(A0,B2,dim) + 2.*cross(A1,B1,dim) + cross(A2,B0,dim);
    fr3 = cross(A0,B3,dim) + 3.*cross(A1,B2,dim) + 3.*cross(A2,B1,dim) + ...
      cross(A3,B0,dim);
  
    fr4 = cross(A0,B4,dim) + 4.*cross(A1,B3,dim) + 6.*cross(A2,B2,dim) + ...
      4.*cross(A3,B1,dim) + cross(A4,B0,dim);
  
    fr  = dual4(fr0,fr1,fr2,fr3,fr4);
else
    fr = cross(A,B,dim);
end
end

function fr = cross2argsd4(A,B)
if(isa(A,'dual4') && isa(B,'dual4'))
    A0 = A.f0; A1 = A.f1; A2 = A.f2; A3 = A.f3; A4 = A.f4;
    B0 = B.f0; B1 = B.f1; B2 = B.f2; B3 = B.f3; B4 = B.f4;
    fr0 = cross(A0,B0);
    fr1 = cross(A1,B0) + cross(A0,B1);
    fr2 = cross(A0,B2) + 2.*cross(A1,B1) + cross(A2,B0);
    fr3 = cross(A0,B3) + 3.*cross(A1,B2) + 3.*cross(A2,B1) + cross(A3,B0);  
    fr4 = cross(A0,B4) + 4.*cross(A1,B3) + 6.*cross(A2,B2) + ...
      4.*cross(A3,B1) + cross(A4,B0);
  
    fr  = dual4(fr0,fr1,fr2,fr3,fr4);
elseif(isa(A,'dual4') && ~(isa(B,'dual4')))
    B=dual4(B);
    A0 = A.f0; A1 = A.f1; A2 = A.f2; A3 = A.f3; A4 = A.f4;
    B0 = B.f0; B1 = B.f1; B2 = B.f2; B3 = B.f3; B4 = B.f4;
    fr0 = cross(A0,B0);
    fr1 = cross(A1,B0) + cross(A0,B1);
    fr2 = cross(A0,B2) + 2.*cross(A1,B1) + cross(A2,B0);
    fr3 = cross(A0,B3) + 3.*cross(A1,B2) + 3.*cross(A2,B1) + cross(A3,B0);  
    fr4 = cross(A0,B4) + 4.*cross(A1,B3) + 6.*cross(A2,B2) + ...
      4.*cross(A3,B1) + cross(A4,B0);
  
    fr  = dual4(fr0,fr1,fr2,fr3,fr4);
elseif(~(isa(A,'dual4')) && isa(B,'dual4'))
    A=dual4(A);
    A0 = A.f0; A1 = A.f1; A2 = A.f2; A3 = A.f3; A4 = A.f4;
    B0 = B.f0; B1 = B.f1; B2 = B.f2; B3 = B.f3; B4 = B.f4;
    fr0 = cross(A0,B0);
    fr1 = cross(A1,B0) + cross(A0,B1);
    fr2 = cross(A0,B2) + 2.*cross(A1,B1) + cross(A2,B0);
    fr3 = cross(A0,B3) + 3.*cross(A1,B2) + 3.*cross(A2,B1) + cross(A3,B0);  
    fr4 = cross(A0,B4) + 4.*cross(A1,B3) + 6.*cross(A2,B2) + ...
      4.*cross(A3,B1) + cross(A4,B0);
  
    fr  = dual4(fr0,fr1,fr2,fr3,fr4);
else
    fr = cross(A,B);
end
end

  
