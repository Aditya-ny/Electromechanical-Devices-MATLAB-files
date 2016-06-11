%
% File: arbref2.m - Arbitrary reference frame
% Including rotor variable transformation
%

clear all;close all;clc;

%% Set up some paramters

fe=60;we=2*pi*fe;Tp=1/fe;Vs=120;
t=[0:Tp/500:3*Tp];

%% Transformation to an alternate reference frame

% *** Voltage sources ***

K=1.0;      % At least for now
Vas=sqrt(2)*Vs*cos(we*t);
Vbs=sqrt(2)*Vs*cos(we*t-2*pi/3)*K; % Inc. > 1.0 to produce unbalanced harm. torques
Vcs=sqrt(2)*Vs*cos(we*t+2*pi/3);
Vabcs=[Vas; Vbs; Vcs];

figure
subplot(311);plot(t,Vas,t,Vbs,t,Vcs);legend('Vas','Vbs','Vcs')

%% Transform sinusoidal stator variables

% Reference frame speed

w=we;       % Synchronous reference frame
w=0;        % Stationary reference frame
%w=wr;      % Rotor reference frame
w=.6*we;    % Arbitrary reference frame

[m,n]=size(t);
for i=1:n
  theta=w*t;
  Ks=[cos(theta(i)) cos(theta(i)-2*pi/3) cos(theta(i)+2*pi/3);
      sin(theta(i)) sin(theta(i)-2*pi/3) sin(theta(i)+2*pi/3);
      0.5 0.5 0.5];
  Ks=(2/3)*Ks;
  Vqdos(:,i)=Ks*Vabcs(:,i);
end

% Plot results

Vqs=Vqdos(1,:);Vds=Vqdos(2,:);Vos=Vqdos(3,:);
subplot(312);plot(t,Vqs,t,Vds,t,Vos);legend('Vqs','Vds','Vos')

%% Recover original data

for i=1:n
  theta=w*t;
  Ksinv=[cos(theta(i))        sin(theta(i))        1
         cos(theta(i)-2*pi/3) sin(theta(i)-2*pi/3) 1
         cos(theta(i)+2*pi/3) sin(theta(i)+2*pi/3) 1];
  Fabcs(:,i)=Ksinv*Vqdos(:,i);
end

Fas=Fabcs(1,:);Fbs=Fabcs(2,:);Fcs=Fabcs(3,:);
subplot(313);plot(t,Fas,t,Fbs,t,Fcs);legend('Fas','Fbs','Fcs')

%% Transform non sinusoidal stator variables

K=1.0;      % At least for now
Vas=sqrt(2)*Vs*square(we*t);
Vbs=sqrt(2)*Vs*square(we*t-2*pi/3)*K; % Inc. > 1.0 to produce unbalanced harm. torques
Vcs=sqrt(2)*Vs*square(we*t+2*pi/3);
Vabcs=[Vas; Vbs; Vcs];

figure
subplot(311);plot(t,Vas,t,Vbs,t,Vcs);legend('Vas','Vbs','Vcs')

% Reference frame speed

%w=we;       % Synchronous reference frame
%w=0;       % Stationary reference frame
%w=wr;      % Rotor reference frame
%w=.6*we;   % Arbitrary reference frame

[m,n]=size(t);
for i=1:n
  theta=w*t;
  Ks=[cos(theta(i)) cos(theta(i)-2*pi/3) cos(theta(i)+2*pi/3);
      sin(theta(i)) sin(theta(i)-2*pi/3) sin(theta(i)+2*pi/3);
      0.5 0.5 0.5];
  Ks=(2/3)*Ks;
  Vqdos(:,i)=Ks*Vabcs(:,i);
end

% Plot results

Vqs=Vqdos(1,:);Vds=Vqdos(2,:);Vos=Vqdos(3,:);
subplot(312);plot(t,Vqs,t,Vds,t,Vos);legend('Vqs','Vds','Vos')

%% Recover original data

for i=1:n
  theta=w*t;
  Ksinv=[cos(theta(i))        sin(theta(i))        1
         cos(theta(i)-2*pi/3) sin(theta(i)-2*pi/3) 1
         cos(theta(i)+2*pi/3) sin(theta(i)+2*pi/3) 1];
  Fabcs(:,i)=Ksinv*Vqdos(:,i);
end

Fas=Fabcs(1,:);Fbs=Fabcs(2,:);Fcs=Fabcs(3,:);
subplot(313);plot(t,Fas,t,Fbs,t,Fcs);legend('Fas','Fbs','Fcs')

%% Rotor variable transformation


s=0.1;thr=s*we*t;Vr=50;       % Slip frequency
Var=sqrt(2)*Vr*sin(s*we*t);
Vbr=sqrt(2)*Vr*sin(s*we*t-2*pi/3)*K; % Inc. > 1.0 to produce unbalanced harm. torques
Vcr=sqrt(2)*Vr*sin(s*we*t+2*pi/3);
Vabcr=[Var; Vbr; Vcr];

figure
subplot(311);plot(t,Var,t,Vbr,t,Vcr);legend('Var','Vbr','Vcr')

for i=1:n
  beta=w*t-thr(i);
  Kr=[cos(beta(i)) cos(beta(i)-2*pi/3) cos(beta(i)+2*pi/3);
         sin(beta(i)) sin(beta(i)-2*pi/3) sin(beta(i)+2*pi/3);
         0.5 0.5 0.5];
     Kr=(2/3)*Kr;
  Vqdor(:,i)=Kr*Vabcr(:,i);
end

Vqr=Vqdor(1,:);Vdr=Vqdor(2,:);Vor=Vqdor(3,:);
subplot(312);plot(t,Vqr,t,Vdr,t,Vor);legend('Vqr','Vdr','Vor')

for i=1:n
  beta=w*t-thr(i);
  Krinv=[cos(beta(i))        sin(beta(i))        1
         cos(beta(i)-2*pi/3) sin(beta(i)-2*pi/3) 1
         cos(beta(i)+2*pi/3) sin(beta(i)+2*pi/3) 1];
  Fabcr(:,i)=Krinv*Vqdor(:,i);
end

Far=Fabcr(1,:);Fbr=Fabcr(2,:);Fcr=Fabcr(3,:);
subplot(313);plot(t,Far,t,Fbr,t,Fcr);legend('Far','Fbr','Fcr')

