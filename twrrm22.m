function dX=twrrm22(t,X)

I=[X(1); X(2)]; wr=X(3); thr=X(4);

% model parameters
r=10;Ll=0;Ks=2667;M=0.055; X0=3;K =6.283*10e-5;Bv= 4;

% source model

V=[120
    120];

%machine equations

R=[Rs 0
    0 Rr];

L=[Ks M*cos(thr);
    M*cos(thr) K];

A=[0 -M*sin(thr);
    -M*sin(thr) 0];

dI=inv(L)*(V-R*I-wr*A*I);

Te=-M*I(1)*I(2)*sin(thr);
TL=0;
dthr=wr;
dwr=(Te-Tl-Bv*wr)/J;


dX=[dI;
    dwr;
    dthr];

