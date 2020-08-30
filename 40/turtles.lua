local modem = peripheral.wrap("right")

modem.open(1)

term.write("Single turtle diameter: ")
local diameter = tonumber(read())

term.write("Current height: ")
local height = tonumber(read())

local command = "quarry.lua " .. diameter .. " " .. height

modem.transmit(1, 2, command)
