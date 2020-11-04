-- GET INPUT
print("local filpath: ")
print("github path: ")
local url = "https://raw.githubusercontent.com/" .. read()

-- URL REQUEST
local response = http.get(url)
local content = response.readAll()
response.close()

-- WRITE TO FILE
local file = fs.open(filpath, "w")
file.write(content)
file.close()
