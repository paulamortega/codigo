function [closed, New_start, Node_information, ocuw, open, time, Way]=Replaning_Comparation(closed, goal, Node_information, obstacle_1, ocuw, ocuw_Obs, open, Path, size_grid_x, size_grid_y, start)

ocuw(1:size_grid_x,1:size_grid_y,1:3)=ones(size_grid_x,size_grid_y,3); %Se Vacia el arreglo ocuw
ocuw_Obs(1:size_grid_x,1:size_grid_y,1:3)=ones(size_grid_x,size_grid_y,3); %Se Vacia el arreglo ocuw

%Ingreso de obstáculos a los arreglos
for t=1:size(obstacle_1,2) %  Length calcula las columnas del vector Obs
    %Se crea un nodo con las coordenadas del obstáculo
    node.x=obstacle_1(1,t);
    node.y=obstacle_1(2,t);
    [Id]=Calc_Id(node, size_grid_y); %Calcula el Id del obstáculo
    Node_information(Id).obs=1; %Se asigna un 1 a los obstáculos en Node_information
    ocuw(obstacle_1(1,t),obstacle_1(2,t),:)=[140/255 140/255 140/255]; %Agrega los obstáculos en ocuw.
    ocuw_Obs(obstacle_1(1,t),obstacle_1(2,t),:)=[140/255 140/255 140/255]; %Agrega los obstáculos en ocuw.
end


for i=1:length(Node_information)
    
    node.x=Node_information(i).x;
    node.y=Node_information(i).y;
    [Id]=Calc_Id(node, size_grid_y);

    Node_information(Id).state=0;

end

ocuw_Obs(goal.x,goal.y,:)=[255/255 0/255 0/255];
ocuw_Obs(start.x,start.y,:)=[0/255 0/255 255/255];

figure(1)
imshow(ocuw_Obs,'InitialMagnification','fit');

[Id]=Calc_Id(start, size_grid_y); %Calcula el Id del nuevo punto start
%Se asignan los datos correspondientes de este nuevo punto inicial

start.x=Node_information(Id).x;
start.y=Node_information(Id).y;
start.g=inf; %Siempre inicia la ganancia g como infinito
start.rhs=Node_information(Id).rhs;
start.h=Node_information(Id).h;
start.key=Node_information(Id).key;
start.pred=Node_information(Id).pred;


for i=1:length(Node_information)
    
    if(isempty(Node_information(i).key)==0) %Si la llave no está vacía       
            
            if(Node_information(i).key(1)~=inf && isempty(Node_information(i).obs)==0) %Pasó de libre a obstáculo

                %% Eliminar nodo de open o closed y colocar valores de inf en Node_information

                %%Buscar sus hijos y resetearlos

                node.x=Node_information(i).x;
                node.y=Node_information(i).y;
                node.g=Node_information(i).g;
                node.rhs=Node_information(i).rhs;
                node.h=Node_information(i).h;
                node.key=Node_information(i).key;
                node.pred=Node_information(i).pred;

                [closed, Node_information, open]=RemoveChildren(closed, node, Node_information, open, size_grid_y);

                %%Eliminar current de las listas
                [column_O, isintheopen]=findinthelist(open, node); %Busca en open 
                    
                if(isintheopen==true)
                    open(column_O)=[]; %Remover de open
                else
                    [column_C, isintheclosed]=findinthelist(closed, node); %Busca en closed el xnext

                    if(isintheclosed==true)
                        closed(column_C)=[]; %Remover de closed
                    end
            
                end

                Node_information(i).g=inf;
                Node_information(i).rhs=inf;
                Node_information(i).key(1)=inf;
                Node_information(i).key(2)=inf;

            end
    end
end



[column, ~]=findinthelist(closed, start); %Busca start en closed

closed(column)=[]; %eliminar start de closed

[open]=start; %open inicia con start

%% Se calcula la ruta con los nuevos datos de las listas para corregir los valores de cada casilla que necesite
tic;
[closed, Node_information, open]=ComputeOptimalPath(closed, goal, Node_information, obstacle_1, open, size_grid_x, size_grid_y, start);
time=toc;

%% Se escoge nuevamente el camino 
[New_start, ocuw, Way]=Draw_D_Star(closed, goal, ocuw, start);

end