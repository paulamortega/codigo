function[obstacle, obs, ocuw, camino, LGHF]=Obstaculos_individuales_A(size_grid_x,size_grid_y,percentage_obs, start, goal, ocuw, camino, LGHF)

i=0;
% % Porcentaje=2;
obstacle=[0;0];
obs=zeros(size_grid_x,size_grid_y);

casillas=round(((size_grid_x*size_grid_y)/100)*percentage_obs);

while(i~=casillas)
    
    R=[randi(size_grid_x);randi(size_grid_y)];
    
    if(R(1)==start(1,1) && R(2)==start(2,1))
        continue
    end

    if(R(1)==goal(1,1) && R(2)==goal(2,1))
        continue
    end

    [~,colum]=find(obstacle(1,:)==R(1) & obstacle(2,:)==R(2));

    if(isempty(colum))
        i=i+1;
        obstacle(:,i)=R;
        obs(R(1),R(2))=i;
        ocuw(obstacle(1,i),obstacle(2,i),:)=[140/255 140/255 140/255];
        camino(obstacle(1,i),obstacle(2,i))=-3;
        LGHF(obstacle(1,i),obstacle(2,i),:)=-3;
    end   

end

imshow(ocuw,'InitialMagnification','fit')

end