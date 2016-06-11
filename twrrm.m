function Xdot = twrrm(t,X)

I = [X(1); X(2)]; wr = X(3); thr = X(4);

% define model parameters

Rs = 10; Rr = 10; Ls = 0.6; Lm = 0.3; Lr = 0.6; J = 0.003; Bm = 0.15;

% Source model

V = [120; 120];

% Machine Equations

R = [Rs,0; 0,Rr];
L = [Ls,Lm*cos(thr);
     Lm*cos(thr),Lr];
A = [0,-Lm*sin(thr);
     -Lm*sin(thr), 0];
dI = inv(L)*(V-R*I-wr*A*I);

Te = -Lm*I(1)*I(2)*sin(thr);
TL = 0;

dthr = wr;
dwr = (Te-TL-Bm*wr)/J;

% Return results to ode45
Xdot = [dI; dwr; dthr];



