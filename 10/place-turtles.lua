function takeTurtles()
    turtle.turnLeft()

    for slot=1,16 do
        turtle.select(slot)
        turtle.suck()
    end

    turtle.turnRight()
end

function forwardLength(length)
    for i=1,length do
        turtle.forward()
    end
end

-- running code
takeTurtles()
turtle.up()

for y=1,4 do
    turtle.select(y)
    turtle.placeDown()

    -- on the last iteration do something else
    if y ~= 4 then
        forwardLength(16)
    else
        print("ciao")
    end
end
