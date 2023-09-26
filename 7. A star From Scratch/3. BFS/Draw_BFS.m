function[ocuw, camino]=Draw_BFS(closed, goal, ocuw, start, camino)

%% verificación de bloqueo de paso

     if(goal(3,1)==inf) %Si goal no tiene padre es porque los obstáculos bloquean el paso
         ocuw(goal(1,1),goal(2,1),:)=[1 0 0]; %% ingresa en ocuw el punto final
         disp('no hay paso')
         figure()
         hold on;
         imshow(ocuw,'InitialMagnification','fit')
         return
     end

%% Proceso para graficar el camino nodo a nodo

ocuw(goal(1,1),goal(2,1),:)=[1 0 0]; %% ingresa en ocuw el punto final
figure()
hold on;
%% ingreso padre y punto final en way

Parent=[goal(3,1);goal(4,1)]; %Variable para los nodos padres que inicia con los datos del padre del nodo final
Way=[Parent [goal(1,1);goal(2,1)]]; %Arreglo para guardar las coordenadas de los pasos de la ruta

%% Busca los padres y los agrega a way

while (true)
    [~,C_Parent]=find(closed(1,:)==Parent(1,1) & closed(2,:)==Parent(2,1)); %Encontrar parent en la lista closed

    if(closed(3,C_Parent)==start(1,1) && closed(4,C_Parent)==start(2,1)) %Si parent es igual al punto inicial 
        break
    end

    Way=[closed(3:4,C_Parent) Way]; %Agrega el padre de parent al inicio way
    Parent=closed(3:4,C_Parent);
end

%% Recorre way y grafica nodo a nodo en orden ascendente
for i=1:size(Way,2)
    
    camino(Way(1,i),Way(2,i))=i;
    ocuw(Way(1,i),Way(2,i),:)=[0/255 ((255-25)/(size(Way,2))*i)/255 0/255];%% pintar la ruta 
    imshow(ocuw,'InitialMagnification','fit')
    pause(0.2)          
    drawnow

end

end