function[ocuw, camino, i]=Draw_A(closed, goal, ocuw, start, cost_vector, camino, j)

%% verificación de si hay camino

     [~,C_goal]=find(closed(1,:)==goal(1,1) & closed(2,:)==goal(2,1)); %Encontrar punto final en lista closed

     if(isempty(C_goal)) %Si no se lo encuentra es porque está encerrado
         ocuw(goal(1,1),goal(2,1),:)=[1 0 0]; %Pinta punto final
         disp('no hay camino') %Imprime letrero 
         figure() %Inicializa la figura
         hold on; %Mantiene la figura
         imshow(ocuw,'InitialMagnification','fit') %imprime la figura
         i=0;
         return %Finaliza la función
     end

% ocuw(goal(1,1),goal(2,1),:)=[1 0 0]; %Pinta punto final
figure() %Inicializa la figura
hold on; %Mantiene la figura
Parent=closed(3:4,C_goal); %Variable para los nodos padres que inicia con los datos del padre del nodo final
Way=[Parent closed(1:2,end)]; %Vetor en el que se guardan las coordenadas de las posiciones del camino

while (true)
[~,C_Parent]=find(closed(1,:)==Parent(1,1) & closed(2,:)==Parent(2,1)); %Busca la columna donde está el padre en las dos primeras filas en closed

if(closed(3,C_Parent)==start(1,1) && closed(4,C_Parent)==start(2,1)) %Si el padre que se buscó corresponde al nodo inicial
    break %Rompe el ciclo while
end

Way=[closed(3:4,C_Parent) Way]; %Guarda uno por uno las posiciones del camino en orden ascendente
Parent=closed(3:4,C_Parent); %Asigna el nuevo padre

end

for i=1:size(Way,2)
    [~,C_Cost]=find(cost_vector(1,:)==Way(1,i) & cost_vector(2,:)==Way(2,i)); %Busca si el paso posee un valor de coste
    if(isempty(C_Cost)) %Si no tiene ningun valor de coste
        ocuw(Way(1,i),Way(2,i),:)=[0/255 ((255-25)*i/size(Way,2))/255 0/255];%% pintar la ruta de verde
    else
        ocuw(Way(1,i),Way(2,i),:)=[0/255 139/255 100/255];%% pintar la ruta de un color diferente
    end
%     imshow(ocuw,'InitialMagnification','fit');
%     pause(0.2)          
%     drawnow

    camino(Way(1,i),Way(2,i))=i;

end

imshow(ocuw,'InitialMagnification','fit');
% if(j==1)
%     title('A star 100x100/20');
% else
%     if(j==2)
%         title('A star 100x100/40');
%     else
%         if(j==3)
%             title('A star 100x100/50');
%         else
%             if(j==4)
%                 title('A star 200x200/20');
%             else
%                 if(j==5)
%                     title('A star 200x200/40');
%                 else
%                     if(j==6)
%                         title('A star 200x200/50');
%                     else
%                         if(j==7)
%                             title('A star 400x400/20');
%                         else
%                             if(j==8)
%                                 title('A star 400x400/40');
%                             else
%                                 title('A star 400x400/50');
%                             end
%                         end
%                     end
%                 end
%             end
%         end
%     end
% end

end