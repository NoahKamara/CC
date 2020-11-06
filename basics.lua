-- How to use: basics = require("basics")
local function refuel()
    for i=1,16 do
        local data = turtle.getItemDetail(i)
        if data and string.match(data['name'], "coal") then
            turtle.select(i)
            turtle.refuel(2)
            return true
        end
    end
    return false
end

local function walk()
    refuel()
    local success = turtle.forward()
    while not success do
        turtle.dig()
        success = turtle.forward()
    end
end

local function walkUp()
    refuel()
    local success = turtle.up()
    while not success do
        turtle.digUp()
        success = turtle.up()
    end
end

local function walkDown()
    refuel()
    local success = turtle.down()
    while not success do
        turtle.digDown()
        success = turtle.down()
    end
end


local function walkBack()
    refuel()
    local success = turtle.back()
    while not success do
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.dig()
        turtle.turnLeft()
        turtle.turnLeft()
        success = turtle.back()
    end
end
return {
    refuel = refuel,
    walk = walk,
    walkUp = walkUp,
    walkDown = walkDown,
    walkBack = walkBack
}