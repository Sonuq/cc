local args = {...}
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
if not args[1] then
    print("use 'tnt <steps>' to place and ignite tnt")
    return 
else
    bomb(args[1], args[2])
end
