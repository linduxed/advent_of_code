local one = {}

local function up_or_down(char, floor)
    if char == "(" then
        return floor + 1
    elseif char == ")" then
        return floor - 1
    else
        error("Not a paren: " .. char)
    end
end

function one.final_floor(chars)
    local floor = 0

    for i = 1, chars:len() do
        local char = chars:sub(i, i)
        floor = up_or_down(char, floor)
    end

    return floor
end

function one.basement_char(chars)
    local floor = 0

    for i = 1, chars:len() do
        local char = chars:sub(i, i)
        floor = up_or_down(char, floor)

        if floor < 0 then
            return i
        end
    end
end

return one
