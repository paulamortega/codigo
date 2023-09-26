%Spanning tree nuevo

close all;
clear all;
clc;

tic %Inicio de conteo del tiempo

%Tamaño del espacio de trabajo
size_grid_x=5;
size_grid_y=5;

%Nodo de inicio
start(1,1)=5; %Coordenada x
start(2,1)=1; %Coordenada y
start(3,1)=inf; %Coordenada x del padre
start(4,1)=inf; %Coordenada y del padre

%Nodo final
goal(1,1)=2; %Coordenada x
goal(2,1)=1; %Coordenada y
goal(3,1)=inf; %Coordenada x del padre
goal(4,1)=inf; %Coordenada y del padre

% Obstáculos
obstacle=[3,1;3,2;2,2;2,3]'; %Vector de Obstáculos

%Creación del arreglo tridimencional
ocuw(1:size_grid_y,1:size_grid_x,1:3)=zeros(size_grid_y,size_grid_x,3); %arreglo para graficar en rgb

%Matriz inicial
camino=zeros(size_grid_y,size_grid_x);%matrìz para mostrar cada paso

%Ingreso de puntos a los arreglos
camino(start(1,1),start(2,1))=1;
ocuw(start(1,1),start(2,1),:)=[1 0 0];
ocuw(goal(1,1),goal(2,1),:)=[1 0 0];

%Ingreso de obstáculos a los arreglos
% % size_obstacle=size(obstacle); %Tamaño del vector de obstáculos
for t=1:size(obstacle,2) %Ciclo que comienza en 1 y termina en la cantidad de columnas que tenga obstacle
    camino(obstacle(1,t),obstacle(2,t))=-3; %Llena los obstáculos en camino.
    ocuw(obstacle(1,t),obstacle(2,t),:)=[140/255 140/255 140/255]; %Pinta los obstáculos en ocuw.
end

%% Creación de lista open
open(:,1)=start; %Lista open inicialmente con start 

%% Variables para el proceso 
current=start;%punto actual;
a=1; %Cantidad de pasos
success=0; %Variable para finalizar el ciclo de proceso
locked=0; %Variable para caso de encierro
closed=[]; %Lista close inicialmente vacía

%%

while(size(open,2)~=0 && success==0 && locked==0) %Hacer mientras la lista open esté llena, no se llegue al goal y no se encuentre encerrado el camino.

     [open,current,camino,a,ocuw,locked]=removenode(open,camino,current,a,ocuw); %Función que realiza el proceso de remover de la lista open y escoger el nuevo punto actual

     [closed]=insertnode(closed,current); %%Función que agrega el punto actual a la lista closed

     [open, closed, success, goal]=spandNodeST(current, open, closed, goal, success, size_grid_y, size_grid_x, obstacle); %Función que realiza la expanción del nodo y analiza los vecinos
     

end
toc 

