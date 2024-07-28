# seed20
20 Lines seeded random library for Lua, allowing for multiple instances of RNG generators and deterministic randomness.

# Example Usage
```lua
require("path.to.seed20") -- doesn't require assigning to a variable!

random() -- equivalent to math.random()

local rnd = random.new(123)
local a = rnd:get()
local b = rnd:get()
rnd.set_seed(123)
local c = rnd:get()

assert(a == c) -- first number generated after setting seed is always the same
assert(a ~= b) -- second number should never be equal to the first
```

# Function List
- `random()` - Equivalent to both `math.random` and `random:get()`. Can be called with 0, 1, or 2 arguments.
- `random.new([seed])` - Returns a new seed20 instance.

(For the functions below, assume we ran the code `local instance = random.new()`)
- `instance:get()` or `instance()` - Returns a random number based on arguments given.
- `instance:export()` - Returns the current state of the seed20 instance as a table, should be used for save files and such.
- `instance:import(table)` - Sets the current state of the seed20 instance based off a previous export.
- `instance:set_seed(seed)` - Sets the seed of the random object.

# Additional Credits
- Naming convention inspired by Yonaba's [30log](https://github.com/Yonaba/30log).
