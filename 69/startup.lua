local recipe = { 
    1, 2, 3,
    5, 6, 7,
    9, 10, 11
}

function load_items()
    for i, k in pairs(recipe) do
        turtle.select(k)
        
        while not turtle.suck(1) do
        end
    end
end


-- Main
while true do
    load_items()
    turtle.craft()

    turtle.turnRight()
    turtle.turnRight()

    turtle.drop()

    turtle.turnRight()
    turtle.turnRight()
end

