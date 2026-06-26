local Story = {}

local Network = require("../core/network")
local State = require("../core/state")

-- Hardcoded coordinates for unit placements in Story Mode
local PlacementPositions = {
    { x = 12.5, y = 5.0, z = -45.2, UnitName = "Unit A" },
    { x = 15.0, y = 5.0, z = -43.1, UnitName = "Unit B" }
}

function Story.Run(config)
    local currentYen = State.GetYen()
    local placedCount = State.GetPlacedUnitsCount()
    
    print(string.format("[Story] Yen: %d, Placed: %d", currentYen, placedCount))
    
    -- Iterate through defined spots and place units if money is sufficient
    for index, spot in ipairs(PlacementPositions) do
        if placedCount < index then
            local targetProfile = nil
            for _, profile in ipairs(config.PlacementProfile) do
                if profile.Name == spot.UnitName then
                    targetProfile = profile
                    break
                end
            end
            
            if targetProfile and currentYen >= targetProfile.Cost then
                print(string.format("[Story] Placing %s at position %d", spot.UnitName, index))
                Network.PlaceUnit(spot.UnitName, spot.x, spot.y, spot.z)
                break -- Wait for next iteration to allow server sync
            end
        end
    end
end

return Story
