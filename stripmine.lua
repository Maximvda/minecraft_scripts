-- Requirements :
-- Dig at specified levels
-- Dump items when full and also return to refuel if low


-- Initializing --
local rowsMined = {0}
local totalRows = {0}
local hallLength = {0}
local fuelNeeded = {0}
local fuelLevel = turtle.getFuelLevel()
local fuelLimit = turtle.getFuelLimit()
local startConfirmed = "No"
local slot = turtle.getSelectedSlot()
local itemSpace = turtle.getItemSpace()
local torchCounter = 0


local function clear(column,row)
	term.clear()
	if column == nil and row == nil then
		column = 1
		row = 1
	elseif row == nil then
		row = 1
	elseif column == nil then
		column = 1
	end
	term.setCursorPos(column,row)
end

local function checkNumber(varToCheck)
	assert(type(varToCheck) == "number", "Program expected number. Got string or something else instead.")
end

local function fallingBlock()
local success, data = turtle.inspect()
local fBlocks =
{
sand="minecraft:sand",
gravel="minecraft:gravel",
anvil="minecraft:anvil",
dragon_egg="minecraft:dragon_egg"
}
	if data.name==fBlocks.sand or data.name==fBlocks.gravel or data.name==fBlocks.anvil or data.name==fBlocks.dragon_egg then
		return true
	else
		return false
	end
end

local function dig(length,back)
for i=1, length do
	torchCounter=torchCounter+1
	while fallingBlock() == true do
		turtle.dig()
		sleep(1)
	end
	turtle.dig()
	turtle.forward()
	turtle.digDown()
	if torchCounter >= 8 then
		turtle.select(16)
		if turtle.getItemSpace() < 64 then
		local data = turtle.getItemDetail()
		if data.name == "minecraft:torch" then
		turtle.placeDown()
		end
		end
		torchCounter = 0
		turtle.select(1)
	end
end
if back == true then
turtle.turnLeft()
turtle.turnLeft()
for i=2, length do
	forward()
end
forward()
turtle.turnLeft()
turtle.turnLeft()
end

end

-- Welcome + User input --

clear(1,1)

print("Welcome to the Strip Mining Program.")
sleep(1)
print("Please enter a Hall/Strip Length (x = x block/s): ")
hallLength[1] = io.read()
hallLength[1] = tonumber(hallLength[1])
checkNumber(hallLength[1])
print("Please enter a number of rows:")
totalRows[1] = io.read()
totalRows[1] = tonumber(totalRows[1])
checkNumber(totalRows[1])
print("Calculating if turtle has enough fuel...")
fuelNeeded[1] = (hallLength[1]*3*totalRows[1])+(12*totalRows[1])
sleep(1.0)
assert(fuelNeeded[1]<fuelLimit, "Your fuel Limit is too low. Try an advanced turtle.")
assert(fuelNeeded[1]<fuelLevel, "Your turtle hasn't enought fuel.")
print("Your turtle has enough fuel. Please place a chest behind the turtle.")
sleep(2.0)
clear(1,1)
print("Place a chest behind the turtle.")
print("Place Torches to place in Slot 16 (Bottom right hand corner)")
write("Press any key to start the program.")
local skip = io.read()

-- Post initialization --

local rowsToMine = totalRows[1]-rowsMined[1]
clear(1,1)
turtle.select(1)

-- Main Loop --

for i=1, totalRows[1] do
	turtle.select(1)
	dig(3,false)
	turtle.turnLeft()
	dig(hallLength[1],true)
	rowsMined[1] = rowsMined[1]+1
	clear(1,1)
	print("Rows Mined: ",rowsMined[1])
	local z = 1
	turtle.select(15)
	if turtle.getItemSpace() < 64 then
		turtle.turnLeft()
		for i=1,rowsMined[1]*3+1 do
			forward()
		end
		for i=1,15 do
			turtle.select(z)
			z=z+1
			turtle.drop(64)
		end
		turtle.turnRight()
		turtle.turnRight()
		for i=1,rowsMined[1]*3+1 do
			forward()
		end
		turtle.turnLeft()
	end
	turtle.turnRight()
	rowsToMine = totalRows[1]-rowsMined[1]
end

-- Ending --

do
	print("Putting Items into chest.")
	turtle.turnLeft()
	turtle.turnLeft()
	for i=1, (rowsMined[1]*3)+1 do
		forward()
	end
	z=1
    for i=1,16 do
			turtle.select(z)
			z=z+1
			turtle.drop(64)
	end
end

turtle.select(1)

print("Mining Complete.")

sleep(2)

clear(1,1)

turtle.