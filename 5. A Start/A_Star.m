%A Start Terrenos No Planos

close all;
clear all;
clc;

tic %Inicio de conteo del tiempo

%Tamaño del espacio de trabajo
size_grid_x=6;
size_grid_y=6;

%Nodo final
goal(1,1)=1; %Coordenada x
goal(2,1)=6; %Coordenada y
goal(3,1)=inf; %Coordenada x del padre
goal(4,1)=inf; %Coordenada y del padre

%Nodo de inicio
start(1,1)=6; %Coordenada x
start(2,1)=1; %Coordenada y
start(3,1)=inf; %Coordenada x del padre
start(4,1)=inf; %Coordenada y del padre
start(5,1)=0; %Coste de nodo inicial
start(6,1)=(abs(start(2)-goal(2))+abs(start(1)-goal(1)))*10; %Estimación (F) del nodo inicial

% Obstáculos
obstacle=[2,5;2,6]'; %Vector de Obstáculos

% Costes
Cost=[6,6,40]'; %Vector de costes

%Creación del arreglo tridimencional
ocuw(1:size_grid_x,1:size_grid_y,1:3)=ones(size_grid_x,size_grid_y,3); %arreglo para graficar en rgb

%Matrices iniciales
camino=zeros(size_grid_x,size_grid_y); %Matriz de camino
GHF(1:size_grid_x,1:size_grid_y,1:3)=zeros(size_grid_x,size_grid_y,3); %Matriz para los valores G, H y F

%Ingreso de puntos a los arreglos
ocuw(start(1,1),start(2,1),:)=[1 0 0];

%Ingreso de obstáculos a los arreglos
for t=1:size(obstacle,2) %  Length calcula las columnas del vector Obs
    camino(obstacle(1,t),obstacle(2,t))=-3; %Llena los obstáculos en camino.
    GHF(obstacle(1,t),obstacle(2,t),:)=[-3 -3 -3];
    ocuw(obstacle(1,t),obstacle(2,t),:)=[140/255 140/255 140/255]; %Pinta los obstáculos en ocuw.
end

%Ingreso de costes a los arreglos
for t=1:size(Cost,2) %  Length calcula las columnas del vector Obs
    GHF(Cost(1,t),Cost(2,t),1)=Cost(3,t); %Llena los obstáculos en la primera matriz de GHF.
    ocuw(Cost(1,t),Cost(2,t),:)=[0/255 0/255 255/255]; %Pinta los obstáculos en ocuw.
end

%% Creación de lista open
open(:,1)=start; %Lista open inicialmente con start

%% Variables para el proceso 
current=start;%punto actual;
closed=[]; %Lista close inicialmente vacía

%%

while(size(open,2)~=0) %Hacer mientras la lista open esté llena, no se llegue al goal y no se encuentre encerrado el camino.

     [open,current]=removenode_A_Star(open); %Función que realiza el proceso de remover de la lista open y escoger el nuevo punto actual

     [closed]=insertnode_A_Star(closed,current); %%Función que agrega el punto actual a la lista closed

     if(current(1,1)==goal(1,1) && current(2,1)==goal(2,1)) %Se analiza si uno de los vecinos del current corresponde al punto final
         break; %Finaliza la función actual
     end

     [open, closed, GHF]=expandNode_A_Star(current, open, closed, size_grid_y, size_grid_x, obstacle, Cost, goal, GHF); %Función que realiza la expanción del nodo y analiza los vecinos
     
end

toc %Finaliza contéo de tiempo

%%Pintado de camino
if(goal(1,1)~=0 && goal(2,1)~=0) %Entra si existe un punto final, de lo contrario solo llena las listas 

  [ocuw, camino]=Draw_A_Star(closed, goal, ocuw, start, Cost, camino); %Función que se encarga de realizar la gráfica del recorrido

end