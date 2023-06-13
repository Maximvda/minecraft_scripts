-- Smeltery controller code
os.loadAPI("components/link_class")
os.loadAPI("components/config")
os.loadAPI("components/smeltery")

-- Initialisation
local update_timer = os.startTimer(10)
local smelter = smeltery.init()

local function callback_message(message)
    smelter.set_output(message)
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

        if event[1] == "timer" then
            if event[2] == update_timer then
                info = smelter.get_info()
                update_timer = os.startTimer(10)
                link.send_data(info)
                print("Update timer")
            elseif event[2] == smelter.control_timer then
                print("Contorl timer")
                smelter.control_tick()
            end
        end
    end
end

-- Run the os loop can be combined with other peripherals to run simulatinous
parallel.waitForAny(
    event_loop
)