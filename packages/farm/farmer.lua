local seed = ""
local rowSize = ""
--simple log function
local function log(entry)
    local f = fs.open('./log', 'w')
    f.write(entry)
    f.close()
end


local function checkCrop()
    local has_block, data = turtle.inspect()
    if has_block then 
        if data["age"] == 7 then 
            return true   
        else 
            return false 
        end 
    else 
        return nil
    end 
end



local function dropInventory()
    log('dropping inventory...')
    for i=1, 16 do 
        turtle.select(i)
        turtle.drop()
    end 
end 


local function placeCrop()
    for i=1, 16 do 
        turtle.select(i)
        local item = turtle.getItemDetail()
        if item["name"] == seed then 
            turtle.place()
            return true   
        end 
    end 
end


local function checkFuel()
    while (turtle.getFuelLevel() <= 0) do 
        log('attempting refuel')
        for i=1, 16 do
            turtle.select(i)  
            turtle.refuel()
        end   
    end 
end

local steps = 0
local function move()
    if rowSize > steps then 
        turtle.turnLeft()
        turtle.forward()    
        turtle.turnRight()
        steps + 1
    else
        turtle.turnRight()
        turtle.forward() 
    end
end

local function harvest()
    checkFuel()
    if (checkCrop() == true ) then
        turtle.dig()
        placeCrop()
        return true
    else (checkCrop() == nil ) then 
        placeCrop()
        return true
    else 
        return false 
    end
end 

        
while true do 
    repeat 
        local h = harvest()
    until (h == true)
    dropInventory()
end
