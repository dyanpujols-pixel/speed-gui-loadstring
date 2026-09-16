local Players = game:GetService("Players")
local player = Players.LocalPlayer

local speedEnabled = true
local speed = 100

local gui = Instance.new("ScreenGui")
gui.Name = "SpeedMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 150)
frame.Position = UDim2.new(0.5, -110, 0.5, -75)
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "Speed Menu"
title.TextScaled = true
title.Parent = frame

local input = Instance.new("TextBox")
input.Size = UDim2.new(0.8, 0, 0, 35)
input.Position = UDim2.new(0.1, 0, 0.28, 0)
input.Text = tostring(speed)
input.PlaceholderText = "Speed"
input.Parent = frame

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0.8, 0, 0, 35)
toggle.Position = UDim2.new(0.1, 0, 0.55, 0)
toggle.Text = "Speed: ON"
toggle.Parent = frame

input.FocusLost:Connect(function()
    local value = tonumber(input.Text)
    if value then
        speed = math.clamp(value, 0, 500)
        input.Text = tostring(speed)
    end
end)

toggle.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    toggle.Text = speedEnabled and "Speed: ON" or "Speed: OFF"
end)

local function setupCharacter(character)
    local humanoid = character:WaitForChild("Humanoid")

    task.spawn(function()
        while humanoid.Parent do
            if speedEnabled and humanoid.WalkSpeed ~= speed then
                humanoid.WalkSpeed = speed
            end
            task.wait(0.1)
        end
    end)
end

if player.Character then
    setupCharacter(player.Character)
end

player.CharacterAdded:Connect(setupCharacter)