-- Configuration
local side_length = 8
local sapling_block = "minecraft:oak_sapling"
local upper_bound_block = "minecraft:obsidian"

-- Internal variables
local current_side_walked = 0

-- Walk to the next tree
function tree_next()
    if current_side_walked + 1 == side_length then
        -- If on the edge, go on the other side
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()

        current_side_walked = 0

    else
        -- Otherwise, go as usual
        turtle.turnRight()

        turtle.forward()
        turtle.turnLeft()

        current_side_walked = current_side_walked + 1
    end
end

-- Check if tree in front has grown
function has_tree_grown()
    local has_block, data = turtle.inspect()
    return has_block and data.name ~= sapling_block
end

-- Start breaking the tree in front, front the bottom to the top
function break_tree_in_front()
    local go_up = true
    local up_count = 0

    while go_up do
        turtle.dig()

        local success, above_block = turtle.inspectUp()

        -- don't dig if above block is the upper bound
        if success and above_block.name == upper_bound_block then
            go_up = false

        else
            turtle.digUp()
            turtle.up()

            up_count = up_count + 1

            local success, front_block = turtle.inspect()

            if not success then
                go_up = false
            end
        end

    end

    for i=1, up_count do
        turtle.down()
    end
end

-- Finds block in inventory, returns true if block was found,
-- false if not. If found, slot is selected
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


-- Place sapling in front if in inventory
function place_sapling()
    inventory_find_block_or_error(sapling_block)
    turtle.place()
end

-- Main
while true do
    if has_tree_grown() then
        break_tree_in_front()
        place_sapling()
    end

    tree_next()
end

