%Aleksander Lyskawa
%275462
%gr. 6 pt. 13:15
%13.10.2023
%cwiczenie 2

clear all 
close all 

TzewN = -20;
TwewN = 20;
TpN = 10;
qN = 5000;

a = 0.3;

Kcw=qN/(TwewN - TzewN + a * (TwewN - TpN));
Kcwp=a * Kcw;
Kcp=Kcwp * (TwewN - TpN)/(TpN - TzewN);


q = 4000:200:6000;
Tp = (q + Kcw*TzewN + (Kcp*TzewN)*((a+1)/a))/(5*a+Kcw);
Tw = (q/Kcw*(a+1)) + TzewN/(a+1) + a/(a+1) * Tp

figure
grid on
hold on
plot(TzewN, TwewN, 'ro', 'MarkerSize', 10);
title('Wykres statycznej char. T_{wew}(q) dla znanej T_{zew}')
xlabel('q[W]')
ylabel('T_{wew} [\circ C]')
legend('Location', 'SouthEast');

for i=1:length(q)

    Tw = (q(i)/Kcw*(a+1)) + TzewN/(a+1) + a/(a+1) * Tp
  
   

   
    plot(q,Tp,qN,TpN, 'x')
    grid on;
    title('Wykres statycznej char. T_{p}(q) dla znanej T_{zew}')
    xlabel('q[W]')
    ylabel('T_{p} [\circ C]')
    legend('Location', 'SouthEast');

end

Tz = -30:10:30;
Tp = (qN + Kcw*Tz + (Kcp*Tz)*((a+1)/a))/(5*a+Kcw);
Tw = (qN/Kcw*(a+1)) + Tz/(a+1) + a/(a+1) * (qN + Kcw*Tz + (Kcp*Tz)*((a+1)/a))/(5*a+Kcw) 

for i=1:length(Tz)
subplot(2,2,4)   
plot(Tz,Tw,TzewN,TwewN, 'x')
grid on;
title('Wykres T_{wew}(T_{zew}) dla znanego q')
xlabel('T_{zew} [\circ C]')
ylabel('T_{wew} [\circ C]')
legend('Location', 'SouthEast');


subplot(2,2,3)
plot(Tz,Tp,TzewN,TpN, 'x')
grid on;
title('Wykres T_{p}(T_{zew}) dla znanego q')
xlabel('T_{zew}[\circ C]')
ylabel('T_{p}[\circ C]')
legend('Location', 'SouthEast');

end





