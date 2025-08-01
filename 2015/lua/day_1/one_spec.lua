local one = require("one")

describe("final_floor", function()
    it("returns 3 for the string '((('", function()
        assert.are.equal(one.final_floor("((("), 3)
    end)

    it("returns -3 for the string ')))'", function()
        assert.are.equal(one.final_floor(")))"), (-3))
    end)

    it("returns 0 for the string '((()))'", function()
        assert.are.equal(one.final_floor("((()))"), 0)
    end)

    it("errors if one of the input characters is not a paren", function()
        assert.has_error(
            function() one.final_floor("()()x") end,
            "Not a paren: x"
        )
    end)
end)

describe("basement_char", function()
    it("returns how many chars it takes to get to a negative floor", function()
        assert.are.equal(one.basement_char("(((()))))"), 9)
    end)
end)
