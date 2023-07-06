-- Main turtle code which mines and also periodically sends statistics
os.loadAPI("components/link_class")
os.loadAPI("components/config")
os.loadAPI("components/mine_api")
os.loadAPI("components/crunchy")
os.loadAPI("components/file_sys")

-- Initialisation
local function callback_message(id, message)
    if id == config.id_hub then
        if message == "Start" then
            crunchy.start()
        elseif  message == "Go home" then
            crunchy.stop()
        elseif type(message) == table then
            if message[1] == "Set depth" then
                crunchy.set_depth(message[2])
            end
        end
    elseif id == config.id_chunky then
        crunchy.buffer_chunky_commands(message)
    end
end


local link = link_class.init(config.modem_side, callback_message)
crunchy = crunchy.init()
update_timer = os.startTimer(config.update_interval)


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
            info = crunchy.get_info(info)
            update_timer = os.startTimer(config.update_interval)
            link.send_data(info)
        end
    end
end

local function turtle_loop()
    while true do
        crunchy.tick()
    end
end

-- Run the os loop and turtle tick simulatinous
parallel.waitForAny(
    turtle_loop,
    event_loop
)