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
fprintf('Received Power at 15 km = %.4f dBm\n',dBm);

figure(2);
plot(R,10*log10(Pr*1000),'r','LineWidth',2);
grid on; xlabel('Distance (km)');
ylabel('Received Power (dBm)');
title('Friis Transmission Equation (Aperture Form)');
