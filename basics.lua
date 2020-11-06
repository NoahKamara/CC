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
    steps = steps or #reverseList
    for i=#reverseList, steps-#reverseList, -1 do
        reverseList[i](nil, false)
            table.remove(reverseList,i)
    end
end

function walk(steps, save)
    save = save or true
    steps = steps or 1
    for i=1, steps do
        refuel()
        if save then
            table.insert(reverseList, walkBack)
        end
        local success = turtle.forward()
        while not success do
            turtle.dig()
            success = turtle.forward()
        end
    end
end

function walkUp(steps, save)
    save = save or true
    steps = steps or 1
    for i=1, steps do
        refuel()
        if save then
            table.insert(reverseList, walkDown)
        end
        local success = turtle.up()
        while not success do
            turtle.digUp()
            success = turtle.up()
        end
    end
end

function walkDown(steps,save)
    save = save or true
    steps = steps or 1
    for i=1, steps do
    refuel()
        if save then
    table.insert(reverseList, walkUp)end
        local success = turtle.down()
        while not success do
            turtle.digDown()
            success = turtle.down()
        end
    end
end


function walkBack(steps, save)
    save = save or true
    steps = steps or 1
    for i=1, steps do
        refuel()
        if save then
        table.insert(reverseList, walk)
        end
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

function turnLeft(steps, save)
    save = save or true
    steps = steps or 1
    for i=1, steps do

        if save then
        table.insert(reverseList, turnRight)
        end
        turtle.turnLeft()
        

    end 
end

function turnRight(steps, save)
    save = save or true
    steps = steps or 1
    for i=1, steps do
        if save then
        table.insert(reverseList, turnLeft)
        end
        turtle.turnRight()

    end 
end

return {
    refuel = refuel,
    walk = walk,
    walkUp = walkUp,
    walkDown = walkDown,
    walkBack = walkBack,
    reverse = reverse,
    turnRight = turnRight,
    turnLeft = turnLeft
}