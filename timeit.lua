-- @auth    rocky(wenshaoqi)
-- @date    2020-11-27


local os = os


local function timeit(stmt,number,args)
	local args = args or {}
	local env = args.env or {}
	local new_env = {}
	for k,v in pairs(_G) do
		new_env[k] = v
	end
	for k,v in pairs(env or {}) do
		new_env[k] = v
	end
	
	local number = number or args.number or 10*10000
	local timer = args.timer or os.clock
	local func = stmt
	if type(func) == 'string' then
		func = load(stmt..'\n return true','timeit','bt',new_env)
	end
	assert(type(func)=='function','#1 stmt must be a fucntion or a string')

	local setup = args.setup
	if setup and type(setup)=='string' then
		setup = load(setup..'\n return true','setup','bt',new_env)
	end

	if setup then
		setup()
	end

	local t0 = timer()
	for i=1,number do
		func()
	end
	local t = timer() - t0
	print("cost:"..t..';number:'..number)
	return t

end




-- local function test()
-- 	local i = 0
-- 	for j=1,100 do
-- 		i = i + j
-- 	end
-- end

-- timeit('a=1')
-- timeit(test)


return {
	timeit=timeit,
}