function[closed]=insertnode_BFS(closed,current)

%% Inserta al final de la lista close

closed(:,size(closed,2)+1)=current; %Se ingresa el punto actual en la cola de la lista close

end