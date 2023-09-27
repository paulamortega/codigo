%WanderPlanner

clc
clear all
close all

%% creacion de matriz y puntos
X=5;% eje x
Y=5;%  eje y
camino=zeros(Y,X);%matriz de ceros

Pi=[5,1];% punto de inicial
Pf=[1,4];% punto final
camino(Pi(1),Pi(2))=1;
camino(Pf(1),Pf(2))=1;

O1=[2,2];
O2=[2,3];
O3=[3,2];

camino(O1(1),O1(2))=-3;
camino(O2(1),O2(2))=-3;
camino(O3(1),O3(2))=-3;

ocuw(1:Y,1:X,1:3)=zeros(Y,X,3); %matriz para graficar

Pa=Pi;%punto actual;
PA=2:1000; % Coordenadas de cada paso
a=1;%Contador de pasos

while (true)
%%     
    if (Pa==Pf)
        PA(1,a)=Pa(1);
        PA(2,a)=Pa(2);
        break %Éxito y sale
    end

%% Expandir el nodo

[Da,Aumento]=expancionnodo4(Pa,X,Y,camino);% define vecinos admisibles 

% [Da,Aumento]=expancionnodo8(Pa,n,N,camino);

%% Escoger el camino

[ocuw,camino,Pa]=escoger_ruta4(Da,Pa,camino,ocuw,Aumento);% cambia posición actual a la del vecino

% [ocuw,camino,Pa]=escoger_ruta8(Da,Pa,camino,ocuw,Aumento,a);


%% Ingresar al vector
   PA(1,a)=Pa(1);
   PA(2,a)=Pa(2);
   a=a+1;

end

%% pintar matriz

ocuw(Pi(1),Pi(2),:)=[1 0 0];
ocuw(Pf(1),Pf(2),:)=[1 0 0];
ocuw(O1(1),O1(2),:)=[140/255 140/255 140/255];
ocuw(O2(1),O2(2),:)=[140/255 140/255 140/255];
ocuw(O3(1),O3(2),:)=[140/255 140/255 140/255];

figure()
imshow(ocuw,'InitialMagnification','fit')
title('Ruta')