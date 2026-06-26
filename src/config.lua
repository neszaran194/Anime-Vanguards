local Config = {
    AutoFarm = true,
    AutoUpgrade = true,
    AutoLeave = true,
    TargetWave = 15,
    
    -- Settings for Anime Vanguards
    PlacementProfile = {
        { Name = "Unit A", Cost = 500, Priority = 1, UpgradeCount = 3 },
        { Name = "Unit B", Cost = 1000, Priority = 2, UpgradeCount = 5 }
    },
    
    Webhook = {
        Enabled = false,
        Url = "YOUR_DISCORD_WEBHOOK_URL"
    }
}

return Config
