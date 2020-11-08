os.loadAPI("basics.lua")

local function refuel()
    for i = 1, 16 do
        local data = turtle.getItemDetail(i)
        if data and string.match(data['name'], "coal") then
            turtle.select(i)
            turtle.refuel(10)
            return true
        end
    end
    return false
end

local function plantSeed()
    for i = 1, 16 do
        local data = turtle.getItemDetail(i)
        if data and string.match(data['name'], "minecraft:wheat") then
            turtle.select(i)
            turtle.placeDown()
            return true
        end
    end
    print("NO SEEDS IN INVENTORY")
    return false
end

local function checkAndGo()
    local success, data = turtle.inspectDown()
    if success then
        if data["state"]["age"] == 7 then
            turtle.digDown()
            plantSeed()
        end
    else
        turtle.digDown()
        plantSeed()
    end
    basics.walk()
end

local function run(size)
    basics.walk()

    for x = 1, size do
        for y = 1, size - 1 do
            print("X: ", x, "Y: ", y)
            checkAndGo()
        end
        if x < size then
            if (x % 2 == 1) then
                basics.turnRight()
                checkAndGo()
                basics.turnRight()
            else
                basics.turnLeft()
                checkAndGo()
                basics.turnLeft()
            end
        end
    end
    if (size % 2 == 1) then
        basics.turnRight()
        basics.turnRight()
        for y = 1, size - 1 do basics.walk() end
    end
    basics.turnRight()

    for y = 1, size - 1 do basics.walk() end

    basics.turnRight()
    basics.walkBack()
end

local function getFieldSize()
    if fs.exists("farm.cfg") then
        local file = fs.open("farm.cfg", "r")
        local content = file.readAll()
        file.close()
        local cfg = textutils.unserialise(content)
        if cfg then return tonumber(cfg.size) end
    end
    print("FIELD SIZE: ")
    local file = fs.open("farm.cfg", "w")
    file.write(textutils.serialize({size = tonumber(read())}))
    file.close()
end

local function place_in_chest()
    seed_slots = 0
    for i = 1, 16 do
        turtle.select(i)
        data = turtle.getItemDetail()
        if data ~= nil then
            if not string.match(data["name"], "seed") and
                not string.match(data["name"], "coal") then -- string.match(data["name"], ":wheat") and not string.match(data["name"], "seed") then
                turtle.dropDown()
            end
            if string.match(data["name"], "seed") then
                seed_slots = seed_slots + 1
                if seed_slots > 2 then turtle.drop() end
            end
        end
    end
end

local size = getFieldSize()
while true do
    term.clear()
    term.setCursorPos(1, 1)
    print("REFUELING")
    refuel()
    print("CHECKING CROPS")
    run(size)
    place_in_chest()
    print("SLEEPING (60s)")
    os.sleep(60 * 13)
end
