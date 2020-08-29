local modem = peripheral.wrap("right")

modem.open(1)

function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

while true do
    local event, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")

    if string.starts(message, "quarry") then
        modem.transmit(2, 3, os.getComputerLabel() .. " starting")

        turtle.select(1)
        turtle.digUp()

        shell.openTab(message)
        shell.openTab("fuel.lua")
        break
    end
end
