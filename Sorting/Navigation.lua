CFG = require("Config")

-- Moves turtle forward
local function forward()
    local success = turtle.forward()
    while not success do
        print("CANT MOVE FORWARD")
        success = turtle.forward()
    end
end

-- Moves turtle up
local function up()
    local success = turtle.up()
    while not success do
        print("CANT MOVE UP")
        success = turtle.up()
    end
end

-- Moves turtle down
local function down()
    local success = turtle.down()
    while not success do
        print("CANT MOVE DOWN")
        success = turtle.down()
    end
end

local NAV = {}

-- Retrieves Location from persistence
function NAV.getLocation()
    local location = CFG.load('config/location.cfg')
    if not location then return {x = 0, y = 0, z = 0, facing = "y"} end
    return location
end

-- Saves Location to persistence
function NAV.setLocation(location)
    return CFG.save(location, 'config/location.cfg')
end

-- Turns the turtle to the given side
-- side (str): Side
function NAV.turnTo(side)

    local loc = NAV.getLocation()

    if (loc.facing == side) then return loc end

    local turning = true
    while turning do
        basics.turnRight()
        local old = loc.facing
        if loc.facing == "y" then
            loc.facing = "x"
        elseif loc.facing == "x" then
            loc.facing = "-y"
        elseif loc.facing == "-y" then
            loc.facing = "-x"
        elseif loc.facing == "-x" then
            loc.facing = "y"
        end
        turning = (side ~= loc.facing)
    end
    NAV.setLocation(loc)
    return loc
end

-- Moves the turtle to the given Z coordinate
-- z (int): z-coordinate
function NAV.goToZ(z)
    local loc = NAV.getLocation()
    if loc.z == z then return end
    NAV.goToX(0)
    NAV.goToY(0)

    local loc = NAV.getLocation()

    for i = 1, math.abs(loc.z - z) do
        local op = down
        local dir = 0
        if z > loc.z then
            op = up
            dir = 1
        else
            op = down
            dir = -1
        end
        op()
        loc.z = loc.z + 1 / 2 * dir
        op()
        op()
        loc.z = loc.z + 1 / 2 * dir
        NAV.setLocation(loc)
    end
end

-- Moves the turtle to the given X coordinate
-- x (int): x-coordinate
function NAV.goToX(x)
    local loc = NAV.getLocation()
    if not (loc.x == x) then
        local dir = 0
        if x > loc.x then
            dir = 1
            loc = NAV.turnTo("x")
        else
            dir = -1
            loc = NAV.turnTo("-x")
        end
        for i = 1, math.abs(loc.x - x) do
            forward()
            loc.x = loc.x + dir
            NAV.setLocation(loc)
        end
    end
    NAV.setLocation(loc)
end

-- Moves the turtle to the given Y coordinate
-- y (int): y-coordinate
function NAV.goToY(y)
    local loc = NAV.getLocation()
    if not (loc.y == y) then
        local dir = 0
        if y > loc.y then
            dir = 1
            loc = NAV.turnTo("y")
            for i = 1, math.abs(loc.y - y) do
                forward()
                loc.y = loc.y + dir
                NAV.setLocation(loc)
            end
        else
            dir = -1
            loc = NAV.turnTo("-y")
            for i = 1, math.abs(loc.y - y) do
                forward()
                loc.y = loc.y + dir
                NAV.setLocation(loc)
            end
        end
    end
    NAV.setLocation(loc)
end

-- Moves the turtle to the given Location
-- location (table): location containing coordinates
function NAV.goTo(location)
    if not (location.x and location.y and location.z) then
        print("ERROR MISSING COORDINATES")
        return false
    end
    NAV.goToZ(location.z)
    NAV.goToX(location.x)
    NAV.goToY(location.y)
    return true
end

return NAV
