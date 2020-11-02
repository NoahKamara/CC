

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
    turtle.turnRight()
    for i = 1, math.floor(breite/2) do
        walk()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    --start
    for t=1, tiefe do
        for h = 1, hoehe do
            for b = 1, breite do
                walk()
            end      
            walkup()
            turtle.turnLeft()
            turtle.turnLeft()
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
