% Task10
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
    cstar=0.4*cref;
    setup_lung
    try
        cvsolve
    outchecklung
    [~, PAbar, Pabar, Pv] = lung(0.5);
    [~, cAbar, cabar, cv] = clung();
    Pabar_values(i) = Pabar;
    PAbar_values(i) = PAbar;
    Pv_values(i) = Pv;
    ca_values(i) = cabar;
    cA_values(i) = cAbar;
    cv_values(i) = cv;

        catch ME
            if strcmp(ME.message,'M is too large')
        Pabar_values( i) = NaN;
        PAbar_values( i) = NaN;
        Pv_values( i) = NaN;
        ca_values(i) = NaN;
        cA_values(i) = NaN;
        cv_values(i) = NaN;

            else
                rethrow(ME)
            end
        end
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
plot(altitudes, cA_values, 'DisplayName', 'cAbar');
plot(altitudes, ca_values, 'DisplayName', 'cabar');
plot(altitudes, cv_values, 'DisplayName', 'cv');
xlabel('Altitude(m)');
ylabel('Oxygen concentraion');
legend;
title('Oxygen concentraion as functions of Altitude');
hold off;