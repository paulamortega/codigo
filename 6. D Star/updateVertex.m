function [closed, goal, Node_information, open]=updateVertex(closed, current, goal, Node_information, obstacle, open, size_grid_y, start, xnext)

if(xnext.x~=start.x || xnext.y~=start.y)% Verifica que xnext no sea el punto inicial

    %% Calcular valores de xnext
    
    [Best, xnext]=calcrhs(closed, current, Node_information, obstacle, open, size_grid_y, start, xnext);%Calcula el rhs del xnext (coste)
%     xnext=calcH_D_Star(xnext, goal); %Calcula la heurística del nodo xnext
    [Id]=Calc_Id(xnext, size_grid_y); %Calcula el Id de xnext
    xnext.h=Node_information(Id).h;
    key=calcKey(xnext); %Calcula la llave de xnext  
    xnext.key=key; %Asigna la llave calculada en xnext
    

    if(xnext.key(1)==inf && xnext.key(2)==inf) %Si xnext es obstáculo

        Node_information(Id).h=xnext.h;
        Node_information(Id).key=xnext.key;
        Node_information(Id).pred=xnext.pred;
        Node_information(Id).pred(1)=current.x;
        Node_information(Id).pred(2)=current.y;
        Node_information(Id).state=1;

        return;

    end
    
    if(Best==true) %Si el nodo debe mejorar
        [column_O, isintheopen]=findinthelist(open, xnext); %Busca en open el xnext
        if(isintheopen==true)

            open(:,column_O)=[]; %Vacia esa columna de la lista open
            [open]=addToODstar(xnext, open); %Agrega en la lista open según el orden

            Node_information(Id).g=xnext.g;
            Node_information(Id).rhs=xnext.rhs;
            Node_information(Id).h=xnext.h;
            Node_information(Id).key=xnext.key;
            Node_information(Id).pred=xnext.pred;
            Node_information(Id).state=1;

            return;

        end
        
        [column_C, isintheclosed]=findinthelist(closed, xnext); %Busca en closed el xnext
        if(isintheclosed==true)

            closed(:,column_C)=[]; %Vacia esa columna de la lista close
            [open]=addToODstar(xnext, open); %Agrega en la lista open según el orden

            Node_information(Id).g=xnext.g;
            Node_information(Id).rhs=xnext.rhs;
            Node_information(Id).h=xnext.h;
            Node_information(Id).key=xnext.key;
            Node_information(Id).pred=xnext.pred;
            Node_information(Id).state=1;

            return;

        end

        [open]=addToODstar(xnext, open); %Agrega en la lista open según el orden

        Node_information(Id).g=xnext.g;
        Node_information(Id).rhs=xnext.rhs;
        Node_information(Id).h=xnext.h;
        Node_information(Id).key=xnext.key;
        Node_information(Id).pred=xnext.pred;
        Node_information(Id).state=1;

        return

    else

        Node_information(Id).state=1;

    end

end