
---------------------  N  -----------------------
---------------------  Z- -----------------------
-----  W  ---------------------------------  E-  ----
-----  X-  ------------0---------t()----------  X+  ----
-------------------------------------------------
---------------------  S  ------------------
---------------------  Z+ -------------------- 


_HomeDirection = {x=71,y=38,z=77}
_DirectionLog= {x=71, y=38, z=77}; 

-- Boundaries
local maxX, maxY, maxZ = 500, 500, 500
-- place turtle facing south
local south = "z+"
local east = "x+"
local north = "z-"
local west = "x-"

-- Direction: 0 = North, 1 = East, 2 = South, 3 = West
--local direction = 0 -- 0 = North, 1 = East, 2 = South, 3 = West

local direction = 0 -- 0 = South, 1 = West, 2 = North, 3 = East

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

local function goToDirection(direction)

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


local function up(times)
    times = times or 1
    for i=1,times do
        _DirectionLog.y = _DirectionLog.y + i
        turtle.digUp()
        turtle.up()
    end
end

local function down(times)
    times = times or 1
    for i=1,times do
        _DirectionLog.y = _DirectionLog.y - i
        turtle.digDown()
        turtle.down()
    end
end

-- when turtle facing south 
local function forward(times)
    times = times or 1
    for i=1,times do
        turtle.dig()
        turtle.forward()
        _DirectionLog.z = _DirectionLog.z + i
    end
end
local function backward(times)
    times = times or 1
    for i=1,times do 
        turtle.back()
        _DirectionLog.z = _DirectionLog.z - i
    end
   
end
--breaks block if theres block
local function right(times)
    times = times or 1
    turtle.turnRight()
    for i=1,times do
        turtle.dig()
        turtle.forward()
        _DirectionLog.x = _DirectionLog.x + i
    end
end

--breaks block if theres block
local function left(times)
    times = times or 1
    turtle.turnLeft()
    for i=1,times do
        turtle.dig()
        turtle.forward()
        _DirectionLog.x = _DirectionLog.x - i
    end
end
local function turn180()
    for i=1, 2 do 
        print("turn right")
        turtle.turnRight()
    end
end
local function uTurnRight()
    for i=1, 2 do 
        turtle.right()
    end
   
end
local function uturnLeft()
    turtle.left()
    turtle.dig()
end
-- Function to return home by retracing steps
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
            turtle.digDown()
        end
    end

    -- Move in X direction
    local targetX = _HomeDirection.x
    while _DirectionLog.x < targetX do
        turnToDirection(1)  -- Turn East
        if not forward() then
            print("Unable to move forward, digging...")
            turtle.dig()
        end
    end
    while _DirectionLog.x > targetX do
        turnToDirection(3)  -- Turn West
        if not forward() then
            print("Unable to move forward, digging...")
            turtle.dig()
        end
    end

    -- Move in Z direction
    local targetZ = _HomeDirection.z
    while _DirectionLog.z < targetZ do
        turnToDirection(2)  -- Turn South
        if not forward() then
            print("Unable to move forward, digging...")
            turtle.dig()
        end
    end
    while _DirectionLog.z > targetZ do
        turnToDirection(0)  -- Turn North
        if not forward() then
            print("Unable to move forward, digging...")
            turtle.dig()
        end
    end

    print("Returned home to coordinates: X=" .. _HomeDirection.x .. ", Y=" .. _HomeDirection.y .. ", Z=" .. _HomeDirection.z)
end

-- Function to turn the turtle to the specified direction
local function turnToDirection(targetDirection)
    while direction ~= targetDirection do
        turtle.turnRight()
        direction = (direction + 1) % 4  -- Update direction (0: North, 1: East, 2: South, 3: West)
    end
end


-- Function to refuel the turtle
local function refuel()
    turtle.refuel()
end

-- Function to mine for diamonds
local function mineForDiamonds()
    -- reach loaction 
    while y > -53 do
        local success, block = turtle.inspect()
        print("inspecting block : "..block.name.."status"..success)
        if success and block.name == "minecraft:bedrock" then
            print("bedrock found! Unbreakeable block going up - blocks")
            turtle.up(5)
            turtle.forward(5)
            turtle.down(4)
        end
        turtle.digDown()
    end 
    while turtle.fuel() > 500 do 
        local success, block = turtle.inspect()
        print("inspecting block : "..block.name.."status"..success)
        if success and block.name == "minecraft:bedrock" then
            print("bedrock found! Unbreakeable block going up - blocks")
            turtle.up(5)
            turtle.forward(5)
            turtle.down(5)
        end
        turtle.dig()
    end
    returnhome()
end
local function mineForDiamonds1()
    -- Dig down to Y = -53
    while _DirectionLog.y > -53 do
        turtle.digDown()
        turtle.down()
        _DirectionLog.y = _DirectionLog.y - 1
    end

    print("Reached mining level: Y = -53")
    
    -- Start strip mining
    while true do
        -- Check fuel level and inventory
        if turtle.getFuelLevel() < 500 or isInventoryFull() then
            print("Returning home due to low fuel or full inventory.")
            returnHome()
            return
        end

        -- Inspect the block ahead
        local success, block = turtle.inspect()
        if success then
            -- If it's bedrock, avoid it
            if block.name == "minecraft:bedrock" then
                print("Bedrock detected! Moving around it.")
                -- Move one block to the side (right) to avoid bedrock
                right(1)  -- Move to the turnRight
                left(1)       -- Turn left back to the original direction
            else
                -- If it's not bedrock, continue mining
                turtle.forward(1) -- Dig the block ahead
            end
        else
            -- If no block is present, just move forward
            forward(1)
        end
    end
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
    mineForDiamonds1()
else
    print("Initialization failed.")
end
