
function refuel()
    for i=1, 16 do
        local data = turtle.getItemDetail(i)
        if data and string.match(data['name'], "coal") then
            turtle.select(i)
            turtle.refuel(2)
            return true
        end
    end
    return false
end

local function walk(length)
    if length == nil then
        length = 1
    end
    for i = 1, length do
        local success = false
        while not success do
            fuellevel = turtle.getFuelLevel()
                if fuellevel < 10 then
                    refuel()
                 end
            turtle.dig()
            success = turtle.forward()
        end
    end
end

function find_item(item_name)
    -- findet ersten Slot des strings "item_name" und waehlt ihn aus

    for i=1, 16 do
        local data = turtle.getItemDetail(i)
        if data and string.match(data["name"], item_name)then
            turtle.select(i)
            return i
        end
        
    end
    return false
end


local function cut_leaves()
    for i = 1 , 4 do
        walk()
        for i = 1, 4 do
            turtle.dig()
            turtle.turnRight()
        end
        turtle.back()
        turtle.turnRight()
    end
end


local function chop_tree()
    h=0
    repeat
        fuellevel = turtle.getFuelLevel()
                if fuellevel < 10 then
                    refuel()
                 end
        cut_leaves()      
        turtle.digUp()
        turtle.up()
        y, data = turtle.inspectUp()
        d = data.name
        if y== false then
            d = "sed"
        end
        h = h + 1
    until not string.match(d, "log")
    for i =1, h do
        turtle.down()
    end
end

local function walk_tree()

    local success, data = turtle.inspect()
    in_tree = true
    fuellevel = turtle.getFuelLevel()
                if fuellevel < 10 then
                    refuel()
                 end
    if success then 
        turtle.dig()
        turtle.forward()
        if  string.match(data.name, "log") == "log" then
            chop_tree()
            turtle.digDown()
            find_item("sapling")
            turtle.placeDown()
            turtle.select(1)
        end
    else 
        turtle.forward()
    end
end


anzahl_baume_quer = 4
anzahl_baume_tiefe = 4
abstand_zw_baumen = 5 --inclusive eigner stamm

if anzahl_baume_tiefe % 2 ~= 0 then
    walk_tree_back = true
end

walk_tree()

for q = 1, anzahl_baume_quer do
    for t = 1 , ((anzahl_baume_tiefe-1)*abstand_zw_baumen) do
        walk_tree()
    end
    if q %2 ~= 0  then
        turtle.turnLeft()
        for a=1, abstand_zw_baumen do
            walk_tree()
        end
        turtle.turnLeft()
    else
        turtle.turnRight()
        for a =1 , abstand_zw_baumen do
            walk_tree()
        end
        turtle.turnRight()
    end
end

if walk_tree_back then
    print("walking back")
    turtle.turnLeft()
    walk()
    turtle.turnLeft()
    walk((anzahl_baume_tiefe-1)*abstand_zw_baumen)
    turtle.turnLeft()
    walk()
    turtle.turnRight()
end

-- walk()
-- turtle.turnLeft()
-- walk(anzahl_baume_quer*abstand_zw_baumen-1)
-- turtle.turnLeft()

    



    