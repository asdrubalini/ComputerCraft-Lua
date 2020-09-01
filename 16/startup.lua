local resumeFlagFile = "resume.txt"


if fs.exists(resumeFlagFile) == false then
    -- not resuming, start listening for commands

    print("Now listening for commands")
    shell.run("listen.lua")
else
    -- resuming

    print("Resuming quarry operations")
    shell.openTab("fuel.lua")
    shell.run("quarry.lua")
end
