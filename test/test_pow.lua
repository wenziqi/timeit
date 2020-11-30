-- @auth    rocky(wenshaoqi)
-- @date    2020-11-30
-- @ver     lua5.2,5.3
-- @mail    952623276@qq.com

local timeit = require("timeit")
local pow = math.pow


local x = 10

local function Test_A()
	return x^2
end


local function Test_B()
	return x*x
end

local function Test_c()
	return pow(x,2)
end


local n = 1000000
timeit.timeit(Test_A,n)
timeit.timeit(Test_B,n)
timeit.timeit(Test_c,n)

--[[
cost:0.479;number:1000000
cost:0.331;number:1000000
cost:0.525;number:1000000

]]--

