function [Node_information, obstacle, ocuw, Step]=Change_Obs_comparation(goal, Node_information, obstacle, ocuw, size_grid_x, size_grid_y, start, Step)
% % % % if(Step==40 || Step==80 || Step==120 || Step==160 || Step==200 || Step==240 || Step==280 || Step==320 || Step==360 || Step==400 || Step==440)
% % % %     Window=3; %Ventana
% % % %     Obs=[];
% % % % 
% % % %     %%Detectar obstáculos en la ventana 
% % % %     
% % % %     for k=-Window:Window %Cambia la coordenada x
% % % %         node.x=start.x+k;
% % % %     
% % % %         for j=-Window:Window %Cambia la coordenada y
% % % %            
% % % %             if(k==0 && j==0)
% % % %                 continue;
% % % %             end
% % % %     
% % % %             node.y=start.y+j;
% % % %     
% % % %             if(node.x<1 || node.x>size_grid_x || node.y<1 || node.y>size_grid_y) %Si el node está afuera
% % % %                 continue;
% % % %             end
% % % %     
% % % %             [~,column]=find(obstacle(1,:)==node.x(1) & obstacle(2,:)==node.y);
% % % %     
% % % %             if(isempty(column)==0)
% % % %     
% % % %                 Obs(:,size(Obs,2)+1)=[node.x;node.y]; %Se agrega ese obstáculo a Obs
% % % %                 obstacle(:,column)=[]; %Lo borra de obstacle
% % % %     
% % % %             end
% % % %         end
% % % %     end
% % % %     
% % % %     i=0;
% % % %     percent_change=randi(8)*10; %Cambio de obtáculos al azar
% % % % 
% % % %     %%CAMBIAR EL 8 POR LOS POSIBLES VECINOS QUE PUEDA TENER (3, 5 U 8) QUE PUEDA EER
% % % % 
% % % %     if(start.x==1)
% % % % 
% % % %         if(start.y==1)
% % % %             Neighbors=3;
% % % %         elseif(start.y==size_grid_y)
% % % %             Neighbors=3;
% % % %         else
% % % %             Neighbors=5;
% % % %         end
% % % % 
% % % %     elseif(start.x==size_grid_x)
% % % % 
% % % %         if(start.y==1)
% % % %             Neighbors=3;
% % % %         elseif(start.y==size_grid_y)
% % % %             Neighbors=3;
% % % %         else
% % % %             Neighbors=5;
% % % %         end
% % % % 
% % % %     elseif(start.y==1 || start.y==size_grid_y)
% % % % 
% % % %         Neighbors=5;
% % % % 
% % % %     else
% % % % 
% % % %         Neighbors=8;
% % % % 
% % % %     end
% % % %     
% % % %     stall_number=round((Neighbors/100)*percent_change); %Número de celdas
% % % %     
% % % %     while(size(Obs,2)~=stall_number)
% % % %     
% % % %         if(size(Obs,2)<stall_number) %Si tamaño de obs es menor al stall_numer
% % % %             Random_cordinate.x=start.x+(randi((Window*2)+1))-(Window+1);
% % % %             Random_cordinate.y=start.y+(randi((Window*2)+1))-(Window+1);
% % % %         
% % % %             if(Random_cordinate.x==start.x && Random_cordinate.y==start.y) %Verificar si es diferente al start
% % % %                 continue
% % % %             end
% % % %             if(Random_cordinate.x==goal.x && Random_cordinate.y==goal.y)
% % % %                 continue
% % % %             end
% % % %             if(Random_cordinate.x<1 || Random_cordinate.x>size_grid_x || Random_cordinate.y<1 || Random_cordinate.y>size_grid_y)
% % % %                 continue
% % % %             end
% % % %             
% % % %                 [~,column]=find(Obs(1,:)==Random_cordinate.x & Obs(2,:)==Random_cordinate.y);
% % % %             
% % % %                 if(isempty(column))
% % % %                     
% % % %                     Option=randi(2); %1 Agregar, 2 reemplazar
% % % %                     if(size(Obs,2)<Neighbors && Option==1) %Agregar si el tamaño es menor a los vecion posibles
% % % %                         i=i+1;
% % % %                         Obs(:,size(Obs,2)+1)=[Random_cordinate.x;Random_cordinate.y];
% % % %                     else
% % % %                         i=i+1;
% % % %                         random_position=randi(size(Obs,2));
% % % %                         Obs(:,random_position)=[Random_cordinate.x;Random_cordinate.y];
% % % %                     end
% % % %         
% % % %                 end
% % % %         else
% % % %             random_position=randi(size(Obs,2));
% % % %             Obs(:,random_position)=[];
% % % %         end
% % % %     
% % % %     
% % % %     end
% % % %         
    %Vacia node_information en la columna de obs
    for k=1:length(Node_information)
        Node_information(k).obs=[];
    end
      
% % % %     obstacle=[obstacle Obs];

    if(Step==50)

        load('change_1.mat');

    elseif(Step==100)

        load('change_2.mat');

    elseif(Step==150)

        load('change_3.mat');

    elseif(Step==8000)

        load('change_4.mat');

    elseif(Step==1000)

        load('change_5.mat');

    elseif(Step==1200)

        load('change_6.mat');

    elseif(Step==1400)

        load('change_7.mat');

    elseif(Step==1600)

        load('change_8.mat');

    elseif(Step==320)

        load('change_9.mat');

    elseif(Step==360)

        load('change_10.mat');

    elseif(Step==400)

        load('change_11.mat');
  
    end



end

% % % % % if(Step==1)
% % % % %     obstacle=[1,6;3,6;4,3;4,5;5,4;5,8;6,1;6,3;1,3;3,3;3,2;1,2;2,3]';
% % % % % end
% % % % % 
% % % % % if(Step==4)
% % % % %     obstacle=[1,2;1,3;1,6;2,3;3,2;3,3;3,6;4,3;4,5;5,4;5,5;5,8;6,1;6,3;6,4]';
% % % % % end


% end