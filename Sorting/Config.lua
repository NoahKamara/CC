
local Config = {}

-- Loads Config from file at path
-- filepath (str): path to config file
function Config.load(filepath)
    if not fs.exists(filepath) then
        return nil
    end
    local file = fs.open(filepath, "r")
    local content = file.readAll()
    file.close()
    local config = textutils.unserialise(content)
    return config
end

-- Saves Config to file at path
-- filepath (str): path to config file
function Config.save(table, filepath)
    if fs.isReadOnly(filepath) or fs.isDir(filepath) then
        return false
    end
    local file = fs.open(filepath, "w")
    local content = textutils.serialise(table)
    local success = file.write(content)
    file.close()
    return true
end


return Config