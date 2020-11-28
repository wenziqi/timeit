-- @auth    rocky(wenshaoqi)
-- @date    2020-11-28
-- @ver     lua5.3
-- @mail    952623276@qq.com

--[[
项目中经常用到redis,mongodb这样的kv数据库，
存盘时一般都是用save接口打包对象的存盘数据，
返回一个字典，再序列化存到数据库。
这里测试比较save接口的几种实现。
]]--


local timeit = require("timeit")

--定义一个类CTest
local CTest = {}

--实例化对象接口
function CTest.new()
	local inst = {
		m_Name = "rocky",
		m_Age = 30,
		m_Sex = 1,
		m_IP = "127.0.0.1",
		m_Account = "952623276@qq.com"
	}
	setmetatable(inst,{__index=CTest})
	return inst
end

function CTest:GetName()
	return self.m_Name
end

function CTest:GetAge()
	return self.m_Age
end

function CTest:GetSex()
	return self.m_Sex
end

function CTest:GetIP()
	return self.m_IP
end

function CTest:GetAccount()
	return self.m_Account
end


--
function CTest:Save_A()
	local data = {}
	data["Name"] = self:GetName()
	data["Age"] = self:GetAge()
	data["Sex"] = self:GetSex()
	data["IP"] = self:GetIP()
	data["Account"] = self:GetAccount()
	return data
end


function CTest:Save_B()
	local data = {
		["Name"] = self:GetName(),
		["Age"] = self:GetAge(),
		["Sex"] = self:GetSex(),
		["IP"] = self:GetIP(),
		["Account"] = self:GetAccount(),
	}
	return data
end

function CTest:Save_C()
	if not self._cacheSave then
		self._cacheSave = {}
	end
	local data = self._cacheSave
	data["Name"] = self:GetName()
	data["Age"] = self:GetAge()
	data["Sex"] = self:GetSex()
	data["IP"] = self:GetIP()
	data["Account"] = self:GetAccount()
	return data
end


function CTest:Save_D()
	if not self._cacheSave then
		self._cacheSave = {}
	end
	local data = self._cacheSave
	data["Name"] = self.m_Name
	data["Age"] = self.m_Age
	data["Sex"] = self.m_Sex
	data["IP"] = self.m_IP
	data["Account"] = self.m_Account
	return data
end

--------------------------------------------
local t = CTest.new()


local function Test_A()
	t:Save_A()
end

local function Test_B()
	t:Save_B()
end

local function Test_C()
	t:Save_C()
end

local function Test_D()
	t:Save_D()
end





timeit.timeit(Test_A)
timeit.timeit(Test_B)
timeit.timeit(Test_C)
timeit.timeit(Test_D)

--[[
cost:0.15473;number:100000    --Save_A
cost:0.080188;number:100000   --Save_B
cost:0.057209;number:100000   --Save_C
cost:0.032074;number:100000   --Save_D
]]-- 

--[[
1.Save_A接口先生成一个空的table,之后每次
  增加字段都有可能触发table的rehash,重新
  申请内存释放内存。

2.Save_B接口则是一次性生成包含所有字段的
  table,避免触发table的rehash，所以效率要
  比Save_A接口高。

3.Save_B接口虽然避免了rehash,但是每次调用
  还是会生成一个新的table,考虑到每个对象的
  存盘数据字段相对固定，可以缓存这个table,
  调用存盘接口时再去更新字段的值。Save_C
  接口出了第一次调用会生成新的table,以及触
  发rehash之外，之后都是使用缓存，没有这些
  问题，实验也证明Save_C要比Save_B效率高。

4.Save_D接口则是在Save_C的基础上进一步优化，
  直接访问对象属性，而不是调用对象的方法，
  可以看书性能也是有比较大的提高。因为每次
  函数调用都是有开销的。

5.其实Save_C和Save_D还可以进一步优化，就是
  实例化对象时生成缓存table,这样就不用每次
  调用存盘接口时都要判断了。


6.这些优化方法其实不止是lua,python也同样适用。

]]--
