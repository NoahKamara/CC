-- Pastebin: 3a53ZgRE
function download_from_github(filepath)
    local url = "https://raw.githubusercontent.com/noahkamara/CC/master/" ..
                    filepath

    -- URL REQUEST
    local response = http.get(url)
    local content = response.readAll()
    response.close()

    -- WRITE TO FILE

    if fs.exists(filepath) then
        local old_file = fs.open(filepath, "r")
        if old_file.readAll() ~= content then
            print("Changed: " .. filepath)
        end
        old_file.close()
    end

    local file = fs.open(filepath, "w")
    file.write(content)
    file.close()
end

function main()
    print("installing json parser....")
    local response = http.get("https://pastebin.com/raw/4nRg9CHU")
    local file = fs.open("json", "w")
    file.write(response.readAll())
    file.close()
    os.loadAPI("json")
    print("json parser loaded")
    print("accessing github")
    local str = http.get(
                    "https://api.github.com/repos/noahkamara/CC/git/trees/master?recursive=1")
                    .readAll()
    local obj = json.decode(str)
    for i, val in ipairs(obj.tree) do
        if string.match(val.path, "lua") then
            download_from_github(val.path)
        end
    end

end

main()
