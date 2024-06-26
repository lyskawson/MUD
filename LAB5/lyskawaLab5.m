%Aleksander Lyskawa
%275462
% pt. 13:15
% cw. nr 5

clear all;
close all;

model='lyskawaLab5_si.slx';

t0 = 0;
u0 = 0;
du = 1;
xDot0 = 0;
x0 = 0;


%%1) wartosci parametrow z przygotowania
ksi_1 = [3, -13/5, 0, 1/5, -1/4];
titles_1 = ["ksi = 3", "ksi = -13/5", "ksi = 0", "ksi = 1/5", "ksi = -1/4"];
colors=['r','b','g','m','c'];
w=7;

for i=1:length(ksi_1)
   ksi=ksi_1(i);
   lambda1=w*(-ksi + sqrt(ksi * ksi - 1));
   lambda2=w*(-ksi - sqrt(ksi * ksi -1));
   if ksi == -13/5 || ksi == -1/4
       startTime = 6;
       stopTime = 16;
   else 
       startTime = 0;
       stopTime = 10;

   end 

   figure;
   subplot(211);
   sim(model);
   plot(ans.tout,ans.x, colors(i), LineWidth=2);
   grid on;
   title('Rozwiazanie i bieguny dla ',titles_1(i));
   xlabel('t');
   ylabel('x');

   subplot(212);
   title('Bieguny');
   hold on;
   grid on;
   plot(real(lambda1),imag(lambda1),'x', LineWidth=5);
   plot(real(lambda2),imag(lambda2),'x', LineWidth=5);
   line([0,0], ylim, 'Color', 'k', LineWidth=2);
   line(xlim, [0,0], 'Color', 'k', LineWidth=2); 
   xlabel('Re');
   ylabel('Im');
end


%%2) Dobrane wartosci parametrow do drugiej czesci zadania
ksi_2=[0.3,0.4,0.8,0.9];
w_2=[2,5,8,10];
startTime = 0;
stopTime = 7;


%%takie samo ksi
figure;
for i=1:length(ksi_2)
ksi=ksi_2(2);
w=w_2(i);
lambda1=w*(-ksi + sqrt(ksi * ksi - 1));
lambda2=w*(-ksi - sqrt(ksi * ksi -1));
subplot(211);
title('Takie samo ksi (ten sam kąt)')
hold on;
sim(model);
plot(ans.tout,ans.x,colors(i), LineWidth=2);
grid on;
xlabel('t');
ylabel('x');

subplot(212);
title('Bieguny');
hold on;
plot(real(lambda1),imag(lambda1),strcat('x',colors(i)), LineWidth=5);
plot(real(lambda2),imag(lambda2),strcat('x',colors(i)), LineWidth=5);
line([0,0], ylim, 'Color', 'k', LineWidth=2);
line(xlim, [0,0], 'Color', 'k', LineWidth=2); 
grid on;
xlabel('Re');
ylabel('Im');
end

%%takie samo w
figure;
for i=1:length(ksi_2)
ksi=ksi_2(i);
w=w_2(3);
lambda1=w*(-ksi + sqrt(ksi * ksi - 1));
lambda2=w*(-ksi - sqrt(ksi * ksi -1));
subplot(211);
title('Takie samo ω (na jednym okręgu)')
hold on;
sim(model);
plot(ans.tout,ans.x,colors(i), LineWidth=2);
grid on;
xlabel('t');
ylabel('x');

subplot(212);
hold on;
plot(real(lambda1),imag(lambda1),strcat(colors(i),'x'),'LineWidth',5);
plot(real(lambda2),imag(lambda2),strcat(colors(i),'x'),'LineWidth',5);
line([0,0], ylim, 'Color', 'k', LineWidth=2);
line(xlim, [0,0], 'Color', 'k', LineWidth=2); 
grid on;
xlabel('Re');
ylabel('Im');
title('Bieguny');
end

%%takie samo re
% dla re(lambda) = -1.5 
% ze wzoru -ksi*w=-1.5

w_3= 1.5./(ksi_2);
figure;
for i=1:length(ksi_2)
ksi=ksi_2(i);
w=w_3(i);
lambda1=w*(-ksi + sqrt(ksi * ksi - 1));
lambda2=w*(-ksi - sqrt(ksi * ksi -1));
subplot(211);
title('Taka sama część rzeczywista (odległość od osi OX).')
hold on;
sim(model);
plot(ans.tout,ans.x,colors(i), LineWidth=2);
grid on;
xlabel('t');
ylabel('x');

subplot(212);
hold on;
plot(real(lambda1),imag(lambda1),strcat(colors(i),'x'),'LineWidth',5);
plot(real(lambda2),imag(lambda2),strcat(colors(i),'x'),'LineWidth',5);
line([0,0], ylim, 'Color', 'k', LineWidth=2);
line(xlim, [0,0], 'Color', 'k', LineWidth=2); 
grid on;
xlabel('Re');
ylabel('Im');
title('Bieguny');
end

