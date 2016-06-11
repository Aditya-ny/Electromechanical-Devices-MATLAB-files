%
% Simulation of single-phase reluctance machine
%

clear all;close all;clc

% *** Motor Parameters ***

Rs=10; La=0.11; Lb=0.06; J=0.001; D=0.06;

% *** Initial parameters ***

t0=0;tf=.3;X0=[0 0 9*pi/8]';tspan=[t0 tf];
[t,X]=ode45('sprm',tspan,X0);
i1=X(:,1);wr=X(:,2);thr=X(:,3);

figure
subplot(311);plot(t,i1);grid
title('Transient current, speed and position; i1(t), wr(t), thetar(t)')
subplot(312);plot(t,wr);grid
subplot(313);plot(t,thr);grid

figure
Te=Lb*sin(2.*thr).*i1.^2;
subplot(311);plot(t,Te);grid
title('Te(t) vs time; Te(t) vs wr; Tess vs theta')
subplot(312);plot(wr,Te);grid

i1_ss=12;
angle=[0:pi/100:2*pi];
Tess=Lb*sin(2*angle)*i1_ss^2;
subplot(313);plot(angle,Tess);grid % Saliency Component