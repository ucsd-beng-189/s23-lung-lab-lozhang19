% Task5
clear all;
clf;
global Pstar cstar n maxcount M Q camax RT cI;

cI_values = linspace(0.21, 0.10, 100);

for i=1:length(cI_values)
    cI = cI_values(i);
    PI = cI * RT;
    setup_lung
    cvsolve
    outchecklung
    [~, PAbar, Pabar, Pv] = lung(0.5);
    Pabar_values(i) = Pabar;
    PAbar_values(i) = PAbar;
    Pv_values(i) = Pv;
end

figure;
hold on;
plot(cI_values, PAbar_values, 'DisplayName', 'PAbar');
plot(cI_values, Pabar_values, 'DisplayName', 'Pabar');
plot(cI_values, Pv_values, 'DisplayName', 'Pv');
xlabel('cI');
ylabel('Partial Pressure (mmHg)');
legend;
title('Partial Pressures as functions of cI');
hold off;