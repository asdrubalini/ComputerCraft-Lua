local currentSlot = 1
turtle.select(currentSlot)

local counter = 0

while true do
    if turtle.getItemCount() == 0 then
        currentSlot = currentSlot + 1

        if currentSlot == 16 then
            shell.exit()
        end

        turtle.select(currentSlot)
    end

    if counter % 2 == 1 then
        turtle.placeDown()
    end

    if turtle.forward() then
        counter = counter + 1
    end

end

