-- Matrix Animation for ComputerCraft
local w, h = term.getSize()
local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"
local columns = {}

-- Initialize columns
for i = 1, w do
    columns[i] = {
        pos = math.random(-h, 0),
        speed = math.random(1, 3),
        length = math.random(5, 15)
    }
end

-- Main animation loop
while true do
    term.clear()
    for x = 1, w do
        local col = columns[x]
        for y = 0, h - 1 do
            local pos = y - col.pos
            if pos >= 0 and pos <= col.length then
                term.setCursorPos(x, y + 1)
                if pos == 0 then
                    term.setTextColor(colors.white)
                else
                    term.setTextColor(colors.green)
                end
                term.write(chars:sub(math.random(1, #chars), math.random(1, #chars)))
            end
        end
        col.pos = col.pos + col.speed
        if col.pos > h + col.length then
            col.pos = math.random(-h, 0)
            col.speed = math.random(1, 3)
            col.length = math.random(5, 15)
        end
    end
    sleep(0.1)
end