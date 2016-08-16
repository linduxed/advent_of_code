local one = require("one")

local line = io.read("*line")

print("Final floor: " .. one.final_floor(line))
print("First basement char: " .. one.basement_char(line))
