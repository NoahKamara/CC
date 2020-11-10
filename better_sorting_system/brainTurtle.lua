function save(x, y, z, item, count, mCount)
    file = fs.open("database", fs.exists("database") and "a" or "w")
    file.write(makeCSV({x, y, z, item, count, mCount}))
    file.close()
end

function makeCSV(table)
    x = ""
    for i = 1, #table do
        x = x .. table[i]
        x = x .. ","
    end
end

function line(l)
    values = {}
    lastComma = 0
    for i = 1, #l do
        if l[1] == "," then
            z = ""
            for x = lastComma + 1, i - lastComma - 1 do z = z .. l[x] end
            table.insert(values, z)
        end
    end

    return values
end
function getOreLocation(ore) file = fs.open("database", "r") end
