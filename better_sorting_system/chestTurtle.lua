function getMaxItemsInChest()
    return (turtle.getItemCount() + turtle.getItemSpace()) * 24
end

function fillChest(count)
    break_condition = true
    while count ~= 0 and break_condition do
        for i = 2, 16 do
            turtle.select(i)
            countItemSlot = turtle.getItemCount()
            if countItemSlot > count then
                break_condition = false
                break
            end
            count = count - countItemSlot
            turtle.dropDown()
        end
        if break_condition then
            print("Error chest has less items than count")
            return 0
        end
    end
    turtle.dropDown(count)
end

