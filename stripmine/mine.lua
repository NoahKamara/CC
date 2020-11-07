os.loadAPI("stripmine/Schacht.lua")
basics = require("basics")
local function place_chest_and_fill()
    coal_stacks = 0
    turtle.select(2)
    data = turtle.getItemDetail()
    if string.match(data["name"], "chest") ~= "chest" then
        print("ERROR NO CHESTS")
        return "ERROR"
    end
    turtle.dig()
    turtle.digUp()
    basics.walkUp()
    turtle.dig()
    basics.walkDown()
    turtle.place()
    for i = 1, 16 do
        turtle.select(i)
        data = turtle.getItemDetail()
        if data ~= nil then
            if string.match(data["name"], "chest") ~= "chest" and
                string.match(data["name"], "coal") ~= "coal" and
                string.match(data["name"], "torch") ~= "torch" then
                turtle.drop()
            elseif string.match(data["name"], "coal") == "coal" then
                coal_stacks = coal_stacks + 1
            end
        end
    end
    return coal_stacks
end

-- function zubringer(y_koordinate_start)
--     for i = 1, y_koordinate_start-5 do
--         basics.walkDown()
--     end
-- end

local function turtle_back_to_start(length)
    fuellevel = turtle.getFuelLevel()
    if fuellevel < 10 then Schacht.refuel() end
    basics.turnLeft()
    basics.turnLeft()
    for i2 = 1, length - 1 do
        if turtle.detect() then turtle.dig() end
        basics.walk()
    end
end

local function drop_coal(coal_stacks)
    c = coal_stacks
    for i = 1, 16 do
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

function chest()
    -- basics.walkBack()
    basics.turnRight()
    coal_stacks = place_chest_and_fill()
    drop_coal(coal_stacks)
    basics.turnLeft()
    basics.forward()
end

local function turtle_back_to_top(schaechte, y_koordinate)
    fuellevel = turtle.getFuelLevel()
    if fuellevel < 10 then Schacht.refuel() end
    basics.turnLeft()
    basics.turnLeft()

    for i = 1, schaechte * 4 + 1 do basics.walk() end
    
    for i = 1, y_koordinate - 5 do basics.walkUp() end
end

print(
    "Wenn der erste Block der Abgebaut wird kein cobblestone ist, lege cobbelston in slot1; Tiefe der Seitenschächte: ")
length = tonumber(read())
print("Lege Kisten in Slot 2")
local amount_torches = math.ceil(length / 15)
print("Lege " .. amount_torches .. " Fackeln in slot 16")

print("Anzahl Seitenschächte pro Seite:")
local schaechte = tonumber(read())

print("y-koordinat:")
local y_koordinate = tonumber(read())

-- print("Anzahl der Ebenen:")
-- local ebene = tonumber(read())

-- runter zur mine
for i = 1, y_koordinate - 5 do basics.walkDown() end
basics.walk()
-- in der mine
for i = 1, schaechte do
    basics.turnLeft()
    Schacht.schacht(length)
    turtle_back_to_start(length)
    chest()
    Schacht.schacht(length)
    turtle_back_to_start(length)
    chest()
    basics.turnRight()

    for i = 1, 4 do
        turtle.dig()
        basics.walk()
        turtle.digUp()
        if i == 2 then
            turtle.select(16)
            turtle.placeUp()
        end
    end
end

turtle_back_to_top(schaechte, y_koordinate)

