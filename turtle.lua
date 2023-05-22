local modem_side = "left"
print("turtle running on Channel "..os.getComputerID())
redet.open(modem_side)

while true do
    local id, msg = rednet.receive()






local sSide = "right"
print("Turtle running on Channel "..os.getComputerID())
rednet.open(sSide)
while true do
local id, msg = rednet.receive(1)

if msg then
  if msg == "Init" then
   rednet.send(id, "Good")
  else
   msg = tonumber(msg)

   if msg == 16 then
        print("Stopping")
        rednet.close(sSide)
        return
   elseif msg == 30 then turtle.turnLeft()
   elseif msg == 32 then turtle.turnRight()
   elseif msg == 17 then turtle.forward()
   elseif msg == 31 then turtle.back()
   elseif msg == 57 then turtle.up()
   elseif msg == 42 then turtle.down()
   elseif msg == 21 then turtle.digUp()
   elseif msg == 35 then turtle.dig()
   elseif msg == 49 then turtle.digDown()
   elseif msg == 22 then turtle.placeUp()
   elseif msg == 36 then turtle.place()
   elseif msg == 50 then turtle.placeDown()
   else print("Unknown command "..msg)
   end
  end
end
end