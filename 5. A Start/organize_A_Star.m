function [Colum]=organize_A_Star(open,fnew)

for Colum=1:size(open,2) %Ciclo desde 1 hasta el total de columnas que posea open
    if(open(6,Colum)>fnew) %Si la ganacia de open en esa columna es mayor a la gnew

        break; %Rompe el ciclo for        
    end
end

end