function gnew=calcG(current,xnext,i,Cost)
[~,colum_Cost]=find(Cost(1,:)==xnext(1,1) & Cost(2,:)==xnext(2,1)); %Busca si xnext posee un coste aparte en el vector Cost

if(isempty(colum_Cost)) %Si colum_Cost está vacío
    if(i<5) %Si i es menor a 5
        gnew=current(5,1)+10; %Le suma al coste del padre 10 por ser movimiento axial.
    else
        gnew=current(5,1)+14; %Le suma al coste del padre 14 por ser movimiento diagonal.
    end
else
    if(i<5)
        gnew=current(5,1)+10+Cost(3,colum_Cost); %Le suma al coste del padre 10 por ser movimiento axial y el coste de la posición.
    else
        gnew=current(5,1)+14+Cost(3,colum_Cost); %Le suma al coste del padre 14 por ser movimiento diagonal y el coste de la posición.
    end
end