 local args = {...}
local function bomb(n)
    for i=1, n then 
        turtle.forward()
        for i=1, 16 then 
            turtle.select(i)
            local item = turtle.getItemDetail()
            if item then 
                if item["name"] == "minecraft:tnt" then 
                    turtle.placeDown()
                    redstone.setOutput('bottom', 0.1)
                end 
            end 
        end 
    end 
end 
if not args[1] then
    print("use 'tnt <steps>' to place and ignite tnt")
    return 
else
    bomb(args[1])
end
