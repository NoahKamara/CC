function getMaxItemsInChest()
    return (turtle.getItemCount() + turtle.getItemSpace()) * 24
end

function fillChest(count)
    while count ~= 0 do
        for i = 2, 16 do
            turtle.select(i)
            countItemSlot = turtle.getItemCount()
            if countItemSlot > count then break end
            count = count - countItemSlot
            turtle.dropDown()
        end
    end
    turtle.dropDown(count)
end

