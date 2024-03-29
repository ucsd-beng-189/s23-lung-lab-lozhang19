global Pstar n maxcount M Q camax RT PI beta VA Q;
%heterogeneity parameter (0<=beta<=1):
%beta=0 for homogenous lung
%beta=1 for no ventilation/perfusion correlation
beta=0.25
%number of iterations used in bisection:
maxcount=20
%
%number of ``alveoli'':
n=100
%
%reference oxygen concentration (moles/liter):
cref=0.2/(22.4*(310/273))
%cref=concentration of oxygen 
%in air at sea level at body temperature
%
%oxygen concentration in the inspired air:
cI=cref
%
%blood oxygen concentration
%at full hemoglobin saturation: 

%cstar=4*(concentration of hemoglobin 
%in blood expressed in moles/liter)
%
%rate of oxygen consumption (moles/minute):
M=0.25*cref*5.6
%
%oxygen partial pressure 
%at which hemoglobin is half-saturated:
Pstar=25
%
%gas constant*absolute temperature 
%(mmHg*liters/mole):
RT=760*22.4*(310/273)
%
%oxygen partial pressure 
%in the inspired air (mmHg):
PI=RT*cI
%
%oxygen concentration
%in blood exposed directly to inspired air:
camax=cstar*(PI/Pstar)^3/(1+(PI/Pstar)^3)
%camax is an upper bound 
%on oxygen concentration in blood 
%
%expected value of total alveolar ventilation:
VAtotal=5.0     %(liters/minute)
%
%expected value of total perfusion:
Qtotal=5.6      %(liters/minute)
%
%expected alveolar ventilation per alveolus:
VAbar=VAtotal/n
%
%expected perfusion per alveolus: 
Qbar=Qtotal/n 

a1=-log(rand(n,1));
a2=-log(rand(n,1));
av=(a1+a2)/2;        
VA=VAbar*(a1*beta+av*(1-beta));
Q = Qbar*(a2*beta+av*(1-beta));
r=VA./Q;
figure(1)
plot(Q,VA,'.')

%find actual values of 
%VAtotal, Qtotal, VAbar, and Qbar:
VAtotal=sum(VA)
Qtotal =sum(Q)
VAbar=VAtotal/n
 Qbar= Qtotal/n