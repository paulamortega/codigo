function Diag=Diagonal(current, obstacle, delta, i)

% diff=[current(1,1)-xnext(1,1),current(2,1)-xnext(2,1)]; %Calcula la diferencia del movimiento

adj1=[current(1,1)+delta(i,1),current(2,1)]; %Casilla adyacente 1
adj2=[current(1,1),current(2,1)+delta(i,2)]; %Casilla adyacente 2

[~, o1]=find(obstacle(1,:)==adj1(1,1) & obstacle(2,:)==adj1(1,2)); %Busca si la casilla adyacente 1 es obtáculo
[~, o2]=find(obstacle(1,:)==adj2(1,1) & obstacle(2,:)==adj2(1,2)); %Busca si la casilla adyacente 2 es obtáculo

if(isempty(o1)==0 && isempty(o2)==0) %Si la casilla adjacente 1 no es obstáculo continua el proceso
    Diag=true; %Si las dos casillas adjacentes son obstáculos no se debe agregar el xnext a la lista Open   
else
    Diag=false;
end
end