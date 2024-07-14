%position vector of the end effector for the RCR robot manipulator
function rpos = rposDX(q,par)
    th = q(1); phi = q(2); s=q(3); bt = q(4);

    BC = par(1); CD = par(2);
    
    %strictly speaking, the HTMX function is not 'dualized' (except if all 
    %its arguments are duals), it will fail if th and eje are real while Dr 
    %is dual. Hence, we construct the below function. Alternatively, you
    %can use the HTM function
    HTMD = f2dualf(@HTMX); %we change HTM to dual function

    T1 = HTMD(th,[0,0,1],[0,0,0]);
    T2 = HTMD(phi,[1,0,0],[s,0,0]);
    T3 = HTMD(0,[0,0,1],[0,0,BC]);
    T4 = HTMD(bt,[0,0,1],[0,0,0]);
    T5 = HTMD(0,[1,0,0],[CD,0,0]);

    RD = T1*T2*T3*T4*T5; 
    rpos = RD(1:3,4); 
    rpos=rpos.';
end
    
%Homogeneous transformation matrix. This is for illustrative purposes, you
%can use the HTM function instead.
function fr = HTMX(th,eje,Dr)
fr(1:3,1:3) = rot_mat(th,eje);
fr(1:3,4) = Dr;
fr(4,:) = [0,0,0,1];
end

