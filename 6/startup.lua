local sapling_name = "minecraft:spruce_sapling"
local block_name = "minecraft:spruce_log"
local leaves_name = "minecraft:spruce_leaves"
local sleep_duration = 120

local storeMaterials = {
    block_name,
    leaves_name,
    "minecraft:stick"
}


function makeSaplingGrow()
    turtle.select(16)

    repeat
        local success, front_block = turtle.inspect()
        turtle.place()
    until (front_block.name == block_name)

    turtle.select(1)
end

function placeSapling()
    turtle.select(15)
    turtle.place()
    turtle.select(1)
end

function digTree()
    turtle.select(1)

    local goUp = true
    local upCount = 0

    while goUp do
        turtle.dig()
        turtle.digUp()
        turtle.up()

        upCount = upCount + 1

        local success, front_block = turtle.inspect()

        if not success then
            goUp = false
        end
    end

    for i=1,upCount do
        turtle.down()
    end
end

function takeBoneMeal()
    turtle.select(16)

    local neededBoneMeal = turtle.getItemSpace()

    turtle.turnRight()
    turtle.suck(neededBoneMeal)
    turtle.turnLeft()
end

function takeSapling()
    turtle.select(15)

    local neededSaplings = turtle.getItemSpace()

    turtle.turnLeft()
    turtle.suck(neededSaplings)
    turtle.turnRight()
end

function storeMaterial()
    for slot=1,14 do
        turtle.select(slot)
        local detail = turtle.getItemDetail()

        if detail then
            turtle.dropDown()
        end
    end

    turtle.select(1)
end

while true do
    takeBoneMeal()
    takeSapling()

    placeSapling()
    makeSaplingGrow()

    digTree()
    storeMaterial()

    local seconds = 0
    
    while seconds < sleep_duration do
        print(sleep_duration - seconds .. " seconds left")
        seconds = seconds + 1

        os.sleep(1)
    end
end
