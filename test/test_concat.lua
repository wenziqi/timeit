-- @auth    rocky(wenshaoqi)
-- @date    2020-11-28
-- @ver     lua5.3
-- @mail    952623276@qq.com

local timeit = require("timeit")


local n = 100
local bigTable = {}
for i=1,n do 
	bigTable[i]=tostring(i)
end


local function Test_A()
	local s=''
	for i=1,#bigTable do
		s = s .. bigTable[i]
	end
end

local function Test_B()
	local t = {}
	for i=1,#bigTable do
		t[i] = bigTable[i]
	end
	local s = table.concat(t)
end

local function Test_C()
	local s=table.concat(bigTable)
end


timeit.timeit(Test_A)
timeit.timeit(Test_B)
timeit.timeit(Test_C)

--[[
cost:2.286448;number:100000     --Test_A
cost:1.669879;number:100000     --Test_B
cost:0.686212;number:100000     --Test_C
]]-- 

--[[
可以发现，当要拼接的字符串数量很多时，
concat要比..效率高
]]--
