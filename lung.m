%filename: lung.m (main program)
function [PI, PAbar, Pabar, Pv] = lung(beta)
    global Pstar cstar n maxcount M Q camax RT cI;
setup_lung

a1=-log(rand(n,1));
a2=-log(rand(n,1));
av=(a1+a2)/2;        
VA=VAbar*(a1*beta+av*(1-beta));
Q = Qbar*(a2*beta+av*(1-beta));
r=VA./Q;

cvsolve
outchecklung
end