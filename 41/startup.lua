local modem = peripheral.wrap("back")

modem.open(1)

term.write("Diameter: ")
local diameter = tonumber(read())

term.write("Height: ")
local height = tonumber(read())

local command = "quarry.lua " .. diameter .. " " .. height

--print("Starting in 5s")
--os.sleep(5)

modem.transmit(1, 2, command)

shell.execute("startup")
