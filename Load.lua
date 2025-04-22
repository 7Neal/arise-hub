-- SERVICES
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

-- CONFIG (initial values)
local tweenSpeed = 0.5
local teleportInterval = 2
local autoTeleportEnabled = false

-- FUNCTIONS
local function tweenTo(pos)
    local tweenInfo = TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear)
    local goal = {CFrame = CFrame.new(pos)}
    TweenService:Create(HRP, tweenInfo, goal):Play()
end

local function findNearestMob()
    local closest, minDist = nil, math.huge
    for _, mob in pairs(workspace:GetDescendants()) do
        if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
            local dist = (HRP.Position - mob.HumanoidRootPart.Position).Magnitude
            if dist < minDist then
                minDist = dist
                closest = mob
            end
        end
    end
    return closest
end

-- AUTOTELEPORT LOOP
task.spawn(function()
    while true do
        if autoTeleportEnabled then
            local mob = findNearestMob()
            if mob then
                tweenTo(mob.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
            end
        end
        task.wait(teleportInterval)
    end
end)

-- UI SETUP
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "SkyhubGUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 400)
Frame.Position = UDim2.new(0.02, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", Frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Skyhub for Arise"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- TOGGLE BUTTON FOR AUTO TELEPORT
local Toggle = Instance.new("TextButton", Frame)
Toggle.Size = UDim2.new(0.9, 0, 0, 30)
Toggle.Position = UDim2.new(0.05, 0, 0, 40)
Toggle.Text = "Auto Teleport: OFF"
Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Toggle.TextColor3 = Color3.new(1, 1, 1)
Toggle.Font = Enum.Font.Gotham
Toggle.TextSize = 14
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 6)

Toggle.MouseButton1Click:Connect(function()
    autoTeleportEnabled = not autoTeleportEnabled
    Toggle.Text = "Auto Teleport: " .. (autoTeleportEnabled and "ON" or "OFF")
end)

-- TWEEN SPEED SLIDER
local tweenLabel = Instance.new("TextLabel", Frame)
tweenLabel.Position = UDim2.new(0.05, 0, 0, 80)
tweenLabel.Size = UDim2.new(0.9, 0, 0, 20)
tweenLabel.TextColor3 = Color3.new(1, 1, 1)
tweenLabel.BackgroundTransparency = 1
tweenLabel.Text = "Tween Speed: 0.5s"
tweenLabel.Font = Enum.Font.Gotham
tweenLabel.TextSize = 14

local tweenSlider = Instance.new("TextBox", Frame)
tweenSlider.Position = UDim2.new(0.05, 0, 0, 100)
tweenSlider.Size = UDim2.new(0.9, 0, 0, 25)
tweenSlider.PlaceholderText = "Enter tween speed (e.g. 0.3)"
tweenSlider.Text = ""
tweenSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tweenSlider.TextColor3 = Color3.new(1, 1, 1)
tweenSlider.Font = Enum.Font.Gotham
tweenSlider.TextSize = 14
Instance.new("UICorner", tweenSlider).CornerRadius = UDim.new(0, 6)

tweenSlider.FocusLost:Connect(function()
    local val = tonumber(tweenSlider.Text)
    if val then
        tweenSpeed = math.clamp(val, 0.05, 3)
        tweenLabel.Text = "Tween Speed: " .. tweenSpeed .. "s"
    end
end)

-- TELEPORT INTERVAL SLIDER
local intervalLabel = Instance.new("TextLabel", Frame)
intervalLabel.Position = UDim2.new(0.05, 0, 0, 135)
intervalLabel.Size = UDim2.new(0.9, 0, 0, 20)
intervalLabel.TextColor3 = Color3.new(1, 1, 1)
intervalLabel.BackgroundTransparency = 1
intervalLabel.Text = "Teleport Interval: 2s"
intervalLabel.Font = Enum.Font.Gotham
intervalLabel.TextSize = 14

local intervalSlider = Instance.new("TextBox", Frame)
intervalSlider.Position = UDim2.new(0.05, 0, 0, 155)
intervalSlider.Size = UDim2.new(0.9, 0, 0, 25)
intervalSlider.PlaceholderText = "Enter interval (e.g. 1.5)"
intervalSlider.Text = ""
intervalSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
intervalSlider.TextColor3 = Color3.new(1, 1, 1)
intervalSlider.Font = Enum.Font.Gotham
intervalSlider.TextSize = 14
Instance.new("UICorner", intervalSlider).CornerRadius = UDim.new(0, 6)

intervalSlider.FocusLost:Connect(function()
    local val = tonumber(intervalSlider.Text)
    if val then
        teleportInterval = math.clamp(val, 0.1, 10)
        intervalLabel.Text = "Teleport Interval: " .. teleportInterval .. "s"
    end
end)

-- Add additional functionality here based on the original SKYLOLAND script
