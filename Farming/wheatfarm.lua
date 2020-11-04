
local function refuel()
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

local function walk()
    local success = turtle.forward()
    while not success do
        print("CANT MOVE FORWARD")
        success = turtle.forward()
    end
end

local function plantSeed()
    for i=1,16 do
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
    walk()
end



local function run(size)
    walk()

    for x=1,size do
        
        for y=1,size-1 do
            print("X: ", x, "Y: ", y)
            checkAndGo()
        end
        if x < size then
            if (x % 2 == 1) then
                turtle.turnRight()
                checkAndGo()
                turtle.turnRight()
            else
                turtle.turnLeft()
                checkAndGo()
                turtle.turnLeft()
            end
        end
    end
    turtle.turnRight()

    for y=1, size-1 do
        walk()
    end

    turtle.turnRight()
    turtle.back()
end


local function getFieldSize()
    if fs.exists("farm.cfg") then
        local file = fs.open("farm.cfg", "r")
        local content = file.readAll()
        file.close()
        local cfg = textutils.unserialise(content)
        if cfg then
            return tonumber(cfg.size)
        end
    end
    print("FIELD SIZE: ")
    local file = fs.open("farm.cfg", "w")
    file.write(textutils.serialize({size = tonumber(read())}))
    file.close()
end


local size = getFieldSize()
while true do
    term.clear()
    term.setCursorPos(1,1)
    print("REFUELING")
    refuel()
    print("CHECKING CROPS")
    run(size)
    print("SLEEPING (60s)")
    os.sleep(60)
end
