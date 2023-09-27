%compares two keys and defines if the first one is less than the second one
function less=compareKeyLess(key1,key2)

if(key1(1)<key2(1)) %Si la F de current es menor a la F del goal
    less=1;
else
    if(key1(1)==key2(1) && key1(2)<key2(2)) %Si la F de current es igual a la F del goal y la g de current es menor a la g del goal
        less=1;
    else
        less=0;
    end
end

end