% Task 9
clear all;
clf;
global Pstar cstar n maxcount M Q camax RT cI beta;

cref=0.2/(22.4*(310/273));
cI = cref; % initial alveolar oxygen concentration (mmHg)

beta_values = [ 0.25, 0.5, 0.75]; % values for beta
cstar_values = [cref:-0.0005:0.1*cref]; % values for cstar

Pabar_threshold = 80;

for j = 1:length(beta_values)
    beta = beta_values(j);
    for i = 1:length(cstar_values)
        cstar = cstar_values(i);
        setup_lung
        try
        cvsolve
        outchecklung
        Pabar_values(j, i) = Pabar;
        PAbar_values(j, i) = PAbar;
        Pv_values(j, i) = Pv;

        if Pabar < Pabar_threshold
                fprintf('For beta=%.2f, the minimum cstar value at which normal resting rate of oxygen consumption can be maintained is %.2f mmHg\n', beta, cstar);
        end

        catch ME
            if strcmp(ME.message,'M is too large')
        Pabar_values(j, i) = NaN;
        PAbar_values(j, i) = NaN;
        Pv_values(j, i) = NaN;
            else
                rethrow(ME)
            end
        end
    end
            end

% Plot the results
figure;
hold on;
for j = 1:length(beta_values)
    plot(cstar_values, PAbar_values(j, :), 'DisplayName', sprintf('PAbar, beta=%.2f', beta_values(j)));
    plot(cstar_values, Pabar_values(j, :), 'DisplayName', sprintf('Pabar, beta=%.2f', beta_values(j)));
    plot(cstar_values, Pv_values(j, :), 'DisplayName', sprintf('Pv, beta=%.2f', beta_values(j)));
end
xlabel('cstar (mmHg)');
ylabel('Partial Pressure (mmHg)');
legend;
title('Partial Pressures as functions of cstar for different beta values');
set(gca, 'XDir', 'reverse');
hold off;
