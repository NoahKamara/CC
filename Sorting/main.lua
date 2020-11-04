
CFG = require("Config")

local storage = CFG.load("config/storage.cfg")
local limits = CFG.load("config/limits.cfg")

local function getInventory()
    local content = {}
    for i=1,16 do
        turtle.select(i)
        data = turtle.getItemDetail()
        if data then
            table.insert(content, {count = data.count, item = data.name})
        end
    end
    return content
end

local function contains(table, item)
    for i, v in pairs(table) do 
        print(i, v)
    end
end

local content = getInventory()
contains(storage, content[0])
-- content = getInventory()



