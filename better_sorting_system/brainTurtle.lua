function save(x, y, count, mCount)
    file = fs.open("database", fs.exists("database") and "a" or "w")
    file.write(x .. "," .. y .. "," .. count .. "," .. "," .. mCount .. "\n")
    file.close()
end

