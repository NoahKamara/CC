function save(x, y, z, item, count, mCount)

    local file = fs.open("database", fs.exists("database") and "a" or "w")
    file.write(makeCSV({x, y, z, item, count, mCount}))
    file.close()
end

function rewrite(rows)
    fs.delete("database")
    for x, row in ipairs(rows) do
        if row then save(row.x, row.y, row.item, row.count, row.mCount) end
    end
end

local function load()
    local rows = {}
    local file = fs.open("database", "r")
    if file then
        local l = file.readLine()
        while l ~= nil do
            table.insert(rows, lineToObject(line(l)))
            l = file.readLine()
        end
        file.close()
    end
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
    -- adding last entry
    local z = l:sub(lastComma + 1, #l)
    table.insert(values, z)

    return values
end

function lineToObject(values)
    x = {}
    x["x"] = tonumber(values[1])
    x["y"] = tonumber(values[2])
    x["z"] = tonumber(values[3])
    x["item"] = values[4]
    x["count"] = tonumber(values[5])
    x["mCount"] = tonumber(values[6])
    return x
end

function findLocations(item)
    local rows_with_item = {}
    local indices = {}
    for i, v in ipairs(rows) do
        if v.item then
            if string.match(v.item, item) then
                table.insert(rows_with_item, v)
                table.insert(indices, i)
            end
        end
    end
    return rows_with_item, indices
end

function findFittingChest(rows_with_item, count, indices)
    for i, row in pairs(rows_with_item) do
        if (row.mCount - row.count) >= count then return row, indices[i] end
    end
    return 0
end

function useEmptyChest(item, count, mCount)
    good_row = {}
    for z = 1, 5 do
        for y = 1, 16 do
            for x = 1, 16 do
                found = true
                for key, value in pairs(rows) do
                    if value.x == x and value.y == y and value.z == z then
                        found = false
                        break
                    end
                end
                if found then
                    good_row["x"] = x
                    good_row["y"] = y
                    good_row["z"] = z
                    good_row["item"] = item
                    good_row["count"] = count
                    good_row["mCount"] = mCount
                    break
                end
                if found then break end
            end
            if found then break end
        end
        if found then break end
    end
    return good_row
end

function listenForElevator()
    print("Item: ")
    local item = read()
    print("Count: ")
    local count = tonumber(read())
    print("mCount")
    local mCount = tonumber(read())
    return item, count, mCount
end

function infoToElevator(z) print("An ElevatorTurtle gehe ebene: ", z) end

function infoToChestTurtle(z, x, y, count)
    print("ChestTurtle " .. z .. " gehe zu ", x, y, "Count: ", count)
end
function mainBrain()
    while true do
        rows = load()
        -- empfangen
        local item, count, mCount = listenForElevator()
        local rows_with_item, indices = findLocations(item)
        local good_row, index = findFittingChest(rows_with_item, count, indices)
        print("good_row =", good_row)
        if good_row == 0 then
            good_row = useEmptyChest(item, count, mCount)
        end
        local success1 = infoToElevator(good_row.z)
        local success2 = infoToChestTurtle(good_row.z, good_row.x, good_row.y,
                                           count)
        if not success1 or not success2 then
            print("Error! Notaus turtle antwortet nicht")
            print("ElevatorTurtle Success:", success1)
            print("ChestTurtle Success:", success2)
            -- break
        end
        good_row.count = good_row.count + count
        if index ~= nil then
            rows[index] = good_row
        else
            table.insert(rows, good_row)
        end

        -- rewrite(rows)
    end
end

mainBrain()
