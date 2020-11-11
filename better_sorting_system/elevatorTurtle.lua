
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

function deliver(inventory)
    for 
        to_floor(cur_floor, inventory["z"])




cur_floor = 0
hight_of_floor = 1
