% Aleksander Lyskawa
%275462
% gr. 6, pt. 13:00
%Lab3

clear all 
close all

t = [0:0.01:8];

% 1)
xs1_1 = 4 * exp(-1*t);
xs2_1 = -8/3*exp(-3/2*t);
xs_1 = xs1_1 + xs2_1;
xw = 2/3;
x_1 = xs_1 + xw;

poziom = t;
poziom(:) = xw;

figure('Name','wykres nr 1')
grid on
hold on
plot(t,x_1,'black', 'LineWidth',3)
plot(t, poziom, 'r--')
plot(t, xs_1, 'c--','LineWidth',2)
xlabel('t')
ylabel('x')
legend('x','xw','xs1','xs2','xs','Location', 'NorthEast');


%2)
xs1_2 = -8 * exp(-1*t);
xs2_2 = 4*exp(-3/2*t);
xs_2 = xs1_2 + xs2_2;
x_2 = xs_2 + xw;

figure('Name','wykres nr 2')
grid on
hold on
plot(t,x_2,'black', 'LineWidth',3)
plot(t, poziom, 'r--')
plot(t, xs_2, 'c--','LineWidth',2)
xlabel('t')
ylabel('x')
legend('x','xw','xs1','xs2','xs','Location', 'NorthEast');


%skokowa 
xs1_s = -2 * exp(-1*t);
xs2_s = 4/3 * exp(-3/2*t);
xs_s = xs1_s + xs2_s;
x_s = xs_s + xw;

figure('Name','wykres do skokowego wymuszenia')
grid on
hold on
plot(t,x_s,'black', 'LineWidth',3)
plot(t, poziom, 'r--')
plot(t, xs_s, 'c--','LineWidth',2)
xlabel('t')
ylabel('x')
legend('x','xw','xs1','xs2','xs','Location', 'NorthEast');

%impulsowa 
xs1_i = 2 * exp(-1*t);
xs2_i = -2 * exp(-3/2*t);
xs_i = xs1_i + xs2_i;
x_i = xs_i + xw;

figure('Name','wykres do impuslowego wymuszenia ')
grid on
hold on
plot(t,x_i,'black', 'LineWidth',3)
plot(t, poziom, 'r--')
xlabel('t')
ylabel('x')
legend('x','xw','xs1','xs2','xs','Location', 'NorthEast');


%porownanie
figure('Name','Porownanie')
grid on
hold on
plot(t,x_i,'black')
plot(t, x_2, 'red')
plot(t, x_1, 'blue')
xlabel('t')
ylabel('x')
legend('x','xw','xs1','xs2','xs','Location', 'NorthEast');


