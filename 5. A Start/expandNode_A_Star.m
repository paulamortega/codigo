function[open, closed, GHF]=expandNode_A_Star(current, open, closed, size_grid_y, size_grid_x, obstacle, Cost, goal, GHF)

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

    gnew=calcG_A_Star(current,xnext,i,Cost); %Calcula la ganancia de xnext
    [H, fnew]=calcF_A_Star(xnext, goal, gnew); %Calcula la Estimación (F) de xnext

    %% Buscar xnext en open y/o en closed

        [~, columna_O]=find(open(1,:)==xnext(1,1) & open(2,:)==xnext(2,1)); %Busca en open el xnext
        
        if(isempty(columna_O))
           isintheopen=false; %Si no lo encuentra en open

            [~, columna_C]=find(closed(1,:)==xnext(1,1) & closed(2,:)==xnext(2,1)); %Busca en open el xnext
            if(isempty(columna_C))
               isintheclose=false; %Si no lo encuentra en close
            else
               isintheclose=true;
% % % %                continue; %Si lo encuentra en closed no necesita realiza el resto del proceso 
            end

        else
           isintheopen=true; %Si lo encuentra en open
           isintheclose=false; %No debe estar en closed
        end

        %% Verificar en las listas

        if(isintheopen==true) %Si xnext está en la lista open
            if(fnew<open(6,columna_O)) %Si el nuevo f calculado es menor al que ya tenía
                open(:,columna_O)=[]; %Vacia esa columna de la lista open
                [open, GHF]=addToOAstar(xnext, current, open, fnew, H, gnew, GHF); %Agrega en la lista open según el orden
            end
        else
            if(isintheclose==true) %Si xnext está en la lista closed
                if(fnew<closed(6,columna_C)) %Si el nuevo f calculado es menor al que ya tenía
                    closed(:,columna_C)=[]; %Vacia esa columna de la lista close
                    [open, GHF]=addToOAstar(xnext, current, open, fnew, H, gnew, GHF); %Agrega en la lista open según el orden
                end
            else
                [open, GHF]=addToOAstar(xnext, current, open, fnew, H, gnew, GHF); %Agrega en la lista open según el orden
            end
        end
end
end