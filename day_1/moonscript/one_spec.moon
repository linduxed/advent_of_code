one = require("one")

describe "final_floor", ->
    it "returns 3 for the string '((('", ->
        assert.are.equal(one.final_floor("((("), 3)

    it "returns -3 for the string ')))'", ->
        assert.are.equal(one.final_floor(")))"), (-3))

    it "returns 0 for the string '((()))'", ->
        assert.are.equal(one.final_floor("((()))"), 0)

    it "errors if one of the input characters is not a paren", ->
        assert.has_error(-> one.final_floor("()()x"), "Not a paren: x")

describe "basement_char", ->
    it "returns how many chars it takes to get to a negative floor", ->
        assert.are.equal(one.basement_char("(((()))))"), 9)
