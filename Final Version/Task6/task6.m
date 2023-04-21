% Task6
clear all;
clf;
global Pstar cstar n maxcount M Q camax RT cI;

altitudes = [0:100:5000];

T0=288.15; %sea level standard temperature(K)
P0=101325;%sea level standard atmospheric pressure
M_air=0.029;
R=8.314;%specific gas constant for dry air
g0=9.8;%standard acceleration of gravity(m/s)

for i=1:length(altitudes)
    altitude = altitudes(i);
    Patm = P0*exp(-g0*M_air*altitude/(R*T0));
    Patm_mmHg=Patm*0.0075;
    PH2O=47;
    FiO2=0.2095;
    PI=(Patm_mmHg-PH2O)*FiO2;
    if PI < 0
    PI = 0.1;
end

   
    RT=760*22.4*(T0/273.15);
    cI=PI/RT;
    cref=0.2/(22.4*(310/273));
    cstar=cref;
    setup_lung
    cvsolve
    outchecklung
    [~, PAbar, Pabar, Pv] = lung(0.5);
    [~, cA, ca, cv] = lung(0.5);
    Pabar_values(i) = Pabar;
    PAbar_values(i) = PAbar;
    Pv_values(i) = Pv;
    ca_values(i) = ca;
    cA_values(i) = cA;
    cv_values(i) = cv;
end

figure;
hold on;
plot(altitudes, PAbar_values, 'DisplayName', 'PAbar');
plot(altitudes, Pabar_values, 'DisplayName', 'Pabar');
plot(altitudes, Pv_values, 'DisplayName', 'Pv');
xlabel('Altitude(m)');
ylabel('Partial Pressure (mmHg)');
legend;
title('Partial Pressures as functions of Altitude');
hold off;

figure;
hold on;
plot(altitudes, cA_values, 'DisplayName', 'cA');
plot(altitudes, ca_values, 'DisplayName', 'ca');
plot(altitudes, cv_values, 'DisplayName', 'cv');
xlabel('Altitude(m)');
ylabel('Oxygen concentraion');
legend;
title('Oxygen concentraion as functions of Altitude');
hold off;