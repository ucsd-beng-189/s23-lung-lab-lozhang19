% Task5
clear all;
clf;
global Pstar cstar n maxcount M Q camax RT cI;

cI_values = [0.1:0.01:1];

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
subplot(3,1,1);
plot(cI_values, PAbar_values, 'DisplayName', 'PAbar');
xlabel('cI');
ylabel('Partial Pressure (mmHg)');
legend;
title('Partial Pressures as functions of cI');
subplot(3,1,2);
plot(cI_values, Pabar_values, 'DisplayName', 'Pabar');
xlabel('cI');
ylabel('Partial Pressure (mmHg)');
legend;
title('Partial Pressures as functions of cI');
subplot(3,1,3);
plot(cI_values, Pv_values, 'DisplayName', 'Pv');
xlabel('cI');
ylabel('Partial Pressure (mmHg)');
legend;
title('Partial Pressures as functions of cI');
hold off;