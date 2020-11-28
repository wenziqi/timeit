-- @auth    rocky(wenshaoqi)
-- @date    2020-11-28
-- @ver     lua5.3
-- @mail    952623276@qq.com

--[[

-- 项目里计算数值经常用到公式，
   这些公式都是策划填在导表里，
   每次都是用load函数来加载执 
   行，没做缓存。所以这里提出
   一种优化方案，并进行对比。
]]--


local string = string
local _cache = {}
local _template = [[

local math = math
local max = math.max
local min = math.min
local floor = math.floor
local ceil = math.ceil

local function __eval(env)
	local _ENV = env
	return %s
end
return __eval
]]

local function eval_cache(formula,env)
	local chunk = _cache[formula]
	if not chunk then
		chunk = load(string.format(_template,formula),"eval","bt")
		_cache[formula] = chunk
	end
	return chunk()(env)
end


local function eval_no_cache(formula,env)
	return load("return ".. formula,"eval","bt",env)()
end

--------------------------------------------

local sformula = "a+b*c"
local env = {a=10,b=100,c=2}
print("cache:",eval_cache(sformula,env))
print("no_cache:",eval_no_cache(sformula,env))

local function Test_A()
	eval_cache(sformula,env)
end

local function Test_B()
	eval_no_cache(sformula,env)
end


local timeit = require("timeit")
timeit.timeit(Test_A)
timeit.timeit(Test_B)

--[[
cache:	210
no_cache:	210
cost:0.05029;number:100000      -- eval_cache
cost:0.252281;number:100000     -- eval_no_cache

-- eval_cahe 避免了每次都load一个新的chunk

]]-- 


