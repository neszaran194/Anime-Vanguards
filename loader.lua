-- [[ Secure Remote Loader ]]
-- This is the script you distribute to users.

local LoaderConfig = {
    ScriptUrl = "https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/YOUR_REPO/main/Anime%20Vanguards/dist/bundle.lua",
    UseKeySystem = false,
    ExpectedKey = "AV-PRO-1234" -- Simple fallback key check
}

local function InitializeScript()
    print("[Loader] Verifying client environment...")
    task.wait(0.5)

    print("[Loader] Fetching latest script version...")
    local success, scriptContent = pcall(function()
        return game:HttpGet(LoaderConfig.ScriptUrl)
    end)

    if success and scriptContent then
        print("[Loader] Code retrieved successfully. Starting execution...")
        -- Run the retrieved script inside a new environment
        local run, err = loadstring(scriptContent)
        if run then
            run()
        else
            warn("[Loader] Failed to compile script: " .. tostring(err))
        end
    else
        warn("[Loader] Connection failed. Please check internet connection or GitHub raw URL.")
    end
end

-- Key validation check (if enabled)
if LoaderConfig.UseKeySystem then
    -- Example implementation of key verification
    -- In a real setup, you would verify this key with a remote server (e.g. Luarmor or custom Web API)
    local userKey = rawget(_G, "ScriptKey") or (getgenv and getgenv().ScriptKey)
    if userKey == LoaderConfig.ExpectedKey then
        InitializeScript()
    else
        warn("[Loader] Invalid or expired Key!")
    end
else
    -- Run directly if no key system is enabled
    InitializeScript()
end
