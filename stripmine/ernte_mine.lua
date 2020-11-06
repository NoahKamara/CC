function refuel()
    for i=1,16 do
        local data = turtle.getItemDetail(i)
        if data and string.match(data['name'], "coal") then
            turtle.select(i)
            turtle.refuel(5)
            return true
        end
    end
    return false
end



local function walk()
    fuellevel = turtle.getFuelLevel()
        if fuellevel < 10 then
            refuel()
        end
    local success = false
    while not success do
        turtle.dig()
        success = turtle.forward()
    end
end

local function walkup()
    fuellevel = turtle.getFuelLevel()
        if fuellevel < 10 then
            refuel()
        end
    local success = false
    while not success do
        turtle.digUp()
        success = turtle.up()
    end
end

local function walkdown()
    fuellevel = turtle.getFuelLevel()
        if fuellevel < 10 then
            refuel()
        end
    local success = false
    while not success do
        turtle.digDown()
        success = turtle.down()
    end
end

local function zubringer(y_koordinate_start)
    for i = 1 , y_koordinate_start-5 do
        walkdown()
    end
end

local function empty_chest()

    turtle.select(1)
    repeat
        sucked = turtle.suck()
    until not sucked
end

-- dropped items, returned stacks an coal, returned falls wenn ein slot leer war
local function drop_in_storage()
    coal_stacks = 0
    one_empty = false
    for i=1, 16 do
        turtle.select(i)
        data = turtle.getItemDetail()
        if data ~= nil then
            if string.match(data["name"], "coal") ~= "coal" then
                coal_stacks = coal_stacks + 1
                turtle.drop()
            end
        elseif data == nil then 
            one_empty = true
        end
    end
    return coal_stacks, one_empty
end

-- dropped alle stacks an  stein coal bis auf 2 
local function drop_coal(coal_stacks)
    c = coal_stacks
    for i=1, 16 do
        turtle.select(i)
        data = turtle.getItemDetail()
        if data ~= nil then
            if string.match(data["name"], ":coal") == ":coal" and c > 2 then
                c = c - 1
                turtle.drop()
            end
        end
    end
end

local function turtle_back_to_top(schaechte, y_koordinate)
    fuellevel = turtle.getFuelLevel()
        if fuellevel < 10 then
            Schacht.refuel()
        end
    turtle.turnLeft()
    turtle.turnLeft()
    for i=1, schaechte*2+4 do
        walk()
    end

    for i = 1 , y_koordinate-5 do
        walkup()
    end
end


print("Anzahl Seitenschächte pro Seite:")
local schaechte = tonumber(read())

print("y-koordinat:")
local y_koordinate = tonumber(read())


repeat
    for i = 1 , y_koordinate-5 do
        walkdown()
    end

    for i=1, schaechte do
        turtle.turnLeft()
        empty_chest()
        turtle.turnRight()
        walk()
        walk()
        turtle.turnRight()
        empty_chest()
        turtle.turnLeft()
        for i=1, 2 do 
            walk()
        end
    end

    turtle_back_to_top(schaechte, y_koordinate)
    coal_stacks, mine_empty = drop_in_storage()
    drop_coal(coal_stacks)	

    turtle.turnLeft()
    turtle.turnLeft()
until mine_empty