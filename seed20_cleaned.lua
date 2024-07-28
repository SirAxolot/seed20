--
-- seed20 by razzle4tazzle (https://github.com/SirAxolot/seed20)
--

local seed20 = {}

-- store math.random in a variable to prevent feedback loops once we replace it
local rnd = math.random
local rnd_seed = math.randomseed
local max_int = 9007199254740991 -- math.maxinteger doesnt exist before 5.3, manual workaround

-- create a new random seed
function seed20.new(seed, i)
    local instance = setmetatable({}, seed20)
    instance.seed = math.fmod(seed or os.time(), max_int)

    -- tracks the current amount of numbers generated, to offset the seed value
    -- this is so the same seed wont return the same value after multiple random() calls
    instance.i = i or 0
    return instance
end

-- functionally similar to math.random
function seed20:get(...)
    rnd_seed(self.seed + self.i)
    self.i = math.fmod(self.i + 5381, max_int)
    return rnd(...)
end

function seed20:set_seed(seed)
    self.i = 0
    self.seed = seed
end

-- for saving/loading seeds to/from save files.
function seed20:export() return {self.seed, self.i} end
function seed20:import(t)
    self.seed, self.i = t[1], t[2]
end

-- calling random() in global scope will return the global math.random
seed20.__call = seed20.get

-- global seed for simulating math.random calls with this system in place
-- it's not recommended to use the global seed for anything which you need to be deterministically random,
-- but for nondeterministic stuff like visual effects its okay
_G.random = seed20.new()

-- finally, override the math random functions with their global seed counterparts.
-- this will simulate the regular math.random function with minimal overhead, while still allowing support for the new random system.
rawset(math, "random", function (...) return _G.random:get(...) end)
rawset(math, "randomseed", function (...) return _G.random:set_seed(...) end)
