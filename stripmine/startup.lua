local modem = peripheral.wrap("right")


modem.transmit(1, 3, "ready")

rep, fd, fdd, dist, programm = os.pullEvent("modem_message")

print(programm)

shell.run(programm)
