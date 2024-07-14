%FR = ErrorFD(f,q,a,dqa) computes the error propagation on position (the 
%     function f). This function is vectorized
%f: function f(q,a)
%   q and a are vector or matrices of the same size
%   q are the generalized coordinates, a are time-independent parameters
%   f1 = f(q_vec1,a_vec1), f2 = f(q_vec2,a_vec2) 
%   F  = f([q_vec1;q_vec2],[a_vec1;a_vec2]) = [f1;f2]
%dqa: is a vector or matrix with the errors in q and a (ussually, the 
%     errors on coordinates are taken as zero)
%     size(dqa,2) = size(q,2) + size(a,2) 

%F. Penunuri
%Yucatan Mexico 2024.
function fr=ErrorFD(f,qv0p,parv,dqparv)
    m1=size(qv0p,2);
    m2=size(parv,2);
    M = m1+m2;
    %the dxmlf (x=1,2,3,4) functions do not sepparate coordinates from
    %parameters, we create the auxiliar ff function to combine the
    %variables 
    ff=@(q) f(q(:,1:m1),q(:,m1+1:M));   
    BE = eye(M);
    qpM = cat(2,qv0p,parv);
    suma = d1mlf(ff,dqparv(:,1).*BE(1,:),qpM).^2;
    for k=2:M  
        suma = suma + d1mlf(ff,dqparv(:,k).*BE(k,:),qpM).^2;
    end
    fr = sqrt(suma);
end
