% Task 9
clear all;
clf;
global Pstar cstar n maxcount M Q camax RT cI beta;

cref=0.2/(22.4*(310/273));
cI = cref; % initial alveolar oxygen concentration (mmHg)

beta_values = [0, 0.25, 0.5, 0.75, 1]; % values for beta
cstar_values = [cref:-0.00025:0.5*cref]; % values for cstar


for j = 1:length(beta_values)
    beta = beta_values(j);
    for i = 1:length(cstar_values)
        cstar = cstar_values(i);
        setup_lung
        cvsolve
        outchecklung
        Pabar_values(j, i) = Pabar;
        PAbar_values(j, i) = PAbar;
        Pv_values(j, i) = Pv;
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
% Find the minimum value of cstar at which normal resting rate of oxygen consumption can be maintained

for j = 1:length(beta_values)
    beta = beta_values(j);
    
    for i = 1:length(cstar_values)
        cstar = cstar_values(i);
        
        try
            [PI, PAbar, Pabar, Pv] = lung(beta);
            M_diff = M - Q' * (carterial(Pv, cstar, cI) - Pv);
            
            if M_diff > 0
                min_cstar(j) = cstar;
                break;
            end
        catch
            % Do nothing, continue to the next cstar value
        end
    end
end

