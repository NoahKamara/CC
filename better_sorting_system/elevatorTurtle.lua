
function empty_input_chest()
    while turtle.suck() do end
    inventory = {}
    for i = 2, 16 do
        inventory[i] = {}
        turtle.select(i)
        inventory.i ["count"] = turtle.getItemCount()
        inventory.i ["item"] = turtle.getItemDetail().name    
    end 
    return inventory
end

function drop_in_input_chest()
    for i = 2, 16 do
        turtle.select(i)
        turtle.drop()
    end
end

function to_floor(cur_floor, dest_floor)
    for i=1, math.abs(cur_floor-dest_floor) * hight_of_floor do
        if cur_floor - dest_floor == math.abs(cur_floor - dest_floor) then
            turtle.up()
        elseif cur_floor - dest_floor ~= math.abs(cur_floor - dest_floor) then
            turtle.down()
        end
    end
end

function drop_in_floorturtle(inventory_slots)
    for i = 2, 16 do
        turtle.select(i)
        if i in inventory_slots then
            turtle.drop()
        end
    end
end

function deliver_to_floor(inventory)
    zielebenen = {}
    for i in inventory do
        z1 = 0 
        for en, z in ipairs(zielbenen) do
            if inventory[i].z == z then 
                break
            else 
                z1 = z1 + 1 
            end
        end  
        if z1 == en then 
            table.insert(zielebenen, inventory.i ["z"])
        end
    end
    return zielebenen
end

