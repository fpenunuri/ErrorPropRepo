%Error propagation on jerk (the third order time derivative of 
%function f). This function is vectorize
%FR = ErrorJD(f,q3p,q2p,q1p,q,a,dqa) computes the error propagation on 
%the third order time derivative of function f.
%f: function f(q,a)
%   q and a are vector or matrices of the same size
%   q are the generalized coordinates, a are time-independent parameters
%   f1 = f(q_vec1,a_vec1), f2 = f(q_vec2,a_vec2) 
%   F  = f([q_vec1;q_vec2],[a_vec1;a_vec2]) = [f1;f2]
%q3p: 3th-time derivative of generalized coordinates at a given time
%q2p: 2th-time derivative of generalized coordinates at a given time
%q1p: 1th-time derivative of generalized coordinates at a given time
%q: 0th-time derivative of generalized coordinates at a given time
%dqa: is a vector or matrix with the error on q and a (ussually, errors  
%     on coordinates are taken as zero)
%     size(dqa,2) = size(q,2) + size(a,2) 
%
%Both, the kinematic quantities and the error propagation are computed with
%dual numbers. Nevertheless, the efficiency is slow compared to function
%ErrorPKinQDCSA which only uses the dual number to compute the kinematic
%quantities while the complex steep approximation (CSA) method is used to 
%compute the error propagation. Although, the CSA only works for real 
%functions. 

%F. Penunuri
%Yucatan Mexico 2024.
function fr=ErrorJD(f,qv3p,qv2p,qv1p,qv0p,parv,dqparv)
    m1 = size(qv0p,2);
    [r2,m2] = size(parv);
    M = m1 + m2;    
    %the dxmlf (x=1,2,3,4) functions do not sepparate coordinates from
    %parameters, we create the auxiliar ff function to 'join', the
    %variables.
    ff = @(q) f(q(:,1:m1),q(:,m1+1:M));
    BE = eye(M);
    qpM = cat(2,qv0p,parv);
    qv1pX = cat(2,qv1p,zeros(r2,m2)); %parameters are independent of time
    qv2pX = cat(2,qv2p,zeros(r2,m2));
    qv3pX = cat(2,qv3p,zeros(r2,m2));
        
    suma = (d4mlf(ff,qv1pX,qv1pX,qv1pX,dqparv(:,1).*BE(1,:),qpM) + ...
            3*d3mlf(ff,qv2pX,qv1pX,dqparv(:,1).*BE(1,:),qpM) + ...
            d2mlf(ff,qv3pX,dqparv(:,1).*BE(1,:),qpM)).^2;
                        
    for k=2:M  
        suma = suma + ...
            (d4mlf(ff,qv1pX,qv1pX,qv1pX,dqparv(:,k).*BE(k,:),qpM) + ...
            3*d3mlf(ff,qv2pX,qv1pX,dqparv(:,k).*BE(k,:),qpM) + ...
            d2mlf(ff,qv3pX,dqparv(:,k).*BE(k,:),qpM)).^2;
    end
    fr = sqrt(suma);
end

