%rg = CouplerPointSPH4R(thv,vd) gives the couple-point curve of the spherical 
%4R mechanism
%OUTPUT VARIABLES
%rg: coupler point column vector for the spherical 4R mechanism
%INPUT VARIABLES
%th: input angle
%vd: design variable vector 
%vd = [eta1,phi1,psi,alpha1,alpha2,alpha3,alpha4,beta,gm] 
%a small quantity is taken as 1e-13 (see function 'sph4r_vars')

function fr = CouplerPointSPH4R(th,vd)
   [~,~,~,fr,~,~,~,~] =  sph4r_vars(th,vd);
 end
 
