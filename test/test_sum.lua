-- @auth    rocky(wenshaoqi)
-- @date    2020-11-30
-- @ver     lua5.2,5.3
-- @mail    952623276@qq.com

local timeit = require("timeit")



local function sumA(n)
	if n<=1 then return 1 end
	return n + sumA(n-1) 
end

local function sumB(n,s)
	s = s or 1
	if n<=1 then return s end
	return sumB(n-1,n+s)
end


local n = 100
local function Test_A()
	sumA(n)
end

local function Test_B()
	sumB(n)
end



local n = 10000
timeit.timeit(Test_A,n)
timeit.timeit(Test_B,n)

--[[
cost:0.187;number:10000
cost:0.195;number:10000

]]--

