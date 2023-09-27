function [Colum]=organize(open,gnew)

for Colum=1:size(open,2) %Ciclo desde 1 hasta el total de columnas que posea open
    if(open(5,Colum)>gnew) %Si la ganacia de open en esa columna es mayor a la gnew
        
        break; %Rompe el ciclo for        
    end
end

end