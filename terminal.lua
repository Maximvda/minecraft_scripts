local modem_side = "back"
rednet.open(modem_side)

local remote_info = {}

local function main_loop()
    user_input()
    event, params = os.pullEvent()
    if event == "rednet_message" then
        handle_renet_event(params)
    end

end

local function handle_renet_event(params)
    local sender_id = params[1]
    local message = params[2]

    -- Process the incomming messages and parse their data to be displayed
end

local function user_input()
    term.clear()
    term.setCursorPos(1,1)
    print("Waiting on user input")
    local value = read()
end

-- Start the main loop which is at the top for easyer understanding
while true do
    main_loop()
end

-- Get Channel Number
print("Enter the channel of mining turtle")
channel = tonumber(read())



local channel = 0
local sSide = "back"

-- Get Channel Number
print("What channel?")
channel = tonumber(read())

-- Connect
print("Connecting to " .. channel)
rednet.open(sSide)
rednet.send(channel, "Init")
local id, msg = rednet.receive(1)

if not msg or id ~= channel then
        print("Could not connect")
        return
end

-- Print commands
print("Commands:")
print("Q        - Disconnect/Quit")
print("WASD - Move/Turn")
print("Space- Move Up")
print("Shift- Move Down")
print("Y        - Mine Up")
print("H        - Mine")
print("N        - Mine Down")
print("U        - Place Up")
print("J        - Place")
print("M        - Place Down")

-- Program Loop
while true do
        local event, sc = os.pullEvent("key")

        if sc == 16 then
                rednet.send(channel, sc)
                print("Closing")
                rednet.close(sSide)
                return
        elseif sc == 17 or
            sc == 30 or
            sc == 31 or
            sc == 32 or
            sc == 42 or
            sc == 57 or
            sc == 21 or
            sc == 22 or
            sc == 35 or
            sc == 36 or
            sc == 49 or
            sc == 50 then
                rednet.send(channel, sc)
        end
end
