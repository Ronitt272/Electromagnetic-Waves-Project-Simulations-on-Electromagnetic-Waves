%%
close all;
clear all;

% E(z,t) = E0 exp( -alpha *z) cos( w*t - beta*z) in x
% H(z,t) = Re(H0 exp(-alpha *z) exp(j*omega*t -beta*z) in y
% H0 = E0/eta , eta is intrinsic impedence
%By utilising the above equations, the 3D Model has been created.

%% parameters
f = 10e9; %frequency

c= 3e8;  % speed of light

omega = 2*pi*f; % angular frequency

T = 1/f; %time period of wave

%% calculation for alpha beta and neeta
mu0 = 4*pi*1e-7; 
mur1 =1; 
mu1 =mu0*mur1;

mur2 = 1;
mu2 = mu0*mur2;

ep0 = 8.85*1e-12;
epr1 =2;
ep1 = ep0*epr1;

epr2 = 1;
ep2 = ep0*epr2;

sigma1 = 0.00075654; 
sigma2 = 0.002;

alpha1 =  omega*sqrt(mu1*ep1/2) * sqrt (     sqrt(    (1 + (sigma1/(omega*ep1))^2)  -1    )       );
beta1 =  omega*sqrt(mu1*ep1/2) * sqrt (     sqrt(    (1 + (sigma1/(omega*ep1))^2)  +1    )       );
eta1 =sqrt( (1i*omega*mu1)/ (sigma1 +  (1i*omega*ep1))); 

alpha2 =  omega*sqrt(mu2*ep2/2) * sqrt (     sqrt(    (1 + (sigma2/(omega*ep2))^2)  -1    )       );
beta2 =  omega*sqrt(mu2*ep2/2) * sqrt (     sqrt(    (1 + (sigma2/(omega*ep2))^2)  +1    )       );
eta2 =sqrt( (1i*omega*mu2)/ (sigma2 +  (1i*omega*ep2))); 
%%

%%peak amplitude of electric field
Ei0 = 200;
Er0 = (abs((eta2-eta1)*Ei0/(eta1+eta2)));
Et0 = (abs((2*Ei0)/(eta1+eta2)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% provide fixed values of alpha and neeta and H0

% alpha =0.5;
% 
% lambda = c/f;
% 
% beta =2*pi/lambda;
% neeta =1*exp(1i*pi/4);  
% H0= E0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

%%
lambda1 = 2*pi/beta1;  
lambda2 = 2*pi/beta2;  
number_of_cycles =10;
x1 = 0:(lambda1/100):number_of_cycles*lambda1;
x2 = 0:(lambda2/100):number_of_cycles*lambda2;
z1 =zeros(size(x1));
z2 =zeros(size(x2));


t=0.0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% for i = 0:(length(z)-1)
for i = 0:10
t = i*0.01;
%generating the incident wave

Ei =Ei0.*    (  exp(-alpha1 * x1).* cos(omega*t - beta1*x1) ) ;
Hi =(Ei0/abs(eta1)).*    (  exp(-alpha1 * x1).* cos(omega*t - beta1*x1 - angle(eta1)) ) ;

figure(1)
plot3(x1/lambda1,Ei,z1,'b');
hold on;
plot3(x1/lambda1,z1,Hi,'r');
hold on;
plot3(x1/lambda1,z1,z1,'g');
grid on;
hold off;
axis([0,max(x1)/lambda1,-Ei0,Ei0,-Ei0/abs(eta1),Ei0/abs(eta1)]);
legend('Electric Field','Magnetic Field', 'Wave Propagation');
title('INCIDENT WAVE');
xlabel('Direction of Propagation'); ylabel('electric field'); zlabel('magnetic field');


end

%%
% for i = 0:(length(z)-1)
for i = 0:10
t = i*0.01;
%generating the transmitted wave

Et =Et0.*    (  exp(-alpha2 * x2).* cos(omega*t - beta2*x2) ) ;
Ht =(Et0/abs(eta2)).*    (  exp(-alpha2 * x2).* cos(omega*t - beta2*x2 - angle(eta2)) ) ;

figure(2)
plot3(x1/lambda2,Et,z2,'b');
hold on;
plot3(x1/lambda2,z2,Ht,'r');
hold on;
plot3(x1/lambda2,z2,z2,'g');
grid on;
hold off;
axis([0,max(x2)/lambda2,-Et0,Et0,-Et0/abs(eta2),Et0/abs(eta2)]);
legend('Electric Field','Magnetic Field', 'Wave Propagation');
title('TRANSMITTED WAVE');
xlabel('Direction of Propagation'); ylabel('electric field'); zlabel('magnetic field');


end


%%
% for i = 0:(length(z)-1)
for i = 0:10
t = i*0.01;
%generating the reflected wave

Er =Er0.*    (  exp(-alpha1 * x1).* cos(omega*t + beta1*x1) ) ;
Hr =(Er0/abs(eta1)).*    (  exp(-alpha1 * x1).* cos(omega*t + beta1*x1 - angle(eta1)) ) ;

figure(3)
plot3(-x1/lambda1,-Er,-z1,'b');
hold on;
plot3(-x1/lambda1,-z1,Hr,'r');
hold on;
plot3(-x1/lambda1,-z1,-z1,'g');
grid on;
hold off;
legend('Electric Field','Magnetic Field', 'Wave Propagation');
title('REFLECTED WAVE');
xlabel('Direction of Propagation'); ylabel('electric field'); zlabel('magnetic field');


end



