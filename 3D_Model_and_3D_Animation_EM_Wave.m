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
mur =1; % 0 for free space
mu =mu0*mur;

ep0 = 8.85*1e-12;
epr =2; % 0 for free space
ep = ep0*epr;

sigma =0.00075654;  % it is 0 for free space

alpha =  omega*sqrt(mu*ep/2) * sqrt (     sqrt(    (1 + (sigma/(omega*ep))^2)  -1    )       );
beta =  omega*sqrt(mu*ep/2) * sqrt (     sqrt(    (1 + (sigma/(omega*ep))^2)  +1    )       );
eta =sqrt( (1i*omega*mu)/ (sigma +  (1i*omega*ep)));  % for free space it is 377
%%

%%peak amplitude of electric field
E0 = 200;

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
lambda = 2*pi/beta;  
number_of_cycles =10;
x = 0:(lambda/100):number_of_cycles*lambda;
z =zeros(size(x));


t=0.0;
Ey =E0.*    (  exp(-alpha * x).* cos(omega*t - beta*x) ) ;
Hz =(E0/abs(eta)).*    (  exp(-alpha * x).* cos(omega*t - beta*x - angle(eta)) ) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% uncomment below block for animation
Yline = animatedline('LineWidth', 3, 'color','b');
Zline = animatedline('LineWidth', 3, 'color','r');
Xline = animatedline('LineWidth', 3, 'color','g');

axis([0,max(x)/lambda,-E0,E0,-E0/abs(eta),E0/abs(eta)]);

title("3D Animation of Electromagntic Wave");
view(45,20);

xlabel('Propagation Direction(X)');
ylabel('Electric Field(Y)');
zlabel('Magnetic Field(Z)');
legend('Electric Field','Magnetic Field', 'Wave Propagation');

hold on;

for i = 0:length(x)-1
addpoints(Xline,x(i+1)/lambda,0,0);    
addpoints(Yline,x(i+1)/lambda,Ey(i+1),0);      
addpoints(Zline,x(i+1)/lambda,0,Hz(i+1));      
drawnow
% pause(0.002);
% hold on;
end

hold off;
%% Uncomment above block for animation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure(2)
% subplot(3,1,1)
% plot(x/lambda,Ey,x,Hz);
% xlabel('Direction of Propagation');
% ylabel('electric and Magnetic field');
% legend('electric field','magnetic field');
subplot(2,1,1)
plot(x/lambda,Ey);
xlabel('Direction of Propagation');
ylabel('electric field');
legend('electric field');
subplot(2,1,2)
plot(x/lambda,Hz,'r');
xlabel('Direction of Propagation');
ylabel('Magnetic field');
legend('Magnetic field');

% for i = 0:(length(z)-1)
for i = 0:10
t = i*0.01;


Ey =E0.*    (  exp(-alpha * x).* cos(omega*t - beta*x) ) ;
Hz =(E0/abs(eta)).*    (  exp(-alpha * x).* cos(omega*t - beta*x - angle(eta)) ) ;

figure(3)
plot3(x/lambda,Ey,z,'b');
hold on;
plot3(x/lambda,z,Hz,'r');
hold on;
plot3(x/lambda,z,z,'g');
grid on;
hold off;
axis([0,max(x)/lambda,-E0,E0,-E0/abs(eta),E0/abs(eta)]);
legend('Electric Field','Magnetic Field', 'Wave Propagation');
title('3D Model of Electromagnetic Wave')
xlabel('Direction of Propagation'); ylabel('electric field'); zlabel('magnetic field');


end

