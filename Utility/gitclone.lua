function download_from_github(filpath)
    local url = "https://raw.githubusercontent.com/noahkamara/CC/master/" .. filpath 

    -- URL REQUEST
    local response = http.get(url)
    local content = response.readAll()
    response.close()

    -- WRITE TO FILE
    local file = fs.open(filpath, "w")
    file.write(content)
    file.close()
end



function main()
    print("installing json parser....")
    local response = http.get("https://pastebin.com/raw/4nRg9CHU")
    local file = fs.open("json","w")
    file.write(response.readAll())
    file.close()
    os.loadAPI("json")
    print("json parser loaded")
    print("accessing github")
    local str = http.get("https://api.github.com/repos/noahkamara/CC/git/trees/master?recursive=1").readAll()
    local obj = json.decode(str)
    for i, val in ipairs(obj.tree) do
        if string.match(val.path, "lua") then 
            download_from_github(val.path)
        end
    end


end

main()
