-- @auth    rocky(wenshaoqi)
-- @date    2020-11-30
-- @ver     lua5.2,5.3
-- @mail    952623276@qq.com

local timeit = require("timeit")
local pow = math.pow


local x = 2
local y = 10

local function Test_A()
	return x^y
end


local function Test_B()
	return pow(x,y)
end


local n = 1000000
timeit.timeit(Test_A,n)
timeit.timeit(Test_B,n)

--[[
cost:0.48;number:1000000
cost:0.555;number:1000000

]]--
