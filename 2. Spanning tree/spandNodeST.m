function[open, closed, success, goal]=spandNodeST(current, open, closed, goal, success, size_grid_y, size_grid_x, obstacle)

%Realiza la expancion del nodo teniendo en cuenta los 4 vecinos de current

% delta=[-1 0; 0 -1; +1 0; 0 +1]; %Variación que se debe realizar al punto actual para obtener los vecinos
delta=[-1 0; 0 -1; +1 0; 0 +1; -1 -1; +1 -1; +1 +1; -1 +1]; %Variación que se debe realizar al punto actual para obtener los 8 vecinos

for i=1:1:8
    xnext(1,1)=current(1,1)+delta(i,1); %Se suma la varición para obtener la coordenada x del xnext
    xnext(2,1)=current(2,1)+delta(i,2); %Se suma la varición para obtener la coordenada y del xnext

    if(xnext(1,1)<1 || xnext(1,1) > size_grid_y) %Se analiza si la coordenada está dento del espacio de trabajo
        continue;
    end
    
    if(xnext(2,1)<1 || xnext(2,1) > size_grid_x) %Se analiza si la coordenada está dento del espacio de trabajo
        continue;
    end
    
    [~, o]=find(obstacle(1,:)==xnext(1,1) & obstacle(2,:)==xnext(2,1)); %Se analiza si la coordenada es correspondiente a un obtáculo
    if(isempty(o))
        
    else
        continue;
    end

    if(i>4) %Hacer para los casos en que se mueva por las diagonales
        
        Diag=Diagonal(current, obstacle, delta, i); %Valida que el paso no este entre dos obstaculos en diagonal
        if(Diag==true)%Si Diag es verdadero
            continue %Busca el siguiente xnext
        end
    end



    if(xnext(1,1)==goal(1,1) && xnext(2,1)==goal(2,1)) %Se analiza si uno de los vecinos del current corresponde al punto final
        xnext(3,1)=current(1,1);
        xnext(4,1)=current(2,1);
        goal=xnext;
        success=1; %Se le otorga el valor de 1 a la variable para poder terminar el proceso
        break; %Finaliza la función actual
    else

        %% Buscar si xnext está en open y/o en close
        [~, columna_O]=find(open(1,:)==xnext(1,1) & open(2,:)==xnext(2,1)); %Busca en open el xnext

        if(isempty(columna_O))
           isintheopen=false; %Si no lo encuentra
           
            [~, columna_C]=find(closed(1,:)==xnext(1,1) & closed(2,:)==xnext(2,1)); %Busca en closed el xnext
            if(isempty(columna_C))
                isintheclose=false; %Si no lo encuentra
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

            if(isempty(open)) %Si la lista open está vacia 
                open=xnext; %se añade el valor de xnext en open 
            else
                Ra=randi([1,size(open,2)+1]); %Toma un valor al azar entre 1 y el número tolar de columnas que poseaa la lista open aumetado en uno
                if(Ra==size(open,2)+1) %Si el valor aleatorio es igual al tamaño que posee open más uno
                   open(:,Ra)=xnext; %Agraga despues de la última columna el punto actual
                else
                   if(Ra==1) %Si el valor de Ra es igual a 1
                     open=[xnext open]; %Agrega el xnext en la primera posición y coloca despues todos los datos que estaban en open
                   else
                     open=[open(:,1:Ra-1) xnext open(:,Ra:end)]; %Posiciona en la columna que se eligió al azar el xnext sin sobre escribir el resto de las columnas
                   end
                end
            end
        end
    end
end
end