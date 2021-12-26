os.loadAPI("basics.lua")


print("Kobble in slot 1")
print("Treibstoff in slot 4")

print("Anzahl der Turtle in slot 7 ff")
local turtleAmmount = tonumber(read())

print("Anzahl der Kisten in slot 2")
local chestAmmount = tonumber(read())

print("Anzahl der Fackeln in slot 3")
local torcheAmmount = tonumber(read())

print("Starttreibstoff pro Turtle in slot 4-6")
local treibstoff = tonumber(read())

local stack = 64
local stackNumber = 0

for turtleNumber = 1, turtleAmmount do     
    turtle.select(turtleNumber+6)
    while (turtle.place() == false) do
        os.sleep(3)
    end

    for i=1, 4 do
        if i == 1 then
            drop = 2
        elseif i == 2 then 
            drop = math.floor( chestAmmount / (turtleAmmount + 1))
        elseif i == 3 then 
            drop = math.floor( torcheAmmount / (turtleAmmount + 1))
        end
        
        turtle.select(i)
        turtle.drop(drop)

        if i==4 then 
            stack = stack - treibstoff
            if stack > 0 then 
                turtle.select(i+stackNumber)
                turtle.drop(treibstoff)
            elseif stack < 0 then
                turtle.select(i+stackNumber)
                turtle.drop()
                stackNumber = stackNumber + 1
                turtle.select(i+stackNumber)
                turtle.drop(math.abs(stack))
                stack = 64 - math.abs(stack)
            end
        end
    end
end

while (basics.walk() == "turtle") do os.sleep(3) end 

shell.run("stripmine/startup.lua")