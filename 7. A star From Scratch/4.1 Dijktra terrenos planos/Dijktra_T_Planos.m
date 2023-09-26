%Dijktra Terrenos Planos

close all;
clear all;
clc;

tic %Inicio de conteo del tiempo

%Tamaño del espacio de trabajo
size_grid_x=10;
size_grid_y=6;

%Nodo de inicio
start(1,1)=10; %Coordenada x
start(2,1)=1; %Coordenada y
start(3,1)=inf; %Coordenada x del padre
start(4,1)=inf; %Coordenada y del padre
start(5,1)=0; %Coste de nodo inicial

%Nodo final
goal(1,1)=4; %Coordenada x
goal(2,1)=4; %Coordenada y
goal(3,1)=inf; %Coordenada x del padre
goal(4,1)=inf; %Coordenada y del padre

% Obstáculos
obstacle=[2,3;2,4;2,5;3,5;4,5;5,2;5,3;5,4;5,5;6,5;7,5;8,5;9,5;2,2]'; %Vector de Obstáculos

%Creación del arreglo tridimencional
ocuw(1:size_grid_x,1:size_grid_y,1:3)=ones(size_grid_x,size_grid_y,3); %arreglo para graficar en rgb

%Matriz inicial
camino=zeros(size_grid_x,size_grid_y); %Matriz para mostrar los pasos del camino
Gain=zeros(size_grid_x,size_grid_y); %Matriz de ganancias

%Ingreso de puntos a los arreglos
ocuw(start(1,1),start(2,1),:)=[1 0 0];

%Ingreso de obstáculos a los arreglos
for t=1:size(obstacle,2) 
    camino(obstacle(1,t),obstacle(2,t))=-3; %Llena los obstáculos en camino.
    Gain(obstacle(1,t),obstacle(2,t))=-3; %Llena los obstáculos en Gain.
    ocuw(obstacle(1,t),obstacle(2,t),:)=[140/255 140/255 140/255]; %Pinta los obstáculos en ocuw.
end

%% Creación de lista open 
open(:,1)=start; %Lista open inicialmente con start

%%

%Variables para el proceso 
current=start;%punto actual;
closed=[]; %Lista close inicialmente vacía

while(size(open,2)~=0) %Hacer mientras la lista open esté llena, no se llegue al goal y no se encuentre encerrado el camino.

     [open,current]=removenode_Dijktra(open); %Función que realiza el proceso de remover de la lista open y escoger el nuevo punto actual

     [closed]=insertnode_Dijktra(closed,current); %%Función que agrega el punto actual a la lista closed

     if(current(1,1)==goal(1,1) && current(2,1)==goal(2,1)) %Se analiza si uno de los vecinos del current corresponde al punto final
         break; %Finaliza la función actual
     end

     [open, closed, Gain]=spandNode_Dijktra_T_Planos(current, open, closed, size_grid_y, size_grid_x, obstacle, Gain); %Función que realiza la expanción del nodo y analiza los vecinos
     
end

toc %Finaliza contéo de tiempo

%% Pintado de camino
if(goal(1,1)~=0 && goal(2,1)~=0) %Entra si existe un punto final, de lo contrario solo llena las listas 

  [ocuw, camino]=Draw_Dijktra_T_Planos(closed, goal, ocuw, start, camino); %Función que se encarga de realizar la gráfica del recorrido

end