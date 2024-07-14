%vectorize a function of 2 vector arguments (arguments are not members 
%of a user defined class, except for the dualx class --x=1,2,3,4)
%the efficiency is not increased, this is just for convenience
%
%fsv = vectorizef2a(@fs);
%Output variables
%fsv: function_handle of two arguments
%Input variables
%fs: a function of two variables. F = fs(r1,r2); r1 and r2 must be 
%   bra-vectors. F is also a row vector. If F is ket vector 
%   define an auxiliar function faux = @(a,b) transpose(fs(a,b))
%
%M = fsv(Rm1,Rm2), M=[fs(Rm(1,:),Rm2(1,:));....;fs(Rm1(end,:),Rm2(end,:))]
%
%Rm1 is a m1 x n1 matrix
%Rm2 is a m2 x n2 matrix
%m1=m2, or: 
%if m1>m2 then m2 must be 1 and Rm2 is replicated m1 times
%if m2>m1 then m1 must be 1 and Rm1 is replicated m2 times

%F. Penunuri
function frv = vectorizef2a(f)
    frv=@(Rm1,Rm2) faux(f,Rm1,Rm2);  
end

function mvals = faux(ff,r1,r2)        
    m1=size(r1,1);
    m2=size(r2,1);
    m=m1;
    if(m1<m2)
        m=m2;
        %r1=kron(r1,ones(m2,1));
        r1=repmat(r1,[m2,1]);
    elseif(m2<m1)
        %r2=kron(r2,ones(m1,1));
        r2=repmat(r2,[m1,1]);
    end
    
    aux1=ff(r1(1,:),r2(1,:));
    if(size(aux1,1) ~= 1)
      error(['For this case, function must be a row vector '...
              'Type ''help vectorizef2a'' for more information'])
    end
    
    sx=size(aux1);
    rng=numel(sx);
    indx=repmat({':'},1,rng);
    indx{1}=1;
    sx(1)=m;
    
    if(isa(aux1,'dual1'))
        mvals=dual1(zeros(sx));
    elseif(isa(aux1,'dual2'))
        mvals=dual2(zeros(sx));
    elseif(isa(aux1,'dual3'))
        mvals=dual3(zeros(sx));
    elseif(isa(aux1,'dual4'))
        mvals=dual4(zeros(sx));
    else
        mvals=zeros(sx);
    end
    
    mvals(indx{:})=aux1;
    for k=2:m
        indx{1}=k;
        mvals(indx{:})=ff(r1(k,:),r2(k,:));
    end
end

