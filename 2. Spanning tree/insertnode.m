function[closed]=insertnode(closed,current)
%Agrega en una posición aleatoria el punto actual en la lista close

if(isempty(closed)) %Si la lista closed se encuentra vacia
   closed=current; %Closed toma como primer valor el punto actual
else
   Ra=randi([1,size(closed,2)+1]); %Toma un valor al azar entre 1 y el número tolal de columnas que poseaa la lista closed aumetado en uno
   if(Ra==size(closed,2)+1) %Si el valor aleatorio es igual al número de columnas que posee closed más uno
      closed(:,Ra)=current; %Agraga despues de la última columna el punto actual
   else
       if(Ra==1) %Si el valor de Ra es igual a 1
           closed=[current closed]; %Agrega el punto actual en la primera posición y coloca despues todos los datos que estaban en closed
       else
           closed=[closed(:,1:Ra-1) current closed(:,Ra:end)]; %Posiciona en la columna que se eligió al azar el punto actual sin sobre escribir el resto de las columnas
       end
   end
end

end           