function [open, GHF]=addToOAstar(xnext, current, open, fnew, H, gnew, GHF)

xnext(3,1)=current(1,1); %Se le añade al xnext su correspondiente current
xnext(4,1)=current(2,1); 
xnext(5,1)=gnew; %Ganancia del xnext
xnext(6,1)=fnew; %Estimación del xnext

if(isempty(open)) %Si la lista open está vacía
    open=xnext; %Se coloca xnext como único elemento en open
else
    
    if(fnew>=open(6,end)) %Si la estimación de xnext es mayor o igual a la estimación de la última posición que hay en open
        open=[open xnext];
    else
        if(size(open,2)==1)
            open=[xnext open];
        else
            [Colum]=organize_A_Star(open,fnew); %Busca la columna en donde debe ir según la estimación 
            open=[open(:,1:Colum-1) xnext open(:,Colum:end)];
        end
    end
end

GHF(xnext(1,1),xnext(2,1),:)=[gnew H fnew];
        
end