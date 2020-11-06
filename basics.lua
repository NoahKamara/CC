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

reverseList = {}

local function reverse(steps)
    steps = steps or table.getn(reverseList)
    for i=table.getn(reverseList), steps, -1 do
        reverseList[i]()
        table.remove(reverseList,i)
    end
end
function walk(steps)
    table.insert(reverseList, walkBack)
    steps = steps or 1
    for i=1, steps do
        refuel()
        local success = turtle.forward()
        while not success do
            turtle.dig()
            success = turtle.forward()
        end
    end
end

function walkUp(steps)
    table.insert(reverseList, walkDown)
    steps = steps or 1
    for i=1, steps do
        refuel()
        local success = turtle.up()
        while not success do
            turtle.digUp()
            success = turtle.up()
        end
    end
end

function walkDown(steps)
    table.insert(reverseList, walkUp)
    steps = steps or 1
    for i=1, steps do
    refuel()
        local success = turtle.down()
        while not success do
            turtle.digDown()
            success = turtle.down()
        end
    end
end


function walkBack(steps)
    table.insert(reverseList, walk)
    steps = steps or 1
    for i=1, steps do
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
end

return {
    refuel = refuel,
    walk = walk,
    walkUp = walkUp,
    walkDown = walkDown,
    walkBack = walkBack,
    reverse = reverse,
}