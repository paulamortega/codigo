function spanningTree()
close all;
clear all;
clc;

%grid size
size_grid_x=5;
size_grid_y=4;

%start node
start(1,1)=4;
start(2,1)=1;
start(3,1)=inf;
start(4,1)=inf;

%goal node
goal(1,1)=2;
goal(2,1)=5;
goal(3,1)=inf;
goal(4,1)=inf;

%building of the grid
OcuW(1:size_grid_y,1:size_grid_x,1:3)=ones(size_grid_y,size_grid_x,3);
OcuW(4,3,:)=[0,0,0];%obstacle
OcuW(3,2:3,:)=zeros(1,2,3);%obstacle
OcuW(start(1,1),start(2,1),:)=[0 0 1];%start
OcuW(goal(1,1),goal(2,1),:)=[0 0 1];%goal
figure, imshow(OcuW,'InitialMagnification','fit')
hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
success=0;

open(:,1)=start;
closed=[];

while(size(open,2)~=0 && success==0)
    random_position=createrandomposition(length_list);%longitud de open
    [open, current]=removenode(open,random_position);
    random_position=createrandomposition(length_list); %longitud de close
    [closed]=insertnode(closed,random_position); %%falta insertar x en una posición al azar
    [open, closed,success]=spandNodeST(current, open, closed, goal, success, size_grid_y, size_grid_x);
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [open, closed,success]=spandNodeST(current, open, closed, goal, success, size_grid_y, size_grid_x)
delta=[-1 0; 0 -1; +1 0; 0 +1];
for i=1:1:4
    xnext(1,1)=current(1,1)+delta(i,1);
    xnext(2,1)=current(2,1)+delta(i,2);
    if(xnext(1,1)<1 || xnext(1,1) > size_grid_y)
        continue;
    end
    if(xnext(2,1)<1 || xnext(2,1) > size_grid_x)
        continue;
    end
    if(xnext(1,1)==goal(1,1) && xnext(2,1)==goal(2,1))
        xnext(3,1)=current(3,1);
        xnext(4,1)=current(4,1);
        success=1;
        break;
    else
        if(isinlist(xnext,open)==false && isinlist(next,close)==false)%% falta verificar que xnext no esté en open ni en closed
            xnext(3,1)=current(3,1);
            xnext(4,1)=current(4,1);
            random_position=createrandomposition(length_list);
            [open]=insertnode(open,random_position); %%falta insertar xnext al azar en la lista open
        end
    end
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function randomNeighbor=getRandomNeighbor(node, size_grid_x,size_grid_y)
px=randi(3,1,1)-2;
|=node.x+px
while(randomNeighbor.x<1 || randomNeighbor.x>size_grid_x)
    px=randi(3,1,1)-2;
    randomNeighbor.x=node.x+px
end
py=randi(3,1,1)-2;
randomNeighbor.y=node.y+py
while(randomNeighbor.y<1 || randomNeighbor.y>size_grid_y || (px==0 && py==0))
    py=randi(3,1,1)-2;
    randomNeighbor.y=node.y+py
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function isinthelist=isinlist(node,list)
[~, v]=find(list(1,:)==node(1,1) & list(2,:)==node(2,1))
if(isempty(v))
    isinthelist=false;
else
    isinthelist=true;
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%