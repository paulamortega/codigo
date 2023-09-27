%D Star comparation  

close all;
clear all;
clc;

%Tamaño del espacio de trabajo

% size_grid_x=6;
% size_grid_y=8;

size_grid_x=100;
size_grid_y=100;

%% Creación de la estructura
node.x=[];
node.y=[];
node.g=inf;
node.rhs=inf;
node.h=[];
node.key=[];
node.pred=[];
node.state=0;
Node_information=node;

%Nodo final
goal.x=100;
goal.y=100;
[Id]=Calc_Id(goal, size_grid_y);
goal.g=inf;
Node_information(Id).g=inf;
goal.rhs=inf;
Node_information(Id).rhs=inf;
goal.h=0;
Node_information(Id).h=0;
goal.key=calcKey(goal);
Node_information(Id).key=goal.key;

% Se llenan los datos de las coordenadas en los lugares del arreglo
for y=1:size_grid_y
    for x=1:size_grid_x
        node.x=x;
        node.y=y;
        [Id]=Calc_Id(node, size_grid_y); %Función para calcular el Id correspondiente
        Node_information(Id).x=x;
        Node_information(Id).y=y;
        Node_information(Id).g=inf;
        Node_information(Id).rhs=inf;
        Node_information(Id).state=0;

        Node_information(Id).h=(abs(node.y-goal.y)+abs(node.x-goal.x))*10; %Se calcula la heurística del
    end
end

% % % %Nodo final
% % % goal.x=100;
% % % goal.y=100;
% % % [Id]=Calc_Id(goal, size_grid_y);
% % % goal.g=inf;
% % % Node_information(Id).g=inf;
% % % goal.rhs=inf;
% % % Node_information(Id).rhs=inf;
% % % goal.h=0;
% % % Node_information(Id).h=0;
% % % goal.key=calcKey(goal);
% % % Node_information(Id).key=goal.key;

%Nodo de inicio
start.x=1;
start.y=1;
[Id]=Calc_Id(start, size_grid_y);
start.g=inf;
Node_information(Id).g=inf;
start.rhs=0;
Node_information(Id).rhs=0;
start.h=(abs(start.y-goal.y)+abs(start.x-goal.x))*10; %Heuristica del nodo inicial
Node_information(Id).h=start.h;
start.key=calcKey(start);
Node_information(Id).key=start.key;
start.pred=[];

%Creación del arreglo tridimencional
ocuw(1:size_grid_x,1:size_grid_y,1:3)=ones(size_grid_x,size_grid_y,3); %arreglo para graficar en rgb

%Ingreso de puntos a los arreglos
ocuw(start.x,start.y,:)=[1 0 0];
ocuw(goal.x,goal.y,:)=[1 0 0];

%% Obstáculos iniciales

% percentage_obs=60;
% [obstacle_1, obs, ocuw]=Obstaculos_D(goal, percentage_obs, ocuw, size_grid_x, size_grid_y, start);
% 
% save('obstacle','obstacle_1')

load('obstacle.mat');

% obstacle_1=[1,3;1,6;3,1;3,6;4,3;4,5;5,4;5,8;6,1;6,3]'; %Vector de Obstáculos

closed=[]; %Lista close inicialmente vacía

open=start; %Lista open inicia con start 

%Ingreso de obstáculos a los arreglos
for t=1:size(obstacle_1,2) %  Length calcula las columnas del vector Obs
    node.x=obstacle_1(1,t);
    node.y=obstacle_1(2,t);
    [Id]=Calc_Id(node, size_grid_y);
    Node_information(Id).obs=1; %Se coloca el valor de 1 a las posiciones que son obstáculos
    ocuw(obstacle_1(1,t),obstacle_1(2,t),:)=[140/255 140/255 140/255]; %Agrega los obstáculos en ocuw.
end

% imshow(ocuw,'InitialMagnification','fit')
% hold on

ocuw_Obs=ocuw;
figure(1)
imshow(ocuw_Obs,'InitialMagnification','fit')
hold on;

% figure(2)


%% ComputeOptimalPath

tic

[closed, Node_information, open]=ComputeOptimalPath(closed, goal, Node_information, obstacle_1, open, size_grid_x, size_grid_y, start); %Función que calcula la ruta óptima.

Time1=toc;

Times(1)=Time1;

%% Fin seudocódigo

[New_start, ocuw, Way]=Draw_D_Star(closed, goal, ocuw, start); %Función para llenar Way y elegir el nuevo punto inicial

ocuw(start.x,start.y,:)=[0/255 0/255 255/255]; %Se agrega el punto estart de color azul para identificar el camino

figure(2)
imshow(ocuw,'InitialMagnification','fit')

%% Se crea la estructura Path en la cual se guardan todos los pasos de la trayectoria
Path(1).x=start.x;
Path(1).y=start.y;
Path(2)=New_start;

Step=0; %Variable para cambiar los grupos de obstáculos

%% Replanning

while(true)
Step=Step+1; 

    [Node_information, obstacle_2, ocuw, Step]=Change_Obs_comparation(goal, Node_information, obstacle_1, ocuw, size_grid_x, size_grid_y, New_start, Step);

    if(length(obstacle_1)~=length(obstacle_2)) %Si hay mayor o menor número de obstáculos

        obstacle_1=obstacle_2; %Se toman los nuevos obstáculos como los actuales

        [closed, New_start, Node_information, ocuw, open, time, Way]=Replaning_Comparation(closed, goal, Node_information, obstacle_1, ocuw, ocuw_Obs, open, Path, size_grid_x, size_grid_y, New_start); %Función para hacer el Replaning
        
        Times(length(Times)+1)=(time);

        for i=1:length(Path) %Se ubica todos los elementos de Path en ocuw con el color azul
            ocuw(Path(i).x,Path(i).y,:)=[0/255 0/255 255/255];
        end

        pause(0.2);
        figure(2)
        imshow(ocuw,'InitialMagnification','fit');


        Path(length(Path)+1)=New_start; %Se agrega el nuevo start a la estructura Path

        if(Path(end).x==goal.x && Path(end).y==goal.y) %Si ya se llegó al final no hay que Replanificar más
            ocuw(Path(end).x,Path(end).y,:)=[0/255 0/255 255/255];
            pause(0.02);
            figure(2)
            imshow(ocuw,'InitialMagnification','fit');
            break %Termina el ciclo while del Replaning
        end

    else
        if(obstacle_1~=obstacle_2) %Se verifica si Hubo cambio en los obstáculos

           obstacle_1=obstacle_2; %Se toman los nuevos obstáculos como los actuales

           [closed, New_start, Node_information, ocuw, open, time, Way]=Replaning_Comparation(closed, goal, Node_information, obstacle_1, ocuw, ocuw_Obs, open, Path, size_grid_x, size_grid_y, New_start); %Función para hacer el Replaning
        
           Times(Step+1)=(time);

           pause(0.02);
           figure(2)
           imshow(ocuw,'InitialMagnification','fit');

           Path(length(Path)+1)=New_start; %Se agrega el nuevo start a la estructura Path

           if(Path(end).x==goal.x && Path(end).y==goal.y) %Si ya se llegó al final no hay que Replanificar más
               ocuw(Path(end).x,Path(end).y,:)=[0/255 0/255 255/255];
               pause(0.02);
               figure(2)
               imshow(ocuw,'InitialMagnification','fit');
               break %Termina el ciclo while del Replaning
           end

        else
            
            [column, isintheWay]=findinthelist(Way, New_start); %Función para buscar el New_start en la estructura Way

            if(length(Way)~=1) %Si el tamaño de way es diferente a 1
                if(column-1>0) %Si existe posición anterior
                    New_start.x=Way(column-1).x;   
                    New_start.y=Way(column-1).y;
                else
                    New_start.x=Way(column).x;   
                    New_start.y=Way(column).y;
                end
            else
                New_start.x=Way(1).x;    
                New_start.y=Way(1).y;
            end
    
            for i=1:length(Path) %Se ubica todos los elementos de Path en ocuw con el color azul
                ocuw(Path(i).x,Path(i).y,:)=[0/255 0/255 255/255];
            end
            pause(0.02);
            figure(2)
            imshow(ocuw,'InitialMagnification','fit');

            Path(length(Path)+1)=New_start; %Se agrega el nuevo start a la estructura Path

            if(Path(end).x==goal.x && Path(end).y==goal.y) %Si ya se llegó al final no hay que Replanificar más
               ocuw(Path(end).x,Path(end).y,:)=[0/255 0/255 255/255];
               pause(0.2);
               figure(2)
               imshow(ocuw,'InitialMagnification','fit');
               break %Termina el ciclo while del Replaning
            end

        end
    end

end

FullTime=toc;

count_expand=0;
for k=1:length(Node_information)

    if(isempty(Node_information(k).key)==0)
        count_expand=count_expand+1;
    end

end

count_pred=0;

for k=1:length(Node_information)

    if(isempty(Node_information(k).pred)~=0)
        count_pred=count_expand+1;  %Celdas expandidas
    end

end

TIME=0;
for k=1:length(Times)

    TIME=TIME+Times(k);

end

node.x=goal.x;
node.y=goal.y;
[Id]=Calc_Id(node, size_grid_y);

velocidad=1; %1 metro sobre segundo
TiempoR=Node_information(Id).g/velocidad;

Datos=[TIME count_expand TiempoR];


