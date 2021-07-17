-- Configuration
local internal_side_length = 6
local sapling_block = "minecraft:oak_sapling"
local sleep_time = 10 -- time between one tree and the other
local structure_heigth = 7

-- Internal variables
local current_side_walked = 0

-- Walk to the next tree
function tree_next()
    if current_side_walked + 1 == internal_side_length then
        -- If on the edge, go on the other side
        turtle.turnRight()
        current_side_walked = 0

    else
        -- Otherwise, go as usual
        turtle.turnRight()

        turtle.forward()
        turtle.turnLeft()

        current_side_walked = current_side_walked + 1
    end
end

function inventory_find_block(block_name)
    local found = false
    local checked_slots_count = 0

    while not found do
        -- check if the equipped block is a sapling
        local details = turtle.getItemDetail()

        if details ~= nil and details.name == block_name then
            found = true

        else
            local current_slot = turtle.getSelectedSlot()

            if current_slot == 16 then
                current_slot = 0
            end

            turtle.select(current_slot + 1)
            checked_slots_count = checked_slots_count + 1
        end

        if checked_slots_count == 16 then
            break
        end
    end

    return found
end

function inventory_find_block_or_error(block_name)
    local found = inventory_find_block(block_name)

    if not found then
        error("Cannot find required block in inventory")
    end
end


function bone_meal_front()
    -- Check if front block exists and is a sapling
    -- If not, return
    local has_block, data = turtle.inspect()

    if (not has_block) or (data.name ~= sapling_block) then
        return
    end

    inventory_find_block_or_error("minecraft:bone_meal")

    local grown = false
    while not grown do
        inventory_find_block_or_error("minecraft:bone_meal")
        turtle.place()

        local has_block, data = turtle.inspect()

        if data.name ~= sapling_block then
            grown = true
        end
    end
end


-- Main

for i = 1, structure_heigth do
    turtle.up()
end

while true do
    bone_meal_front()
    tree_next()

    sleep(sleep_time)
end

