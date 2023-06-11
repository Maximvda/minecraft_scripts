-- Smeltery controller code
os.loadAPI("components/link")
os.loadAPI("components/config")
os.loadAPI("components/smeltery")

-- Initialisation
link.init(config.modem_side)
local update_timer = os.startTimer(10)
local smelter = smeltery.init()

local function event_loop()
    while true do
        event = {os.pullEvent()}
        if event[1] == "rednet_message" then
            link.handle_message(par1, par2)
        end
        if event[1] == "key" and event[2] == 57 then
            return
        end

        if event[1] == "timer" and event[2] == update_timer then
            info = smelter.get_info()
            update_timer = os.startTimer(10)
            link.send_data(info)
        end
    end
end

-- Run the os loop can be combined with other peripherals to run simulatinous
parallel.waitForAny(
    event_loop
)