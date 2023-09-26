function [Node_information, obstacle, ocuw, Step]=Change_Obs(goal, Node_information, obstacle, ocuw, size_grid_x, size_grid_y, start, Step)
if(Step==50 || Step==100 || Step==150 || Step==280 || Step==320 || Step==360 || Step==400 || Step==440)
    Window=4; %Ventana
    Obs=[];
    Window_Nodes=[];

    %%Detectar obstáculos en la ventana 
    
    for k=-Window:Window %Cambia la coordenada x
        node.x=start.x+k;
    
        for j=-Window:Window %Cambia la coordenada y
           
            if(k==0 && j==0)
                continue;
            end
    
            node.y=start.y+j;
    
            if(node.x<1 || node.x>size_grid_x || node.y<1 || node.y>size_grid_y) %Si el node está afuera
                continue;
            end
    
            [~,column]=find(obstacle(1,:)==node.x(1) & obstacle(2,:)==node.y);
            
    
            if(isempty(column)==0)
    
                Obs(:,size(Obs,2)+1)=[node.x;node.y]; %Se agrega ese obstáculo a Obs
                obstacle(:,column)=[]; %Lo borra de obstacle
            else
                Window_Nodes(:,size(Window_Nodes,2)+1)=[node.x;node.y];
            end
        end
    end
    
    i=0;
    percent_change=randi(6)*10; %Cambio de obtáculos al azar

    stall_number=round((size(Window_Nodes,2)/100)*percent_change); %Número de celdas
    
    while(size(Obs,2)~=stall_number)
    
        if(size(Obs,2)<stall_number) %Si tamaño de obs es menor al stall_numer
            Random_stall=randi(size(Window_Nodes,2));
            Random_cordinate.x=Window_Nodes(1,Random_stall);
            Random_cordinate.y=Window_Nodes(2,Random_stall);
        
            if(Random_cordinate.x==start.x && Random_cordinate.y==start.y) %Verificar si es diferente al start
                continue
            end
            if(Random_cordinate.x==goal.x && Random_cordinate.y==goal.y)
                continue
            end
            
                [~,column]=find(Obs(1,:)==Random_cordinate.x & Obs(2,:)==Random_cordinate.y);
            
                if(isempty(column))
                    
                    Option=randi(6); %1 a 5 Agregar, 6 reemplazar
                    if(Option>=1 && Option<=5) %Agregar si el tamaño es menor a los vecion posibles
                        i=i+1;
                        Obs(:,size(Obs,2)+1)=[Random_cordinate.x;Random_cordinate.y];
                        Window_Nodes(:,Random_stall)=[];
%                     else
%                         i=i+1;
%                         random_position=randi(size(Obs,2));
%                         Obs(:,random_position)=[Random_cordinate.x;Random_cordinate.y];
                    end
        
                end
        else
            random_position=randi(size(Obs,2));
            Obs(:,random_position)=[];
        end
    
    
    end
        
    %Vacia node_information en la columna de obs
    for k=1:length(Node_information)
        Node_information(k).obs=[];
    end
      
    obstacle=[obstacle Obs];

% %     if(Step==50)
% % 
% %         save('change_1','obstacle');
% % 
% %     elseif(Step==100)
% % 
% %         save('change_2','obstacle');
% % 
% %     elseif(Step==150)
% % 
% %         save('change_3','obstacle');
% % 
% %     elseif(Step==8000)
% % 
% %         save('change_4','obstacle');
% % 
% %     elseif(Step==10000)
% % 
% %         save('change_5','obstacle');
% % 
% %     elseif(Step==12000)
% % 
% %         save('change_6','obstacle');
% % 
% %     elseif(Step==14000)
% % 
% %         save('change_7','obstacle');
% % 
% %     elseif(Step==280)
% % 
% %         save('change_8','obstacle');
% % 
% %     elseif(Step==320)
% % 
% %         save('change_9','obstacle');
% % 
% %     elseif(Step==360)
% % 
% %         save('change_10','obstacle');
% % 
% %     elseif(Step==400)
% % 
% %         save('change_11','obstacle');
% %   
% %     end



end

% % % % % if(Step==1)
% % % % %     obstacle=[1,6;3,6;4,3;4,5;5,4;5,8;6,1;6,3;1,3;3,3;3,2;1,2;2,3]';
% % % % % end
% % % % % 
% % % % % if(Step==4)
% % % % %     obstacle=[1,2;1,3;1,6;2,3;3,2;3,3;3,6;4,3;4,5;5,4;5,5;5,8;6,1;6,3;6,4]';
% % % % % end


end