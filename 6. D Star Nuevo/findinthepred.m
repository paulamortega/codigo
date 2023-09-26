function [Row]=findinthepred(list, node)

L=length(list);
% isinlist=false;
Row=[];

for k=1:L
    if(isempty(list(k).pred)==0)
        if(list(k).pred(1)==node.x && list(k).pred(2)==node.y)
            Row(length(Row)+1)=k;
        end
    end
end

end