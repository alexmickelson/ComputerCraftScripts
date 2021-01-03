
GoLeft = false
ROW_DEPTH = 50
ROW_COUNT = 10
SINGLE_ROW = true

local function digRowAndReturn() 
    for i=1, ROW_DEPTH, 1  do
        if SINGLE_ROW then
            turtle.dig()
            turtle.forward()
        else
            turtle.dig()
            turtle.forward()
            turtle.digUp()
            turtle.digDown()
        end
    end
    turtle.turnLeft()
    turtle.turnLeft()
    for i = 1, ROW_DEPTH, 1 do
        turtle.forward()
    end

end

local function TurnToNextRow()
    if GoLeft then
        turtle.turnLeft()
        turtle.dig()
        turtle.forward()
        turtle.digUp()
        turtle.digDown()
        turtle.turnLeft()
        GoLeft = false
    else
        turtle.turnRight()
        turtle.dig()
        turtle.forward()
        turtle.digUp()
        turtle.digDown()
        turtle.turnRight()
        GoLeft = true
    end
end

local function emptyInventory()
    local isBlock, block = turtle.inspect()
    if(isBlock and block.name == "minecraft:chest" ) then
        for i = 1, 16 do
            turtle.select(i)
            turtle.drop()
        end
    else
        print("Cannot Empty inventory, no chest")
    end
end

local function goToChest(currentRow)
    turtle.turnRight()
    for i = 1, currentRow do
        -- sometimes gravel will fall behing the turtle
        if turtle.detect() then
            turtle.dig()
        end
        turtle.forward()
    end
    turtle.turnLeft()
end

local function goToNextRow(currentRow)
    turtle.turnLeft()
    for i = 1, currentRow do
        turtle.forward()
    end
    turtle.dig()
    turtle.forward()
    if not SINGLE_ROW then
        turtle.digUp()
        turtle.digDown()
    end
    turtle.turnLeft()
end


-- start main here
-- place a two wide chest behind turtle (and to the back-left corner)
for row = 1, ROW_COUNT do
    digRowAndReturn()
    goToChest(row - 1)
    emptyInventory()
    goToNextRow(row - 1)
end
