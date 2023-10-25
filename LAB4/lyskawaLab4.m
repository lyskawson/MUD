%Aleksander Lyskawa
%275462
% pt. 13:15
% cw. nr 4

clear all 
close all

model = 'lyskawaLab4_si.slx';
t = [0:0.01:8];

%Initial conditions 
%1) x'(0)=0
%2) x'(0)=9
%3) x(0)=0
%4) x(0)=8

initialConditions = [10/3, 1/3, 0, 8];
titles = ["x'(0) = 0", "x'(0) = 9", 'x(0) = 0', 'x(0) = 8'];

%Wartosci zmiennych dla indeksu 275462
a1 = 2;
a0 = 6;
b = 4;
u0 = 5 ;
t0 = 0;
du = 0;

%%symulacyjnie 
figure('Name','Rozwiazania symulacyjne') 
for i=1:4
   
   x0=initialConditions(i);
   subplot(2,2,i);
   sim(model)
   plot(ans.tout, ans.xout, LineWidth=2);
   grid on;
   title('Rozwiazanie dla ',titles(i));
   xlabel('t');
   ylabel('x');


end


%% analitycznie 
xw = 10/3;
poziom = t;
poziom(:) = xw;

figure('Name','Rozwiazania analityczne');
%1)
subplot(2,2,1)
xs_1 = 0;
x_1 = xs_1 + xw;
title('Name',"Rozwiazanie dla x'(0)=0")
grid on
hold on
plot(t,poziom,'red', LineWidth=2)
xlabel('t')
ylabel('x')

%2)
subplot(2,2,2)
xs_2 = -3*exp(-3*t);
x_2 = xs_2 + xw;
title('Name',"Rozwiazanie dla x'(0)=9")
grid on
hold on
plot(t,x_2,'blue', LineWidth=2)
xlabel('t')
ylabel('x')

%3)
subplot(2,2,3)
xs_3 = -10/3*exp(-3*t);
x_3 = xs_3 + xw;
title('Name',"Rozwiazanie dla x(0)=0")
grid on
hold on
plot(t,x_3,'magenta', LineWidth=2)
xlabel('t')
ylabel('x')

%4)
subplot(2,2,4)
xs_4 = 14/3*exp(-3*t);
x_4 = xs_4 + xw;
title('Name',"Rozwiazanie dla  x(0)=8")
grid on
hold on
plot(t,x_4,'green', LineWidth=2)
xlabel('t')
ylabel('x')

