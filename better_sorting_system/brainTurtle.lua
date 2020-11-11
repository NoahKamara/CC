function save(x, y, z, item, count, mCount)

    local file = fs.open("database", fs.exists("database") and "a" or "w")
    file.write(makeCSV({x, y, z, item, count, mCount}))
    file.close()
end

local function load()
    local rows = {}
    local file = fs.open("database", "r")
    local l = file.readLine()
    while l ~= nil do
        table.insert(rows, lineToObject(line(l)))
        l = file.readLine()
    end
    file.close()
    return rows
end

function makeCSV(table)
    local x = ""
    for i = 1, #table do
        x = x .. table[i]
        if i == #table then
            x = x .. "\n"
            break
        end
        x = x .. ","
    end
    return x
end

function line(l)
    local values = {}
    local lastComma = 0
    for i = 1, #l do
        local str = l:sub(i, i)
        if str == ',' then
            local z = l:sub(lastComma + 1, i - 1)
            table.insert(values, z)
            lastComma = i
        end
    end

    return values
end

function lineToObject(values)
    x = {}
    x["x"] = values[1]
    x["y"] = values[2]
    x["z"] = values[3]
    x["item"] = values[4]
    x["count"] = values[5]
    x["mCount"] = values[6]
    return x
end

function addRowToDB(row)
    table.insert(rows, row)
    save(row)
end

function findLocations(ore)
    local rows_with_ore = {}
    for i, v in ipairs(rows) do
        if string.match(v, ore) then table.insert(rows_with_ore, v) end
    end
    return rows_with_ore
end

function checkForSpace(row) return row.mCount - row.count end

function dropSlotsWithSameItem(ore)
    for i = 1, 16 do
        turtle.select(i)
        if string.match(turtle.getItemDetail(i).name, ore) then
            turtle.drop()
        end
    end
end

function drop()
    for i = 1, 16 do
        turtle.select(i)
        local data = turtle.getItemDetail(i)
        dropSlotsWithSameItem(data.name)
    end
end

function findFittingChest(rows_with_ore, count)
    for i, row in pairs(rows_with_ore) do
        if checkForSpace(row) >= count then return row end
    end
    return 0
end

function mainBrain()
    while true do
        rows = load()
        -- empfangen
        local item, count = listenForElevator()
        local rows_with_item = findLocations(item)
        local good_row = findFittingChest(rows_with_item, count)
        if good_row == 0 then good_row = useEmptyChest(item, count) end
        local success1 = infoToElevator(good_row.z)
        local success2 = infoToChestTurtle(good_row.z, good_row.x, good_row.y,
                                           count)
        if not success1 or not success2 then
            print("Error! Notaus turtle antwortet nicht")
            print("ElevatorTurtle Success:", success1)
            print("ChestTurtle Success:", success2)
            break
        end
        good_row.count = good_row.count + count
        save(good_row) -- muss noch richtig reihe ändern
    end
end
