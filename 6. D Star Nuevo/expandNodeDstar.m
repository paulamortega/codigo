function [closed, goal, Node_information, open]=expandNodeDstar(closed, current, goal, Node_information, obstacle, open, size_grid_x, size_grid_y, start)

delta=-1*[+1 +1; +1 0; +1 -1; 0 +1; 0 -1; -1 +1; -1 0; -1 -1]; %Variación que se debe realizar al punto actual para obtener los 8 vecinos

if(current.g>current.rhs) %Si el current está como no visitado anteriormente (g=inf)
    current.g=current.rhs; %Se asigna el mejor valor de ganancia que es rhs

    if(current.x==goal.x && current.y==goal.y)
        goal=current;
    end

    %%Añade current en closed
    if(isempty(closed)) %Si la lista closed está vacía 
        closed=current;
    else
        position=length(closed); %Calcula el tamaño que tiene closed
        closed(position+1)=current; %Inserta current despues de la última posición de closed
    end

    [Id]=Calc_Id(current, size_grid_y); %Se calcula el Id de current
    Node_information(Id).g=current.rhs; %Se asigna a current toda su información 

    for i=1:8 
        xnext=[]; %Se vacía todo lo de xnext
        xnext.x=current.x+delta(i,1); %Se suma la varición para obtener la coordenada x del xnext
        xnext.y=current.y+delta(i,2); %Se suma la varición para obtener la coordenada y del xnext
        xnext.g=inf; %La ganacia g siempre es infinita mientras no pase a la lista closed

        if(xnext.x<1 || xnext.x>size_grid_x || xnext.y<1 || xnext.y>size_grid_y) %Se analiza si la coordenada está dento del espacio de trabajo
            continue;
        end
        
        [closed, goal, Node_information, open]=updateVertex(closed, current, goal, Node_information, obstacle, open, size_grid_y, start, xnext); %Función para insertar xnext en open

    end

else
    
    current.g=inf;

    if(current.x==goal.x && current.y==goal.y)
        goal=current;
    end

    %%Añade current en closed
    if(isempty(closed)) %Si la lista closed está vacía 
        closed=current;
    else
        position=length(closed); %Calcula el tamaño que tiene closed
        closed(position+1)=current; %Inserta current despues de la última posición de closed
    end

    [Id]=Calc_Id(current, size_grid_y); %Se calcula el Id de current
    Node_information(Id).g=current.rhs; %Se asigna a current toda su información 

    for i=1:8 
        xnext=[]; %Se vacía todo lo de xnext
        xnext.x=current.x+delta(i,1); %Se suma la varición para obtener la coordenada x del xnext
        xnext.y=current.y+delta(i,2); %Se suma la varición para obtener la coordenada y del xnext
        xnext.g=inf; %La ganacia g siempre es infinita mientras no pase a la lista closed

        if(xnext.x<1 || xnext.x>size_grid_x || xnext.y<1 || xnext.y>size_grid_y) %Se analiza si la coordenada está dento del espacio de trabajo
            continue;
        end
        
        [closed, END, goal, Node_information, open]=updateVertex(closed, current, goal, Node_information, obstacle, open, size_grid_y, start, xnext); %Función para insertar xnext en open
        if(END==true)
            return;
        end
    end

        [closed, goal, Node_information, open]=updateVertex(closed, current, goal, Node_information, obstacle, open, size_grid_y, start, xnext); %%%????????

end

end