os.loadAPI("basics.lua")


print("Kobble in slot 1")
print("Treibstoff in slot 4")

print("Anzahl der Turtle in slot 5 ff")
local turtleAmmount = tonumber(read())

print("Anzahl der Kisten in slot 2")
local chestAmmount = tonumber(read())

print("Anzahl der Fackeln in slot 3")
local torcheAmmount = tonumber(read())

print("Starttreibstoff pro Turtle in slot 4")
local treibstoff = tonumber(read())

for turtleNumber = 1, turtleAmmount -1 do     
    turtle.select(turtleNumber+4)
    while (turtle.place() == false) do
        os.sleep(3)
    end

    for i=1, 4 do
        if i == 1 then
            drop = 2
        elseif i == 2 then 
            drop = math.floor( chestAmmount / turtleAmmount)
        elseif i == 3 then 
            drop = math.floor( torcheAmmount / turtleAmmount)
        elseif i == 4 then 
            drop = treibstoff
        end

        turtle.select(i)
        turtle.drop(drop)
    end
end

basics.walk()

shell.run("stripmine/startup.lua")