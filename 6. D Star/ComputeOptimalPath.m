function [closed, Node_information, open]=ComputeOptimalPath(closed, goal, Node_information, obstacle,open, size_grid_x, size_grid_y, start)

while(compareKeyLess(open(1).key,goal.key)==1 || goal.g~=goal.rhs)
    
    current=open(1); %Asigna el nuevo current
    open(1)=[]; %Vacia la primera posición de la lista open
    
    [closed, goal, Node_information, open]=expandNodeDstar(closed, current, goal, Node_information, obstacle, open, size_grid_x, size_grid_y, start); %Función para realizar la expanción del nodo

    if(isempty(open)) %Si la lista open está vacia debe terminar el proceso
        break
    end

end

end