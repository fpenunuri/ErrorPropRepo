%rgen = CouplerPoint4R(th, pars) 
%calculates the coordinates (position vector) of the coupler point for a 
%planar 4R mechanism, assuming circuit = -1 (negative root in th3).

%th can be a scalar, a 1xn row vector, or an mxn matrix.
%pars = [x0, y0, r1, r2, r3, r4, rcx, rcy, psi]
%x0, y0, r1, r2, r3, r4, rcx, rcy, psi can be scalars (in which case pars 
%would be a row vector) or mx1 column vectors (in which case pars would be 
%of size m*9). If th is a 1xn row vector and the other variables are 
%scalars, rgen is obtained for the same mechanism but at n different input 
%angles th. If th is an mxn matrix (and the other parameters are mx1), rgen 
%is obtained for m different mechanisms, each evaluated at n different 
%input angles.

%This function returns "NaN" if the mechanism cannot be physically 
%assembled with the specified parameters. In general, rgen is of size 
%mx2xn, where the first index is for the different mechanisms, the second 
%index is for the x or y coordinates of the coupler point, and the third 
%index refers to the nth point of the trajectory (corresponding to the nth 
%input angle). If you want the first index to correspond to the points 
%instead of the different mechanisms, you can use 
%rgper = permute(rgen, [3, 2, 1])

% Universidad Autonoma de Yucatan
% F. Penunuri
function [rgen] = CouplerPoint4R(th,pars)
    
    n2c_pars = num2cell(pars,1);     
    [x0, y0, r1 ,r2, r3, r4, rcx, rcy, psi] = n2c_pars{:};
      
    L3 = (r4.^2 - r1.^2 - r2.^2 - r3.^2)./(2.0*r2.*r3);
    L2 = r1./r3;
    L1 = r1./r2;
    
    cth = cos(th);
    sth = sin(th);

    ka = cth + L3 - L1 + L2.*cth;
    kb = -2.0*sth;
    kc = L1 + L3 + (L2 - 1.0).*cth;
    disc = kb.^2 - 4*ka.*kc;
    disc(disc<0) = NaN;
    
    nc = size(th,2); 
    nr = length(x0);
    
    th3 = 2.0*atan2(-kb -sqrt(disc),2.0*ka);
    
    cth3 = cos(th3);
    sth3 = sin(th3);

    r2cth   = r2.*cth;
    rcxcth3 = rcx.*cth3;
    rcysth3 = rcy.*sth3;
    r2sth   = r2.*sth;
    rcxsth3 = rcx.*sth3;
    rcycth3 = rcy.*cth3;

    pxn0 = cos(psi).*(r2cth + rcxcth3 - rcysth3) - ...
           sin(psi).*(r2sth + rcxsth3 + rcycth3);

    pyn0 = sin(psi).*(r2cth + rcxcth3 - rcysth3) + ...
           cos(psi).*(r2sth + rcxsth3 + rcycth3);
    
    px = x0 + pxn0;
    py = y0 + pyn0;
    
    rgenaux = cat(1,px,py);
    rgen = reshape(rgenaux,[nr,2,nc]);  
end


