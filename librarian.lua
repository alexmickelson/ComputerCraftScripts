-- shell.run("librarian", 268, 54, 112)
-- wget https://raw.githubusercontent.com/alexmickelson/ComputerCraftScripts/master/librarian.lua


-- x positive is north
-- z positive is east

INPUT_CHEST_X = arg[1]
INPUT_CHEST_Y = arg[2] --not used currently
INPUT_CHEST_Z = arg[3]

print("starting librarian with "..tostring(INPUT_CHEST_X)..", ".. tostring(INPUT_CHEST_Y)..", ".. tostring(INPUT_CHEST_Z))

local function isInFrontOfInputChest()
    local x, y, z = gps.locate()
    local xDistance = math.abs(x - INPUT_CHEST_X)
    -- local yDistance = math.abs(y - INPUT_CHEST_Y)
    local zDistance = math.abs(z - INPUT_CHEST_Z)
    if xDistance < 2 and zDistance < 2 then
        print("close to input chest")
        local isBlock, block = turtle.inspect()
        return isBlock and block.name == "minecraft:chest"
    else
        return false    
    end
end

local function turnAround()
    turtle.turnLeft()
    turtle.turnLeft()
end

local function pointToInputChest()
    print("attempting to point toward input chest")
    local x_start, y_start, z_start = gps.locate()

    local chest_direction = "unknown"
    if INPUT_CHEST_X - x_start > 0 then
        chest_direction = 'north'
    elseif INPUT_CHEST_X - x_start < 0 then
        chest_direction = 'south'
    elseif INPUT_CHEST_Z - z_start > 0 then
        chest_direction = 'east'
    elseif INPUT_CHEST_Z - z_start < 0 then
        chest_direction = 'west'
    end

    while turtle.detect() do
        turtle.turnLeft()
    end
    turtle.forward()
    local x_off, y_off, z_off = gps.locate()
    turtle.back()

    local facing = 'unknown'
    if x_off - x_start > 0 then
        facing = 'north'
    elseif x_off - x_start < 0 then
        facing = 'south'
    elseif z_off - z_start > 0 then
        facing = 'east'
    elseif z_off - z_start < 0 then
        facing = 'west'
    end

    while facing ~= chest_direction do
        turtle.turnLeft()
    end
    print("facing input chest: "..chest_direction)
end

local function goToInputChest() 
    if not isInFrontOfInputChest() then
        pointToInputChest()
        while not isInFrontOfInputChest() do
            turtle.forward()
        end
    end
end

local function fillInventory()
    print("filling inventory from input chest")
    local i = 1
    while turtle.suck(i) do
        i = i + 1
    end
end

local function selectedItemIsInLeftChest(localIndex)
    local left = peripheral.wrap("left")
    for item in left.list() do
        local localItem = turtle.getItemDetail()
        if item.name == localItem.name then
            return true
        end
    end
end

local function selectedItemIsInRightChest(localIndex)
    local right = peripheral.wrap("right")
    for item in right.list() do
        local localItem = turtle.getItemDetail()
        if item.name == localItem.name then
            return true
        end
    end
end

local function tryToPlaceInventoryInAdjacentBlocks()
    for i = 1, 16 do
        if selectedItemIsInLeftChest(i) then
            turtle.turnLeft()
            turtle.select(i)
            turtle.drop()
            turtle.turnRight()
        end
        if selectedItemIsInRightChest(i) then
            turtle.turnRight()
            turtle.select(i)
            turtle.drop()
            turtle.turnLeft()
        end
    end
end

local function sortInventory()
    -- stop at output chest
    while not turtle.detect() do
        tryToPlaceInventoryInAdjacentBlocks()
        turtle.forward()
    end
    print("placing remaining inventory in output chest")

    for i=1, 16 do
        turtle.select(i)
        turtle.drop()
    end
end
-- print(tostring(isInFrontOfInputChest()))
goToInputChest()
fillInventory()
turnAround()
sortInventory()
