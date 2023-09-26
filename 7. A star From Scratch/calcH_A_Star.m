function H=calcH_A_Star(xnext, goal)

H=(abs(xnext(2)-goal(2))+abs(xnext(1)-goal(1)))*10;

end