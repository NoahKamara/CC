
local function walk()
    local success = false
    while not success do
        turtle.dig()
        success = turtle.forward()
    end
end

local function place_torche()
    turtle.up()
    turtle.back()
    turtle.turnRight()
    if not turtle.detect() then
        turtle.select(1)
        turtle.place()
    end
    turtle.turnLeft()
    walk()
    turtle.turnRight()
    turtle.turnRight()
    turtle.select(16)
    turtle.place()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.down()
end

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

local function check_ore(success, data)
    if not success then
        return false
    end
    return string.match(data["name"], "ore")
end

local function detect_ore_and_dig()
    for i = 1,2 do
        if i == 1 then
            -- Detect / Dig Down
            local success, data = turtle.inspectDown()
            if check_ore(success, data) then
                turtle.digDown()
            end
        else
            -- Detect / Dig Up
            turtle.up()
            local success, data = turtle.inspectUp()
            if check_ore(success, data) then
                turtle.digUp()
            end
        end
        -- Detect / Dig Right
        turtle.turnRight()
        local success, data = turtle.inspect()
        if check_ore(success, data) then
            turtle.dig()
        end
        turtle.turnLeft()
        -- Detect / Dig Left
        turtle.turnLeft()
        local success, data = turtle.inspect()
        if check_ore(success, data) then
            turtle.dig()
        end
        turtle.turnRight()
    end
    turtle.down()
end



function schacht(length)
    for i=1, length do
        fuellevel = turtle.getFuelLevel()
        if fuellevel < 10 then
            refuel()
        end
        turtle.dig()
        walk()
        turtle.digUp()
        detect_ore_and_dig()
        if i % 10 == 0 then
            place_torche()
        end
    end
end


