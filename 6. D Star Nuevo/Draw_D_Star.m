function[New_start, ocuw, Way]=Draw_D_Star(closed, goal, ocuw, start)

[col_goal, isinlist]=findinthelist(closed, goal); %Busca en closed el punto final

if(isinlist==true) %Si está el punto final en la lista closed es porque existe camino

    % Se inicializa la estructura Way con el punto final y el padre del punto final
    Way(2).x=closed(col_goal).pred(1); %Padre del punto final
    Way(2).y=closed(col_goal).pred(2);
    Way(1).x=goal.x; %Punto final
    Way(1).y=goal.y;

    %% LLenado de Way
    while(true)

        current=Way(end); %Current toma el valor del último valor de way (último padre)
        [column, ~]=findinthelist(closed, current); %Se busca en closed ese padre

        if(current.x==start.x && current.y==start.y) %Si el padre actúal es el punto inicial se debe terminar el proceso
            break
        end

        L=length(Way); %Calcula el tamaño de Way
        %Se coloca el padre en Way despues de la última posición
        Way(L+1).x=closed(column).pred(1);
        Way(L+1).y=closed(column).pred(2);

    end
    
    color=0; %Variable para cambiar la gama del color verde
    for i=L:-1:1
        color=color+1;
        ocuw(Way(i).x,Way(i).y,:)=[0/255 ((255-25)*color/L)/255 0/255];
    end

    %Se asigna como nuevo start la siguiente posición en el camino
    New_start.x=Way(end-1).x;
    New_start.y=Way(end-1).y;

else

    if(length(closed)~=1)

        Heuristics=[closed.h];
        Min=min(Heuristics);

        [column]=findheuristic(closed, Min);

        Way(2).x=closed(column).pred(1); %Padre del punto final
        Way(2).y=closed(column).pred(2);
        Way(1).x=closed(column).x;
        Way(1).y=closed(column).y;

        %% LLenado de Way
        while(true)
    
            current=Way(end); %Current toma el valor del último valor de way (último padre)
            [column, ~]=findinthelist(closed, current); %Se busca en closed ese padre
    
            if(current.x==start.x && current.y==start.y) %Si el padre actúal es el punto inicial se debe terminar el proceso
                break
            end
    
            L=length(Way); %Calcula el tamaño de Way
            %Se coloca el padre en Way despues de la última posición
            Way(L+1).x=closed(column).pred(1);
            Way(L+1).y=closed(column).pred(2);
    
        end

        New_start.x=Way(end-1).x;
        New_start.y=Way(end-1).y;

        return;

    end

    if(length(closed)==1) %Si closes posee solo un dato

        %Se asigna el nuevo start como la única posición disponible
        New_start.x=closed(1).x;
        New_start.y=closed(1).y;

        Way=New_start;

        return;

    end

end
end
