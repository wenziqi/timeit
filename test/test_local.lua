-- @auth    rocky(wenshaoqi)
-- @date    2020-11-27
-- @ver     lua5.3
-- @mail    952623276@qq.com
local timeit = require("timeit")


local n = 100
local floor = math.floor

local function Test_A()
	for i=1,n do
		local s = math.floor(i)
	end
end

local function Test_B()
	local floor = math.floor
	for i=1,n do
		local s = floor(i)
	end
end

timeit.timeit(Test_A)
timeit.timeit(Test_B)

--[[
cost:0.804657;number:100000
cost:0.603486;number:100000
]]--

