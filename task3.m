% Task4
clear all;
clf;
global Pstar cstar n maxcount M Q camax RT cI;

betas = [0:0.1:1];
max_M_values = zeros(1, length(betas));

for i=1:length(betas)
    beta=betas(i);
    M_low = 0;
    M_high = 1;

    while M_high - M_low > 0.001
        M = (M_low + M_high)/2;

        try
            setup_lung
            cvsolve
            outchecklung
            [PI, PAbar, Pabar, Pv] = lung(beta);
        catch
            M_high = M;
        end
    end

    max_M_values(i) = M_low;
end

figure;

plot(betas, max_M_values, 'DisplayName', 'Max Sustainable Oxygen Consumpution Rate');
xlabel('Beta');
ylabel('Max Sustainable Oxygen Consumpution (M)');
legend;
title('Max Sustainable Oxygen Consumpution Rate as functions of Beta');