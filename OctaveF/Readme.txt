The folders "01DualNumbersF" and "02DMLF" were downloaded from:
R. Peón-Escalante, K.B. Cantún-Avila, O. Carvente, A. Espinosa-Romero, F.
Peñuñuri, Dual number implementation to compute higher order directional
derivatives, Mendeley Data, v1, 2022. http://dx.doi.org/10.17632/kcrm6pmk7d.3.

It is also recommended ref:
R. Peón-Escalante, K. Cantún-Avila, O. Carvente, A. Espinosa-Romero,
F. Peñuñuri, A dual number formulation to efficiently compute higher order
directional derivatives, Journal of Computational Science 76 (2024) 102217.
doi:10.1016/j.jocs.2024.102217.

To make the implementation Octave-compatible, we have included the 'num2cell'
function. 

The folders "03AuxiliarDualFun", "04ErrorP", and "05MechF" contain the 
implementation of our study about error propagation on kinematic quantities.

The Folder "06FunEx" contains auxiliary functions to the examples of our study.

The files "Err_prop_RCR_Det.m", "Err_prop_RCR_MC.m", "Err_prop_SPH4R_Det.m",
"Err_prop_SPH4R_MC.m", and "ErrPropP4R.m" contain the examples of the paper.

For help, on a Matlab/Octave command windows type: help function_name, where
function_name is one of: 
a) folder "02DMLF":
d1mlf, d2mlf, d3mlf, and d4mlf

b) folder "03AuxiliarDualFun":
args2duals, f2dualf

c) folder "04ErrorP":
ErrorAD, ErrorFD, ErrorJD, ErrorPKinQ03DCSA, ErrorPKinQDCSA, ErrorVD, 
ErrPropMCNormal, ErrPropMCUniform, KinQ03, KinQ04, and vectorizef2a

d) folder "05MechF":
absX, HTM, rot_mat, Scross, sp, vtangent, vuni

e) folder "06FunEx":
CouplerPoint4R, CouplerPointSPH4R, print_mat, rposD, rposDX, sph4r_vars


Although care has been taken on writing the code, there is not guaranteed to 
be free of error. The use of the dual classes it is entirely at the user's 
risk and the author disclaims all liability.

F. Peñuñuri
