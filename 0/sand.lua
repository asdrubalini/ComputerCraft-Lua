local currentSlot = 1

while true do
    if turtle.detectDown() then
        turtle.forward()
    end

    if turtle.getItemCount() == 0 then
        currentSlot = currentSlot + 1

        if currentSlot == 16 then
            shell.exit()
        end

        turtle.select(currentSlot)
    end

    turtle.placeDown()
end
