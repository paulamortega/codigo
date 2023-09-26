function g=calcG(current, obstacle, xnext)

[~, Obs_xnext]=find(obstacle(1,:)==xnext.x & obstacle(2,:)==xnext.y); %Busca xnext en los obstáculos
[~, Obs_parent]=find(obstacle(1,:)==current.x & obstacle(2,:)==current.y); %Busca el padre de xnext en los obstáculos

if(isempty(Obs_parent)==0 || isempty(Obs_xnext)==0) %Si xnext es obstáculo o el padre es obstáculo 
    g=inf; %Se le asigna a g un valor de inf
else
    g=round(sqrt((current.x-xnext.x)^2+(current.y-xnext.y)^2)*10); %Se calcula el valor de g (10 0 14)
end

end