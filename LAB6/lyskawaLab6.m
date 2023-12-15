%Aleksander Lyskawa
%pt 13:15
%LAB 6

close all;
clear all;
clc;

model="lyskawaLab6_si.slx";
nonlinear_model = "lyskawaLab6_si_nonlinear.slx";
A1 = 2; 
Aw1 = 0.1 * 2; 
H1 = 4;

A2 = 6; 
Aw2 = 0.1 * 6;
H2 = 5; 

t0 =5;
stopTime = 50;
g=9.81;

%% liniowo  
a1 = Aw1 * sqrt(2*g/H1);
a2 = Aw2 * sqrt(2*g/H2);

fwe1max= a1 * H1;
fwe2max=a2 * H2 - a1 * H1;

% skok w zbiorniku 1, zbiornik 2 = const
dfwe1 = 0.1*fwe1max;
dfwe2= 0;
arrayfwe1_0 = [0, 0.5* fwe1max, 0.9 * fwe1max]; 
fwe2_0 = 0.1 * fwe2max;

% wykres h1
figure;
for i=1:3
    fwe1_0=arrayfwe1_0(i); 
    h1_0=fwe1_0/a1;
    h2_0=(fwe2_0 + fwe1_0)/a2;
    
    hold on;
    grid on;
    sim(model);
    plot(ans.tout,ans.h1, LineWidth=2);
    xlabel('time [s]')
    ylabel('h1');
    title('Wykres h(t) w zbiorniku nr 1 po wymuszeniu w zbiorniku nr 1 (liniowy model)');
   
end 

% wykres h2 
figure;
for i=1:3
    fwe1_0=arrayfwe1_0(i); 
    h1_0=fwe1_0/a1;
    h2_0=(fwe2_0 + fwe1_0)/a2;
    
    hold on;
    grid on;
    sim(model);
    plot(ans.tout,ans.h2,LineWidth=2);
    xlabel('time [s]')
    ylabel('h2');
    title('Wykres h(t) w zbiorniku nr 2 po wymuszeniu w zbiorniku nr 1(liniowy model)');
   
end

% skok w zbiorniku 2, zbiornik 1 = const
dfwe1 = 0;
dfwe2= 0.1*fwe2max;
arrayfwe2_0 = [0,0.5* fwe2max, 0.9 * fwe2max]; 
fwe1_0 = 0.2 * fwe1max;

% wykres h1
figure;
for i=1:3
    fwe2_0=arrayfwe2_0(i); 
    h1_0=fwe1_0/a1;
    h2_0=(fwe2_0 + fwe1_0)/a2;
    
    hold on;
    grid on;
    sim(model);
    plot(ans.tout,ans.h1, LineWidth=2);
    xlabel('time [s]')
    ylabel('h1');
    title('Wykres h(t) w zbiorniku nr 1 po wymuszeniu w zbiorniku nr 2 (liniowy model)');
    set(gca,"FontSize",18)
  
end 

% wykres h2 
figure;
for i=1:3
    fwe2_0=arrayfwe2_0(i); 
    h1_0=fwe1_0/a1;
    h2_0=(fwe2_0 + fwe1_0)/a2;
    
    hold on;
    grid on;
    sim(model);
    plot(ans.tout,ans.h2,LineWidth=2);
    xlabel('time [s]')
    ylabel('h2');
    title('Wykres h(t) w zbiorniku nr 2 po wymuszeniu w zbiorniku nr 2(liniowy model)');
    set(gca,"FontSize",18)
   
end

%% nieliniowo 
fwe1max= Aw1*sqrt(2*g* H1);
fwe2max= Aw2*sqrt(2*g* H2)- fwe1max;

% skok w zbiorniku 1, zbiornik 2 = const
dfwe1 = 0.1*fwe1max;
dfwe2= 0;
arrayfwe1_0 = [0,0.5* fwe1max, 0.9 * fwe1max]; 
fwe2_0 = 0.1 * fwe2max;

% wykres h1
figure;
for i=1:3
    fwe1_0=arrayfwe1_0(i); 
    h1_0 = fwe1_0^2/(Aw1^2 *2*g);
    h2_0 = (fwe1_0 + fwe2_0)^2/(Aw2^2 * 2*g); 
    
    hold on;
    grid on;
    sim(nonlinear_model);
    plot(ans.tout,ans.h1, LineWidth=2);
    xlabel('time [s]')
    ylabel('h1');
    title('Wykres h(t) w zbiorniku nr 1 po wymuszeniu w zbiorniku nr 1 (nieliniowy model)');
   
end 

% wykres h2 
figure;
for i=1:3
    fwe1_0=arrayfwe1_0(i); 
    h1_0 = fwe1_0^2/(Aw1^2 *2*g);
    h2_0 = (fwe1_0 + fwe2_0)^2/(Aw2^2 * 2*g);
    hold on;
    grid on;
    sim(nonlinear_model);
    plot(ans.tout,ans.h2,LineWidth=2);
    xlabel('time [s]')
    ylabel('h2');
    title('Wykres h(t) w zbiorniku nr 2 po wymuszeniu w zbiorniku nr 1 (nieliniowy )');
    
end

