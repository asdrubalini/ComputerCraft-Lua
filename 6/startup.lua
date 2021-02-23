local sapling_name = "minecraft:oak_sapling"
local block_name = "minecraft:oak_log"
local leaves_name = "minecraft:oak_leaves"
local sleep_duration = 120
local resumeFileName = "resume.txt"


function updateResumeFile(upCount, facing)
    local file = fs.open(resumeFileName, "w")
    file.writeLine(upCount)
    file.writeLine(facing)
    file.close()
end

function checkResumeFile()
    return fs.exists(resumeFileName)
end

function resumeFromFile()
    local file = fs.open(resumeFileName, "r")
    local upCount = file.readLine()
    local facing = file.readLine()
    file.close()

    if facing == "right" then
        turtle.turnLeft()
    elseif facing == "left" then
        turtle.turnRight()
    end

    for i=1,upCount do
        turtle.down()
    end
end


function makeSaplingGrow()
    turtle.select(16)

    repeat
        local success, front_block = turtle.inspect()
        turtle.place()
    until (front_block.name == block_name)

    turtle.select(1)
end

function placeSapling()
    turtle.select(15)
    turtle.place()
    turtle.select(1)
end

function digTree()
    turtle.select(1)

    local goUp = true
    local upCount = 0

    while goUp do
        turtle.dig()
        turtle.digUp()
        turtle.up()

        upCount = upCount + 1

        updateResumeFile(upCount, "normal")

        local success, front_block = turtle.inspect()

        if not success then
            goUp = false
        end
    end

    for i=1,upCount do
        turtle.down()

        updateResumeFile(upCount - i, "normal")
    end
end

function takeBoneMeal()
    turtle.select(16)

    local neededBoneMeal = turtle.getItemSpace()

    turtle.turnRight()
    updateResumeFile(0, "right")
    turtle.suck(neededBoneMeal)
    turtle.turnLeft()
    updateResumeFile(0, "normal")
end

function takeSapling()
    turtle.select(15)

    local neededSaplings = turtle.getItemSpace()

    turtle.turnLeft()
    updateResumeFile(0, "left")
    turtle.suck(neededSaplings)
    turtle.turnRight()
    updateResumeFile(0, "normal")
end

function storeMaterial()
    for slot=1,14 do
        turtle.select(slot)
        local detail = turtle.getItemDetail()

        if detail then
            turtle.dropDown()
        end
    end

    turtle.select(1)
end

-- resume to normal position based on file
if checkResumeFile() then
    resumeFromFile()
end

while true do
    takeBoneMeal()
    takeSapling()

    placeSapling()
    makeSaplingGrow()

    digTree()
    storeMaterial()

    local seconds = 0
    
    while seconds < sleep_duration do
        print(sleep_duration - seconds .. " seconds left")
        seconds = seconds + 1

        os.sleep(1)
    end
end
