%
% File: arbref1.m - Arbitrary reference frame
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



