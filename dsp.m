clc; clear; close all;

%% 1. Simulate Friis Transmission (Aperture Form)
Pt = 15;
Aet = 0.2;  % value in m^2
Aer = 0.5;  % value in m^2
f = 5e9;
d = 15000;
c = 3e8;
lambda = c/f;

Pr = Pt*(Aet*Aer)/(lambda^2*d^2); % calculating power received
disp('Power received')
disp(Pr)

distance = 0:100:15000;
% received power at different distances
Pr_distance = Pt*(Aet*Aer)./(lambda^2*distance.^2);

figure(1);
plot(distance,Pr_distance, 'r')
xlabel('Distance(m)')
ylabel('Received power(W)')
title('Distance vs Received Power')
grid on


%% 2. Simulate Friis Transmission (Gain Form)
Pt = 100;
Gt_dB = 25;
Gr_dB = 20;
f = 3e9;
d = 50;
c = 3e8;

% convert gain from dB to linear
Gt = 10^(Gt_dB/10);
Gr = 10^(Gr_dB/10);
% Wavelength
lambda = c/f;
% Received power
Pr = Pt*Gt*Gr*(lambda/(4*pi*d))^2;
% calculating power received
disp('Received Power =')
disp(Pr)
% Distance vs Received power
distance = 0:1:50;
Pr = Pt*Gt*Gr*(lambda./(4*pi*distance)).^2;
figure(2);
plot(distance,Pr,'r')
xlabel('Distance(m)')
ylabel('Received Power(W)')
title('Distance vs Received Power')
ylim([0 100])
grid on


%% 3. Pattern Multiplication (Isotropic Sources)
lambda = 1;
d = lambda/4;
K = 2*pi/lambda;
x = 0:0.01:2*pi;
E_single = abs(cos(x));
E_single = E_single/max(E_single);

% Case 1 : beta = 0
beta1 = 0;
E_af1 = cos((K*d*cos(x)+ beta1)/2);
E_total1 = E_single.*E_af1;
E_af1 = E_af1/max(abs(E_af1));
E_total1 = E_total1/max(abs(E_total1));

% Case 2 : beta = pi/2
beta2 = pi/2;
E_af2 = cos((K*d*cos(x)+ beta2)/2);
E_total2 = E_single.*E_af2;
E_af2 = E_af2/max(abs(E_af2));
E_total2 = E_total2/max(abs(E_total2));

% Case 3 : beta = -pi/2
beta3 = -pi/2;
E_af3 = cos((K*d*cos(x)+ beta3)/2);
E_total3 = E_single.*E_af3;
E_af3 = E_af3/max(abs(E_af3));
E_total3 = E_total3/max(abs(E_total3));

% Plots
figure(3);
subplot(3,3,1);
polarplot(x,E_single);
grid on;
title('Single source pattern');

subplot(3,3,2);
polarplot(x,E_af1);
grid on;
title('Array factor, \beta = 0');

subplot(3,3,3);
polarplot(x,E_total1);
grid on;
title('Total pattern, \beta = 0');

subplot(3,3,4);
polarplot(x,E_single);
grid on;
title('Single Source pattern');

subplot(3,3,5);
polarplot(x,E_af2);
grid on;
title("\beta=\pi/2: Array factor");

subplot(3,3,6);
polarplot(x,E_total2);
grid on;
title("\beta=\pi/2: Total Pattern");

subplot(3,3,7);
polarplot(x,E_single);
grid on;
title('Single Source pattern');

subplot(3,3,8);
polarplot(x,E_af3);
grid on;
title("\beta=-\pi/2: Array factor");

subplot(3,3,9);
polarplot(x,E_total3);
grid on;
title('Pattern multiplication for isotropic sources');


%% 4. Array Factor Pattern of 10-Element Broadside Array
N = 10;
lambda = 1;
k = 2*pi/lambda;
d = lambda/4;
phi = 0:0.01:2*pi;
alpha = 0;
L = (N-1)*d;
psi = k*d*cos(phi)+alpha;
Earrayfactor = cos(psi/2);
% Array factor
AF = (1/N)*abs((sin(N*psi/2))./(sin(psi/2)));
figure(4);
polarplot(phi,AF);
grid on;
D = 2*L/lambda;
Ddb = 10*log10(D);
disp('Directivity of 10 elements broadside array');
disp(Ddb);
title('Array factor pattern of 10 element broadside array');


%% 5. 10-Element Uniform Amplitude Hansen-Woodyard Array
lambda = 1;
d = lambda/4;
N = 10;
k = 2*pi/lambda;
a = k*d + (2.94/N);
L = (N-1)*d;

x = linspace(0,2*pi,360);
psi = k*d*cos(x) + a;
Arrayfactor = cos(psi/2);
AF = (1/N)*abs((sin(N*psi/2))./(sin(psi/2)));
figure(5);
polarplot(x,abs(AF),'g-');
hold on;

a = (-1)*(k*d + 2.94/N);
x = linspace(0,2*pi,360);
psi = k*d*cos(x) + a;
Arrayfactor = cos(psi/2);
AF = (1/N)*abs((sin(N*psi/2))./(sin(psi/2)));
polarplot(x,abs(AF),'r');
legend('For k*d+(2.94/N)','For -(k*d+(2.94/N))');

D = 1.789*(4*(L/lambda));
Ddb = 10*log10(D);
disp('Directivity of 10 element HansenWoodyard array is');
disp(D);
disp('Directivity of 10 element HansenWoodyard array in dB is');
disp(Ddb);
title('HansenWoodyard Array');
hold off;


%% 6. 10-Element Uniform Amplitude Endfire Array (d = lambda/4)
alpha = 0;
N = 10;
lambda = 1;
k = 2*pi/lambda;
d = lambda/4;
phi = 0:0.01:2*pi;
L = (N-1)*d;

% Case 1: End-fire array (+kd)
psi1 = k*d*cos(phi) + k*d;
AF1 = (1/N)*abs(sin(N*psi1/2)./sin(psi1/2));

% Case 2: End-fire array (-kd)
psi2 = k*d*cos(phi) - k*d;
AF2 = (1/N)*abs(sin(N*psi2/2)./sin(psi2/2));

figure(6);
polarplot(phi, AF1, '-');
hold on;
polarplot(phi, AF2, ':');
grid on;
legend('+kd (Solid Line)', '-kd (Dotted Line)');
title('Array Factor Pattern for 10 Element End-Fire Array');
hold off;

% Directivity approximation
D = 2*L/lambda;
Ddb = 10*log10(D);
disp('Approximate Directivity of 10 element array');
disp(D);
disp('Approximate Directivity in dB:');
disp(Ddb);
