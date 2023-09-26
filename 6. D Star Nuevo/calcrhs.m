function [Best, xnext]=calcrhs(closed, current, Node_information, obstacle, open, size_grid_y, start, xnext)

% Best=false;

[Id]=Calc_Id(xnext, size_grid_y); %Calcula Id de xnext

if(Node_information(Id).state==0 || isempty(Node_information(Id).pred))%Si la información no es actual o xnext no tiene padre

    rhs_current=current.g+calcG(current, obstacle, xnext); %Costo del padre + Costo de xnext
    xnext.pred(1,:)=[current.x current.y]; %Coloca current como padre de xnext
    xnext.rhs=rhs_current; %Asigna el rhs calculado al nodo xnext
    Best=true;

else

    pred.x=Node_information(Id).pred(1); 
    pred.y=Node_information(Id).pred(2);
    Id_pred=Calc_Id(pred, size_grid_y); %Se calcula el Id del padre

    if(Node_information(Id_pred).obs==1) %Si el anterior padre es obstáculo (Duda de si entra o no)

        xnext.pred(1,:)=[current.x current.y]; %Coloca current como padre de xnext

    end

    rhs_pred=Node_information(Id_pred).g+calcG(Node_information(Id_pred), obstacle, xnext); %Costo del padre + Costo de xnext
    rhs_current=current.g+calcG(current, obstacle, xnext); %Costo del padre + Costo de xnext

    if(rhs_current<rhs_pred) %Si el nuevo rhs es mejor que el anterior
        xnext.pred(1,:)=[current.x current.y]; %Coloca current como padre de xnext
        xnext.rhs=rhs_current; %Asigna el rhs calculado al nodo xnext
        Best=true;
    else
        xnext.pred(1,:)=[pred.x pred.y]; %Coloca pred como padre de xnext
        xnext.rhs=rhs_pred; %Asigna el rhs calculado al nodo xnext
        Best=false;
    end

end

end
