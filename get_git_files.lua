--dow = http.get("https://raw.githubusercontent.com/Maximvda/minecraft_scripts/main/get_git_files.lua")
--f = fs.open("clone.lua", "w")
--f.write(dow.readAll())
--f.close()
--dow.close()

local function get(pc, script_name, folder)
    if folder == "" then
        file_name = pc.."/"..script_name
    else
        file_name = pc.."/"..folder.."/"..script_name
    end
    local download = http.get("https://raw.githubusercontent.com/Maximvda/minecraft_scripts/main/computer/"..file_name) --This will make 'download' hold the contents of the file.
    if download then --checks if download returned true or false
        local handle = download.readAll() --Reads everything in download
        download.close() --remember to close the download!
        if folder == "" then
            file = fs.open(script_name,"w") --opens the file defined in 'saveTo' with the permissions to write.
        else
            fs.makeDir(folder)
            file = fs.open(folder.."/"..script_name, "w")
        end

        file.write(handle) --writes all the stuff in handle to the file defined in 'saveTo'
        file.close() --remember to close the file!
    else --if returned false
        print("Unable to download the file "..pc)
        print("Make sure you have the HTTP API enabled or")
        print("an internet connection!")
    end --end the if
end --close the function

local function clone_pc(pc)
    if pc == "0" then
        get("0", "startup.lua", "")
        get("0", "button_class", "components")
        get("0", "config", "components")
        get("0", "input", "components")
        get("0", "interface", "components")
        get("0", "link", "components")
        get("0", "turtles", "views")
        get("0", "reactor", "views")
        get("0", "smeltery", "views")
    elseif pc == "1" then
        get("1", "startup.lua", "")
        get("1", "config", "components")
        get("1", "mine_api", "components")
        get("1", "link_class", "components")
        get("1", "logger", "components")
    elseif pc == "2" then
        get("2", "startup.lua", "")
        get("2", "config", "components")
        get("2", "link_class", "components")
        get("2", "smeltery", "components")
    elseif pc == "4" then
        get("4", "startup.lua", "")
        get("4", "config", "components")
        get("4", "link_class", "components")
        get("4", "chunky", "components")
    end

end

print("Which pc to clone?")
pc = read()
print("Cloning: "..pc)
clone_pc(pc)