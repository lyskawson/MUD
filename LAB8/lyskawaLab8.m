% Aleksander Lyskawa
% 275462
% pt 13:15
% LAB 8

clear all; 
close all;
clc;

model='lyskawaLab8_si.slx';
model_rs= 'lyskawaLab8_si_rs.slx'
A1 = 2; 
Aw1 = 0.1 * 2; 
H1 = 5;

A2 = 2; 
Aw2 = 0.1 * 2;
H2 = 4; 

t0 =5;
maxStepSize = 0.001;
startTime = 0;
stopTime = 60;
g=9.81;

a1=Aw1*sqrt(2*g*(H1-H2))/(H1-H2);
a2=Aw2*sqrt(2*g*H2)/H2;

fwe1max=a1*(H1-H2);
fwe2max=a2*H2 - fwe1max;

%TRANSMITANCJE-----------------------------------------
M=[A1*A2 A1*a1+A1*a2+A2*a1 a1*a2];
L1=[A2 a1+a2];
L2=a1;
L3=a1;
L4=[A1 a1];

%% skok w zbiorniku 1, zbiornik 2 = const
dfwe1 = 0.1*fwe1max;
dfwe2 = 0;
arrayfwe1_0 = [0,0.5*fwe1max,0.9*fwe1max];
fwe2_0=0.2*fwe2max;

% wykres h1
figure;
for i=1:3
    fwe1_0=arrayfwe1_0(i); 
    h2_0=(fwe1_0 + fwe2_0)/a2;
    h1_0=fwe1_0/a1 + h2_0;
    
    hold on;
    grid on;
    sim(model);
    plot(ans.tout,ans.h1, LineWidth=2);
    xlabel('time [s]')
    ylabel('h1');
    title('Wykres h(t) w zbiorniku nr 1 po wymuszeniu w zbiorniku nr 1 (transmitancje) ');
end 

% wykres h2 
figure;
for i=1:3
    fwe1_0=arrayfwe1_0(i); 
    h2_0=(fwe1_0 + fwe2_0)/a2;
    h1_0=fwe1_0/a1 + h2_0;
    
    hold on;
    grid on;
    sim(model);
    plot(ans.tout,ans.h2,LineWidth=2);
    xlabel('time [s]')
    ylabel('h2');
    title('Wykres h(t) w zbiorniku nr 2 po wymuszeniu w zbiorniku nr 1 (transmitancje)');
end

%% skok w zbiorniku 2, zbiornik 1 = const
dfwe1 = 0;
dfwe2 = 0.1*fwe2max;
fwe1_0 = 0.2*fwe1max;
arrayfwe2_0= [0,0.5*fwe2max,0.9*fwe2max];

% wykres h1
figure;
for i=1:3
    fwe2_0=arrayfwe2_0(i); 
    h2_0=(fwe1_0 + fwe2_0)/a2;
    h1_0=fwe1_0/a1 + h2_0;
    
    hold on;
    grid on;
    sim(model);
    plot(ans.tout,ans.h1, LineWidth=2);
    xlabel('time [s]')
    ylabel('h1');
    title('Wykres h(t) w zbiorniku nr 1 po wymuszeniu w zbiorniku nr 2 (transmitancje) ');
end 

% wykres h2 
figure;
for i=1:3
    fwe2_0=arrayfwe2_0(i); 
    h2_0=(fwe1_0 + fwe2_0)/a2;
    h1_0=fwe1_0/a1 + h2_0;
    
    hold on;
    grid on;
    sim(model);
    plot(ans.tout,ans.h2,LineWidth=2);
    xlabel('time [s]')
    ylabel('h2');
    title('Wykres h(t) w zbiorniku nr 2 po wymuszeniu w zbiorniku nr 2 (transmitancje)');
end

%ROWNANIA STANU------------------------------------------
M1=[-a1/A1, a1/A1;a1/A2, -a1/A2-a2/A2];
M2=[1/A1, 0;0, 1/A2];
M3=[1, 0;0, 1];
M4=[0, 0;0, 0];

%% skok w zbiorniku 1, zbiornik 2 = const
dfwe1 = 0.1*fwe1max;
dfwe2 = 0;
arrayfwe1_0 = [0,0.5*fwe1max,0.9*fwe1max];
fwe2_0=0.2*fwe2max;

% wykres h1
figure;
for i=1:3
    fwe1_0=arrayfwe1_0(i); 
    h2_0=(fwe1_0 + fwe2_0)/a2;
    h1_0=fwe1_0/a1 + h2_0;
    h_0 = [h1_0, h2_0];
    
    hold on;
    grid on;
    sim(model_rs);
    plot(ans.tout,ans.h1, LineWidth=2);
    xlabel('time [s]')
    ylabel('h1');
    title('Wykres h(t) w zbiorniku nr 1 po wymuszeniu w zbiorniku nr 1 (r. stanu)');
end 

% wykres h2 
figure;
for i=1:3
    fwe1_0=arrayfwe1_0(i); 
    h2_0=(fwe1_0 + fwe2_0)/a2;
    h1_0=fwe1_0/a1 + h2_0;
     h_0 = [h1_0, h2_0];
    
    hold on;
    grid on;
    sim(model_rs);
    plot(ans.tout,ans.h2,LineWidth=2);
    xlabel('time [s]')
    ylabel('h2');
    title('Wykres h(t) w zbiorniku nr 2 po wymuszeniu w zbiorniku nr 1 (r. stanu)');
end

%% skok w zbiorniku 2, zbiornik 1 = const
dfwe1 = 0;
dfwe2 = 0.1*fwe2max;
fwe1_0 = 0.2*fwe1max;
arrayfwe2_0= [0,0.5*fwe2max,0.9*fwe2max];

% wykres h1
figure;
for i=1:3
    fwe2_0=arrayfwe2_0(i); 
    h2_0=(fwe1_0 + fwe2_0)/a2;
    h1_0=fwe1_0/a1 + h2_0;
    h_0 = [h1_0, h2_0];
    
    hold on;
    grid on;
    sim(model_rs);
    plot(ans.tout,ans.h1, LineWidth=2);
    xlabel('time [s]')
    ylabel('h1');
    title('Wykres h(t) w zbiorniku nr 1 po wymuszeniu w zbiorniku nr 2 (r. stanu) ');
end 

% wykres h2 
figure;
for i=1:3
    fwe2_0=arrayfwe2_0(i); 
    h2_0=(fwe1_0 + fwe2_0)/a2;
    h1_0=fwe1_0/a1 + h2_0;
    h_0 = [h1_0, h2_0];
    
    hold on;
    grid on;
    sim(model_rs);
    plot(ans.tout,ans.h2,LineWidth=2);
    xlabel('time [s]')
    ylabel('h2');
    title('Wykres h(t) w zbiorniku nr 2 po wymuszeniu w zbiorniku nr 2 (r. stanu)');
end