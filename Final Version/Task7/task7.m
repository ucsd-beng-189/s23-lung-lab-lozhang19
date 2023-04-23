% Task8
clear all;
clf;
global Pstar cstar n maxcount M Q camax RT cI;

altitudes = [0:1:1000];

for i=1:length(altitudes)
    altitude = altitudes(i);
    cref = (0.2 / (22.4 + altitude)) * (1 / (310/273));
    cstar=1.5*cref;
    setup_lung
    try
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
    
catch ME
    if strcmp(ME.message,'M is too large')
        fprintf('At altitude %d meters, it becomes impossible to sustain the normal resting rate of oxygen consumption (without breathing harder or increasing the cardiac output).\n', altitude);
        Pabar_values( i) = NaN;
        PAbar_values( i) = NaN;
        Pv_values( i) = NaN;
        ca_values(i) = NaN;
        cA_values(i) = NaN;
        cv_values(i) = NaN;
        break;
            else
                rethrow(ME)
    end
    end
end

valid_indices = ~isnan(PAbar_values);
altitudes = altitudes(valid_indices);
PAbar_values = PAbar_values(valid_indices);
Pabar_values = Pabar_values(valid_indices);
Pv_values = Pv_values(valid_indices);
ca_values = ca_values(valid_indices);
cA_values = cA_values(valid_indices);
cv_values = cv_values(valid_indices);

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