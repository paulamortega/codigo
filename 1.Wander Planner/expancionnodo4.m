function[Da,Aumento]=expancionnodo4(Pa,X,Y,camino)
        Da=[0,0,0,0]; %Open y Close
        Aumento=[1,0;-1,0;0,1;0,-1];

    for e=1:4 %% escoje direcciones de las cuatro posibles
           Paso=Pa+Aumento(e,:);
           if(Paso(1)<1 || Paso(1)>Y  || Paso(2)<1 || Paso(2)>X || camino(Paso(1),Paso(2))==-3)%validacion de que esté disponible
              Da(e)=0;
           else
              Da(e)=e;
           end
    end
end