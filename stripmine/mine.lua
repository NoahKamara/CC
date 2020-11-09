os.loadAPI("stripmine/Schacht.lua")
os.loadAPI("stripmine/ernte_mine.lua")
os.loadAPI("basics.lua")

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


local function turtle_back_to_start(length)
    fuellevel = turtle.getFuelLevel()
    if fuellevel < 10 then Schacht.refuel() end
    basics.turnLeft(2)
    for i2 = 1, length - 1 do
        --if turtle.detect() then turtle.dig() end
        while basics.walk() == "turtle" do
            os.sleep(3)
        end
    end
end

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

function chest()
    basics.turnRight()
    coal_stacks = place_chest_and_fill()
    drop_coal(coal_stacks)
    basics.turnLeft()
    while basics.walk() == "turtle" do
        os.sleep(3)
    end
end

local function turtle_back_to_top(schaechte, y_koordinate)
    fuellevel = turtle.getFuelLevel()
    if fuellevel < 10 then Schacht.refuel() end
    basics.turnLeft()
    basics.turnLeft()
    basics.walkUp()
    for i = 1, schaechte * 4 - 1 do
        while basics.walk() == "turtle" do
            os.sleep(3)
        end 
    end

    for i = 1, y_koordinate - 6 do basics.walkUp() end
end

print(
    "Wenn der erste Block der Abgebaut wird kein cobblestone ist, lege cobbelston in slot1; Tiefe der Seitenschächte: ")
length = tonumber(read())

print("Anzahl Seitenschächte pro Seite:")
local schaechte = tonumber(read())

local ammount_chests = (schaechte * 2)
print("Lege " .. ammount_chests .. " Kisten in Slot 2")

local amount_torches = math.floor(length + 5 / 10)
print("Lege " .. amount_torches .. " Fackeln in slot 16")

print("y-koordinat:")
local y_koordinate = tonumber(read())

print("Anzahl der Verschiebung (normla 2):")
local versch = tonumber(read())


print("Turtel gesammtanzahl:")
local anzahl_turtle = tonumber(read())

print("Turtel Nummer:")
local turtle_nummer = tonumber(read())


-- runter zur mine
for i = 1, y_koordinate - 5 do basics.walkDown() end

for i=1, versch do
    while basics.walk() == "turtle" do
        os.sleep(3)
    end
end

-- in der mine
for i = 1, schaechte do

    if (i - turtle_nummer) % anzahl_turtle == 0 then 
        basics.turnLeft()
        Schacht.schacht(length)
        turtle_back_to_start(length)
        chest()
        Schacht.schacht(length)
        turtle_back_to_start(length)
        chest()
        basics.turnRight()
    end

    for i = 1, 4 do
        while basics.walk() == "turtle" do
            os.sleep(3)
        end
    end
end

turtle_back_to_top(schaechte, y_koordinate)


while basics.walk() == "turtle" do
    os.sleep(3)
end
basics.turnLeft()

coal_stacks, mine_empty = ernte_mine.drop_in_storage()
drop_coal(coal_stacks)

if turtle.digDown() then
    ernte_mine.drop_in_storage()
end

basics.turnLeft()

if turtle_nummer == 1 then
    ernte_mine.ernte(schaechte, y_koordinate)
end
