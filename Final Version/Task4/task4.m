% Task4
clear all;
clf;
global Pstar cstar n maxcount M Q camax RT cI;

betas = [0:0.1:1];
Ms = [0:0.01:1];
max_M_values = zeros(1, length(betas));

for i=1:length(betas)
    beta=betas(i);
    setup_lung;

    max_M=0;
    for j = 1:length(Ms)
        M = Ms(j);
        [cv, isError] = cvsolve(r); % Call the modified cvsolve function

        if ~isError
            max_M = M;
        else
            break;
        end
    end

    max_sustainable_M(i) = max_M;
end

figure;
plot(betas, max_sustainable_M);
xlabel('Beta');
ylabel('Maximum Sustainable M');
title('Maximum Sustainable Rate of Oxygen Consumption vs. Beta');