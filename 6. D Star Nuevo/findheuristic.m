function [column]=findheuristic(closed, min)

for column=1:length(closed)

    if(closed(column).h==min)

        break;

    end


end


end