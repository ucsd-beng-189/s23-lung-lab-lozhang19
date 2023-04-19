% Task3
clear all;
clf;
global Pstar cstar n maxcount M Q camax RT cI;

setup_lung
betas = 0.1:0.1:1;
PI_values = zeros(size(betas));
Pabar_values = zeros(size(betas));
PAbar_values = zeros(size(betas));
Pv_values = zeros(size(betas));

for i=1:length(betas)
    beta=betas(i);
    [PI, PAbar, Pabar, Pv] = lung(beta);
    PI_values(i) = PI;
    Pabar_values(i) = Pabar;
    PAbar_values(i) = PAbar;
    Pv_values(i) = Pv;
end

figure;
hold on;
plot(betas, PI_values, 'DisplayName', 'Inspired Oxygen Partial Pressure (PiO2)');
plot(betas, PAbar_values, 'DisplayName', 'Mean Alveolar Oxygen Partial Pressure (PAO2)');
plot(betas, Pabar_values, 'DisplayName', 'Mean Arterial Oxygen Partial Pressure (PaO2)');
plot(betas, Pv_values, 'DisplayName', 'Venous Oxygen Partial Pressure (PvO2)');
xlabel('Beta');
ylabel('Partial Pressure (mmHg)');
legend;
title('Partial Pressures as functions of Beta');
hold off;