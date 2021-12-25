os.loadAPI("basics.lua")

local function place_torche()
    basics.walkUp()
    basics.walkBack()
    basics.turnRight()
    if not turtle.detect() then
        turtle.select(1)
        turtle.place()
    end
    basics.turnLeft()
    basics.walk()
    basics.turnRight(2)
    turtle.select(3)
    turtle.place()
    basics.turnLeft(2)
    basics.walkDown()
end

local function check_ore(success, data)
    if not success then return false end
    if string.match(data["name"], "core") then return string.match(data["name"], "core") end
    if string.match(data["name"], "ic2") then return string.match(data["name"], "ic2") end
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
            basics.walkUp()
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
        basics.walk()
        detect_ore_and_dig()
        if (i+5) % 10 == 0 then place_torche() end
    end
end

