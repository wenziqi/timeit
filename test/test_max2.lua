-- @auth    rocky(wenshaoqi)
-- @date    2020-12-01
-- @ver     lua5.2,5.3
-- @mail    952623276@qq.com

local timeit = require("timeit")
local max = math.max

local x=10
local y=2

local function Test_A()
	local m = x
	if x<y then m=y end
end

local function Test_B()
	local m = max(x,y)
end



local n = 1000000
timeit.timeit(Test_A,n)
timeit.timeit(Test_B,n)

--[[
cost:0.37;number:1000000
cost:0.454;number:1000000

]]--

