one = {}

up_or_down = (char, floor) ->
    if char == "("
        return floor + 1
    elseif char == ")"
        return floor - 1
    else
        error("Not a paren: " .. char)

one.final_floor = (chars) ->
    floor = 0

    for i = 1, chars\len!
        char = chars\sub(i, i)
        floor = up_or_down(char, floor)

    floor

one.basement_char = (chars) ->
    floor = 0

    for i = 1, chars\len!
        char = chars\sub(i, i)
        floor = up_or_down(char, floor)

        if floor < 0
            return i

one
