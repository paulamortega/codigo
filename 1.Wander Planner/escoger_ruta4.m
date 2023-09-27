function[ocuw,camino,Pa]=escoger_ruta4(Da,Pa,camino,ocuw,Aumento)
        while (true)
            Ra=randi(4); %Escoge un número entero entre 1 y 4 al azar
            x=Da(Ra); %Variable para guardar el valor en el puesto Ra de Da
    
           if (x~=0)
              Pa=Pa+Aumento(Ra,:); % Modifica el paso actual coordenada del vecino = Pa
              camino(Pa(1),Pa(2))=1;% guardamos ruta
              ocuw(Pa(1),Pa(2),:)=[0/255 139/255 0/255];%% pintar rut              
              break
           end
       end
end