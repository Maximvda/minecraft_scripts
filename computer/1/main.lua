-- Main turtle code which mines and also periodically sends statistics
os.loadAPI("components/link")
os.loadAPI("components/config")
os.loadAPI("components/miner")
os.loadAPI("components/turtle")

update_timer = os.startTimer(5)

info = {}

local function main_loop()
    while true do
        event, par1, par2, par3 = os.pullEvent()
        if event == "rednet_message" then
            link.handle_message(par1, par2)
        end
        if event == "key" and par1 == 57 then
            return
        end

        if event == "timer" and par1 == update_timer then
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

-- Initialise stuff
link.init(config.modem_side)

-- Run the os loop and turtle tick simulatinous
parallel.waitForAny(
    turtle_loop,
    main_loop
)