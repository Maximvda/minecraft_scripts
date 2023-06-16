-- Load required dependancies
os.loadAPI("components/input")
os.loadAPI("components/config")
os.loadAPI("components/link")
os.loadAPI("components/interface")
os.loadAPI("components/button_class")

local monitor = interface.Interface()

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
    if id == link.ids.smeltery then
        if type(message) == "table" then
            monitor.show_smeltery_levels(message)
        elseif message == "Finished" then
            monitor.show_view("smeltery")
        end

    end
end

link.init(config.modem_side, handle_info)
link.discovery()

info = {}
info.fuel_consumption = 100
info.fuel_reactivity = 50
info.energy = 50
info.stored_energy = 50
info.fuel_level = 50
info.fuel_consumption = 50
info.fuel_reactivity = 50
info.control_rod = 50
info.fuel_temp = 50
info.casing_temp = 50
info.active = false

monitor.update_reactor_stats(info)

while true do
    if not main() then
        return
    end
end
