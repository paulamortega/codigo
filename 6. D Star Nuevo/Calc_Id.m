function [Id]=Calc_Id(node, size_grid_y)

Id=node.y+(node.x-1)*size_grid_y; %Ubicación en la estructura

end