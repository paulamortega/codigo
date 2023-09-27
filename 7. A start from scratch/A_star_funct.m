%%Función A star
function [closed, ocuw, open, T_Total, Way]=A_star_funct(additional_cost, camino, goal, LGHF, obstacle, ocuw, size_grid_x, size_grid_y, start)
%% Creación de lista open



open(:,1)=start; %Lista open inicialmente con start

%% Variables para el proceso 
current=start;%punto actual;
closed=[]; %Lista close inicialmente vacía
% % additional_cost=[];
% % LGHF=zeros(size_grid_x,size_grid_y,3);
% % camino=zeros(size_grid_x,size_grid_y);
t=0;

tic %Inicio de conteo del tiempo

while(size(open,2)~=0) %Hacer mientras la lista open esté llena, no se llegue al goal y no se encuentre encerrado el camino.
    t=t+1;
    

     [open,current]=removenode_A_Star(open); %Función que realiza el proceso de remover de la lista open y escoger el nuevo punto actual

     [closed]=insertnode_A_Star(closed,current); %%Función que agrega el punto actual a la lista closed

     if(current(1,1)==goal(1,1) && current(2,1)==goal(2,1)) %Se analiza si uno de los vecinos del current corresponde al punto final
         break; %Finaliza la función actual
     end

     [open, closed, LGHF]=expandNode_Astar(current, open, closed, size_grid_y, size_grid_x, obstacle, additional_cost, goal, LGHF); %Función que realiza la expanción del nodo y analiza los vecinos
     


end

T_Total=toc; %Finaliza contéo de tiempo

%%Pintado de camino
if(goal(1,1)~=0 && goal(2,1)~=0) %Entra si existe un punto final, de lo contrario solo llena las listas 

%   [ocuw, camino, i]=Draw_A(closed, goal, ocuw, start, cost_vector, camino); %Función que se encarga de realizar la gráfica del recorrido
  [ocuw, camino, i, Way]=Draw_A_compar(closed, goal, ocuw, start, camino);

end

% Datos=[T_Total size(time,2) i 1 (size(open,2)+size(closed,2))];

end