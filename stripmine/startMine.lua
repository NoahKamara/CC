local modem = peripheral.wrap("left")
modem.open(1)
-- rep, fd, fdd ,dist, message = os.pullEvent("modem_message")
-- print(message)

print("Wenn der erste Block der Abgebaut wird kein cobblestone ist, lege cobbelston in slot1; Tiefe der Seitenschächte: ")
length = read()

print("Anzahl Seitenschächte pro Seite:")
local schaechte = read()

local ammount_chests = (schaechte * 2)
print("Lege " .. ammount_chests .. " Kisten in Slot 2")

local amount_torches = math.floor(length + 5 / 10)
print("Lege " .. amount_torches .. " Fackeln in slot 16")

print("y-koordinat:")
local y_koordinate = read()

print("Anzahl der Verschiebung (normla 2):")
local versch = read()

print("Turtel gesammtanzahl:")
local anzahl_turtle = read()

while true do 
    local turtle_nummer = 1
    rep, fd, fdd ,  dist, message = os.pullEvent("modem_message")
    if message == "ready" then
        
        modem.transmit( 3,1, "fastmine")
        

        -- print("Wenn der erste Block der Abgebaut wird kein cobblestone ist, lege cobbelston in slot1; Tiefe der Seitenschächte: ")
        -- length = read()
        modem.transmit( 3,1, lenght)

        -- print("Anzahl Seitenschächte pro Seite:")
        -- local schaechte = read()
        modem.transmit( 3,1, schaechte)

        -- local ammount_chests = (schaechte * 2)
        -- print("Lege " .. ammount_chests .. " Kisten in Slot 2")

        -- local amount_torches = math.floor(length + 5 / 10)
        -- print("Lege " .. amount_torches .. " Fackeln in slot 16")

        -- print("y-koordinat:")
        -- local y_koordinate = read()
        modem.transmit( 3,1, y_koordinate)

        -- print("Anzahl der Verschiebung (normla 2):")
        -- local versch = read()
        modem.transmit( 3,1, versch)


        -- print("Turtel gesammtanzahl:")
        -- local anzahl_turtle = read()
        modem.transmit( 3,1, anzahl_turtle)

        modem.transmit( 3,1, turtle_nummer)

        turtle_nummer = turtle_nummer + 1
    end
    if (turtle_nummer == anzahl_turtle + 1) then
        break
    end
end

