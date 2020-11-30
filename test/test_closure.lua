-- @auth    rocky(wenshaoqi)
-- @date    2020-11-30
-- @ver     lua5.2,5.3
-- @mail    952623276@qq.com

local timeit = require("timeit")




local function Test_A()
	local i=0
	local list = {1,2,3,4,5,6,7,8,9,10}
	local function _iter()
		return function () 
			i = i + 1
			return list[i] 
		end 
	end
	local it = _iter()
	while it() do end
end


local function Test_B()
	local i=0
	local list = {1,2,3,4,5,6,7,8,9,10}
	local function _iter()
		return function (i) 
			return list[i] 
		end 
	end
	local it = _iter()
	while it(i) do i = i + 1 end
end



local n = 10000
timeit.timeit(Test_A,n)
timeit.timeit(Test_B,n)

--[[
cost:0.052;number:10000
cost:0.028;number:10000

]]--

