function[additional_cost, LGHF, cost_vector, ocuw]=Cost_A(size_grid_x,size_grid_y,percentage_cost, start, goal, obstacle, ocuw, LGHF)

i=0;
cost_vector=[0;0];
additional_cost=zeros(size_grid_x,size_grid_y);

casillas=round(((size_grid_x*size_grid_y)/100)*percentage_cost);

while(i~=casillas)
    
    R=[randi(size_grid_x);randi(size_grid_y)];
    
    if(R(1)==start(1,1) && R(2)==start(2,1))
        continue
    end

    if(R(1)==goal(1,1) && R(2)==goal(2,1))
        continue
    end

    [~,colum1]=find(cost_vector(1,:)==R(1) & cost_vector(2,:)==R(2));
    [~,colum2]=find(obstacle(1,:)==R(1) & obstacle(2,:)==R(2));

    if(isempty(colum1) && isempty(colum2))
        i=i+1;
        cost_vector(:,i)=R;
        g=randi([1,5])*10;
        additional_cost(R(1),R(2))=g;
        LGHF(R(1),R(2),2)=g;
        ocuw(R(1),R(2),:)=[0/255 0/255 255/255];
    end   

end

imshow(ocuw,'InitialMagnification','fit')

end