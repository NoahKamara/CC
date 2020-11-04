
CFG = require("Config")
OpQueue = require("OperationsQueue")
NAV = require("Navigation")

local storage = CFG.load("config/storage.cfg")
local limits = CFG.load("config/limits.cfg")

local function getInventory()
    local content = {}
    for i=1,16 do
        turtle.select(i)
        local data = turtle.getItemDetail()
        if data then
            table.insert(content, {count = data.count, item = data.name})
        end
    end
    return content
end

storage["minecraft:stone"] = 
{
    amount = 0,
    location = {
        x = 0,
        y = 0,
        z = 0
    }
}



local function makeInventoryQueue()
    local content = getInventory()
    for i, v in pairs(content) do
        OpQueue.add("PUT " .. v.item .. " " .. v.count)
    end
end

local function insertIntoChest(item_name, pos)
    for i=1, 16 do
        local data = turtle.getItemDetail(i)
        if data and string.match(data.name, item_name)then
            turtle.select(i)
            if pos == "UP" then
                turtle.dropUp()
            else
                turtle.dropDown()
            end
        end
        
    end
end


local function execute(operation)
    local split = Utility.split(operation, " ")
    local cmd = split[1]
    local d1 = split[2]
    local d2 = split[3]
    if cmd == "ADDCHEST" then
        NAV.goTo({x=0, y=0, z=0})
        -- retrieve chest to place
    elseif cmd == "PUT" then
        if not Utility.contains(storage, d2) then
            OpQueue.addPriority("ADDCHEST " .. d2)
        end
        for i, v in pairs(storage[d2].chests) do
            if v.count < 27*64 then
                NAV.goTo(v.location)
                insertIntoChest(d2, v.location.pos)
            end
        end
    elseif cmd == "GET" then
        print("GET", d1, d2)
    end
end

term.clear()
term.setCursorPos(1,1)

makeInventoryQueue()

local queueEmpty = OpQueue.isEmpty()
while not queueEmpty do
    local op = OpQueue.pop()
    local success = execute(op)
    queueEmpty = OpQueue.isEmpty()
end
-- local c = Utility.contains(storage, content[0])
-- print(c)
-- content = getInventory()



