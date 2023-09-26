function[ocuw,camino,Pa]=escoger_ruta8(Da,Pa,camino,ocuw,Aumento,a)
        while (true)
            Ra=randi(8); %Escoge un número entero entre 1 y 4 al azar
            x=Da(Ra); 
    
           if (x~=0)
              Pa=Pa+Aumento(Ra,:); % Modifica el paso actual
              camino(Pa(1),Pa(2))=a;% guardamos ruta
              ocuw(Pa(1),Pa(2),:)=[0/255 139/255 0/255];%% pintar rut              
              break
           end
       end
end