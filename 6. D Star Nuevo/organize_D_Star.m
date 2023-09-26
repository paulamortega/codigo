function [Colum]=organize_D_Star(open,xnext)

L=length(open); %Calcula el tamaño de open

for Colum=1:L %Ciclo desde 1 hasta el total de columnas que posea open
    if(open(Colum).key(1)>xnext.key(1)) %Si la ganacia de open en esa columna es mayor a la g
        break; %Rompe el ciclo for        
    end
end

end