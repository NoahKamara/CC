
print("Kobble in slot 4")
print("KOhle in slot 5")

print("Anzahl der Turtle in slot 1")
local turtleAmmount = tonumber(read())

print("Anzahl der Kisten in slot 2")
local chestAmmount = tonumber(read())

print("Anzahl der Fackeln in slot 3")
local torcheAmmount = tonumber(read())


for i = 1, turtleAmmount do     
    turtle.select(0)
    while (turtle.place() == false) do
        os.sleep(3)
    end

    for i=1, 5 do
        if i == 1 then
            drop = 1
        elseif i == 2 then
            drop = math.floor(torcheAmmount / turtleAmmount)
        elseif i == 3 then 
            drop = math.floor(chestAmmount / turtleAmmount)
        elseif i == 4 then 
            drop = 1
        end
        elseif i == 5 then 
            drop = 20
        end

        turtle.select(i)
        turtle.drop()
    end
end