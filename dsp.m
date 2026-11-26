clc; clear; close all;

%% EXPERIMENT 1: FRIIS TRANSMISSION EQUATION (GAIN FORM)
Pt=100; Gt=25; Gr=20; f=3e9; c=3e8;
R=1:0.1:50; L=c/f;

Pr=Pt*10^(Gt/10)*10^(Gr/10).*(L./(4*pi*R)).^2;
P=Pr(end); dBm=10*log10(P*1000);

fprintf('=== EXPERIMENT 1 ===\n');
fprintf('Received Power = %.6f W\n',P);
fprintf('Received Power = %.4f dBm\n\n',dBm);

figure(1);
plot(R,10*log10(Pr*1000),'b','LineWidth',2);
grid on; xlabel('Distance (m)');
ylabel('Received Power (dBm)');
title('Friis Transmission Equation (Gain Form)');


%% EXPERIMENT 2: FRIIS TRANSMISSION EQUATION (APERTURE FORM)
Pt=15; Aet=0.2; Aer=0.5;
f=5e9; c=3e8; L=c/f;
R=1:0.1:15;

Pr=Pt*Aet*Aer./(L^2*(R*1000).^2);
P=Pr(end); dBm=10*log10(P*1000);

fprintf('=== EXPERIMENT 2 ===\n');
fprintf('Received Power at 15 km = %.4f microW\n',P*1e6);
fprintf('Received Power at 15 km = %.4f dBm\n\n',dBm);

figure(2);
plot(R,10*log10(Pr*1000),'r','LineWidth',2);
grid on; xlabel('Distance (km)');
ylabel('Received Power (dBm)');
title('Friis Transmission Equation (Aperture Form)');


%% EXPERIMENT 3: BROADSIDE ANTENNA ARRAY
N=10; d=0.25; beta=0;
theta=linspace(0,2*pi,1000);

psi=2*pi*d*cos(theta)+beta;
AF=abs(sin(N*psi/2)./(N*sin(psi/2)));

AF(~isfinite(AF))=1;

figure(3);
polarplot(theta,AF,'LineWidth',1.5);
title('Polar Radiation Pattern (Broadside Array)');


%% EXPERIMENT 4: END-FIRE ANTENNA ARRAY
N=4; d=0.5; k=2*pi;
beta=-k*d;
theta=linspace(0,2*pi,1000);

psi=k*d*cos(theta)+beta;
AF=abs(sin(N*psi/2)./(N*sin(psi/2)));

AF(~isfinite(AF))=1;

figure(4);
polarplot(theta,AF,'LineWidth',1.5);
title('Both-Side End-Fire Array Pattern');


%% EXPERIMENT 5: PATTERN MULTIPLICATION (DIPOLE + ARRAY FACTOR)
theta=0:0.1:360;
t=deg2rad(theta);

lambda=1; d=lambda/4;
k=2*pi/lambda; beta=0;

E=abs(sin(t));
AF=abs(2*cos((k*d*cos(t)+beta)/2));
AF=AF/max(AF);

Et=E.*AF;
Et=Et/max(Et);
EdB=20*log10(Et+eps);
EdB(EdB < -40)=-40;

figure(5);
subplot(1,3,1);
polarplot(t,E,'b','LineWidth',2);
title('Dipole Pattern');

subplot(1,3,2);
polarplot(t,AF,'r','LineWidth',2);
title('Array Factor');

subplot(1,3,3);
polarplot(t,Et,'k','LineWidth',2);
title('Pattern Multiplication');


%% EXPERIMENT 6: HANSEN-WOODYARD END-FIRE ARRAY (BIDIRECTIONAL)
N = 10;
lambda = 1;
d = lambda/4;
k = 2*pi/lambda;
L = (N-1)*d;

theta = 0:0.1:360;
theta_rad = deg2rad(theta);

% Case beta = +(kd + pi/N)
beta1 = k*d + pi/N;
psi1 = k*d*cos(theta_rad) + beta1;
AF1 = abs(sin(N*psi1/2)./(N*sin(psi1/2)));
AF1(~isfinite(AF1)) = 1;

% Case beta = -(kd + pi/N)
beta2 = -(k*d + pi/N);
psi2 = k*d*cos(theta_rad) + beta2;
AF2 = abs(sin(N*psi2/2)./(N*sin(psi2/2)));
AF2(~isfinite(AF2)) = 1;

figure(6);
polarplot(theta_rad, AF1, 'g-');
hold on;
polarplot(theta_rad, AF2, 'r');
legend('\beta = +(kd + \pi/N)', '\beta = -(kd + \pi/N)');
title('Hansen-Woodyard Endfire Array Rad Pattern');
