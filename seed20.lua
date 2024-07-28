-- seed20 by razzle4tazzle (https://github.com/SirAxolot/seed20)
local a,b,c,d={},math.random,math.randomseed,9007199254740991
function a.new(e,f)
    local g=setmetatable({},a)
    g.seed,g.i=math.fmod(e or os.time(),d), f or 0
    return g
end
function a:get(...)
    c(self.seed+self.i)
    self.i=math.fmod(self.i+5381,d)
    return b(...)
end
function a:set_seed(e)
    self.i, self.seed = 0,e
end
function a:export() return {self.seed,self.i} end
function a:import(h) self.seed,self.i= h[1],h[2] end
a.__call,_G.random=a.get,a.new()
rawset(math,"random",function(...)return _G.random:get(...)end)
rawset(math,"randomseed",function(...)return _G.random:set_seed(...)end)
