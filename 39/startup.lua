-- user configuration
local farmLength = 30
local partsCount = 4
local sleepTime = 120

-- internal variables

-- 0: FRONT
-- 1: LEFT
-- 2: BACK
-- 3: RIGHT
local facing = 0

local front_distance = 0

-- forward over one entire row of melons and break it
function forwardAndDig()
    for i = 1, farmLength + 1 do
        turtle.forward()

        -- last block is not a melon, so don't break it
        if i ~= (farmLength + 1) then
            turtle.digDown()
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
        turtle.drop()
    end

    turtle.select(1)
end

while true do
    for part = 1, partsCount do
        forwardAndDig()
        turnToNewRow(4, "left")
        forwardAndDig()

        -- if it isn't the last step, turn turn
        if part ~= partsCount then
            turnToNewRow(1, "right")
        else
            turtle.turnLeft()

            returnHome()
            storeInChest()

            turtle.turnLeft()
        end
    end

    os.sleep(sleepTime)
end
