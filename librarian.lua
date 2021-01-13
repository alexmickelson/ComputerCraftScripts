
INPUT_CHEST_X = arg[1]
INPUT_CHEST_Y = arg[2] --not used currently
INPUT_CHEST_Z = arg[3]

print("startin librarian with "..tostring(INPUT_CHEST_X)..", ".. tostring(INPUT_CHEST_Y)..", ".. tostring(INPUT_CHEST_Z))

local function isInFrontOfInputChest()
    local x, y, z = gps.locate()
    local xDistance = math.abs(x - INPUT_CHEST_X)
    -- local yDistance = math.abs(y - INPUT_CHEST_Y)
    local zDistance = math.abs(z - INPUT_CHEST_Z)
    if xDistance < 2 and zDistance < 2 then
        print("close to input chest")
        local isBlock, block = turtle.inspect()
        if isBlock and block.name == "minecraft:chest" then
            -- grab as many things as you can
            local i = 1
            while turtle.suck(i) do
                i = i + 1
            end
        end
    end
end

local function goToInputChest() 
    -- chest is either in front or behind
    while(turtle.detect()) do
        print("rotating to find input chest")
        turtle.turnLeft()
    end
    turtle.forward()
end

isInFrontOfInputChest()