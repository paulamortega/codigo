function[Da,Aumento]=expancionnodo8(Pa,X,Y,camino)
        Da=[0,0,0,0,0,0,0,0];
        Aumento=[1,0;-1,0;0,1;0,-1;1,1;-1,1;1,-1;-1,-1];

    for e=1:8%% escoje direcciones de las cuatro posibles
           Paso=Pa+Aumento(e,:);%arriba
           if(Paso(1)<1 || Paso(1)>Y  || Paso(2)<1 || Paso(2)>X || camino(Paso(1),Paso(2))==-3)
              Da(e)=0;
           else
              Da(e)=e;
           end
    end
end