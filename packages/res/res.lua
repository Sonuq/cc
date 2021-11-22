local function log(entry)
    local f = fs.open('./log', 'a')
    f.write(entry)
    f.close()
end 

local data = { 
    key = nil
}
if fs.exists('./data') == true then
    log('recalling data') 
    local f = fs.open("./data", "r")
    local data = textutils.serialize(f.readAll())
    f.close()
end


if key == nil then 
    log('error : no key given')
end 


res = {}
function res:set_key(key)
    data.key = key
    local f = fs.open("./data")
    f.write(data)
    f.close()
end

function res:setOutput()
    rednet.open('left')
    local id, message = rednet.receive()
    if not msg[1] or not msg[2] or not msg[3] then 
        log('improper request sent')
    else 
        if msg[1] == key then 
            redstone.setOutput(msg[2], msg[3])
            log(string.format('redstone output : side=%s on=%s', msg[2], msg[3]))
        end
    end 
    rednet.close('left')
end 


function res:getOutput()
    rednet.open('left')
    local id, message = rednet.receive()
    if not msg[1] or not msg[2] then 
        log('improper request sent')
    else 
        if msg[1] == key then 
            redstone.setOutput(msg[2])
            log(string.format('redstone get output : side=%s', msg[2]))
        end 
    end 
    rednet.close('left')
end

function res:getAnalogInput()
    rednet.open('left')
    local id, message = rednet.receive()
    if not msg[1] or not msg[2] then 
        log('improper request sent')
    else 
        if msg[1] == key then 
            redstone.getAnalogInput(msg[2])
            log(strng.format('redstone get input : side=%s', msg[2]))
        end 
    end 
    rednet.close('left')
end
