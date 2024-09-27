--t2

---------------------  S  -----------------------
---------------------  Z+ -----------------------
-----  E  ------------------------------------- W-  ----
-----  X+  ------------0---------t()----------  X-  ----
-------------------------------------------------
---------------------  N  ------------------
---------------------  Z- --------------------




_HomeDirection = { x = 69, y = 38, z = 85 }     
_DirectionLog = { x = 69, y = -53, z = 85 }

-- Boundaries
local maxX, maxY, maxZ = 500, 500, 500
-- place turtle facing south
local south = "z+" --0
local west = "x-"  --1
local north = "z-" -- 2
local east = "x+"  -- 3
local ypositive = "y+" --4
local ynegative = "y-" --5


local direction = 0 -- 0 = South, 1 = West, 2 = North, 3 = East

local function updatePosition()
    if direction == 0 then
        _DirectionLog.z = _DirectionLog.z + 1
    elseif direction == 1 then
        _DirectionLog.x = _DirectionLog.x - 1
    elseif direction == 2 then
        _DirectionLog.z = _DirectionLog.z - 1
    elseif direction == 3 then
        _DirectionLog.x = _DirectionLog.x + 1
    elseif direction == 4 then
        _DirectionLog.y = _DirectionLog.y + 1
    elseif direction == 5 then
        _DirectionLog.y = _DirectionLog.y- 1
    end
end



-- Function to initialize the Turtle
local function init()
    print("Turtle initialization started.")

    -- Refuel if the turtle is low on fuel
    if turtle.getFuelLevel() < 100 then
        print("Low fuel. Please refuel the turtle.")
        return false -- Abort initialization
    end

    print("Turtle initialized with enough fuel.")
    return true -- Initialization successful
end


-- Function to check if inventory is full
local function isInventoryFull()
    for slot = 1, 16 do
        if turtle.getItemCount(slot) == 0 then
            return false
        end
    end
    return true
end

local function justDig()
    turtle.dig()
    turtle.digUp()
    turtle.digDown()
end 

-- facing direction 
-- (forward z+) south = 0
-- (right x-) west = 1 
-- (backward z-) north = 2
--  (left x+) east  = 3
-- (up y+) =4
-- (donw y-) = 5

-- mathi 
local function up(times)
    times = times or 1
    direction = 4
    for i = 1, times do
        turtle.digUp()
        turtle.up()
        updatePosition()
    end
end
-- tala
local function down(times)
    times = times or 1
    direction = 5
    for i = 1, times do
        turtle.digDown()
        turtle.down()
        updatePosition()
    end
end

-- agadi
-- when turtle facing south
local function forward(times)
    times = times or 1
    
    direction = 0
    for i = 1, times do
        justDig()
        turtle.forward()
        updatePosition()
    end
end

-- pachadi
local function backward(times)
    times = times or 1
    direction =2 
    for i =1,2 do
        turtle.turnRight()
    end
    for i = 1, times do
        justDig()
        turtle.forward()
        updatePosition()
    end
end

--right
local function right(times)
    times = times or 1
    turtle.turnRight()
    direction = 1
    for i = 1, times do
        turtle.dig()
        turtle.forward()
        updatePosition()
    end
end

--left
local function left(times)
    times = times or 1
    turtle.turnLeft()
    direction = 3
    for i = 1, times do
        turtle.dig()
        turtle.forward()
        updatePosition()
    end
end

local function stripMine(length, width)
    -- Ensure we have fuel
    if turtle.getFuelLevel() < (length * width  * 2)  then
        print("Not enough fuel!")
        return
    end
    if isInventoryFull() then
        print("Inventory is full! Please clear some items.")
        return
    end
    --for h = 1, height do
        for w = 1, width do
            for l = 1, length - 1 do
                forward()
                justDig()
            end
            
            -- Turn around at the end of each strip
            if w < width then
                if w % 2 == 1 then
                    right(2)
                    justDig()
                else
                    left(2)
                    justDig()
                end
            end
        end
        
        -- Move up for the next layer if not at top
        -- if h < height then
        --     for i = 1, width - 1 do
        --         turtle.back()
        --     end
        --     turtle.digUp()
        --     turtle.up()
        --     turtle.turnRight()
        --     turtle.turnRight()
        -- end
   -- end
    
    -- Return to starting position
    -- for i = 1, height - 1 do
    --     turtle.down()
    -- end
end


-- Function to return home by retracing steps
local function returnHome()
    -- Return to original Y position
    while _DirectionLog.y < _HomeDirection.y do
        if not up() then
            print("Unable to move up, digging up...")
            turtle.digUp()
        end
    end
    while _DirectionLog.y > _HomeDirection.y do
        if not down() then
            print("Unable to move down, digging down...")
            turtle.digDown(1)
        end
    end

    -- Move in X direction
    local targetX = _HomeDirection.x
    while _DirectionLog.x < targetX do
        turnToDirection(1) -- Turn East
        if not forward() then
            print("Unable to move forward, digging...")
            turtle.dig()
        end
    end
    while _DirectionLog.x > targetX do
        turnToDirection(3) -- Turn West
        if not forward() then
            print("Unable to move forward, digging...")
            turtle.dig()
        end
    end

    -- Move in Z direction
    local targetZ = _HomeDirection.z
    while _DirectionLog.z < targetZ do
        turnToDirection(2) -- Turn South
        if not forward() then
            print("Unable to move forward, digging...")
            turtle.dig()
        end
    end
    while _DirectionLog.z > targetZ do
        turnToDirection(0) -- Turn North
        if not forward() then
            print("Unable to move forward, digging...")
            turtle.dig()
        end
    end

    print("Returned home to coordinates: X=" ..
    _HomeDirection.x .. ", Y=" .. _HomeDirection.y .. ", Z=" .. _HomeDirection.z)
end

-- Function to refuel the turtle
local function refuel()
    turtle.refuel()
end
local function checkFuel()
    return turtle.getFuelLevel()
end
-- Function to mine for diamonds
local function mineForDiamonds()
    -- reach loaction
    while _DirectionLog.y > -53 do
        local success, block = turtle.inspect()
        if success and block.name == "minecraft:bedrock" then
            print("bedrock found! Unbreakeable block going up - blocks")
            up(5)
            forward(5)
            down(4)
        end
        down()
        print(_DirectionLog.y)
    end
    while checkFuel() > 500 do
        local success, block = turtle.inspect()
        if success and block.name == "minecraft:bedrock" then
            print("bedrock found! Unbreakeable block going up - blocks")
            up(5)
            forward(5)
            down(5)
        end
        stripMine(10,10)
    end
    returnHome()
end



local function testMovement()
    up(5)
    down(5)
    forward(5)
    backward(5)
    right(5)
    left(5)
    print(_DirectionLog.x)
    print(_DirectionLog.y)
    print(_DirectionLog.z)
end
-- Main execution
if init() then
    print("Starting mining operation for diamonds...")
    mineForDiamonds()
else
    print("Initialization failed.")
end
