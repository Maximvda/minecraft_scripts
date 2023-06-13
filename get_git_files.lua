


local function get(file_name, script_name, folder)
    local download = http.get("https://https://raw.githubusercontent.com/Maximvda/minecraft_scripts/main/computer/"..file_name) --This will make 'download' hold the contents of the file.
    if download then --checks if download returned true or false
        local handle = download.readAll() --Reads everything in download
        download.close() --remember to close the download!
        if folder == "" then
            file = fs.open(script_name,"w") --opens the file defined in 'saveTo' with the permissions to write.
        else
            fs.makeDir(folder)
            file = fs.open(folder.."/"..script_name)
        end

        file.write(handle) --writes all the stuff in handle to the file defined in 'saveTo'
        file.close() --remember to close the file!
    else --if returned false
        print("Unable to download the file "..file)
        print("Make sure you have the HTTP API enabled or")
        print("an internet connection!")
    end --end the if
end --close the function

local function clone_pc(pc)
    if pc == 0 then
        get("0/main.lua", "main.lua", "")
        get("0/components/button_class", "button_class", "components")
    end
end
