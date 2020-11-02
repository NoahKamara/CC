os.loadAPI("stripmine/Schacht.lua")

local function walk()
    local success = false
    while not success do
        turtle.dig()
        success = turtle.forward()
    end
end


print("Wenn der erste Block der Abgebaut wird kein cobblestone ist, lege cobbelston in slot1; Tiefe der Seitenschächte: ")
length = tonumber(read())

local amount_torches = math.ceil(length/15)
print("Lege ".. amount_torches .." Fackeln in slot 16" )

print("Anzahl Seitenschächte pro Seite:")
local schaechte = tonumber(read())

function turtle_back_to_start(length)
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

for i=1, schaechte do
    turtle.turnLeft()
    Schacht.schacht(length)
    turtle_back_to_start(length)
    Schacht.schacht(length)
    turtle_back_to_start(length)
    turtle.turnRight()
    for i3=1, 3 do 
        turtle.dig()
        walk()
    end
end
    



    

