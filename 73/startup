-- Automatic melon farmer from Asdrubalini

-- user configuration
local farmLength = 128
local partsCount = 1
local sleepTime = 360
local melon_count_filename = "melons.txt"

-- internal variables

local melon_count = 0

-- forward over one entire row of melons and break it
function forwardAndDig()
    for i = 1, farmLength + 1 do
        turtle.forward()

        -- last block is not a melon, so don't break it
        if i ~= (farmLength + 1) then
            local result, error_message = turtle.digDown()

            if result then
                melon_count = melon_count + 1
            end

        end
    end
end

-- turn left or right based on a string
function turnDirection(direction)
    if direction == "left" then
        turtle.turnLeft()
    elseif direction == "right" then
        turtle.turnRight()
    end
end

-- turn left or right and go to the new melon row
function turnToNewRow(length, direction)
    turnDirection(direction)

    for i = 1, length do
        turtle.forward()
    end

    turnDirection(direction)
end

function returnHome()
    for i = 1, ((4 * partsCount) + partsCount - 1) do
        turtle.forward()
    end
end

function storeInChest()
    for slot = 1, 16 do
        turtle.select(slot)
        turtle.dropDown()
    end

    turtle.select(1)
end

-- local f_melon_count = open(melon_count_filename, "w")

-- Wait for redstone on the back
print("Waiting for redstone signal...")

while true do
    os.pullEvent("redstone")
    if rs.getInput("back") then
        break
    end
end

while true do
    print("Broken melons:", melon_count)

    for part = 1, partsCount do
        forwardAndDig()
        turnToNewRow(4, "left")
        forwardAndDig()

        -- if it isn't the last step, turn left
        if part ~= partsCount then
            turnToNewRow(1, "right")
        else
            turtle.turnLeft()

            returnHome()
            storeInChest()

            turtle.turnLeft()
        end
    end

    for counter = 1, sleepTime do
        print("Sleeping...", sleepTime - counter)
        os.sleep(1)
    end
end

