local modemLeft = peripheral.wrap("left")
local modemRight = peripheral.wrap("right")
local modem

if modemLeft then
    modem = modemLeft
elseif modemRight then
    modem = modemRight
else
    print("Unable to find modem")
    os.exit()
end

modem.open(1)

function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

while true do
    local event, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")

    print(message)

    if string.starts(message, "quarry") then
        modem.transmit(2, 3, os.getComputerLabel() .. " starting")

        shell.openTab(message)
        shell.run("fuel.lua")
        break
    end
end
