function [open, LGHF]=addToOAstar(xnext, current, open, fnew, H, gnew, LGHF)

% % % % % xnext(3,1)=current(1,1); %Se le añade al xnext su correspondiente current
% % % % % xnext(4,1)=current(2,1); 
xnext(6,1)=gnew; %Ganancia del xnext
xnext(7,1)=fnew; %Estimación del xnext

if(isempty(open)) %Si la lista open está vacía
    open=xnext; %Se coloca xnext como único elemento en open
    open(3:4,1)=[current(1,1) current(2,1)];
else
    
    if(fnew>=open(7,end)) %Si la estimación de xnext es mayor o igual a la estimación de la última posición que hay en open
        open=[open xnext];
        open(3:4,end)=[current(1,1) current(2,1)];
    else
        if(size(open,2)==1)
            open=[xnext open];
            open(3:4,1)=[current(1,1) current(2,1)];
        else
            [Colum]=organize_A_Star(open,fnew); %Busca la columna en donde debe ir según la estimación 
            open=[open(:,1:Colum-1) xnext open(:,Colum:end)];
            open(3:4,Colum)=[current(1,1) current(2,1)];
        end
    end
end

% LGHF(xnext(1,1),xnext(2,1),:)=[0 gnew H fnew]; %Se agrega en GHF sus valores correspondientes de G, H y F
       
end