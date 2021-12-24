
print("Kobble in slot 1")
print("KOhle in slot 5")

print("Anzahl der Turtle in slot 2")
local turtleAmmount = tonumber(read())

print("Anzahl der Kisten in slot 3")
local chestAmmount = tonumber(read())

print("Anzahl der Fackeln in slot 4")
local torcheAmmount = tonumber(read())


for i = 1, turtleAmmount do     
    turtle.select(1)
    while (turtle.place() == false) do
        os.sleep(3)
    end

    for i=2, 5 do
        if i == 2 then
            drop = 20
        elseif i == 3 then 
            drop = math.floor(torcheAmmount / turtleAmmount)
        elseif i == 4 then 
            drop = math.floor(chestAmmount / turtleAmmount)
        elseif i == 5 then 
            drop = 1
        end

        turtle.select(i)
        turtle.drop(drop)
    end
end