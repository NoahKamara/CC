local function walk(length)
    if length == nil then
        length = 1
    end
    for i, lenght do
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

function refuel()
    for i=1,16 do
        local data = turtle.getItemDetail(i)
        if data and string.match(data['name'], "coal") then
            turtle.select(i)
            turtle.refuel(2)
            return true
        end
    end
    return false
end

function find_item(item_name)
    -- findet ersten Slot des strings "item_name" und waehlt ihn aus

    for i=1,16 do
        local data = turtle.getItemDetail(i)
        if data and string.match(data['name'], item_name) == item_name then
            turtle.select(i)
            return i
        end
        return false
    end
end


local function walk_tree_tree()

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
        end
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
        h += 1
    until  string.match(data.name, wood) ~= wood
    for i, h do
        turtle.down()
    end
end

local function cut_leaves()
    for i, 4 do
        turtle.dig()
        turtle.forward()
        for i, 4 do
            turtle.dig()
            turtle.turnRight()
        end
        turtle.dig()
        turtle.back()
        turtle.turnRight()
    end
end

anzahl_baume_quer =
anzahl_baume_tiefe =
abstand_zw_baumen = --inclusive eigner stamm

if anzahl_baume_tiefe % 2 == 0 then
    walk_tree_back == true
end

for q, anzahl_baume_quer-1 do
    for t, anzahl_baume_tiefe-1*abstand_zw_baumen do
        walk_tree()
    end
    if q %2 ~= 0  then
        turtle.turnLeft()
        for a, abstand_zw_baumen do
            walk_tree()
        end
        turtle.turnLeft()
    else
        turtle.turnRight()
        for a, abstand_zw_baumen do
            walk_tree()
        end
        turtle.turnRight()
    end
end

if walk_tree_back then
    turtle.turnLeft()
    walk()
    turtle.turnLeft()
    walk((anzahl_baume_tiefe-1)*abstand_zw_baumen)
    turtle.turnLeft()
    walk()
    turtle.turnRight()
end

walk()
turtle.turnLeft()
walk(anzahl_baume_breite*abstand_zw_baumen-1)
turtle.turnLeft()
walk()
    



    