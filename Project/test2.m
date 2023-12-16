%Zmienne wejsciowe Tzew,qg,fp
%Zmienne wejsciowe (stanu) Twew, Tp

clear all;
close all;
clc;
%========= 1. Identyfikacja =============
%wartosci nominalne
TzewN=-20; %oC      
TwewN=20; %oC        
TpN=10; %oC      
qgN=20000; %W
Vw=2.5; %m^3
Vp=1.25; %m^3
fpN=0.2; %m^3/s
cp=1000; %cieplo wlasciwe powietrza
rop=1.2;%gestosc powietrza
a1=0.55;
a2=0.45;
%.............................
%identyfikacja parametrow statycznych
K1=(a1*qgN)/(TwewN-TzewN);
Kp=(a2*qgN)/(TwewN-TpN);
K2=(a2*qgN - cp*rop*fpN*(TpN-TzewN))/(TpN-TzewN);
%.............................
%identyfikacja paramterow dynamicznych
Cvw=cp*rop*Vw; %pojemnosc cieplna wnetrza
Cvp=cp*rop*Vp; %pojemnosc cieplna poddasza

%========= 2. Punkty pracy =============
Tzew0=TzewN ; % [+0 , +10 , +20]
qg0=qgN; 
fp0=fpN;

%pkty rownowagi
Tp0=(Tzew0*(Kp*K1 + (K2+cp*rop*fp0)*(K1+Kp))+Kp*qg0)/(K1*Kp+(K1+Kp)*(K2+cp*rop*fp0));
Twew0=(qg0+Kp*Tp0+K1*Tzew0)/(K1+Kp);

%========= 3. Symulacja =============
%parametry
czas_symulacji=100;
t0=10;
dfp=1;
dqg=0;
dTzew=0;
%%%%%%%%%  a. BADANIA MODELU NIELINIOWEGO %%%%%%%%%%%%%

model='Rak_miniprojekt_si.slx';

sim(model,czas_symulacji);
figure(1)
subplot(211)
plot(ans.tout,ans.Twew);
xlabel('t [s]');
ylabel('Twew(t)');
title('Temperatura wnętrza (Model nieliniowy)');
grid on
subplot(212);
plot(ans.tout,ans.Tp);
xlabel('t [s]');
ylabel('Tp(t)');
title('Temperatura poddasza (Model nieliniowy)');
grid on

