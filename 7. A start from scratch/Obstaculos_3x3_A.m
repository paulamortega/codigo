function[obstacle, obs, ocuw, camino, LGHF]=Obstaculos_3x3_A(size_grid_x,size_grid_y,percentage_obs, start, goal, ocuw, camino, LGHF)

i=0;
k=0;
delta=[-1,0;-1,1;0,1;1,1;1,0;1,-1;0,-1;-1,-1]';
obstacle=[0;0];
obs=zeros(size_grid_x,size_grid_y);

casillas=round(((size_grid_x*size_grid_y)/100)*percentage_obs);

while(i<casillas)
    
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
        k=k+1;
        obstacle(:,i)=R;
        obs(R(1),R(2))=k;
        ocuw(obstacle(1,i),obstacle(2,i),:)=[140/255 140/255 140/255];
        camino(obstacle(1,i),obstacle(2,i))=-3;
        LGHF(obstacle(1,i),obstacle(2,i),:)=-3;
    else
        continue;
    end   

    for j=1:8
        Ra=R+delta(:,j);

        if(R(1)==1 || R(1)==size_grid_x || R(2)==1 || R(2)==size_grid_y)
            if(Ra(1,1)<1 || Ra(1,1)>size_grid_x) %Se analiza si la coordenada está dento del espacio de trabajo
                continue;
            end
    
            if(Ra(2,1)<1 || Ra(2,1)>size_grid_y) %Se analiza si la coordenada está dento del espacio de trabajo
                continue;
            end
        end

        if(Ra(1)~=start(1,1) || Ra(2)~=start(2,1))
            if(Ra(1)~=goal(1,1) || Ra(2)~=goal(2,1))

                [~,colum]=find(obstacle(1,:)==Ra(1) & obstacle(2,:)==Ra(2));

                if(isempty(colum))
                    i=i+1;
                    obstacle(:,i)=Ra;
                    obs(Ra(1),Ra(2))=k;
                    ocuw(obstacle(1,i),obstacle(2,i),:)=[140/255 140/255 140/255];
                    camino(obstacle(1,i),obstacle(2,i))=-3;
                    LGHF(obstacle(1,i),obstacle(2,i),:)=-3;
                end  
        
                if(i==casillas)
                    break
                end
            end
        end
    end
end

imshow(ocuw,'InitialMagnification','fit')

end