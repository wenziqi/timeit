-- @auth    rocky(wenshaoqi)
-- @date    2020-11-30
-- @ver     lua5.2,5.3
-- @mail    952623276@qq.com

local timeit = require("timeit")

local list = {1,2,3,4,5,6,7,8,9,10}

local function Test_A()
	for i=1,#list do
	end
end

local function Test_B()
	for i,v in ipairs(list) do 
	end
end

local function Test_C()
	for i,v in ipairs(list) do 
	end
end

local n = 100000
timeit.timeit(Test_A,n)
timeit.timeit(Test_B,n)
timeit.timeit(Test_C,n)

--[[
cost:0.07;number:100000
cost:0.212;number:100000
cost:0.21;number:100000

-- Test_A要比其两种方式效率高，其他两种则不相上下

]]--

