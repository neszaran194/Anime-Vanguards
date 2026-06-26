-- [[ Main Script Entry Point ]]

local Config = require("./config")
local State = require("./core/state")
local Story = require("./games/story")
local Network = require("./core/network")

print("------ Anime Vanguards Auto-Play Script Initialized ------")

task.spawn(function()
    while Config.AutoFarm do
        local currentWave = State.GetCurrentWave()
        
        -- Run the active game module
        Story.Run(Config)
        
        -- Handle target wave check
        if currentWave >= Config.TargetWave then
            print(string.format("[Main] Reached target wave %d. Exiting/Re-lobbying...", Config.TargetWave))
            Network.ReturnToLobby()
            break
        end
        
        task.wait(1.5) -- Loop interval
    end
end)
