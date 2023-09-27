function [open]=addToODstar(xnext, open)

if(isempty(open)) %Si la lista open está vacía
    open=xnext; %Se coloca xnext como único elemento en open
else
    
    key_xnext=xnext.key; %Se asigna el valor de la llave que tiene xnext
    key_open=open(end).key; %Se asigna el valor de la llave que tiene el ultimo dato de open

    if(key_xnext(1)>=key_open(1)) %Si la estimación de xnext es mayor o igual a la estimación de la última posición que hay en open
        open=[open xnext]; %Agrega xnext en la última posición de open
    else
        if(length(open)==1)
            open=[xnext open]; %Agrega xnext en la primera posición de open
        else
            [Colum]=organize_D_Star(open,xnext); %Busca la columna en donde debe ir según la estimación 
            open=[open(:,1:Colum-1) xnext open(:,Colum:end)]; %Agrega xnext en la posición correspondiente 
        end
    end
end
       
end