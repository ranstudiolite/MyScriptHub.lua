-- Script Hub Kustom untuk Delta Executor (Lua)
-- Hanya gunakan di game pribadi!

-- Buat GUI di layar pemain
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer.PlayerGui
screenGui.Name = "CustomScriptHub"

-- Buat panel utama
local mainPanel = Instance.new("Frame")
mainPanel.Size = UDim2.new(0, 250, 0, 300)
mainPanel.Position = UDim2.new(0.1, 0, 0.5, -150)
mainPanel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
mainPanel.BackgroundTransparency = 0.2
mainPanel.UICorner = Instance.new("UICorner")
mainPanel.UICorner.CornerRadius = UDim.new(0, 15)
mainPanel.Parent = screenGui

-- Buat judul
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "My Custom Hub"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundColor3 = Color3.new(0.2, 0.4, 0.8)
title.UICorner = Instance.new("UICorner")
title.UICorner.CornerRadius = UDim.new(0, 15)
title.Parent = mainPanel

-- Buat tombol Fly
local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0.8, 0, 0, 35)
flyButton.Position = UDim2.new(0.1, 0, 0.2, 0)
flyButton.Text = "Nyalakan Fly"
flyButton.TextColor3 = Color3.new(1, 1, 1)
flyButton.BackgroundColor3 = Color3.new(0.3, 0.8, 0.3)
flyButton.UICorner = Instance.new("UICorner")
flyButton.UICorner.CornerRadius = UDim.new(0, 10)
flyButton.Parent = mainPanel

-- Buat tombol Auto Farm
local farmButton = Instance.new("TextButton")
farmButton.Size = UDim2.new(0.8, 0, 0, 35)
farmButton.Position = UDim2.new(0.1, 0, 0.35, 0)
farmButton.Text = "Auto Farm"
farmButton.TextColor3 = Color3.new(1, 1, 1)
farmButton.BackgroundColor3 = Color3.new(0.8, 0.6, 0.2)
farmButton.UICorner = Instance.new("UICorner")
farmButton.UICorner.CornerRadius = UDim.new(0, 10)
farmButton.Parent = mainPanel

-- Status toggle
local isFlying = false
local isFarming = false

-- Fungsi Fly
flyButton.MouseButton1Click:Connect(function()
    isFlying = not isFlying
    local character = game.Players.LocalPlayer.Character
    local humanoid = character and character:FindFirstChild("Humanoid")
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")

    if not humanoid or not rootPart then return end

    if isFlying then
        flyButton.Text = "Matikan Fly"
        humanoid.WalkSpeed = 50
        spawn(function()
            while isFlying and character do
                task.wait()
                local input = game:GetService("UserInputService")
                local dir = Vector3.new(0, 0, 0)
                if input:IsKeyDown(Enum.KeyCode.W) then dir += rootPart.CFrame.LookVector * 10 end
                if input:IsKeyDown(Enum.KeyCode.S) then dir -= rootPart.CFrame.LookVector * 10 end
                if input:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0, 10, 0) end
                if input:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.new(0, 10, 0) end
                rootPart.Velocity = dir
            end
        end)
    else
        flyButton.Text = "Nyalakan Fly"
        humanoid.WalkSpeed = 16
        rootPart.Velocity = Vector3.new(0, 0, 0)
    end
end)

-- Fungsi Auto Farm (contoh untuk mengumpulkan Coin)
farmButton.MouseButton1Click:Connect(function()
    isFarming = not isFarming
    local character = game.Players.LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")

    if not rootPart then return end

    if isFarming then
        farmButton.Text = "Matikan Farm"
        spawn(function()
            while isFarming and character do
                task.wait(0.5)
                local coins = workspace:FindPartsInRegion3WithWhiteList(
                    Region3.new(rootPart.Position - Vector3.new(10, 10, 10), rootPart.Position + Vector3.new(10, 10, 10)),
                    {workspace:FindFirstChild("Coins") or Instance.new("Folder")}
                )
                for _, coin in ipairs(coins) do
                    coin:Destroy()
                    print("Coin diambil!")
                end
            end
        end)
    else
        farmButton.Text = "Auto Farm"
    end
end)

print("Script Hub Berjalan!")
