args = {...}
local block_count = args[1]

local current_slot = 1

for i = 0, block_count - 1, 1
do
    if turtle.getItemCount() == 0 then
        current_slot = current_slot + 1
        turtle.select(current_slot)
    end

    turtle.placeDown()
    turtle.forward()
end

