%Error propagation on acceleration (the second order time derivative of 
%function f). This function is vectorized
%FR = ErrorAD(f,q2p,q1p,q,a,dqa) computes the error propagation on 
%the second order time derivative of function f
%f: function f(q,a)
%   q and a are vector or matrices of the same size
%   q are the generalized coordinates, a are time-independent parameters
%   f1 = f(q_vec1,a_vec1), f2 = f(q_vec2,a_vec2) 
%   F = f([q_vec1;q_vec2],[a_vec1;a_vec2]) = [f1;f2]
%q2p: 2th-time derivative of generalized coordinates at a given time
%q1p: 1th-time derivative of generalized coordinates at a given time
%q: 0th-time derivative of generalized coordinates at a given time
%dqa: is a vector or matrix with the error on q and a (ussually, the errors  
%     on coordinates are taken as zero)
%     size(dqa,2) = size(q,2) + size(a,2) 

%F. Penunuri
%Yucatan Mexico 2024.
function fr=ErrorAD(f,qv2p,qv1p,qv0p,parv,dqparv)
  m1=size(qv0p,2);
  [r2,m2]=size(parv);
  M=m1+m2;    
  %the dxmlf (x=1,2,3,4) functions do not sepparate coordinates from
  %parameters, we create the auxiliar ff function to 'join', the
  %variables.
  ff=@(q) f(q(:,1:m1),q(:,m1+1:M));
  BE = eye(M);
  qpM = cat(2,qv0p,parv);
  qv1pX = cat(2,qv1p,zeros(r2,m2)); %parameters are independent of time
  qv2pX = cat(2,qv2p,zeros(r2,m2));     
  suma = (d2mlf(ff,qv2pX,dqparv(:,1).*BE(1,:),qpM) + ...
          d3mlf(ff,qv1pX,qv1pX,dqparv(:,1).*BE(1,:),qpM)).^2;
  
  for k=2:M 
    suma = suma + (d2mlf(ff,qv2pX,dqparv(:,k).*BE(k,:),qpM) + ...
                  d3mlf(ff,qv1pX,qv1pX,dqparv(:,k).*BE(k,:),qpM)).^2;
  end
  fr = sqrt(suma);
end




