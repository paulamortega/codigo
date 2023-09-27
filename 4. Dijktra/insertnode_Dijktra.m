function[closed]=insertnode_Dijktra(closed,current)

closed(:,size(closed,2)+1)=current; %Se ingresa el punto actual en la cola de la lista close

end