function[open,current]=removenode_A_Star(open)
        %% Escoger el dato de la primera posición      
        current=open(:,1); % Modifica el paso actual con el primero de la lista
        open(:,1)= []; %Quitar de la lista open
end