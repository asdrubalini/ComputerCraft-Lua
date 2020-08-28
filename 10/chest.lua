-- user variables

local wantedItems = {
    "minecraft:diamond_ore",
    "minecraft:iron_ore",
    "minecraft:gold_ore",
    "minecraft:coal",
    "minecraft:redstone",
    "minecraft:lapis_lazuli",
    "minecraft:sand",
    "minecraft:diamond"
}

local chestDistance = 32
local dumpSide = "right"
local quarryCount = 4

-- internal variables

local distanceFromChest = 0


function turtle.checkAndDumpUnwanted()
    if dumpSide == "right" then
        turtle.turnRight()
    elseif dumpSide == "left" then
        turtle.turnLeft()
    end

    for slot=1,16 do
        turtle.select(slot)

        local detail = turtle.getItemDetail(slot)
        local wanted = false

        if detail then
            for _, item in ipairs(wantedItems) do
                if detail.name == item then
                    wanted = true
                end
            end
        end

        if not wanted then
            turtle.drop()
        end
    end

    if dumpSide == "right" then
        turtle.turnLeft()
    elseif dumpSide == "left" then
        turtle.turnRight()
    end

    turtle.select(1)
end

function turtle.storeWantedInChest()
    -- Adjust the turtle position in order to match the chest on the left side
    turtle.turnLeft()

    for slot=1,16 do
        turtle.select(slot)
        turtle.drop()
    end

    -- Return to normal position
    turtle.turnRight()
end

function turtle.forwardFor(blocks)
    distanceFromChest = distanceFromChest + blocks

    for blocks=1,blocks do
        turtle.forward()
    end
end

function turtle.suckEverything()
    local pickedSlots = 0

    for slot=1,16 do
        turtle.select(slot)

        if turtle.suckDown() then
            pickedSlots = pickedSlots + 1
        end
    end
    
    return pickedSlots
end

function turtle.returnToChest()
    turtle.turnRight()
    turtle.turnRight()

    turtle.forwardFor(distanceFromChest)
    distanceFromChest = 0

    turtle.turnRight()
    turtle.turnRight()
end

shell.openTab("fuel.lua")

while true do
    for quarryIdx=1,quarryCount do
        repeat
            turtle.forwardFor((chestDistance * quarryIdx) - 1) -- reach the chest
            local pickedSlots = turtle.suckEverything() -- pull every possibile item from the chest

            if pickedSlots ~= 0 then
                turtle.checkAndDumpUnwanted() -- dump unwanted stuff
            end

            turtle.returnToChest() -- return home

            -- if any item was picked up, put them back into the chest
            if pickedSlots ~= 0 then
                turtle.storeWantedInChest()
            end
        
        until pickedSlots ~= 16
    end
end
