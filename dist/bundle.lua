local __DARKLUA_BUNDLE_MODULES={cache={}}do do local function __modImpl()local
Config={AutoFarm=true,AutoUpgrade=true,AutoLeave=true,TargetWave=15,
PlacementProfile={{Name='Unit A',Cost=500,Priority=1,UpgradeCount=3},{Name=
'Unit B',Cost=1000,Priority=2,UpgradeCount=5}},Webhook={Enabled=false,Url=
'YOUR_DISCORD_WEBHOOK_URL'}}return Config end function __DARKLUA_BUNDLE_MODULES.
a()local v=__DARKLUA_BUNDLE_MODULES.cache.a if not v then v={c=__modImpl()}
__DARKLUA_BUNDLE_MODULES.cache.a=v end return v.c end end do local function 
__modImpl()local State={}local Players=game:GetService('Players')local
LocalPlayer=Players.LocalPlayer function State.GetYen()local leaderstats=
LocalPlayer:FindFirstChild('leaderstats')if leaderstats and leaderstats:
FindFirstChild('Yen')then return leaderstats.Yen.Value end return 0 end function
State.GetCurrentWave()local waveGui=LocalPlayer.PlayerGui:FindFirstChild(
'WaveGui')if waveGui and waveGui:FindFirstChild('WaveText')then return tonumber(
waveGui.WaveText.Text)or 1 end return 1 end function State.GetPlacedUnitsCount()
local placedUnits=0 local workspaceUnits=workspace:FindFirstChild('PlacedUnits')
if workspaceUnits and workspaceUnits:FindFirstChild(LocalPlayer.Name)then
placedUnits=#workspaceUnits[LocalPlayer.Name]:GetChildren()end return
placedUnits end return State end function __DARKLUA_BUNDLE_MODULES.b()local v=
__DARKLUA_BUNDLE_MODULES.cache.b if not v then v={c=__modImpl()}
__DARKLUA_BUNDLE_MODULES.cache.b=v end return v.c end end do local function 
__modImpl()local Network={}local ReplicatedStorage=game:GetService(
'ReplicatedStorage')ReplicatedStorage:FindFirstChild('Remotes')function Network.
PlaceUnit(unitName,x,y,z)print(string.format(
'[Network] Placing unit %s at (%.2f, %.2f, %.2f)',unitName,x,y,z))end function
Network.UpgradeUnit(unitId)print(string.format('[Network] Upgrading unit ID: %s'
,tostring(unitId)))end function Network.StartNextWave()print(
'[Network] Voting to start next wave')end function Network.ReturnToLobby()print(
'[Network] Returning to Lobby')end return Network end function
__DARKLUA_BUNDLE_MODULES.c()local v=__DARKLUA_BUNDLE_MODULES.cache.c if not v
then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.c=v end return v.c end end
do local function __modImpl()local Story={}local Network=
__DARKLUA_BUNDLE_MODULES.c()local State=__DARKLUA_BUNDLE_MODULES.b()local
PlacementPositions={{x=12.5,y=5,z=-45.2,UnitName='Unit A'},{x=15,y=5,z=-43.1,
UnitName='Unit B'}}function Story.Run(config)local currentYen=State.GetYen()
local placedCount=State.GetPlacedUnitsCount()print(string.format(
'[Story] Yen: %d, Placed: %d',currentYen,placedCount))for index,spot in ipairs(
PlacementPositions)do if placedCount<index then local targetProfile=nil for _,
profile in ipairs(config.PlacementProfile)do if profile.Name==spot.UnitName then
targetProfile=profile break end end if targetProfile and currentYen>=
targetProfile.Cost then print(string.format('[Story] Placing %s at position %d',
spot.UnitName,index))Network.PlaceUnit(spot.UnitName,spot.x,spot.y,spot.z)break
end end end end return Story end function __DARKLUA_BUNDLE_MODULES.d()local v=
__DARKLUA_BUNDLE_MODULES.cache.d if not v then v={c=__modImpl()}
__DARKLUA_BUNDLE_MODULES.cache.d=v end return v.c end end do local function 
__modImpl()local UI={}local repo=
[[https://raw.githubusercontent.com/deividcomsono/Obsidian/main/]]local Library=
loadstring(game:HttpGet(repo..'Library.lua'))()local ThemeManager=loadstring(
game:HttpGet(repo..'addons/ThemeManager.lua'))()local SaveManager=loadstring(
game:HttpGet(repo..'addons/SaveManager.lua'))()function UI.Initialize(Config)
local Window=Library:CreateWindow({Title='Anime Vanguards Hub',Footer=
'Developer Edition',Icon=95816097006870,NotifySide='Right',ShowCustomCursor=true
})local Tabs={AutoFarm=Window:AddTab('Auto Farm','swords'),Units=Window:AddTab(
'Units','users'),Misc=Window:AddTab('Misc','cog'),['UI Settings']=Window:AddTab(
'UI Settings','settings')}local FarmLeftGroup=Tabs.AutoFarm:AddLeftGroupbox(
'Farm Controller')FarmLeftGroup:AddToggle('AutoFarmToggle',{Text=
'Enable Auto Farm',Default=Config.AutoFarm,Tooltip=
'Starts the auto placement and farm loop',Callback=function(Value)Config.
AutoFarm=Value end})FarmLeftGroup:AddToggle('AutoLeaveToggle',{Text=
'Auto Return to Lobby',Default=Config.AutoLeave,Tooltip=
'Leave the game when target wave is reached',Callback=function(Value)Config.
AutoLeave=Value end})FarmLeftGroup:AddSlider('TargetWaveSlider',{Text=
'Target Wave',Default=Config.TargetWave,Min=1,Max=50,Rounding=0,Compact=false,
Callback=function(Value)Config.TargetWave=Value end})local UnitLeftGroup=Tabs.
Units:AddLeftGroupbox('Unit Automation')UnitLeftGroup:AddToggle(
'AutoPlaceToggle',{Text='Auto Place Units',Default=true,Tooltip=
'Automatically place units based on coordinates',Callback=function(Value)print(
'[UI] Auto Place set to:',Value)end})UnitLeftGroup:AddToggle('AutoUpgradeToggle'
,{Text='Auto Upgrade Units',Default=Config.AutoUpgrade,Tooltip=
'Automatically upgrade placed units when Yen is sufficient',Callback=function(
Value)Config.AutoUpgrade=Value end})local MiscLeftGroup=Tabs.Misc:
AddLeftGroupbox('Performance Boosters')MiscLeftGroup:AddToggle('Disable3DRender'
,{Text='Disable 3D Rendering',Default=false,Tooltip=
[[Turns off 3D world rendering to lower CPU/GPU usage dramatically]],Callback=
function(Value)game:GetService('RunService'):Set3DRenderingEnabled(not Value)end
})MiscLeftGroup:AddSlider('MaxFPSSlider',{Text='Max FPS Cap',Default=60,Min=15,
Max=240,Rounding=0,Compact=false,Callback=function(Value)if setfpscap then
setfpscap(Value)end end})ThemeManager:SetLibrary(Library)SaveManager:SetLibrary(
Library)ThemeManager:SetFolder('AnimeVanguardsHub')SaveManager:SetFolder(
'AnimeVanguardsHub/configs')SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])SaveManager:LoadAutoloadConfig()end
return UI end function __DARKLUA_BUNDLE_MODULES.e()local v=
__DARKLUA_BUNDLE_MODULES.cache.e if not v then v={c=__modImpl()}
__DARKLUA_BUNDLE_MODULES.cache.e=v end return v.c end end end local Config=
__DARKLUA_BUNDLE_MODULES.a()local State=__DARKLUA_BUNDLE_MODULES.b()local Story=
__DARKLUA_BUNDLE_MODULES.d()local Network=__DARKLUA_BUNDLE_MODULES.c()local UI=
__DARKLUA_BUNDLE_MODULES.e()UI.Initialize(Config)print(
'------ Anime Vanguards Auto-Play Script Initialized ------')task.spawn(function
()while Config.AutoFarm do local currentWave=State.GetCurrentWave()Story.Run(
Config)if currentWave>=Config.TargetWave then print(string.format(
'[Main] Reached target wave %d. Exiting/Re-lobbying...',Config.TargetWave))
Network.ReturnToLobby()break end task.wait(1.5)end end)