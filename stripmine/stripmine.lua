os.loadAPI("stripmine/Schacht.lua")

local function walk()
    local success = false
    while not success do
        turtle.dig()
        success = turtle.forward()
    end
end

local function place_chest_and_fill()
    turtle.select(2)
    data = turtle.getItemDetail()
    if string.match(data["name"], "chest") ~= "chest" then
        print("ERROR NO CHESTS")
        return "ERROR"
    end
    turtle.dig()
    walk()
    turtle.digUp()
    turtle.back()
    turtle.place()
    for i=1, 16 do
        turtle.select(i)
        data = turtle.getItemDetail()
        if not data ~= nil then
            if string.match(data["name"], "chest") ~= "chest" and string.match(data["name"], "coal") ~= "coal" and string.match(data["name"], "torch") ~= "torch" then
                turtle.drop()
            end
        end
    end
end

print("Wenn der erste Block der Abgebaut wird kein cobblestone ist, lege cobbelston in slot1; Tiefe der Seitenschächte: ")
length = tonumber(read())
print("Lege Kisten in Slot 2")
local amount_torches = math.ceil(length/15)
print("Lege ".. amount_torches .." Fackeln in slot 16" )

print("Anzahl Seitenschächte pro Seite:")
local schaechte = tonumber(read())

local function turtle_back_to_start(length)
    fuellevel = turtle.getFuelLevel()
        if fuellevel < 10 then
            Schacht.refuel()
        end
    turtle.turnLeft()
    turtle.turnLeft()
    for i2=1, length do
        if turtle.detect() then
            turtle.dig()
        end   
        walk()
    end
end

function chest()
    turtle.back()
    turtle.turnRight()
    place_chest_and_fill()
    turtle.turnLeft()
    turtle.forward()
end

for i=1, schaechte do
    turtle.turnLeft()
    Schacht.schacht(length)
    turtle_back_to_start(length)
    chest()
    Schacht.schacht(length)
    turtle_back_to_start(length)
    chest()
    turtle.turnRight()
    for i=1, 4 do 
        turtle.dig()
        turtle.digUp()
        walk()
    end
end
    



    

