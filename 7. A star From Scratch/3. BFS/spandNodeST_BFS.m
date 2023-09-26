function[open, closed, success, goal, level]=spandNodeST_BFS(current, open, closed, goal, success, size_grid_y, size_grid_x, obstacle, level)

%Realiza la expanción del nodo teniendo en cuenta los 8 vecinos de current

% delta=[-1 0; 0 -1; +1 0; 0 +1]; %Variación que se debe realizar al punto actual para obtener los vecinos
delta=[-1 0; 0 -1; +1 0; 0 +1; -1 -1; +1 -1; +1 +1; -1 +1];

for i=1:8
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
    
    if(xnext(1,1)==goal(1,1) && xnext(2,1)==goal(2,1)) %Se analiza si uno de los vecinos del current corresponde al punto final
        goal(3,1)=current(1,1); %Se asigna el padre al nodo final
        goal(4,1)=current(2,1);
        goal(5,1)=current(5,1)+1; %Se asigna el nivel correspondiente al nodo final

        level(goal(1,1),goal(2,1))=goal(5,1); %Se llena el nivel del punto final en level
        
        success=1; %Se le otorga el valor de 1 a la variable para poder terminar el proceso
        break; %Finaliza la función actual
    else

        %% Buscar si xnext está en open y/o en close
        [~, columna_O]=find(open(1,:)==xnext(1,1) & open(2,:)==xnext(2,1)); %Busca en open el xnext
        if(isempty(columna_O))
           isintheopen=false; %Si no o encuentra

           [~, columna_C]=find(closed(1,:)==xnext(1,1) & closed(2,:)==xnext(2,1)); %Busca en open el xnext
            if(isempty(columna_C))
                isintheclose=false; %Si no o encuentra
            else
                isintheclose=true; %Si lo encuentra
            end
        else
           isintheopen=true; %Si lo encuentra
           isintheclose=false; %No lo encuentra
        end

        %% 
        if(isintheopen==false && isintheclose==false)%%Se verifica que xnext no esté en open ni en closed
            xnext(3,1)=current(1,1); %Se le añade al xnext su correspondiente current
            xnext(4,1)=current(2,1); 
            xnext(5,1)=current(5,1)+1; %Asigna el nivel
            open=[open xnext]; %Se ingresa en la lista open de ùltimo
        end
    end
end
end