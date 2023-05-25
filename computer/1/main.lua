-- Main turtle code which mines and also periodically sends statistics
os.loadAPI("components/link")
os.loadAPI("components/config")
os.loadAPI("components/mine_api")
os.loadAPI("components/turtle")

-- Initialisation
miner = mine_api.init()
link.init(config.modem_side)
update_timer = os.startTimer(5)


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
            miner.get_info(info)
            update_timer = os.startTimer(5)
            link.send_data(info)
        end
    end
end

local function turtle_loop()
    while true do
        miner.tick()
    end
end

print(miner.falling_block())

-- Run the os loop and turtle tick simulatinous
parallel.waitForAny(
    turtle_loop,
    event_loop
)