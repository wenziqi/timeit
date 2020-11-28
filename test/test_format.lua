-- @auth    rocky(wenshaoqi)
-- @date    2020-11-28
-- @ver     lua5.3
-- @mail    952623276@qq.com

local timeit = require("timeit")


local n = 100

local function Test_A()
	for i=1,n do
		local s = string.format("%s%s","test",tostring(i))
	end
end

local function Test_B()
	for i=1,n do
		local s = table.concat({"test",tostring(i)})  --这里每次都会生成一个新的table,是个干扰因素
	end
end

local _tmpTable = {'test',nil}
local function Test_BB()
	for i=1,n do
		_tmpTable[2]=tostring(i)
		local s = table.concat(_tmpTable)  --每次使用固定的table,排除干扰因素。
	end
end

local function Test_C()
	for i=1,n do
		local s = "test"..tostring(i)
	end
end

timeit.timeit(Test_A)
timeit.timeit(Test_B)
timeit.timeit(Test_C)
timeit.timeit(Test_BB)

--[[
cost:0.878931;number:100000   -- Test_A
cost:1.025209;number:100000   -- Test_B
cost:0.574969;number:100000   -- Test_C
]]--

--用..拼接字符串要比其他两种方式要好

--[[
cost:0.916606;number:100000   -- Test_A
cost:0.930618;number:100000   -- Test_B
cost:0.435413;number:100000   -- Test_C
cost:0.731507;number:100000   -- Test_BB

]]--