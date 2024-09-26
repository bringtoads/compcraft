-- Matrix Animation for ComputerCraft Monitor
local monitor = peripheral.wrap("right") -- Adjust this based on where your monitor is connected
local w, h = 8, 4 -- Set width to 8 and height to 4
local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"
local columns = {}

-- Initialize columns
for i = 1, w do
    columns[i] = {
        pos = math.random(-h, 0),
        speed = math.random(1, 2), -- Reduced speed range due to smaller height
        length = math.random(2, 4) -- Adjusted length range for smaller height
    }
end

-- Set up monitor
monitor.setTextScale(1)
monitor.clear()

-- Main animation loop
while true do
    for x = 1, w do
        local col = columns[x]
        for y = 1, h do
            local pos = y - col.pos
            monitor.setCursorPos(x, y)
            if pos >= 0 and pos <= col.length then
                if pos == 0 then
                    monitor.setTextColor(colors.white)
                else
                    monitor.setTextColor(colors.green)
                end
                monitor.write(chars:sub(math.random(1, #chars), math.random(1, #chars)))
            else
                monitor.write(" ") -- Clear previous characters
            end
        end
        col.pos = col.pos + col.speed
        if col.pos > h + col.length then
            col.pos = math.random(-h, 0)
            col.speed = math.random(1, 2)
            col.length = math.random(2, 4)
        end
    end
    sleep(0.2) -- Slightly slower update rate for smaller display
end