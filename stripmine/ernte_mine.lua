os.loadAPI("basics.lua")

local function zubringer(y_koordinate_start)
    for i = 1, y_koordinate_start - 5 do basics.walkDown() end
end

local function empty_chest()

    turtle.select(1)
    repeat sucked = turtle.suck() until not sucked
end

-- dropped items, returned stacks an coal, returned falls wenn ein slot leer war
function drop_in_storage()
    coal_stacks = 0
    one_empty = false
    for i = 1, 16 do
        turtle.select(i)
        data = turtle.getItemDetail()
        if data ~= nil then
            if string.match(data["name"], "coal") ~= "coal" then
                turtle.drop()
            elseif string.match(data["name"], "coal") == "coal" then
                coal_stacks = coal_stacks + 1
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
    for i = 16, 1, -1 do
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

local function turtle_back_to_top(schaechte, y_koordinate, versch)
    fuellevel = turtle.getFuelLevel()
    if fuellevel < 10 then Schacht.refuel() end
    basics.turnLeft(2)

    while basics.walkUp() == "turtle" do
        os.sleep(3)
    end 

    for i = 1, schaechte * 4 - 2 do basics.walk() end

    for i=1, versch do
        while basics.walk() == "turtle" do
            os.sleep(3)
        end
    end

    for i = 1, y_koordinate - 6 do basics.walkUp() end
end

-- print("Anzahl Seitenschächte pro Seite:")
-- local schaechte = tonumber(read())

-- print("y-koordinat:")
-- local y_koordinate = tonumber(read())

function ernte(schaechte, y_koordinate, versch)
    repeat
        for i = 1, y_koordinate - 5 do
            while basics.walkDown() == "turtle" do
                os.sleep(3)
            end  
        end

        for i=1, versch do
            while basics.walk() == "turtle" do
                os.sleep(3)
            end
        end

        basics.walkBack()
        for i = 1, schaechte do
            basics.turnLeft()
            empty_chest()
            basics.turnRight()
            for i2=1, 2 do
                while basics.walk() == "turtle" do
                    os.sleep(3)
                end
            end
            basics.turnRight()
            empty_chest()
            basics.turnLeft()
            for i = 1, 2 do basics.walk() end
        end

        turtle_back_to_top(schaechte, y_koordinate, versch)
        basics.walk()
        basics.turnLeft()
        coal_stacks, mine_empty = drop_in_storage()
        drop_coal(coal_stacks)
        basics.turnLeft()
    until mine_empty
end
