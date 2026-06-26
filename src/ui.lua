local UI = {}

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

function UI.Initialize(Config)
    -- 1. Create Main Window
    local Window = Library:CreateWindow({
        Title = "Anime Vanguards Hub",
        Footer = "Developer Edition",
        Icon = 95816097006870,
        NotifySide = "Right",
        ShowCustomCursor = true,
    })

    -- 2. Define Tabs
    local Tabs = {
        AutoFarm = Window:AddTab("Auto Farm", "swords"),
        Units = Window:AddTab("Units", "users"),
        Misc = Window:AddTab("Misc", "cog"),
        ["UI Settings"] = Window:AddTab("UI Settings", "settings"),
    }

    -- ==========================================
    -- TAB 1: AUTO FARM SETUP
    -- ==========================================
    local FarmLeftGroup = Tabs.AutoFarm:AddLeftGroupbox("Farm Controller")
    
    FarmLeftGroup:AddToggle("AutoFarmToggle", {
        Text = "Enable Auto Farm",
        Default = Config.AutoFarm,
        Tooltip = "Starts the auto placement and farm loop",
        Callback = function(Value)
            Config.AutoFarm = Value
        end
    })

    FarmLeftGroup:AddToggle("AutoLeaveToggle", {
        Text = "Auto Return to Lobby",
        Default = Config.AutoLeave,
        Tooltip = "Leave the game when target wave is reached",
        Callback = function(Value)
            Config.AutoLeave = Value
        end
    })

    FarmLeftGroup:AddSlider("TargetWaveSlider", {
        Text = "Target Wave",
        Default = Config.TargetWave,
        Min = 1,
        Max = 50,
        Rounding = 0,
        Compact = false,
        Callback = function(Value)
            Config.TargetWave = Value
        end
    })

    -- ==========================================
    -- TAB 2: UNIT CONTROLLER
    -- ==========================================
    local UnitLeftGroup = Tabs.Units:AddLeftGroupbox("Unit Automation")
    
    UnitLeftGroup:AddToggle("AutoPlaceToggle", {
        Text = "Auto Place Units",
        Default = true,
        Tooltip = "Automatically place units based on coordinates",
        Callback = function(Value)
            -- We can store this in config later
            print("[UI] Auto Place set to:", Value)
        end
    })

    UnitLeftGroup:AddToggle("AutoUpgradeToggle", {
        Text = "Auto Upgrade Units",
        Default = Config.AutoUpgrade,
        Tooltip = "Automatically upgrade placed units when Yen is sufficient",
        Callback = function(Value)
            Config.AutoUpgrade = Value
        end
    })

    -- ==========================================
    -- TAB 3: MISC & PERFORMANCE (ลดอาการกระตุก)
    -- ==========================================
    local MiscLeftGroup = Tabs.Misc:AddLeftGroupbox("Performance Boosters")

    -- Disable 3D Rendering (โคตรสำคัญในการลดแลคเวลาเปิดจอค้างไว้)
    MiscLeftGroup:AddToggle("Disable3DRender", {
        Text = "Disable 3D Rendering",
        Default = false,
        Tooltip = "Turns off 3D world rendering to lower CPU/GPU usage dramatically",
        Callback = function(Value)
            game:GetService("RunService"):Set3DRenderingEnabled(not Value)
        end
    })

    -- FPS Limiter
    MiscLeftGroup:AddSlider("MaxFPSSlider", {
        Text = "Max FPS Cap",
        Default = 60,
        Min = 15,
        Max = 240,
        Rounding = 0,
        Compact = false,
        Callback = function(Value)
            if setfpscap then
                setfpscap(Value)
            end
        end
    })

    -- 3. Theme Manager & Save Manager settings
    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    ThemeManager:SetFolder("AnimeVanguardsHub")
    SaveManager:SetFolder("AnimeVanguardsHub/configs")
    SaveManager:BuildConfigSection(Tabs["UI Settings"])
    ThemeManager:ApplyToTab(Tabs["UI Settings"])
    SaveManager:LoadAutoloadConfig()
end

return UI
