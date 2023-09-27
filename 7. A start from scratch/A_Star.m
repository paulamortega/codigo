%A Star

close all;
clear all;
clc;

%% Espacio de trabajo 

%Tamaño del espacio de trabajo
size_grid_x=100;
size_grid_y=100;

%Nodo final
goal(1,1)=100; %Coordenada x
goal(2,1)=100; %Coordenada y
goal(3,1)=inf; %Coordenada x del padre
goal(4,1)=inf; %Coordenada y del padre

% load('obstacle.mat');
% obstacle=obstacle_1;  %1,1

% load('change_1.mat');  %17,36

% load('change_2.mat');  %22,44

% load('change_3.mat');  %37,45

% load('change_4.mat');  %38,72

% load('change_5.mat');  %70,71

load('change_6.mat');  %98,91

%Nodo de inicio
start(1,1)=98; %Coordenada x
start(2,1)=91; %Coordenada y
start(3,1)=inf; %Coordenada x del padre
start(4,1)=inf; %Coordenada y del padre
start(5,1)=0;
start(6,1)=0; %Coste de nodo inicial
start(7,1)=(abs(start(2)-goal(2))+abs(start(1)-goal(1)))*10; %Estimación (F) del nodo inicial

%% Creación del arreglo tridimencional
ocuw(1:size_grid_x,1:size_grid_y,1:3)=ones(size_grid_x,size_grid_y,3); %arreglo para graficar en rgb

%Ingreso de puntos a los arreglos
ocuw(start(1,1),start(2,1),:)=[1 0 0];
ocuw(goal(1,1),goal(2,1),:)=[1 0 0];

%Matriz inicial
camino=zeros(size_grid_x,size_grid_y); %Matriz para mostrar los pasos del camino

%Matriz de ganancia, heurística y estimación
LGHF(1:size_grid_x,1:size_grid_y,1:4)=zeros(size_grid_x,size_grid_y,4); %Matriz para los valores G, H y F


% % % % 
% % % % %% Obstáculos
% % % % % % obstacle=[1,2;1,6;4,3;4,4;4,6;5,3;5,4]'; %Vector de Obstáculos
% % % % % % 
% % % % % % for i=1:size(obstacle,2)
% % % % % %     ocuw(obstacle(1,i),obstacle(2,i),:)=[140/255 140/255 140/255];
% % % % % %     camino(obstacle(1,i),obstacle(2,i))=-3;
% % % % % %     LGHF(obstacle(1,i),obstacle(2,i),:)=-3;
% % % % % % end
% % % % 
% % % % % Obstáculos individuales
% % % % percentage_obs=20;
% % % % [obstacle, obs, ocuw, camino, LGHF]=Obstaculos_individuales_A(size_grid_x,size_grid_y,percentage_obs, start, goal, ocuw, camino, LGHF);
% % % % 
% % % % % Obstáculos 3x3
% % % % % % percentage_obs=25;
% % % % % % [obstacle, obs, ocuw, camino, LGHF]=Obstaculos_3x3_A(size_grid_x,size_grid_y,percentage_obs, start, goal, ocuw, camino, LGHF);
% % % % 
%% Costes

percentage_cost=0;
[additional_cost, LGHF, cost_vector, ocuw]=Cost_A(size_grid_x,size_grid_y,percentage_cost, start, goal, obstacle, ocuw, LGHF);

%% Cargar espacio de trabajo

% 100 x 100
% load('100_20.mat');
% load('100_40.mat');
% load('100_50.mat');

% 200 x 200
% load('200_20.mat');
% load('200_40.mat');
% load('200_50.mat');

% 400 x 400
% load('400_20.mat');
% load('400_40.mat');
% load('400_50.mat');


%% Creación de lista open
open(:,1)=start; %Lista open inicialmente con start

%% Variables para el proceso 
current=start;%punto actual;
closed=[]; %Lista close inicialmente vacía
t=0;

while(size(open,2)~=0) %Hacer mientras la lista open esté llena, no se llegue al goal y no se encuentre encerrado el camino.
    t=t+1;
    tic %Inicio de conteo del tiempo

     [open,current]=removenode_A_Star(open); %Función que realiza el proceso de remover de la lista open y escoger el nuevo punto actual

     [closed]=insertnode_A_Star(closed,current); %%Función que agrega el punto actual a la lista closed

     if(current(1,1)==goal(1,1) && current(2,1)==goal(2,1)) %Se analiza si uno de los vecinos del current corresponde al punto final
         break; %Finaliza la función actual
     end

     [open, closed, LGHF]=expandNode_Astar(current, open, closed, size_grid_y, size_grid_x, obstacle, additional_cost, goal, LGHF); %Función que realiza la expanción del nodo y analiza los vecinos
     
     time(t)=toc; %Finaliza contéo de tiempo

end

T_Total=0;
 
for t=1:size(time,2)
    
    T_Total=T_Total+time(t);
end

%%Pintado de camino
if(goal(1,1)~=0 && goal(2,1)~=0) %Entra si existe un punto final, de lo contrario solo llena las listas 

  [ocuw, camino, i]=Draw_A(closed, goal, ocuw, start, cost_vector, camino); %Función que se encarga de realizar la gráfica del recorrido

end

Datos=[T_Total size(time,2) i 1 (size(open,2)+size(closed,2))];
