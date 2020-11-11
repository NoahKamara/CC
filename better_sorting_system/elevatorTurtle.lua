
function empty_input_chest()
    for i = 2, 16 do
        turtle.select(i)
        turtle.suck()
    end
end

function drop_in_input_chest()
    for i = 2, 16 do
        turtle.select(i)
        turtle.suck()
    end
end

function to_floor(cur_floor, dest_floor)
    for i=1, math.abs(cur_floor-dest_floor) * hight_of_floor do
        if cur_floor-dest_floor == math.abs(cur_floor-dest_floor) then
            turtle.up()
        elseif cur_floor-dest_floor ~= math.abs(cur_floor-dest_floor) then
            turtle.down()
        end
    end
end

function drop_in_floorturtle(inventory_slots)
    for i in invertory_slots do
        turtle.select(i)
        turtle.drop()
    end
end

cur_floor = 0
hight_of_floor = 1
