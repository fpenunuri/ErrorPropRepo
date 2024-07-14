%q: generalized coordinates
%pars: parameters independent of time
%the function do not accept matrices as argument, is not vectorized.
%The function only accept 'vectors' as arguemnts
%position vector of the end effector for the RCR robot manipulator using
%the HTM function
function rpos = rposD(q,par)
    th = q(1); phi = q(2); s=q(3); bt = q(4);

    BC = par(1); CD = par(2);

    %using the 'dualized' HTM function
    T1 = HTM(th,[0,0,1],[0,0,0]);
    T2 = HTM(phi,[1,0,0],[s,0,0]);
    T3 = HTM(0,[0,0,1],[0,0,BC]);
    T4 = HTM(bt,[0,0,1],[0,0,0]);
    T5 = HTM(0,[1,0,0],[CD,0,0]);

    RD = T1*T2*T3*T4*T5; 
    rpos = RD(1:3,4); 
    rpos=rpos.';
end
