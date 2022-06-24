local args = {...}
local blacklist = {'minecraft:cobblestone', 'minecraft:dirt', 'create:andesite_cobblestone'}
local notMine = 'forbidden_arcanus:stella_arcanum'
term.clear()
os.loadApi('apis/mover.lua')


local function cPrint(str, color)
    term.setTextColor(color)
    print(str)
    term.setTextColor(colors.white)
end 


if turtle.getFuelLevel() == 0 then 
    cPrint('no fuel', colors.red)
end

os.loadApi('mover.lua')



local function forward()
    while (turtle.getFuelLevel() == 0) do 
        cPrint('Attempting refuel...', colors.red)
        for slot = 1, 16 do 
            turtle.select()
            turtle.refuel()
        end
    end
    turtle.forward()
end

local function isItemBad(x)
    for i, item in ipairs(blacklist) do
        if  item == x then 
            return true 
        end 
    end 
    return false
end 




local function inventoryRoutine()
    cPrint('Clearing inventory...', colors.green)
    if turtle.getItemSpace(16) == 0 then
        for slot = 1, 16 do 
            turtle.select(slot)
            if isItemBad(turtle.getItemDetail().name) == true then 
                print('===============================')
                cPrint('Cleared' .. ' ' .. turtle.getItemCount() .. ' ' .. turtle.getItemDetail().name, colors.green)
                term.clear()
                turtle.drop()
            end
            print('===============================')
        end 
    end

end
local function dig()
    if turtle.inspect().name == notMine then
        mover.go_to(0, 0, 0)
    end
end

local function digDown()
    if turtle.inspectDown().name == notMine then
        mover.go_to(0, 0, 0)

    end
end


local function digUp()
    if turtle.inspectUp().name == notMine then
        mover.go_to(0, 0, 0)
    end    
end


local function mineRoutine()
    for i = 1, args[1] do
        turtle.dig()
        turtle.digDown()
        turtle.digUp()
        forward()
        turtle.turnRight()

        for i = 1, 3 do 
            turtle.dig()
            turtle.digDown()
            turtle.digUp()
            forward()
        end
        
        turtle.turnLeft()
        turtle.digDown()
        turtle.digUp()
        turtle.dig()
        forward()
        turtle.turnLeft()

        for i = 1, 3 do 
            turtle.dig()
            turtle.digDown()
            turtle.digUp()
            forward()
        end

        turtle.turnRight()
    end
end



parallel.waitForAny(mineRoutine, inventoryRoutine)
mover.go_to(0, 0, 0)
inventoryRoutine()
if turtle.inspect().name == 'minecraft:chest' then 
    turtle.drop()
end 
