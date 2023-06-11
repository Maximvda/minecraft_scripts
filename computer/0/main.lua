-- Load required dependancies
os.loadAPI("components/input")
os.loadAPI("components/config")
os.loadAPI("components/link")
os.loadAPI("components/interface")

local function main()
    event = {os.pullEvent()}
    print(event[1], event[2], event[3], event[4])
    if event[1] == "rednet_message" then
        link.handle_message(event[2], event[3])
    end
    if event[1] == "key" and event[2] == 57 then
        return false
    end
    if event[1] == "monitor_touch" then
        interface.check_touch(event[3], event[4])
    end
    return true
end

interface.init()

link.init(config.modem_side)
link.discovery()

while true do
    if not main() then
        return
    end
end
