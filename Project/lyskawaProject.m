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
model='lyskawaProject_si.slx';
model_rs='lyskawaProject_si_rs.slx'

%Zmienne wejsciowe Tz, fp, Tk
%Zmienne wejsciowe (zmienne stanu) Tw, Tp

%model='lyskawaProject_si.slx';

%-------- 1. Identyfikacja -----------------
%wartosci nominalne
TzN=-20;     %temperatura na zewnatrz[oC]      
TwN=20;      %temperatura wewnatrz[oC]        
TpN=15;      %temperatura na poddaszu[oC]     
TkN = 35;    %temperatura powietrza
Vw=30;       %objetosc pomieszczenia[m^3] 
Vp=15;       %objetosc poddasza[m^3]
cp=1000;     %cieplo wlasciwe powietrza
ro=1.2;      %gestosc powietrza
qkN = 20000; %strumien ciepla[W]

%parametry statyczne
fpN=qkN/cp*ro*TkN;    %przeplyw powietrza [m^3/s]
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

%-------- 3. Symulacja ---------------------
t0=10;
dfp=0;
dTz=1;
dTk=0;



%% MODEL NIELINIOWY 
figure;
hold on;
grid on;
sim(model);
plot(ans.tout,ans.Tw, LineWidth=2);
xlabel('time [s]')
ylabel('Tw');
title('Temperatura wnętrza (nieliniowy model)');

figure;
hold on;
grid on;
sim(model);
plot(ans.tout,ans.Tp, LineWidth=2);
xlabel('time [s]')
ylabel('Tp');
title('Temperatura poddasza (nieliniowy model)');

%% ROWNANIA STANU

%Definicja macierzy
M1=[(-cp*ro*fp0-K1-Kp)/Cvw, Kp/Cvw;(cp*ro*fp0+Kp)/Cvp, (-cp*ro*fp0-Kp-K2)/Cvp];
M2=[K1/Cvw, (cp*ro*fp0)/Cvw;K2/Cvp, 0];
M3=[1,0;0,1];
M4=[0,0 ; 0,0];
%.....................
%stan równowagi
u=[Tz0;Tk0];
x0=-inv(M1)*M2*u;

%symulacja
t0=10;
dfp=0;
dTz=1;
dTk=0;

figure;
hold on;
grid on;
sim(model_rs);
plot(ans.tout,ans.Tw, LineWidth=2);
xlabel('time [s]')
ylabel('Tw');
title('Temperatura wnętrza (r. stanu)');

figure;
hold on;
grid on;
sim(model_rs);
plot(ans.tout,ans.Tp, LineWidth=2);
xlabel('time [s]')
ylabel('Tp');
title('Temperatura poddasza (r. stanu)');

