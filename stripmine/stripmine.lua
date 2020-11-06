os.loadAPI("stripmine/Schacht.lua")

function refuel()
    for i=1,16 do
        local data = turtle.getItemDetail(i)
        if data and string.match(data['name'], "coal") then
            turtle.select(i)
            turtle.refuel(15)
            return true
        end
    end
    return false
end

local function walk()
    local success = false
    while not success do
        turtle.dig()
        success = turtle.forward()
    end
end

local function walkup()
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


local function place_chest_and_fill()
    turtle.select(2)
    data = turtle.getItemDetail()
    if string.match(data["name"], "chest") ~= "chest" then
        print("ERROR NO CHESTS")
        return "ERROR"
    end
    turtle.dig()
    turtle.digUp()
    walkup()
    turtle.dig()
    walkdown()
    turtle.place()
    for i=1, 16 do
        turtle.select(i)
        data = turtle.getItemDetail()
        if data ~= nil then
            if string.match(data["name"], "chest") ~= "chest" and string.match(data["name"], "coal") ~= "coal" and string.match(data["name"], "torch") ~= "torch" then
                turtle.drop()
            end
        end
    end
end


-- function zubringer(y_koordinate_start)
--     for i = 1, y_koordinate_start-5 do
--         walkdown()
--     end
-- end


local function turtle_back_to_start(length)
    fuellevel = turtle.getFuelLevel()
        if fuellevel < 10 then
            Schacht.refuel()
        end
    turtle.turnLeft()
    turtle.turnLeft()
    for i2=1, length-1 do
        if turtle.detect() then
            turtle.dig()
        end   
        walk()
    end
end

function chest()
    --turtle.back()
    turtle.turnRight()
    place_chest_and_fill()
    turtle.turnLeft()
    turtle.forward()
end

local function turtle_back_to_top(schaechte, y_koordinate)
    fuellevel = turtle.getFuelLevel()
        if fuellevel < 10 then
            Schacht.refuel()
        end
    turtle.turnLeft()
    turtle.turnLeft()
    for i=1, 4 do 
        walk()
    end
    for i=1, schaechte*2 do
        walk()
    end

    for i = 1 , y_koordinate-5 do
        walkup()
    end
end


print("Wenn der erste Block der Abgebaut wird kein cobblestone ist, lege cobbelston in slot1; Tiefe der Seitenschächte: ")
length = tonumber(read())
print("Lege Kisten in Slot 2")
local amount_torches = math.ceil(length/15)
print("Lege ".. amount_torches .." Fackeln in slot 16" )

print("Anzahl Seitenschächte pro Seite:")
local schaechte = tonumber(read())

print("y-koordinat:")
local y_koordinate = tonumber(read())

--print("Anzahl der Ebenen:")
--local ebene = tonumber(read())


--runter zur mine
for i = 1, y_koordinate-5 do
    walkdown()
end

-- in der mine
for i=1, schaechte do
    turtle.turnLeft()
    Schacht.schacht(length)
    turtle_back_to_start(length)
    chest()
    Schacht.schacht(length)
    turtle_back_to_start(length)
    chest()
    turtle.turnRight()
    turtle.select(16)
    turtle.placeUp()
    for i=1, 4 do 
        turtle.dig()
        turtle.digUp()
        walk()
    end
end

turtle_back_to_top(schaechte, y_koordinate)



    

