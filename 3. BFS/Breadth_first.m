%Breadth first

close all;
clear all;
clc;

tic %Inicio de conteo del tiempo

%Tamaño del espacio de trabajo
size_grid_x=5;
size_grid_y=3;

%Nodo de inicio
start(1,1)=5; %Coordenada x
start(2,1)=1; %Coordenada y
start(3,1)=inf; %Coordenada x del padre
start(4,1)=inf; %Coordenada y del padre
start(5,1)=0; %Nivel de nodo de inicio

%Nodo final
goal(1,1)=2; %Coordenada x
goal(2,1)=1; %Coordenada y
goal(3,1)=inf; %Coordenada x del padre
goal(4,1)=inf; %Coordenada y del padre

% Obstáculos
obstacle=[3,1;3,2;2,3;2,2]'; %Vector de Obstáculos

%Creación del arreglo tridimencional
ocuw(1:size_grid_x,1:size_grid_y,1:3)=ones(size_grid_x,size_grid_y,3); %arreglo para graficar en rgb

%Matriz de niveles y matriz de camino
camino=zeros(size_grid_x,size_grid_y);
level=zeros(size_grid_x,size_grid_y);

%Ingreso de puntos a ocuw
ocuw(start(1,1),start(2,1),:)=[1 0 0];

if(goal(1,1)~=0 && goal(2,1)~=0) %Si existe punto final
ocuw(goal(1,1),goal(2,1),:)=[1 0 0];
end
%Ingreso de obstáculos a los arreglos
size_obstacle=size(obstacle); %Tamaño del vector de obstáculos
for t=1:size(obstacle,2) %  Length calcula las columnas del vector Obs
    level(obstacle(1,t),obstacle(2,t))=-3; %Llena los obstáculos en level.
    camino(obstacle(1,t),obstacle(2,t))=-3; %Llena los obstáculos en camino.
    ocuw(obstacle(1,t),obstacle(2,t),:)=[140/255 140/255 140/255]; %Pinta los obstáculos en ocuw.
end

%% Creación de lista open 
open(:,1)=start; %Lista open inicialmente con start

%% Variables para el proceso 
current=start;%punto actual;
a=1; %Cantidad de pasos
success=0; %Variable para finalizar el ciclo de proceso
closed=[]; %Lista close inicialmente vacía

%%

while(size(open,2)~=0 && success==0) %Hacer mientras la lista open esté llena, no se llegue al goal y no se encuentre encerrado el camino.

     [open,current,level]=removenode_BFS(open,level); %Función que realiza el proceso de remover de la lista open y escoger el nuevo punto actual

     [closed]=insertnode_BFS(closed,current); %%Función que agrega el punto actual a la lista closed

     [open, closed, success, goal, level]=spandNodeST_BFS(current, open, closed, goal, success, size_grid_y, size_grid_x, obstacle, level); %Función que realiza la expanción del nodo y analiza los vecinos
     
end

toc

%%Pintado de camino
if(goal(1,1)~=0 && goal(2,1)~=0) %Entra si existe un punto final, de lo contrario solo llena las listas 

  [ocuw, camino]=Draw_BFS(closed, goal, ocuw, start, camino); %Función que se encarga de realizar la gráfica del recorrido

end
