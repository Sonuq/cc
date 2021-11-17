local args = {...}
rednet.open('top')
if not args[1] or not args[2] then 
    print("control <steps> <dropAmount>")
else
    rednet.broadcast(args)
end