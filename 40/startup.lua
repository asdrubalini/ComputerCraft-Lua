local monitor = peripheral.wrap("left")
local modem = peripheral.wrap("right")

monitor.setTextScale(2)

local turtles_data = {}
local mining_turtles = 16
local chest_turtles = 4

modem.open(2)

function updateDisplay()
    monitor.clear()
    monitor.setCursorPos(1, 1)

    local cursorY = 1

    for i=1, mining_turtles do
        turtle_name = "am" .. i
        
        if turtles_data[turtle_name] ~= nil then
            fuel = turtles_data[turtle_name]
    
            monitor.write(turtle_name .. "\t" .. fuel)
    
            cursorY = cursorY + 1
            monitor.setCursorPos(1, cursorY)
        end
    end

    for i=1, chest_turtles do
        turtle_name = "ch" .. i

        if turtles_data[turtle_name] ~= nil then
            fuel = turtles_data[turtle_name]
    
            monitor.write(turtle_name .. "\t" .. fuel)
    
            cursorY = cursorY + 1
            monitor.setCursorPos(1, cursorY)
        end
    end
end

while true do
    local event, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")

    local turtle_data = {}
    for w in message:gmatch("%S+") do
        table.insert(turtle_data, w)
    end

    local turtle_name = turtle_data[1]
    local fuel = turtle_data[2]    

    print(turtle_name .. " - " .. fuel)

    turtles_data[turtle_name] = fuel

    updateDisplay()
end
