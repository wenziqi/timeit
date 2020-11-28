--timeit.lua

local timeit = require("timeit")

local function test()

	local i = 0
	for j=1,100 do
		i = i + j
	end
end

timeit.timeit('a=1')

timeit.timeit(test)

timeit.timeit('a=b+c*d\n print(a)',1,{env={b=10,c=2,d=5}})

local function test_1(n)
	return n*2
end

timeit.timeit(test_1,nil,{func_args={10}})

timeit.timeit(test_1,1,{func_args={10}})


--打印测试函数调用的执行时间。