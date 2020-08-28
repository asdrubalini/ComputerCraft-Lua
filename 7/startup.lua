craftingSpace = {
    6, 7, 8, 
    10, 11, 12, 
    14, 15, 16
}

while (true) do
    turtle.select(1)

    suckedItems = 0

    repeat
        if turtle.suckUp(1) then
            suckedItems = suckedItems + 1
        else
            os.sleep(2)
        end
    until (suckedItems >= 9)

    for i = 1, 9 do
        turtle.select(1)
        turtle.transferTo(craftingSpace[i], 1)
    end

    turtle.select(1)
    turtle.craft(1)

    turtle.dropDown()
end
