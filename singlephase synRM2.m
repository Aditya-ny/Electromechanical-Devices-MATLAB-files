% Function sprm.m contains the equations for the
% single-phase reluctance machine supplied by a DC source.

  function dX = sprm(t,X);

    I=X(1); wr=X(2); thr=X(3);

% *** Motor Parameters ***

    Rs=10; La=0.11; Lb=0.06; J=0.001; D=0.06;

% *** Voltage source ***

    V=120;

% *** Machine Equations ***
    Ro=[Rs+2*Lb*sin(2*thr)*wr];
    L=[La-Lb*cos(2*thr)];

    dI=inv(L)*(V-Ro*I);

    Te=Lb*sin(2*thr)*I(1)^2;
    Tm=4;
  
    dwr=(Te-Tm-D*wr)/J;
    dthr=wr;
    dX=[dI; dwr; dthr];
