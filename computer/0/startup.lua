-- Load required dependancies
os.loadAPI("components/input")
os.loadAPI("components/config")
os.loadAPI("components/link")
os.loadAPI("components/interface")
os.loadAPI("components/button_class")

os.loadAPI("views/turtles")
os.loadAPI("views/smeltery")
os.loadAPI("views/reactor")
os.loadAPI("views/battery")

local display = peripheral.wrap(config.monitor)

local turtle_view = turtles.Init(display)
local smelter_view = smeltery.Init(display)
local reactor_view = reactor.Init(display)
local battery_view = battery.Init(display)

local monitor = interface.Interface(display)

local function main()
    event = {os.pullEvent()}
    if event[1] == "rednet_message" then
        link.handle_message(event[2], event[3])
    end
    if event[1] == "key" and event[2] == 57 then
        return false
    end
    if event[1] == "monitor_touch" then
        monitor.check_touch(event[3], event[4])
    end
    return true
end
monitor.show_view("reactor")

local function handle_info(id, message)
    if id == config.id_smeltery then
        smelter_view.handle_message(message)
    elseif id == config.id_crunchy then
        turtle_view.set_miner_data(message)
    elseif id == config.id_chunky then
        turtle_view.set_chunky_data(message)
    elseif id == config.id_reactor then
        reactor_view.set_data(message)
    elseif id == config.id_battery then
        battery_view.set_data(message)
    end
end

link.init(config.modem_side, handle_info)

while true do
    if not main() then
        return
    end
end
