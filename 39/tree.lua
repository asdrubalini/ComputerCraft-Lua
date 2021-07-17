-- TODO: don't move if no trees are ready to be chopped

-- Configuration
local side_length = 8
local sapling_block = "minecraft:oak_sapling"
local upper_bound_block = "minecraft:obsidian"
local garbage_collect_period = 8 -- collect garbage every n broken trees

-- Checks if there is a block in front before going forward.
function turtle_forward_and_break()
    if turtle.detect() then
        turtle.dig()
    end

    turtle.forward()
end

-- Walk to the next tree
function tree_next(current_side_walked)
    if current_side_walked + 1 == side_length then
        -- If on the edge, go on the other side
        turtle.turnRight()
        turtle_forward_and_break()
        turtle.turnLeft()

        turtle_forward_and_break()
        turtle.turnLeft()

        current_side_walked = 0

    else
        -- Otherwise, go as usual
        turtle.turnRight()

        turtle_forward_and_break()
        turtle.turnLeft()

        current_side_walked = current_side_walked + 1
    end

    return current_side_walked
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

    -- Try to dig down. If some tree has grown when we were at the
    -- top, try to break the blocks
    while up_count > 0 do
        local status = turtle.down()

        if status then
            up_count = up_count - 1
        else
            turtle.digDown()
        end
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

-- Check if inventory contains any unwanted block and throw
-- out if it does
function throw_out_unwanted_blocks(whitelist_block)
    for i = 1, 16 do
        turtle.select(i)

        local details = turtle.getItemDetail()

        if details ~= nil and details.name ~= whitelist_block then
            turtle.drop()
        end
    end
end

-- Main
local current_side_walked = 0
local tree_counter = 0

while true do
    if has_tree_grown() then
        break_tree_in_front()
        place_sapling()
        tree_counter = tree_counter + 1
    end

    if tree_counter % garbage_collect_period == garbage_collect_period - 1 then
        print("Collecting garbage")
        turtle.turnLeft()
        turtle.turnLeft()

        throw_out_unwanted_blocks(sapling_block)

        turtle.turnLeft()
        turtle.turnLeft()
    end

    current_side_walked = tree_next(current_side_walked)
end

