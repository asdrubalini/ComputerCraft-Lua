local length = 29

function updateSelect()
    local currentSlot = turtle.getSelectedSlot()
    local currentItemCount = turtle.getItemCount()

    if currentItemCount == 0 then
        turtle.select(currentSlot + 1)
    end
end

while true do
    for i=1,length do
        turtle.place()
        turtle.back()

        updateSelect()
    end

    turtle.turnLeft()
    turtle.back()
    turtle.turnLeft()
    turtle.back()
end
