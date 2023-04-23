function [cI, cAbar, cabar, cv] = clung(beta)
    global Pstar cstar n maxcount M Q camax RT cI;
setup_lung
cvsolve
outchecklung
end