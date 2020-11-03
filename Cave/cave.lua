
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
    local success = false
    while not success do
        turtle.digDown()
        success = turtle.down()
    end
end

function dig(hoehe, breite, tiefe)
    -- get to startposition
    fuellevel = turtle.getFuelLevel()
    if fuellevel < 20 then
        refuel()
    end
    turtle.turnRight()
    for i = 1, math.floor(breite/2) do
        walk()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    --start
    for t=1, tiefe do
        for h = 1, hoehe do
            for b = 2, breite do
                walk()
                fuellevel = turtle.getFuelLevel()
                if fuellevel < 10 then
                    refuel()
                 end
            end
            turtle.turnLeft()
            turtle.turnLeft()
            if h < hoehe then
                walkup()
            end
        end
        for x = 1, hoehe do
            walkdown()
        end
        if t < tiefe then
            turtle.turnRight()
            walk()
            turtle.turnLeft()
        end
    end

end

print("hoehe: ")
hoehe = tonumber(read())

print("breite: ")
breite = tonumber(read())

print("tiefe: ")
tiefe = tonumber(read())

dig(hoehe, breite, tiefe)
