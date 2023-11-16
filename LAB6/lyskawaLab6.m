%Aleksander Lyskawa
%pt 13:15
%LAB 6

close all;
clear all;
clc;

model="lyskawaLab6_si.slx";
A1 = 1; % inne
Aw1 = 0.1 * 1; % inne
H1 = 9;

A2 = 1; % inne
Aw2 = 0.1 * 1;
H2 = 2; % inne

t0 =4;
stopTime = 20;
g=9.81;


a1 = Aw1 * sqrt(2*g/H1);
a2 = Aw2 * sqrt(2*g/H2);

fwe1max= a1 * H1;
fwe2max=abs(a2 * H2 - a1 * H1);

% skok w zbiorniku 1, zbiornik 2 = const
dfwe1 = 0.1*fwe1max;
dfwe2= 0;
arrayfwe1_0 = [0,0.5* fwe1max, 0.9 * fwe1max]; 
fwe2_0 = 0.1 * fwe2max;

% wykres h1
figure;
for i=1:3
    h1_0=arrayfwe1_0(i)/a1;
    h2_0=fwe2_0/a2;
    fwe1_0=arrayfwe1_0(i); 
    
    hold on;
    grid on;
    sim(model);
    plot(ans.tout,ans.h1, LineWidth=2);
    xlabel('time [s]')
    ylabel('h1');
    title('Odpowiedz zbiornika nr 1 na wymuszenie w zbiorniku nr 1');
end 

% wykres h2 
figure;
for i=1:3
    h1_0=arrayfwe1_0(i)/a1;
    h2_0=fwe2_0/a2;
    fwe1_0=arrayfwe1_0(i); 
   
    hold on;
    grid on;
    sim(model);
    plot(ans.tout,ans.h2, LineWidth=2);
    xlabel('time [s]')
    ylabel('h2');
    title('Odpowiedz zbiornika nr 2 na wymuszenie w zbiorniku nr 1');
end


% skok w zbiorniku 2, zbiornik 1 = const
dfwe1 = 0;
dfwe2 = 0.2 * fwe2max;  
fwe1_0 = 0.1*fwe1max;
arrayfwe2_0 = [0,0.5*fwe2max,0.9*fwe2max];

%wykres h1
figure;
for i=1:3
    h1_0=fwe1_0/a1;
    h2_0=arrayfwe2_0(i)/a2;
    fwe2_0=arrayfwe2_0(i);
    
    hold on;
    grid on;
    sim(model);
    plot(ans.tout,ans.h1, LineWidth=2);
    xlabel('time [s]')
    ylabel('h1 ');
    title('Odpowiedz zbiornika nr 1 na wymuszenie w zbiorniku nr 2');
    
end

%wykres h2
figure;
for i=1:3
    h1_0=fwe1_0/a1;
    h2_0=arrayfwe2_0(i)/a2;
    fwe2_0=arrayfwe2_0(i);

    hold on;
    grid on;
    sim(model);
    plot(ans.tout,ans.h2, LineWidth=2);
    xlabel('time [s]')
    ylabel('h2');
    title('Odpowiedz zbiornika nr 2 na wymuszenie w zbiorniku nr 2');
end

