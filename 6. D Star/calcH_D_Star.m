function xnext=calcH_D_Star(xnext, goal)

H=(abs(xnext.y-goal.y)+abs(xnext.x-goal.x))*10; %Se calcula la heurística del xnext 
xnext.h=H; %Se le asigna el vaor de H a xnext

end