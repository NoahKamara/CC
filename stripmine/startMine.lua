
-- rep, fd, fdd ,dist, message = os.pullEvent("modem_message")
-- print(message)

print("Wenn der erste Block der Abgebaut wird kein cobblestone ist, lege cobbelston in slot1; Tiefe der Seitenschächte: ")
length = read()

print("Anzahl Seitenschächte pro Seite:")
local schaechte = read()

local ammount_chests = (schaechte * 2)
print("Lege " .. ammount_chests .. " Kisten in Slot 2")

local amount_torches = math.floor(length + 5 / 10)
print("Lege " .. amount_torches .. " Fackeln in slot 3")

print("y-koordinat:")
local y_koordinate = read()

print("Anzahl der Verschiebung (normla 2):")
local versch = read()

print("Turtel gesammtanzahl:")
local anzahl_turtle = read()

local modem = peripheral.wrap("left")
modem.open(1)

local turtle_nummer = 1
while true do 
    
    rep, fd, fdd ,  dist, message = os.pullEvent("modem_message")
    if message == "ready" then
        print("starts programm")
        modem.transmit( 3,1, "stripmine/fastmine")
        
        os.sleep(3)
        -- print("Wenn der erste Block der Abgebaut wird kein cobblestone ist, lege cobbelston in slot1; Tiefe der Seitenschächte: ")
        -- length = read()
        modem.transmit( 3,1, length)
        print("length", length)

        -- print("Anzahl Seitenschächte pro Seite:")
        -- local schaechte = read()
        modem.transmit( 3,1, schaechte)
        print("schaechte", schaechte)

        -- local ammount_chests = (schaechte * 2)
        -- print("Lege " .. ammount_chests .. " Kisten in Slot 2")

        -- local amount_torches = math.floor(length + 5 / 10)
        -- print("Lege " .. amount_torches .. " Fackeln in slot 16")

        -- print("y-koordinat:")
        -- local y_koordinate = read()
        modem.transmit( 3,1, y_koordinate)
        print("y_koordinate", y_koordinate)


        -- print("Anzahl der Verschiebung (normla 2):")
        -- local versch = read()
        modem.transmit( 3,1, versch)
        print("versch", versch)


        -- print("Turtel gesammtanzahl:")
        -- local anzahl_turtle = read()
        modem.transmit( 3,1, anzahl_turtle)
        print("anzahl_turtle", anzahl_turtle)

        modem.transmit( 3,1, turtle_nummer)
        print("turtle_nummer", turtle_nummer)

        turtle_nummer = turtle_nummer + 1
    end
    if (turtle_nummer == anzahl_turtle + 1) then
        break
    end
end

