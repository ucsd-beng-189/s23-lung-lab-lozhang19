% Task3
clear all;
clf;
global Pstar cstar n maxcount M Q camax RT cI;

betas = [0:0.01:1];

for i=1:length(betas)
    beta=betas(i);
    setup_lung
    cvsolve
    outchecklung
    [PI, PAbar, Pabar, Pv] = lung(beta);
    PI_values(i) = PI;
    Pabar_values(i) = Pabar;
    PAbar_values(i) = PAbar;
    Pv_values(i) = Pv;
end

figure;
hold on;
plot(betas, PI_values, 'DisplayName', 'PI');
plot(betas, PAbar_values, 'DisplayName', 'PAbar');
plot(betas, Pabar_values, 'DisplayName', 'Pabar');
plot(betas, Pv_values, 'DisplayName', 'Pv');
xlabel('Beta');
ylabel('Partial Pressure (mmHg)');
legend;
title('Partial Pressures as functions of Beta');
hold off;