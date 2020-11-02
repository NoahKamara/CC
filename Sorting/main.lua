Utility = require("Utility")
Config = require("Config")
OpQueue = require("OperationsQueue")


-- local storage = Config.load("config/storage.cfg")
-- local location = Config.load("config/location.cfg")
-- local config = Config.load("config/config.cfg")

-- Executes an operation
-- operation (str): An Operation
local function execute(operation)
    local op = Utility.split(operation, "\n")
    op = {
        cmd = op[1],
        args = { unpack( op, 2, table.getn(op)) }
    }
    if op.cmd == "PUT" then
        print("PUT", textutils.serialise(op.args))
    elseif op.cmd == "GET" then
        print("GET", textutils.serialise(op.args))
    else
        print("INVALID OPERATION")
    end
end


-- Checks fuellevel, returns true if fuel is sufficient
local function checkFuel() 
    print("CHECKING FUELLEVEL")
end


-- Checks the queue for operations
-- - if th queue is empty, returns
-- - if the queue is not empty, executes operation
local function checkQueue()
    if OpQueue.isEmpty then
        print("OPQUEUE EMPTY")
        return false
    end
    local op = OpQueue.pop()
    execute(op)
    return OpQueue.isEmpty()
end


while true do
    checkFuel()
    local remains = checkQueue()
    if remains then
        -- goToBase()
    end

    sleep(1)
end



