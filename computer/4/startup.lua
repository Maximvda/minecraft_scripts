-- Main turtle code which mines and also periodically sends statistics
os.loadAPI("components/link_class")
os.loadAPI("components/config")
os.loadAPI("components/chunky")

-- Initialisation
chunky = chunky.init()

local function callback_message(message)
    if message == "Start" then
        miner.start()
    elseif  message == "Go home" then
        miner.go_home()
    elseif type(message) == table then
        if message[1] == "Set depth" then
            miner.set_depth(message[2])
        end
    end
end


local link = link_class.init(config.modem_side, callback_message)

local function event_loop()
    while true do
        event = {os.pullEvent()}
        if event[1] == "rednet_message" then
            link.handle_message(event[2], event[3])
        end
        if event[1] == "key" and event[2] == 57 then
            return
        end
    end
end

-- Run the os loop and turtle tick simulatinous
parallel.waitForAny(
    event_loop
)