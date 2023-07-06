-- Main turtle code which mines and also periodically sends statistics
os.loadAPI("components/link_class")
os.loadAPI("components/config")
os.loadAPI("components/chunky")

-- Initialisation
chunky = chunky.init()

local function callback_message(message)
    chunky.handle_command(message)
end

local link = link_class.init(config.modem_side, callback_message)
local update_timer = os.startTimer(config.update_interval)

local function event_loop()
    while true do
        event = {os.pullEvent()}
        if event[1] == "rednet_message" then
            link.handle_message(event[2], event[3])
        end
        if event[1] == "key" and event[2] == 57 then
            return
        end

        if event[1] == "timer" and event[2] == update_timer then
            info = chunky.get_info(info)
            update_timer = os.startTimer(config.update_interval)
            link.send_data(info)
        end
    end
end

local function chunky_loop()
    while true do
        chunky.tick()
        os.sleep(0.1)
    end
end

-- Run the os loop and turtle tick simulatinous
parallel.waitForAny(
    event_loop,
    chunky_loop
)