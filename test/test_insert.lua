-- @auth    rocky(wenshaoqi)
-- @date    2020-11-27
-- @ver     lua5.3
-- @mail    952623276@qq.com

local timeit = require("timeit")


local n = 100
local floor = math.floor

local function Test_A()
	local t = {}
	for i=1,n do
		table.insert(t,i)
	end
end

local function Test_B()
	local t = {}
	for i=1,n do
		t[#t+1] = i
	end
end

local function Test_C()
	local t = {}
	local j = 0
	for i=1,n do
		j = j + 1
		t[j] = i
	end
end

timeit(Test_A)
timeit(Test_B)
timeit(Test_C)

--[[
cost:2.573249;number:100000
cost:1.176226;number:100000
cost:0.785755;number:100000
]]--

