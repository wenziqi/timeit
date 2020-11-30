-- @auth    rocky(wenshaoqi)
-- @date    2020-11-30
-- @ver     lua5.2,5.3
-- @mail    952623276@qq.com

local timeit = require("timeit")
local max = math.max

local list = {}
local nr = 100
math.randomseed(os.time())
for i=1,nr do
	list[i] = math.floor(math.random()*10000)
end

local function Test_A()
	local m 
	for i=1,#list do
		if not m or list[i]>m then m=list[i] end
	end
end

local function Test_B()
	local m
	for i=1,#list do
		if not m then 
			m = list[i]
		else 
			m = max(m,list[i])
		end
	end
end



local n = 10000
timeit.timeit(Test_A,n)
timeit.timeit(Test_B,n)

--[[
cost:0.123;number:10000
cost:0.24;number:10000



]]--

