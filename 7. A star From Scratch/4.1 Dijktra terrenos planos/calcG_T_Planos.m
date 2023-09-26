function gnew=calcG_T_Planos(current,i)

    if(i<5) %Si i es menor a 5
        gnew=current(5,1)+10; %Le suma al coste del padre 10 por ser movimiento axial.
    else
        gnew=current(5,1)+14; %Le suma al coste del padre 14 por ser movimiento diagonal.
    end
