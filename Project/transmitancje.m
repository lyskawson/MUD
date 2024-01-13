% Aleksander Lyskawa
% 275462
% pt 13:15
% LAB 9, 10, 11

clear all;
close all;
clc;
startTime = 0;
stopTime = 500;
maxStepSize = 0.001;
model='lyskawaProject_si_tr.slx';

%Zmienne wejsciowe Tz, fp, Tk
%Zmienne wejsciowe (zmienne stanu) Tw, Tp

%model='lyskawaProject_si.slx';

%-------- 1. Identyfikacja -----------------
%wartosci nominalne
TzN=-20;     %temperatura na zewnatrz[oC]      
TwN=20;      %temperatura wewnatrz[oC]        
TpN=15;      %temperatura na poddaszu[oC]     
TkN =35;    %temperatura powietrza
Vw=30;       %objetosc pomieszczenia[m^3] 
Vp=15;       %objetosc poddasza[m^3]
cp=1000;     %cieplo wlasciwe powietrza
ro=1.2;      %gestosc powietrzat
qkN = 20000; %strumien ciepla[W]

%parametry statyczne
fpN=qkN/(cp*ro*TkN);    %przeplyw powietrza [m^3/s] 
K1=(cp*ro*fpN*(TkN-TpN))/(TwN+2*TpN-3*TzN);
K2=(2*cp*ro*fpN*(TkN - TpN))/(TwN + 2*TpN - 3*TzN);
Kp = (2*cp*ro*fpN*(TkN-TpN)*(TpN-TzN))/((TwN-TpN)*(TwN+2*TpN-3*TzN)) -cp*ro*fpN;

%paramterow dynamiczne
Cvw=cp*ro*Vw;   %pojemnosc cieplna wnetrza
Cvp=cp*ro*Vp;   %pojemnosc cieplna poddasza

%-------- 2. Punkty pracy -------------------
vTz0=[TzN, TzN+2,TzN+2];
vTk0=[TkN,TkN, TkN+1];
vfp0=[fpN,fpN*0.7,fpN*0.8];


%===========================================
%punkty rownowagi
Tz0=vTz0(1);
Tk0=vTk0(1);
fp0=vfp0(1);
A = [-cp*ro*fp0-K1-Kp, Kp; cp*ro*fp0+Kp, -cp*ro*fp0-K2-Kp];
B = [K1,cp*ro*fp0; K2,0];
u = [Tz0; Tk0];
x = -inv(A)*B*u;
Tw0 = x(1);
Tp0 = x(2);

a = cp*ro*fp0;
M=[Cvw*Cvp, Cvw*(a+Kp+K2)+Cvp*(a+K1+Kp), a*(a+K1+K2+Kp)+K1*Kp+K1*K2+Kp*K2];
LTz1 = [K1*Cvp, K1*a+K1*Kp+K1*K2+Kp*K2];
LTk1 = [Cvp*a, a*(a+Kp+K2)];
LTz2= [K2*Cvw, K2*a+K2*K1+K2*Kp+K1*a+K1*Kp];
LTk2 =a*(a+Kp);
%===========================================

figure;
t0=100;
%-----------------------------------
% T_k
subplot(3,2,1)
dTk = 1;
dTz = 0;
dfp = 0;
sim(model);

plot(ans.tout,ans.Tw, LineWidth=2)
xlabel('Czas [s]')
ylabel("T_{w} [^{\circ}C]")
grid on
title('Skok dT_{k}=1')
hold on;

subplot(3,2,2)
plot(ans.tout,ans.Tp, LineWidth=2)
grid on;
xlabel('Czas [s]')
ylabel("T_{p} [^{\circ}C]")
title('Skok dT_{k}=1')
hold on
%-----------------------------------
% T_z
subplot(3,2,3)
dTk= 0;
dTz = 2;
dfp = 0;
sim(model);
plot(ans.tout,ans.Tw, LineWidth=2)
xlabel('Czas [s]')
ylabel("T_{w} [^{\circ}C]")
grid on
title('Skok dT_{z}=2')
hold on

subplot(3,2,4)
plot(ans.tout,ans.Tp, LineWidth=2)
grid on;
xlabel('Czas [s]')
ylabel("T_{p} [^{\circ}C]")
title('Skok dT_{z}=2')
hold on







%===========================================
%punkty rownowagi
Tz0=vTz0(2);
Tk0=vTk0(2);
fp0=vfp0(2);
A = [-cp*ro*fp0-K1-Kp, Kp; cp*ro*fp0+Kp, -cp*ro*fp0-K2-Kp];
B = [K1,cp*ro*fp0; K2,0];
u = [Tz0; Tk0];
x = -inv(A)*B*u;
Tw0 = x(1);
Tp0 = x(2);

a = cp*ro*fp0;
M=[Cvw*Cvp, Cvw*(a+Kp+K2)+Cvp*(a+K1+Kp), a*(a+K1+K2+Kp)+K1*Kp+K1*K2+Kp*K2];
LTz1 = [K1*Cvp, K1*a+K1*Kp+K1*K2+Kp*K2];
LTk1 = [Cvp*a, a*(a+Kp+K2)];
LTz2= [K2*Cvw, K2*a+K2*K1+K2*Kp+K1*a+K1*Kp];
LTk2 =a*(a+Kp);
%===========================================


% T_k
subplot(3,2,1)
dTk = 1;
dTz = 0;
dfp = 0;
sim(model);
plot(ans.tout,ans.Tw, LineWidth=2)

xlabel('Czas [s]')
ylabel("T_{w} [^{\circ}C]")
hold on;
grid on

subplot(3,2,2)
plot(ans.tout,ans.Tp, LineWidth=2)
grid on;
xlabel('Czas [s]')
ylabel("T_{p} [^{\circ}C]")
hold on;

% T_z
subplot(3,2,3)
dTk = 0;
dTz = 2;
dfp = 0;
sim(model);
plot(ans.tout,ans.Tw, LineWidth=2)
xlabel('Czas [s]')
ylabel("T_{w} [^{\circ}C]")
hold on;
grid on

subplot(3,2,4)
plot(ans.tout,ans.Tp, LineWidth=2)
grid on;
xlabel('Czas [s]')
ylabel("T_{p} [^{\circ}C]")
title('Skok dT_{z}=2')
hold on



%===========================================
%punkty rownowagi
Tz0=vTz0(3);
Tk0=vTk0(3);
fp0=vfp0(3);
A = [-cp*ro*fp0-K1-Kp, Kp; cp*ro*fp0+Kp, -cp*ro*fp0-K2-Kp];
B = [K1,cp*ro*fp0; K2,0];
u = [Tz0; Tk0];
x = -inv(A)*B*u;
Tw0 = x(1);
Tp0 = x(2);

a = cp*ro*fp0;
M=[Cvw*Cvp, Cvw*(a+Kp+K2)+Cvp*(a+K1+Kp), a*(a+K1+K2+Kp)+K1*Kp+K1*K2+Kp*K2];
LTz1 = [K1*Cvp, K1*a+K1*Kp+K1*K2+Kp*K2];
LTk1 = [Cvp*a, a*(a+Kp+K2)];
LTz2= [K2*Cvw, K2*a+K2*K1+K2*Kp+K1*a+K1*Kp];
LTk2 =a*(a+Kp);
%===========================================



% T_k
subplot(3,2,1)
dTk = 1;
dTz = 0;
dfp = 0;
sim(model);
plot(ans.tout,ans.Tw, LineWidth=2)
xlabel('Czas [s]')
ylabel("T_{w} [^{\circ}C]")
hold on;
grid on
lgd=legend('Wartosci Nominalne','\Delta T_{z}=+2 ^{\circ}C, fp_{0}=0.8fp_{N}','\Delta T_{z}=+2 ^{\circ}C i \Delta T_{k}=+1 ^{\circ}C, fp_{0}=0.8fp_{N}', Location='best')
lgd.FontSize = 10;

subplot(3,2,2)
plot(ans.tout,ans.Tp, LineWidth=2)
grid on;
xlabel('Czas [s]')
ylabel("T_{p} [^{\circ}C]")
hold on;
lgd=legend('Wartosci Nominalne','\Delta T_{z}=+2 ^{\circ}C, fp_{0}=0.8fp_{N}','\Delta T_{z}=+2 ^{\circ}C i \Delta T_{k}=+1 ^{\circ}C, fp_{0}=0.8fp_{N}', Location='best')
lgd.FontSize = 10;

% T_z
subplot(3,2,3)
dTk = 0;
dTz = 2;
dfp = 0;
sim(model);
plot(ans.tout,ans.Tw, LineWidth=2)
xlabel('Czas [s]')
ylabel("T_{w} [^{\circ}C]")
hold on;
grid on
hold on
lgd=legend('Wartosci Nominalne','\Delta T_{z}=+2 ^{\circ}C, fp_{0}=0.8fp_{N}','\Delta T_{z}=+2 ^{\circ}C i \Delta T_{k}=+1 ^{\circ}C, fp_{0}=0.8fp_{N}', Location='best')
lgd.FontSize = 10;

subplot(3,2,4)
plot(ans.tout,ans.Tp, LineWidth=2)
grid on;
xlabel('Czas [s]')
ylabel("T_{p} [^{\circ}C]")
title('Skok dT_{z}=2')
hold on
lgd=legend('Wartosci Nominalne','\Delta T_{z}=+2 ^{\circ}C, fp_{0}=0.8fp_{N}','\Delta T_{z}=+2 ^{\circ}C i \Delta T_{k}=+1 ^{\circ}C, fp_{0}=0.8fp_{N}', Location='best')
lgd.FontSize = 10;

