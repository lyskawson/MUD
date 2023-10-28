%Aleksander Lyskawa
%275462
% pt. 13:15
% cw. nr 4

clear all 
close all

model = 'lyskawaLab4_si.slx';
t = [0:0.01:4];

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
for i=1:length(initialConditions)
   x0=initialConditions(i);
   subplot(2,2,i);
   sim(model)
   plot(ans.tout, ans.x, LineWidth=2);
   grid on;
   title('Rozwiazanie dla ',titles(i));
   xlabel('t');
   ylabel('x');
   set(gca,"FontSize",12)
end

%% analitycznie (same rozwiazanie ) 
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
set(gca,"FontSize",12)

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
set(gca,"FontSize",12)

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
set(gca,"FontSize",12)

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
set(gca,"FontSize",12)

%% analitycznie ze skladowowymi

figure('Name','Rozwiazania analityczne ze skladowymi');
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
set(gca,"FontSize",12)

%2)
subplot(2,2,2)
xs_2 = -3*exp(-3*t);
x_2 = xs_2 + xw;
title('Name',"Rozwiazanie dla x'(0)=9")
grid on
hold on
plot(t,x_2,'blue', LineWidth=2)
plot(t, poziom, 'r--')
plot(t,xs_2, 'k--')
xlabel('t')
ylabel('x')
set(gca,"FontSize",12)

%3)
subplot(2,2,3)
xs_3 = -10/3*exp(-3*t);
x_3 = xs_3 + xw;
title('Name',"Rozwiazanie dla x(0)=0")
grid on
hold on
plot(t,x_3,'magenta', LineWidth=2)
plot(t, poziom, 'r--')
plot(t, xs_3, 'k--')
xlabel('t')
ylabel('x')
set(gca,"FontSize",12)

%4)
subplot(2,2,4)
xs_4 = 14/3*exp(-3*t);
x_4 = xs_4 + xw;
title('Name',"Rozwiazanie dla  x(0)=8")
grid on
hold on
plot(t,x_4,'green', LineWidth=2)
plot(t, poziom, 'r--')
plot(t, xs_4, 'k--')
xlabel('t')
ylabel('x')
set(gca,"FontSize",12)

%%Dla odpowiedzi skokowej jednostkowej 
figure("Name","Rozwiazanie symulacyjne ze skokiem jednostkowym" )
x0 = 0;
du = 1;
u0 = 0;
sim(model)
plot(ans.tout, ans.x, LineWidth=2)
grid on;
xlabel('t')
ylabel('x')
set(gca,"FontSize",12)

%%Dla wymuszenia skokowego u0 roznego od 0
figure("Name","Rozwiazanie symulacyjne dla wymuszenia skokowego roznego od 0" )
x0 = 0;
du = 10;
u0 = 3;
sim(model)
plot(ans.tout, ans.x, LineWidth=2)
grid on;
xlabel('t')
ylabel('x')
set(gca,"FontSize",20)