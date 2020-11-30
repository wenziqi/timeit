-- @auth    rocky(wenshaoqi)
-- @date    2020-11-30
-- @ver     lua5.2,5.3
-- @mail    952623276@qq.com

local timeit = require("timeit")
local unpack = table.unpack

local list = {1,2,3}

local function Test_A()
	return list[1],list[2],list[3]
end

local function Test_B()
	return unpack(list)
end

timeit.timeit(Test_A)
timeit.timeit(Test_B)

--[[
cost:0.041;number:100000
cost:0.064;number:100000

]]--

