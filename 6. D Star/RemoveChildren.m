function [closed, Node_information, open]=RemoveChildren(closed, node, Node_information, open, size_grid_y)

[Row]=findinthepred(closed, node);

if(isempty(Row)==0)
    for L=length(Row):-1:1
        remove_node.x=closed(Row(L)).x;
        remove_node.y=closed(Row(L)).y;
        [Id]=Calc_Id(remove_node, size_grid_y);

        Node_information(Id).g=inf;
        Node_information(Id).rhs=inf;
        Node_information(Id).key=[];
        Node_information(Id).pred=[];

        closed(Row(L))=[];
    end
end

[Row]=findinthepred(open, node);

if(isempty(Row)==0)
    for L=length(Row):-1:1
        remove_node.x=open(Row(L)).x;
        remove_node.y=open(Row(L)).y;
        [Id]=Calc_Id(remove_node, size_grid_y);

        Node_information(Id).g=inf;
        Node_information(Id).rhs=inf;
        Node_information(Id).key=[];
        Node_information(Id).pred=[];

        open(Row(L))=[];
    end
end



end