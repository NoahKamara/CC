function save(x, y, z, item, count, mCount)
    file = fs.open("database", fs.exists("database") and "a" or "w")
    file.write(makeCSV({x, y, z, item, count, mCount}))
    file.close()
end
function load()
    file = fs.open("databse", "r")
    file.readLine()
    
end
function makeCSV(table)
    x = ""
    for i = 1, #table do
        x = x .. table[i]
        if i == #table then break end
        x = x .. ","
    end
    return x
end

function line(l)
    values = {}
    lastComma = 0
    for i = 1, #l do
        str = l:sub(i, i)
        if str == ',' then
            z = l:sub(lastComma + 1, i - 1)
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

function getOreLocation(ore) file = fs.open("database", "r") end

-- Tests
save(1,2,3,"ore",5,10)

x = line(makeCSV({1, 2, 3, 4, 5, 6, 7, 8, 9}))

row = lineToObject(x)

print(row.item)
