function[open, closed, Gain]=spandNode_Dijktra_T_Planos(current, open, closed, size_grid_y, size_grid_x, obstacle, Gain)

%Realiza la expncion del nodo teniendo en cuenta los 8 vecinos de current

% delta=[-1 0; 0 -1; +1 0; 0 +1]; %Variación que se debe realizar al punto actual para obtener los 4 vecinos

delta=[-1 0; 0 -1; +1 0; 0 +1; -1 -1; +1 -1; +1 +1; -1 +1]; %Variación que se debe realizar al punto actual para obtener los 8 vecinos

for i=1:1:8
    xnext(1,1)=current(1,1)+delta(i,1); %Se suma la varición para obtener la coordenada x del xnext
    xnext(2,1)=current(2,1)+delta(i,2); %Se suma la varición para obtener la coordenada y del xnext
    
    if(xnext(1,1)<1 || xnext(1,1) > size_grid_x) %Se analiza si la coordenada está dento del espacio de trabajo
        continue;
    end
    
    if(xnext(2,1)<1 || xnext(2,1) > size_grid_y) %Se analiza si la coordenada está dento del espacio de trabajo
        continue;
    end
    
    [~, o]=find(obstacle(1,:)==xnext(1,1) & obstacle(2,:)==xnext(2,1)); %Se analiza si la coordenada es correspondiente a un obtáculo
    if(isempty(o))
        
    else
        continue;
    end

    gnew=calcG_T_Planos(current,i); %Calcula la ganancia de xnext

    %% Buscar xnext en open y/o en closed

        [~, columna_O]=find(open(1,:)==xnext(1,1) & open(2,:)==xnext(2,1)); %Busca en open el xnext

        if(isempty(columna_O))
           isintheopen=false; %Si no lo encuentra en open

            [~, columna_C]=find(closed(1,:)==xnext(1,1) & closed(2,:)==xnext(2,1)); %Busca en open el xnext
            if(isempty(columna_C))
               isintheclose=false; %Si no lo encuentra en close
            else
               continue; %Si lo encuentra en closed no necesita realiza el resto del proceso 
            end

        else
           isintheopen=true; %Si lo encuentra en open
           isintheclose=false; %No debe estar en closed
        end

        %% Verificar en las listas

        if(isintheopen==false && isintheclose==false)%%Se verifica que xnext no esté en open ni en closed

            [open,Gain]=addToODijkstra(xnext, current, gnew, open, Gain); %Función que llena el xnext en la posición correspondiente según su coste

        elseif(gnew<open(5,columna_O)) %Verifíca que la gnew sea menor a la que tenia anteriormente

            open(:,columna_O)=[]; %Vacía esa pocición en la lista open
            [open,Gain]=addToODijkstra(xnext, current, gnew, open, Gain); %Función que llena el xnext en la posición correspondiente según su coste

        end
end
end