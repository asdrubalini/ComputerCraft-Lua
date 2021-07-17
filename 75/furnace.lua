-- Configuration

-- TODO: wait until chest is full before moving

local drop_count = 32

function load_from_chest()
    turtle.select(1)

    -- Suck until inventory is full
    local done = false
    while not done do
        local status, reason = turtle.suck(64)

        if not status then
            done = true
        end
    end

    turtle.turnRight()
    turtle.turnRight()
end

function walk_to_next_inventory()
    turtle.forward()
    return not turtle.detect()
end

function return_home(walk_distance)
    turtle.turnRight()
    turtle.turnRight()

    for i = 1, walk_distance do
        turtle.forward()
    end
end

function find_non_empty_slot()
    local found = false
    local current_slot = turtle.getSelectedSlot()

    for i = 1, 16 do
        turtle.select(current_slot)

        if turtle.getItemCount() > 0 then
            found = true
            break
        else
            current_slot = current_slot + 1

            if current_slot == 17 then
                current_slot = 1
            end
        end
    end

    return found
end


-- Main
local walked_furnaces = 0
local early_return = false

while true do
    load_from_chest()

    while walk_to_next_inventory() do
        local found = find_non_empty_slot()

        if not found then
            return_home(walked_furnaces + 1)
            early_return = true
            break
        end

        turtle.dropDown(drop_count)

        walked_furnaces = walked_furnaces + 1
    end

    if not early_return then
        return_home(walked_furnaces + 1)
    end

    walked_furnaces = 0
    early_return = false
end

