function[obstacle, obs, ocuw]=Obstaculos_D(goal, percentage_obs, ocuw, size_grid_x, size_grid_y, start)

i=0;
obstacle=[0;0];
obs=zeros(size_grid_x,size_grid_y);

casillas=round(((size_grid_x*size_grid_y)/100)*percentage_obs);

while(i~=casillas)
    
    R=[randi(size_grid_x);randi(size_grid_y)];
    
    if(R(1)==start.x && R(2)==start.y)
        continue
    end

    if(R(1)==goal.x && R(2)==goal.y)
        continue
    end

    [~,colum]=find(obstacle(1,:)==R(1) & obstacle(2,:)==R(2));

    if(isempty(colum))
        i=i+1;
        obstacle(:,i)=R;
        obs(R(1),R(2))=i;
        ocuw(obstacle(1,i),obstacle(2,i),:)=[140/255 140/255 140/255];
    end   

end
% % % 
% % % imshow(ocuw,'InitialMagnification','fit')

end