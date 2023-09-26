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

%Nodo de inicio
start(1,1)=1; %Coordenada x
start(2,1)=1; %Coordenada y
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

LGHF=zeros(size_grid_x,size_grid_y,3);
camino=zeros(size_grid_x,size_grid_y);

load('obstacle.mat');
obstacle=obstacle_1;

for i=1:size(obstacle,2)
    ocuw(obstacle(1,i),obstacle(2,i),:)=[140/255 140/255 140/255];
    camino(obstacle(1,i),obstacle(2,i))=-3;
    LGHF(obstacle(1,i),obstacle(2,i),:)=-3;
end

percentage_cost=0;
[additional_cost, LGHF, cost_vector, ocuw]=Cost_A(size_grid_x,size_grid_y,percentage_cost, start, goal, obstacle, ocuw, LGHF);
Step=1;
colum=0;

while(true)

    [closed, ocuw, open, T_Total, Way]=A_star_funct(additional_cost, camino, goal, LGHF, obstacle, ocuw, size_grid_x, size_grid_y, start);
%     TIME(1)=T_Total;
    
    for i=Step:length(Way)
    
        ocuw(Way(1,i),Way(2,i),:)=[0/255 0/255 200/255];
    
        if(Step==50 || Step==100 || Step==150)
            colum=colum+1;
            TIME(colum)=T_Total;

            [~, columna]=find(closed(1,:)==Way(1,i) & closed(2,:)==Way(2,i)); %Busca en open el xnext

            g=closed(6,columna);
            count_expand=length(open)+length(closed);

            break; 
        elseif(i==length(Way))
            colum=3;
            TIME(colum)=T_Total;

            [~, columna]=find(closed(1,:)==Way(1,i) & closed(2,:)==Way(2,i)); %Busca en open el xnext

            g=closed(6,columna);
            count_expand=length(open)+length(closed);

        end
    
        Step=Step+1;

    end

    gain(colum)=g;
    Expand(colum)=count_expand;

    figure()
    imshow(ocuw,'InitialMagnification','fit');
    pause(0.5);

    Step=1;

%     start(1,1)=1; %Coordenada x
%     start(2,1)=1; %Coordenada y

    obstacle=0;
    if(colum==1)
        load('change_1.mat');
        obstacle=obstacle_1;
        start(1,1)=47; %Coordenada x
        start(2,1)=51; %Coordenada y
    
    elseif(colum==2)
        load('change_2.mat');
        obstacle=obstacle_1;
        start(1,1)=93; %Coordenada x
        start(2,1)=99; %Coordenada y
    
    elseif(colum==39)
        load('change_3.mat');
        obstacle=obstacle_1;
        start(1,1)=47; %Coordenada x
        start(2,1)=54; %Coordenada y
    
    elseif(colum==4)
        load('change_4.mat');
        obstacle=obstacle_1;
        start(1,1)=65; %Coordenada x
        start(2,1)=74; %Coordenada y
    
    elseif(colum==5)
        load('change_5.mat');
        obstacle=obstacle_1;
        start(1,1)=77; %Coordenada x
        start(2,1)=92; %Coordenada y
    
    elseif(colum==6)
        load('change_6.mat');
        obstacle=obstacle_1;
        start(1,1)=97; %Coordenada x
        start(2,1)=100; %Coordenada y
    end

    ocuw(1:size_grid_x,1:size_grid_y,1:3)=ones(size_grid_x,size_grid_y,3);
    ocuw(start(1,1),start(2,1),:)=[1 0 0];
    ocuw(goal(1,1),goal(2,1),:)=[1 0 0];

    
% % %     for i=1:size(obstacle,2)
% % %         ocuw(obstacle(1,i),obstacle(2,i),:)=[140/255 140/255 140/255];
% % % %         camino(obstacle(1,i),obstacle(2,i))=-3;
% % % %         LGHF(obstacle(1,i),obstacle(2,i),:)=-3;
% % %     end

    if(colum==3)
        break
    else
        for i=1:size(obstacle,2)
        ocuw(obstacle(1,i),obstacle(2,i),:)=[140/255 140/255 140/255];
%         camino(obstacle(1,i),obstacle(2,i))=-3;
%         LGHF(obstacle(1,i),obstacle(2,i),:)=-3;
        end
    end

end

Tiempo=0;
for k=1:length(TIME)

    Tiempo=Tiempo+TIME(k);

end

count_expand=0;
for k=1:length(Expand)

    count_expand=count_expand+Expand(k);

end

total_gain=0;
for k=1:length(gain)

    total_gain=total_gain+gain(k);

end



DatosA=[Tiempo count_expand total_gain];









