function [column, isinlist]=findinthelist(list, node)

L=length(list);
isinlist=false;

for column=1:L
    if(list(column).x==node.x && list(column).y==node.y)
        isinlist=true;
        break
    end
end

end