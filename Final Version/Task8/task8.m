% Task8
clear all;
clf;
global Pstar cstar n maxcount M Q camax RT cI;

altitudes = [0:100:2000];

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
    Pabar_values(i) = Pabar;
    PAbar_values(i) = PAbar;
    Pv_values(i) = Pv;
end

figure;
hold on;
plot(altitudes, PAbar_values, 'DisplayName', ['Pabar,beta=' num2str(beta)]);
plot(altitudes, Pabar_values, 'DisplayName', ['Pabar,beta=' num2str(beta)]);
plot(altitudes, Pv_values, 'DisplayName', ['Pabar,beta=' num2str(beta)]);
xlabel('Altitude(m)');
ylabel('Partial Pressure (mmHg)');
legend;
title('Partial Pressures as functions of Altitude and Beta');
hold off;