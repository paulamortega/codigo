function[open,current,camino,a,ocuw,locked]=removenode(open,camino,current,a,ocuw)

       %% Guardar las columnas en donde están los vecinos de current en la lista open 

        if(a~=1) %Para los pasos siguientes al primero se realiza el proceso clompleto
%            neighbours=[current(1),current(2)+1;current(1),current(2)-1;current(1)+1,current(2);current(1)-1,current(2)]'; % vecinos que tiene Punto actual
           neighbours=[current(1),current(2)+1;current(1),current(2)-1;current(1)+1,current(2);current(1)-1,current(2);current(1)-1,current(2)-1;current(1)-1,current(2)+1;current(1)+1,current(2)+1;current(1)+1,current(2)-1]'; % vecinos que tiene Punto actual
           Position=0; %Posición del vector columns
           columns=0; %Vector que guarda las columnas de los vecinos encontrados en la lista open

           for i=1:8 %Guarda las columnas de open en las que se encuentran los vecinos factibles
               [~,col]=find(open(1,:)==neighbours(1,i) & open(2,:)==neighbours(2,i)); %Busca en open los vecinos
               if(isempty(col)==0) %Si col vacio isempty(col)=1 pero si col no vacio isempty(col)=0
                  Position=Position+1; %Aumenta la variable en una unidad
                  columns(Position)=col; % En columns se guardan las columnas donde en open se encuentran los vecinos de Pa
               end
           end

        else
           columns=1; %De ser el primer paso se toma la variable en uno para realizar el proceso siguiente
        end

       %% Validación de encierro

        if (columns==0) %Si la variable columns es cero es por que el camino está encerrado
            locked=1; %La variable toma un valor de 1 para poder salir del proceso 
            return %Termina la función actual
        else
            locked=0; %Mantiene la variable de encierro en cero
        end

        %% Escoger posición de manera aleatorea
        Ra=randi(size(columns,2)); %Escoge un número entero entre 1 el tamaño que tenga columns al azar
        x=columns(Ra); %Variable para guardar el valor en el puesto Ra de columns   

        %% Modifica el paso actual

        current=open(:,x); % asigna en current lo que se encuentra en open en la columna x
        camino(current(1,1),current(2,1))=a;% guardamos ruta

        %% Remueve de open

        open(:,x)= []; %Quitar de la lista open

        a=a+1;% en cada ciclo a aumente de 1 en 1

        %% Grafica
        
        ocuw(current(1),current(2),:)=[0/255 139/255 0/255];%% pintar la ruta 
        imshow(ocuw,'InitialMagnification','fit')
        pause(0.2)%Pausa de 0.2 segundos
        drawnow %Dibujar nuevamente
end