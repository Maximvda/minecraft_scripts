-- Main turtle code which mines and also periodically sends statistics
os.loadAPI("components/link")
os.loadAPI("components/config")
os.loadAPI("components/battery")

local update_timer = os.startTimer(config.update_interval)
stor_bat = battery.Battery()

local function handle_message(id, message)

end

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
            local info = stor_bat.get_info()
            update_timer = os.startTimer(config.update_interval)
            link.send_data(info)
        end
    end
end

-- Run the os loop and turtle tick simulatinous
parallel.waitForAny(
    event_loop
)