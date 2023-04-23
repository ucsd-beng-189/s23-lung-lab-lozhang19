% Task5
clear all;
clf;
global Pstar cstar n maxcount M Q camax RT cI;

cI_values = [0.004:0.0001:0.01];

for i=1:length(cI_values)
    cI = cI_values(i);
    setup_lung
    cvsolve
    outchecklung
    [~, PAbar, Pabar, Pv] = lung();
    [~, cAbar, cabar, cv] = clung();
    Pabar_values(i) = Pabar;
    PAbar_values(i) = PAbar;
    Pv_values(i) = Pv;
    ca_values(i) = cabar;
    cA_values(i) = cAbar;
    cv_values(i) = cv;
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

figure;
hold on;
plot(cI_values, cA_values, 'DisplayName', 'cAbar');
plot(cI_values, ca_values, 'DisplayName', 'cabar');
plot(cI_values, cv_values, 'DisplayName', 'cv');
xlabel('cI');
ylabel('Oxygen concentraion');
legend;
title('Oxygen concentraion as functions of cI');
hold off;