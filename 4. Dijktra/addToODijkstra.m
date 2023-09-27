function [open,Gain]=addToODijkstra(xnext, current, gnew, open, Gain)

xnext(3,1)=current(1,1); %Se le añade al xnext su correspondiente current
xnext(4,1)=current(2,1); 
xnext(5,1)=gnew; %Ganancia del xnext

if(isempty(open)) %Si la lista open está vacía
    open=xnext; %Se coloca xnext como único elemento en open
else
    
    if(gnew>=open(5,end)) %Si el coste de xnext es mayor o igual al coste de la última posición que hay en open
        open=[open xnext]; %Agrega xnext en la última posición de open
    else
        if(size(open,2)==1)
            open=[xnext open];
        else
            [Colum]=organize(open,gnew); %Busca la columna en donde debe ir según el coste
            open=[open(:,1:Colum-1) xnext open(:,Colum:end)];
        end
    end
end

Gain(xnext(1,1),xnext(2,1))=gnew;

end