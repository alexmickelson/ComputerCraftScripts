
GoLeft = true

local function DigRowAndReturn() 
    for i=1, 100, 1  do
        turtle.dig()
        turtle.forward()
        turtle.digUp()
        turtle.digDown()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    for i = 1, 100, 1 do
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

local function EmptyInventory()
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


-- start main here

DigRowAndReturn()
EmptyInventory()
