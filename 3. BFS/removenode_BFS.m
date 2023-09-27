function[open,current,level]=removenode_BFS(open,level)
        %% Remueve el primero de la lista open      
        current=open(:,1); % Modifica el paso actual con el primero de la lista
        open(:,1)= []; %Quitar de la lista open
        level(current(1,1),current(2,1))=current(5,1); %Se llena el nivel en level
end