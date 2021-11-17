-- local args = {...}
-- local function getAmount(ItemName)
--     local total = 0
--     for i=1, 16 do
--         turtle.select()
--         local slotamount = turtle.getItemDetail()
--         if item ~= nil then 
--             if item["name"] == ItemName then 
--                 turtle.getItemCount() + total
--             end 
--         end 
--     end 
--     return total 
-- end             
local function bomb(n, size)
    for i=1, n do
        turtle.forward()
        for i=1, 16 do
            turtle.select(i)
            local item = turtle.getItemDetail()
            if item ~= nil then 
                if item["name"] == "minecraft:tnt" then
                    for i=1, size do 
                        turtle.placeDown()
                        redstone.setOutput('bottom', true)
                    end
                end 
            end 
        end 
    end 
end
rednet.open('left')
local id, data = rednet.receive()
if id then 
    if not data[1] or not data[2] then
        return 
    else
        bomb(data[1], data[2])
    end
end 

