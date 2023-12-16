% Aleksander Lyskawa
% 275462
% pt 13:15
% LAB 9, 10, 11

clear all;
close all;
clc;
startTime = 0;
stopTime = 300;
maxStepSize = 0.001;
model='lyskawaProject_si.slx';
model_rs='lyskawaProject_si_rs.slx';
model_tr='lyskawaProject_si_tr.slx';

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
%Kp = (K2*(TpN-TzN))/(TwN-TpN) -cp*ro*fpN;
Kp = (2*cp*ro*fpN*(TkN-TpN)*(TpN-TzN))/((TwN-TpN)*(TwN+2*TpN-3*TzN)) -cp*ro*fpN;

%paramterow dynamiczne
Cvw=cp*ro*Vw;   %pojemnosc cieplna wnetrza
Cvp=cp*ro*Vp;   %pojemnosc cieplna poddasza

%-------- 2. Punkty pracy -------------------
Tz0=TzN;
Tk0=TkN;
fp0=fpN;

%punkty rownowagi
A = [-cp*ro*fp0-K1-Kp, Kp; cp*ro*fp0+Kp, -cp*ro*fp0-K2-Kp];
B = [K1,cp*ro*fp0; K2,0];
u = [Tz0; Tk0];
x = -inv(A)*B*u;
Tw0 = x(1);
Tp0 = x(2);

% M = (cp * ro * fp0 + Kp + K2 - (Kp^2 * cp * ro * fp0 / (cp * ro * fp0 + K1 + Kp)));
% Tp0 = (K2 * Tz0) / M + (Kp * cp^2 * ro^2 * fp0^2 * Tk0 + Kp * K1 * cp * ro * fp0 * Tz0) / (M * cp * ro * fp0+ K1 + Kp);
% Tw0 = (cp*ro*fp0*Tk0+K1*Tz0+Kp*Tp0) / (cp*ro*fp0+K1+Kp);

%-------- 3. Symulacja ---------------------
t0=10;
dfp=0;
dTz=5;
dTk=0;


%% MODEL NIELINIOWY
figure;
subplot(211)
hold on;
grid on;
sim(model);
plot(ans.tout,ans.Tw, LineWidth=2,Color=[0.9290, 0.6940, 0.1250]);
xlabel('time [s]')
ylabel('Tw');
title('Temperatura wnętrza (nieliniowy model)');

subplot(212)
hold on;
grid on;
sim(model);
plot(ans.tout,ans.Tp, LineWidth=2, Color=[0.9290, 0.6940, 0.1250]);
xlabel('time [s]')
ylabel('Tp');
title('Temperatura poddasza (nieliniowy model)');

%% ROWNANIA STANU
%Definicja macierzy
A=[(-cp*ro*fp0-K1-Kp)/Cvw, Kp/Cvw;(cp*ro*fp0+Kp)/Cvp, (-cp*ro*fp0-Kp-K2)/Cvp];
B=[K1/Cvw, (cp*ro*fp0)/Cvw;K2/Cvp, 0];
C=[1,0;0,1];
D=[0,0 ; 0,0];

figure;
subplot(211)
hold on;
grid on;
sim(model_rs);
plot(ans.tout,ans.Tw, LineWidth=2, Color=[0, 0.4470, 0.7410]);
xlabel('time [s]')
ylabel('Tw');
title('Temperatura wnętrza (r. stanu)');

subplot(212)
hold on;
grid on;
sim(model_rs);
plot(ans.tout,ans.Tp, LineWidth=2, Color=[0, 0.4470, 0.7410]);
xlabel('time [s]')
ylabel('Tp');
title('Temperatura poddasza (r. stanu)');

%% TRANSMITANCJA
%Definicja transmitancji
a = cp*ro*fp0;
M=[Cvw*Cvp, Cvw*(a+Kp+K2)+Cvp*(a+K1+Kp), a*(a+K1+K2+Kp)+K1*Kp+K1*K2+Kp*K2];
LTz1 = [K1*Cvp, K1*a+K1*Kp+K1*K2+Kp*K2];
LTk1 = [Cvp*a, a*(a+Kp+K2)];
LTz2= [K2*Cvw, K2*a+K2*K1+K2*Kp+K1*a+K1*Kp];
LTk2 =a*(a+Kp);

figure;
subplot(211)
hold on;
grid on;
sim(model_tr);
plot(ans.tout,ans.Tw, LineWidth=2, Color='Red');
xlabel('time [s]')
ylabel('Tw');
title('Temperatura wnętrza (Transmitancje)');

subplot(212);
hold on;
grid on;
sim(model_tr);
plot(ans.tout,ans.Tp, LineWidth=2,Color='Red');
xlabel('time [s]')
ylabel('Tp');
title('Temperatura poddasza (Transmitancje)');

