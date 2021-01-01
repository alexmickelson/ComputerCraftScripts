

local function getLavaFromChest()
    local i = 1
    while turtle.suck(i) do
        i = i + 1
    end
end

local function eatAllHoldingLava()
    for i = 1, 16 do
        turtle.select(i)
        turtle.refuel()
    end
end

local function putBackEmptyBuckets()
    for i = 1, 16 do
        turtle.select(i)
        turtle.drop()
    end
end

-- main
-- needs to be facing a chest with only lava buckets
getLavaFromChest()
eatAllHoldingLava()
putBackEmptyBuckets()