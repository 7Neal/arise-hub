-- Load.lua
-- Arise: Crossover Script Hub (Fast Tween, Auto Farm, Anti-AFK)

-- SERVICES
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local VirtualUser = game:GetService("VirtualUser")

-- UI SETUP
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "AriseScriptHub"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 220, 0, 230)
Frame.Position = UDim2.new(0.05, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

local function CreateButton(text, yPos)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

-- CONFIG
local tweenSpeed = 0.25
local useFastTween = true
local autoFarmEnabled = false

-- Tween function
local function TweenTo(position)
    local tweenInfo = TweenInfo.new(
        useFastTween and tweenSpeed or 1,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
    )
    local goal = { CFrame = CFrame.new(position) }
    local tween = TweenService:Create(HumanoidRootPart, tweenInfo, goal)
    tween:Play()
end

-- UI BUTTONS
local title = Instance.new("TextLabel", Frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Arise Script Hub"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local ToggleTween = CreateButton("Tween: FAST", 40)
local TeleportBtn = CreateButton("Teleport Example", 75)
local AutoFarmBtn = CreateButton("Auto Farm: OFF", 110)
local AntiAFKStatus = CreateButton("Anti-AFK: ACTIVE", 145)

-- Toggle Tween Speed
ToggleTween.MouseButton1Click:Connect(function()
    useFastTween = not useFastTween
    ToggleTween.Text = "Tween: " .. (useFastTween and "FAST" or "SLOW")
end)

-- Example teleport
TeleportBtn.MouseButton1Click:Connect(function()
    TweenTo(Vector3.new(100, 10, 100)) -- Change this to any coord
end)

-- Auto Farm Toggle
AutoFarmBtn.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    AutoFarmBtn.Text = "Auto Farm: " .. (autoFarmEnabled and "ON" or "OFF")

    if autoFarmEnabled then
        task.spawn(function()
            while autoFarmEnabled do
                -- Replace with actual farming coords or logic
                TweenTo(Vector3.new(150, 10, 150))
                task.wait(1.5)
                TweenTo(Vector3.new(200, 10, 150))
                task.wait(1.5)
            end
        end)
    end
end)

-- Anti-AFK Logic
task.spawn(function()
    while true do
        task.wait(60)
        VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end
end)

print("[Arise Hub] Script loaded with Tween, Auto Farm, Anti-AFK.")
