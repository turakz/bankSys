local testClass = {}

testClass.__index = testClass

function testClass.new()
    local self = {fname = "", lname= ""}
    setmetatable(self, testClass)
    return self
end

function testClass:some_method()
    print("hello, world!")
end

function testClass:set_fname()
    io.write("first\n>>")
    self.fname = io.read()
end

function testClass:set_lname()
    io.write("last\n>>")
    self.lname = io.read()
end

function testClass:getfname()
    return self.fname
end

function testClass:getlname()
    return self.lname
end

a1 = testClass.new()
a2 = testClass.new()

a1:set_fname()
a1:set_lname()
a2:set_fname()
a2:set_lname()

peoples = {}

table.insert(peoples, a1)
table.insert(peoples, a2)

for _, v in ipairs(peoples) do
    print("first: "..v:getfname())
    print("last: "..v:getlname())
end

