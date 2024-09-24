-- Define turtle actions
local function moveForward()
    if turtle.forward() then
        print("Turtle moved forward.")
    else
        print("Turtle failed to move forward.")
    end
end

local function turnRight()
    turtle.turnRight()
    print("Turtle turned right.")
end

local function turnLeft()
    turtle.turnLeft()
    print("Turtle turned left.")
end

local function dig()
    if turtle.dig() then
        print("Turtle dug successfully.")
    else
        print("Nothing to dig.")
    end
end

local function placeBlock()
    if turtle.place() then
        print("Block placed.")
    else
        print("Failed to place block.")
    end
end

-- A table mapping commands to functions
local actions = {
    forward = moveForward,
    right = turnRight,
    left = turnLeft,
    dig = dig,
    place = placeBlock,
}

-- Function to fetch and execute commands from the server
local function pollServer()
    local url = "http://<your-server-address>/get-command"  -- Replace with your server URL
    local response = http.get(url)
    
    if response then
        local command = response.readAll()
        response.close()

        -- Execute the corresponding action
        if actions[command] then
            print("Executing command: " .. command)
            actions[command]()
        else
            print("Unknown command: " .. command)
        end
    else
        print("Failed to fetch command from the server.")
    end
end

-- Main loop that continuously polls the server for commands
while true do
    pollServer()
    sleep(2)  -- Poll every 2 seconds
end
