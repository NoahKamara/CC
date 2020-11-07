basics = require("basics")

local function place_torche()
    turtle.up()
    basics.walkBack()
    basics.turnRight()
    if not turtle.detect() then
        turtle.select(1)
        turtle.place()
    end
    basics.turnLeft()
    basics.walk()
    basics.turnRight()
    basics.turnRight()
    turtle.select(16)
    turtle.place()
    basics.turnLeft()
    basics.turnLeft()
    basics.walkDown()
end

local function check_ore(success, data)
    if not success then return false end
    return string.match(data["name"], "ore")
end

local function detect_ore_and_dig()
    for i = 1, 2 do
        if i == 1 then
            -- Detect / Dig Down
            local success, data = turtle.inspectDown()
            if check_ore(success, data) then turtle.digDown() end
        else
            -- Detect / Dig Up
            turtle.up()
            local success, data = turtle.inspectUp()
            if check_ore(success, data) then turtle.digUp() end
        end
        -- Detect / Dig Right
        basics.turnRight()
        local success, data = turtle.inspect()
        if check_ore(success, data) then turtle.dig() end
        basics.turnLeft()
        -- Detect / Dig Left
        basics.turnLeft()
        local success, data = turtle.inspect()
        if check_ore(success, data) then turtle.dig() end
        basics.turnRight()
    end
    basics.walkDown()
end

function schacht(length)
    for i = 1, length do
        fuellevel = turtle.getFuelLevel()
        if fuellevel < 10 then refuel() end
        turtle.dig()
        basics.walk()
        turtle.digUp()
        detect_ore_and_dig()
        if i % 10 == 0 then place_torche() end
    end
end

