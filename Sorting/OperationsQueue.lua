-- OperationsQueue.lua
-- Manages OperationsQueue


Utility = require("Utility")

local OperationsQueue = {location="config/operations.queue"}


-- Returns the number of operations in the queue
function OperationsQueue.count()
    local file = fs.open(OperationsQueue.location, "r")
    local content = file.readAll()
    local queue = Utility.split(content, "\n")
    file.close()
    return table.getn(queue)
end


-- Returns true if the operation queue is empty
function OperationsQueue.isEmpty()
    local file = fs.open(OperationsQueue.location, "r")
    local content = file.readAll()
    local queue = Utility.split(content, "\n")
    file.close()
    return table.getn(queue) == 0
end


-- Adds the operation to the end of the queue
-- operation (str): Operation
function OperationsQueue.add(operation)
    local file = fs.open(OperationsQueue.location, "a")
    file.writeLine(operation)
    file.close()
end


-- Pops the operation at the front of the queue
function OperationsQueue.pop()
    -- READ OPERATION
    local file = fs.open(OperationsQueue.location, "r")
    local content = file.readAll()
    local queue = Utility.split(content, "\n")
    local top = queue[1]
    file.close()

    -- WRITE REMAINING
    file = fs.open(OperationsQueue.location, "w")
    queue = { unpack( queue, 2, table.getn(queue)) }
    for i, v in pairs(queue) do
        file.writeLine(v)
    end
    file.close()
    return top
end


return OperationsQueue