#!/usr/bin/env lua 
--bankSys class
local bankSys = {}

bankSys.__index = bankSys

--constructor
function bankSys.new()

    local self = {
        
        id = "",
        fname = "",
        lname = "",
        balance = 0

    }
    setmetatable(self, bankSys)
    return self

end

--getters
function bankSys:getId()

    return self.id

end

function bankSys:getFname()

    return self.fname

end

function bankSys:getLname()

    return self.lname

end

function bankSys:getBalance()

    return self.balance

end

--setters
function bankSys:setId()
    
    io.write("Account ID#\n>>")
    local id = io.read()
    --we want just digits
    while hasDigit(id) do
        if hasAlpha(id) then
            io.write("\nBad input\n>>")
            id = io.read()
        end
        break
    end
    self.id = string.upper(id)

end

function bankSys:setFname()

    io.write("First Name\n>>")
    local fname = io.read()
    --we want just letters
    while hasDigit(fname) do
        io.write("\nBad input\n>>")
        fname = io.read()
    end
    self.fname = string.upper(fname)

end

function bankSys:setLname()
    
    io.write("Last Name\n>>")
    local lname = io.read()
    while hasDigit(lname) do
        io.write("\nBad input\n>>")
        lname = io.read()
    end
    self.lname = string.upper(lname)
end

function bankSys:setBalance()

    io.write("Balance\n>>")
    local balance = tonumber(io.read())
    while hasAlpha(tostring(balance)) do
        io.write("\nBad input\n>>")
        balance = tonumber(io.read())
    end
    self.balance = balance

end

function bankSys:deposit()
    
    io.write("Deposit amount\n>>")
    local amount = tonumber(io.read())
    while hasAlpha(tostring(amount)) do
        io.write("\nBad input\n>>")
        amount = tonumber(io.read())
    end
    self.balance = self.balance + amount
end

function bankSys:withdrawal()
    
    io.write("Withdrawal amount\n>>")
    local amount = tonumber(io.read())
    while hasAlpha(tostring(amount)) do
        io.write("\nBad input\n>>")
        amount = tonumber(io.read())
    end
    self.balance = self.balance - amount

end
--end of class bankSys

--helper functions
function printInfo(accounts)
    
    index = getAccount(accounts)
    os.execute("clear")
    print("FIRST:"..accounts[index]:getFname())
    print("LAST:"..accounts[index]:getLname())
    print("BALANCE:"..accounts[index]:getBalance())
    print("ID:"..accounts[index]:getId())
    io.write("\npress enter to continue.. ")
    io.read()

end

function printHeader()
    
    io.write(
        "|ACCOUNT |FIRST: "..accounts[a_index]:getFname()
        .." |LAST: "..accounts[a_index]:getLname()
        .." |ID: "..accounts[a_index]:getId()
        .." |BALANCE: $"..accounts[a_index]:getBalance()
        .."\n\n")

end

function getAccount(accounts)

    --find object via id, return table index
    os.execute("clear")
    io.write("Account ID\n>>")
    input = io.read()
    while hasAlpha(input) do
        io.write("\nBad input\n>>")
        input = io.read()
    end
    for i, v in ipairs(accounts) do
        if (input == v:getId()) then
            return i
        end
    end

end

function editAccount(a)
    
    os.execute("clear")
    local menu = {
    
        "First Name",
        "Last Name",
        "Account ID#",
        "Balance",

    }
    for k, v in ipairs(menu) do
        print(k.." - "..v)
    end
    io.write("\n>>")
    local choice = tonumber(io.read())
    if choice == 1 then
        a:setFname()
    elseif choice == 2 then
        a:setLname()
    elseif choice == 3 then
        a:setId()
    elseif choice == 4 then
        a:setBalance()
    end

end
    

function displayMenu()
    
    local menu = {
        
        "Add Account",
        "Select Account",
        "Deposit",
        "Withdrawal",
        "Edit Account Details",
        "Save Accounts",
        "Load Accounts",
        "Exit"
        
        }
    for k, v in ipairs(menu) do
        print(k.." - "..v)
    end

end

function hasDigit(input)
    
    if string.find(input, "%d+") then
        return true
    end

end

function hasAlpha(input)
    
    if string.find(input, "%a+") then
        return true
    end

end

function fromFile(a)
    
    os.execute("clear")
    io.write("Filename?\n>>")
    file_name = io.read()
    local f = assert(io.open(file_name, "r"))
    --grab input in 4 line chunks since we know fields
    while true do
        local fname, lname, id, balance = f:read("*line", "*line", "*line", "*line")
        if not fname then break end
        a = bankSys.new()
        a.fname = fname
        a.lname = lname
        a.id = id
        a.balance = tonumber(balance)
        table.insert(accounts, a)
    end
    f:close()

end

function toFile(accounts)
    
    os.execute("clear")
    io.write("Filename?\n>>")
    file_name = io.read()
    local f = io.open(file_name, "w")
    --write to file
    for k, v in ipairs(accounts) do
        f:write(v:getFname().."\n")
        f:write(v:getLname().."\n")
        f:write(v:getId().."\n")
        f:write(v:getBalance().."\n")
    end
    f:close()

end

--main
accounts = {}
choice = 0
a_index = 0

repeat
    
    io.write("\n")
    if choice == 1 then
        --add account
        os.execute("clear")
        a = bankSys.new()
        a:setFname()
        a:setLname()
        a:setId()
        a:deposit()
        table.insert(accounts, a)

    elseif choice == 2 then
        --select account
        a_index = getAccount(accounts)

    elseif choice == 3 then
        --deposit
        os.execute("clear")
        accounts[a_index]:deposit()

    elseif choice == 4 then
        --withdrawal
        os.execute("clear")
        accounts[a_index]:withdrawal()

    elseif choice == 5 then
        --edit account details
        editAccount(accounts[a_index])

    elseif choice == 6 then
        --save details
        toFile(accounts)
    elseif choice == 7 then
        --load database
        fromFile(accounts)
    end

    choice = 0
    os.execute("clear")
    if a_index ~= 0 then
        printHeader()
    end

    displayMenu()
    io.write("\n>>")
    choice = tonumber(io.read())
    io.write("\n")

until choice == 8 

io.write("Have a nice day!\n")
io.write("press enter to exit.. ")
io.read()
