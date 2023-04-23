% Task 9
clear all;
clf;
global Pstar cstar n maxcount M Q camax RT cI beta;

cref=0.2/(22.4*(310/273));
cI = cref; % initial alveolar oxygen concentration (mmHg)

cstar_values = [cref:-0.0005:0.1*cref]; % values for cstar


for i = 1:length(cstar_values)
        cstar = cstar_values(i);
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
        fprintf('At cstar %d mmHg, it becomes impossible to sustain the normal resting rate of oxygen consumption.\n', cstar);
        Pabar_values(i) = NaN;
        PAbar_values(i) = NaN;
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
cstar_values = cstar_values(valid_indices);
PAbar_values = PAbar_values(valid_indices);
Pabar_values = Pabar_values(valid_indices);
Pv_values = Pv_values(valid_indices);
ca_values = ca_values(valid_indices);
cA_values = cA_values(valid_indices);
cv_values = cv_values(valid_indices);

% Plot the results
figure;
hold on;

    plot(cstar_values, PAbar_values, 'DisplayName', sprintf('PAbar, beta=%.2f', beta));
    plot(cstar_values, Pabar_values, 'DisplayName', sprintf('Pabar, beta=%.2f', beta));
    plot(cstar_values, Pv_values, 'DisplayName', sprintf('Pv, beta=%.2f', beta));

xlabel('cstar');
ylabel('Partial Pressure (mmHg)');
legend;
title('Partial Pressures as functions of cstar for different beta values');
set(gca, 'XDir', 'reverse');
hold off;


figure;
hold on;

plot(cstar_values, cA_values, 'DisplayName', sprintf('cAbar, beta=%.2f', beta));
plot(cstar_values, ca_values, 'DisplayName', sprintf('cabar, beta=%.2f', beta));
plot(cstar_values, cv_values, 'DisplayName', sprintf('cv, beta=%.2f', beta));

xlabel('cstar');
ylabel('Oxygen concentraion');
legend;
title('Oxygen concentraion as functions of cstar for different beta values');
set(gca, 'XDir', 'reverse');
hold off;
