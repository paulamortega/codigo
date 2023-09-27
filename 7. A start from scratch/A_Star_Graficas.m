%A Star

close all;
clear all;
clc;

%% Espacio de trabajo 

Datos=zeros(9,5);

for j=1:9

%% Cargar espacio de trabajo

if(j==1)
    load('100_20.mat');
else
    if(j==2)
        load('100_40.mat');
    else
        if(j==3)
            load('100_50.mat');
        else
            if(j==4)
                load('200_20.mat');
            else
                if(j==5)
                    load('200_40.mat');
                else
                    if(j==6)
                        load('200_50.mat');
                    else
                        if(j==7)
                            load('400_20.mat');
                        else
                            if(j==8)
                                load('400_40.mat');
                            else
                                load('400_50.mat');
                            end
                        end
                    end
                end
            end
        end
    end
end

%% Creación de lista open
open=[];
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

  [ocuw, camino, i]=Draw_A(closed, goal, ocuw, start, cost_vector, camino, j); %Función que se encarga de realizar la gráfica del recorrido

end

Datos(j,:)=[T_Total size(time,2) i 1 (size(open,2)+size(closed,2))];
end

% % % % % porcentaje=[20 40 50]';
% % % % % 
% % % % % figure()
% % % % % h=plot(porcentaje,[Datos(1:3,1),Datos(4:6,1),Datos(7:9,1)]);
% % % % % h(1).Color='y';
% % % % % h(2).Color='b';
% % % % % h(3).Color='r';
% % % % % h(1).LineWidth=2;
% % % % % h(2).LineWidth=2;
% % % % % h(3).LineWidth=2;
% % % % % title('Tiempo vs Porcentaje de Obstáculos');
% % % % % grid on;
% % % % % xlabel('Porcentaje de Obstáculos');
% % % % % ylabel('Tiempo Total');
% % % % % legend('100','200','400');
% % % % % 
% % % % % figure()
% % % % % h=plot(porcentaje,[Datos(1:3,2),Datos(4:6,2),Datos(7:9,2)]);
% % % % % h(1).Color='y';
% % % % % h(2).Color='b';
% % % % % h(3).Color='r';
% % % % % h(1).LineWidth=2;
% % % % % h(2).LineWidth=2;
% % % % % h(3).LineWidth=2;
% % % % % title('Número de Iteraciones vs Porcentaje de Obstáculos');
% % % % % grid on;
% % % % % xlabel('Porcentaje de Obstáculos');
% % % % % ylabel('Número de Iteraciones');
% % % % % legend('100','200','400');
% % % % % 
% % % % % figure()
% % % % % h=plot(porcentaje,[Datos(1:3,3),Datos(4:6,3),Datos(7:9,3)]);
% % % % % h(1).Color='y';
% % % % % h(2).Color='b';
% % % % % h(3).Color='r';
% % % % % h(1).LineWidth=2;
% % % % % h(2).LineWidth=2;
% % % % % h(3).LineWidth=2;
% % % % % title('Número de celdas de la trayectoria vs Porcentaje de Obstáculos');
% % % % % grid on;
% % % % % xlabel('Porcentaje de Obstáculos');
% % % % % ylabel('Número de celdas de la trayectoria');
% % % % % legend('100','200','400');
% % % % % 
% % % % % figure()
% % % % % h=plot(porcentaje,[Datos(1:3,5),Datos(4:6,5),Datos(7:9,5)]);
% % % % % h(1).Color='y';
% % % % % h(2).Color='b';
% % % % % h(3).Color='r';
% % % % % h(1).LineWidth=2;
% % % % % h(2).LineWidth=2;
% % % % % h(3).LineWidth=2;
% % % % % title('Número de celdas expandidas vs Porcentaje de Obstáculos');
% % % % % grid on;
% % % % % xlabel('Porcentaje de Obstáculos');
% % % % % ylabel('Número de celdas expandidas');
% % % % % legend('100','200','400');
