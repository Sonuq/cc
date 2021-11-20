local seed = ""

--simple log function
local function log(entry)
    local f = fs.open('./log', 'w')
    file.write(entry)
    file.close()
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
    while (turtle.getFuelLevel <= 0) do 
        log('attempting refuel')
        for i=1, 16 do
            turtle.select(i)  
            turtle.refuel()
        end   
    end 
end


local function harvest()
    checkFuel()
    if (checkCrop() == true ) then
        turtle.dig()
        placeCrop()
    else (checkCrop() == nil ) then 
        placeCrop()
    end
    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()
end 

        
while true do 
    harvest()
    dropInventory()
end