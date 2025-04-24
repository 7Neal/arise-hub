-- Arise SKYLOHUB - Complete Script Hub for Arise Crossover
-- Works with Xeno Executor | Full Autosave | Inspired by SKYLOLAND UI

--// Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

--// UI Library (replace with your preferred one)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/7Neal/ui-lib/main/library.lua"))()
local Window = Library:CreateWindow("ARISE SKYLOHUB")

--// Config Table
local config = {
    selectedMob = nil,
    tweenSpeed = 1,
    autoFarm = false,
    autoDungeon = false,
    autoPet = false,
    floorCap = 1,
    autoBuy = false,
    infernalCastle = false,
    resultArise = true,
    resultDestroy = true,
    selectedIsland = "None",
    selectedRank = "None"
}

--// Autosave Path
local SaveFile = "AriseSkyloHubConfig.json"

--// Save Function
local function SaveSettings()
    writefile(SaveFile, HttpService:JSONEncode(config))
end

--// Load Settings
if isfile(SaveFile) then
    local success, data = pcall(function()
        return HttpService:JSONDecode(readfile(SaveFile))
    end)
    if success and typeof(data) == "table" then
        for k, v in pairs(data) do
            config[k] = v
        end
    end
end

--// UI Tabs
local mainTab = Window:CreateTab("General")
local dungeonTab = Window:CreateTab("Dungeon")
local petTab = Window:CreateTab("Pets")
local infernalTab = Window:CreateTab("Infernal")
local resultTab = Window:CreateTab("Results")

--// Main Controls
mainTab:CreateToggle("Auto Farm", config.autoFarm, function(val)
    config.autoFarm = val
    SaveSettings()
end)

mainTab:CreateDropdown("Mob", {"Mob1", "Mob2", "Mob3"}, config.selectedMob, function(val)
    config.selectedMob = val
    SaveSettings()
end)

mainTab:CreateSlider("Tween Speed", 0.1, 3, config.tweenSpeed, function(val)
    config.tweenSpeed = val
    SaveSettings()
end)

--// Dungeon Tab

-- You can add specific dungeons as buttons or dropdown

dungeonTab:CreateToggle("Auto Dungeon", config.autoDungeon, function(val)
    config.autoDungeon = val
    SaveSettings()
end)

dungeonTab:CreateSlider("Floor Cap", 1, 50, config.floorCap, function(val)
    config.floorCap = val
    SaveSettings()
end)

dungeonTab:CreateToggle("Auto Buy Tickets", config.autoBuy, function(val)
    config.autoBuy = val
    SaveSettings()
end)

--// Pets Tab
petTab:CreateToggle("Auto Pet Send", config.autoPet, function(val)
    config.autoPet = val
    SaveSettings()
end)

--// Infernal Castle
infernalTab:CreateToggle("Enable Infernal Castle", config.infernalCastle, function(val)
    config.infernalCastle = val
    SaveSettings()
end)

--// Result Tab
resultTab:CreateToggle("Result: Arise", config.resultArise, function(val)
    config.resultArise = val
    SaveSettings()
end)

resultTab:CreateToggle("Result: Destroy", config.resultDestroy, function(val)
    config.resultDestroy = val
    SaveSettings()
end)

--// Farming Loop
spawn(function()
    while true do
        if config.autoFarm and config.selectedMob then
            local mob = workspace:FindFirstChild(config.selectedMob, true)
            if mob and mob:FindFirstChild("HumanoidRootPart") then
                local goal = { CFrame = mob.HumanoidRootPart.CFrame }
                TweenService:Create(HumanoidRootPart, TweenInfo.new(config.tweenSpeed, Enum.EasingStyle.Linear), goal):Play()
            end
        end
        task.wait(0.5)
    end
end)

-- You can expand this loop for dungeon, pet, and infernal features similarly.
-- Final polish: Add notifications, credit tab, or protection logic if needed.
