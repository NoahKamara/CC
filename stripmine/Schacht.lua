os.loadAPI("basics.lua")

local function place_torche()
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
end

local function check_ore(success, data)
    if not success then return false end
    if string.match(data["name"], "core") then return string.match(data["name"], "core") end
    if string.match(data["name"], "ic2") then return string.match(data["name"], "ic2") end
    return string.match(data["name"], "ore")
end

local function detect_ore_and_dig(direction)
    if direction == "up" then
        -- Detect / Dig Down
        local success, data = turtle.inspectDown()
        if check_ore(success, data) then turtle.digDown() end
    else
        -- Detect / Dig Up
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


function schacht(length)
    for i = 1, length do
        basics.walk()
        if i % 2 ~= 0 then
            detect_ore_and_dig("down")
            basics.walkUp()
            detect_ore_and_dig("up")
        elseif i % 2 ==0 then 
            detect_ore_and_dig("up")
            basics.walkDown()
            detect_ore_and_dig("down")
        end
        if (i+5) % 10 == 0 then place_torche() end  
    end
    if length % 2 ~= 0 then
        basics.walkDown()
    end
end
