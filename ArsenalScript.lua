local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Aimbot = {
    Enabled = false,
    LockPart = "Head",
    MaxDistance = 1000,
    TrackedTarget = nil
}

-- Circle Aimbot
local CircleAimbot = {
    Enabled = false,
    Radius = 150,  -- Circle Radius in pixels
    Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2) -- Mitte des Bildschirms
}

local AFKFarm = {
    Enabled = false
}

local FFA = {
    Enabled = false
}

local ESP = {
    Enabled = true,
    LinesEnabled = false,
    Distance = 1000
}

local function IsEnemy(player)
    return FFA.Enabled or (LocalPlayer.Team == nil or player.Team ~= LocalPlayer.Team)
end

local function IsVisible(targetPart)
    local ray = Ray.new(Camera.CFrame.Position, (targetPart.Position - Camera.CFrame.Position).unit * Aimbot.MaxDistance)
    local hit, _ = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Camera})
    return hit and hit:IsDescendantOf(targetPart.Parent)
end

local function GetClosestTarget()
    local closestTarget = nil
    local closestDistance = Aimbot.MaxDistance

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and IsEnemy(player) and player.Character and player.Character:FindFirstChild(Aimbot.LockPart) then
            local targetPart = player.Character[Aimbot.LockPart]
            local distanceToTarget = (LocalPlayer.Character.HumanoidRootPart.Position - targetPart.Position).Magnitude

            if player.Character.Humanoid.Health > 0 and IsVisible(targetPart) then
                if closestTarget == nil or distanceToTarget < closestDistance then
                    closestDistance = distanceToTarget
                    closestTarget = player
                end
            end
        end
    end

    return closestTarget
end

local function AimAt(target)
    if target and target.Character then
        local targetPart = target.Character:FindFirstChild(Aimbot.LockPart)
        if targetPart then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
        end
    end
end

-- Circle Aimbot Visualisierung
local function CreateCircleAimbot()
    local circle = Drawing.new("Circle")
    circle.Position = CircleAimbot.Position
    circle.Radius = CircleAimbot.Radius
    circle.Visible = true
    circle.Color = Color3.fromRGB(255, 0, 0)  -- Rot
    circle.Thickness = 2
    circle.Filled = false  -- Offen, nicht ausgefüllt

    -- Render-Stepped für den Kreis
    RunService.RenderStepped:Connect(function()
        circle.Visible = CircleAimbot.Enabled
        circle.Position = CircleAimbot.Position
        circle.Radius = CircleAimbot.Radius
    end)

    return circle
end

-- Prüft, ob ein Spieler im Circle Aimbot ist
local function IsPlayerInCircle(target)
    local targetPosition = Camera:WorldToScreenPoint(target.Character.HumanoidRootPart.Position)
    local distance = (Vector2.new(targetPosition.X, targetPosition.Y) - CircleAimbot.Position).Magnitude
    return distance <= CircleAimbot.Radius
end

-- Circle Aimbot Trigger und Zielen
RunService.RenderStepped:Connect(function()
    if CircleAimbot.Enabled then
        local closestTarget = GetClosestTarget()
        if closestTarget and IsPlayerInCircle(closestTarget) then
            AimAt(closestTarget)
            -- Verfolgen, solange das Ziel im Kreis bleibt
            while CircleAimbot.Enabled and closestTarget and IsPlayerInCircle(closestTarget) do
                AimAt(closestTarget)
                RunService.RenderStepped:Wait()
                if not IsVisible(closestTarget.Character:FindFirstChild(Aimbot.LockPart)) or closestTarget.Character.Humanoid.Health <= 0 then
                    break
                end
            end
        end
    end
end)

local function EnableAFKFarm()
    RunService.RenderStepped:Connect(function()
        if AFKFarm.Enabled then
            local target = GetClosestTarget()
            if target and target.Character and target.Character:FindFirstChild(Aimbot.LockPart) then
                local targetPart = target.Character[Aimbot.LockPart]
                if target.Character.Humanoid.Health > 0 then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = targetPart.CFrame * CFrame.new(0, 0, -5)
                end
            end
        end
    end)
end

local function CreateESP(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Adornee = player.Character.Head
        billboardGui.Size = UDim2.new(0, 200, 0, 50)
        billboardGui.StudsOffset = Vector3.new(0, 3, 0)
        billboardGui.AlwaysOnTop = true
        billboardGui.Parent = player.Character.Head

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Parent = billboardGui
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextStrokeTransparency = 0.5
        nameLabel.Font = Enum.Font.Code
        nameLabel.TextSize = 14

        -- ESP Lines
        local line = Drawing.new("Line")
        line.Thickness = 2
        line.Color = Color3.fromRGB(0, 255, 0)  -- Grün
        RunService.RenderStepped:Connect(function()
            line.Visible = ESP.LinesEnabled
            if player.Character and player.Character:FindFirstChild("Head") then
                local screenPosition = Camera:WorldToViewportPoint(player.Character.Head.Position)
                line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                line.To = Vector2.new(screenPosition.X, screenPosition.Y)
            else
                line.Visible = false
            end
        end)
    end
end

local function RemoveESP(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        local billboardGui = player.Character.Head:FindFirstChildOfClass("BillboardGui")
        if billboardGui then
            billboardGui:Destroy()
        end
    end
end

local function EnableESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            CreateESP(player)
        end
    end

    Players.PlayerAdded:Connect(function(player)
        if player ~= LocalPlayer then
            CreateESP(player)
        end
    end)

    Players.PlayerRemoving:Connect(function(player)
        RemoveESP(player)
    end)
end

local function CreateCrosshair()
    local crosshair = Drawing.new("Circle")
    crosshair.Radius = 5
    crosshair.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    crosshair.Visible = true
    crosshair.Thickness = 2

    local hue = 0
    RunService.RenderStepped:Connect(function()
        hue = (hue + 1) % 360
        crosshair.Color = Color3.fromHSV(hue / 360, 1, 1)
    end)
end

RunService.RenderStepped:Connect(function()
    if Aimbot.Enabled then
        Aimbot.TrackedTarget = GetClosestTarget()
        if Aimbot.TrackedTarget then
            AimAt(Aimbot.TrackedTarget)
        end
    end
end)

local function CreateMainGUI()
    local gui = Instance.new("ScreenGui")
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 250, 0, 450)  -- GUI länger gemacht
    mainFrame.Position = UDim2.new(1, -260, 0, 10)
    mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    mainFrame.BorderSizePixel = 0
    mainFrame.BackgroundTransparency = 0.2
    mainFrame.AnchorPoint = Vector2.new(1, 0)
    mainFrame.Visible = false
    mainFrame.Parent = gui

    local openCloseButton = Instance.new("TextButton")
    openCloseButton.Size = UDim2.new(0, 100, 0, 30)
    openCloseButton.Position = UDim2.new(0.5, -50, 0, 10)
    openCloseButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    openCloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    openCloseButton.Text = "Open"
        openCloseButton.Parent = gui
    openCloseButton.Font = Enum.Font.Code
    openCloseButton.BackgroundTransparency = 0.3

    local ffaToggleButton = Instance.new("TextButton")
    ffaToggleButton.Size = UDim2.new(0, 230, 0, 40)
    ffaToggleButton.Position = UDim2.new(0, 10, 0, 50)
    ffaToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    ffaToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ffaToggleButton.Text = "FFA Mode: OFF"
    ffaToggleButton.Parent = mainFrame
    ffaToggleButton.Font = Enum.Font.Code

    local aimbotToggleButton = Instance.new("TextButton")
    aimbotToggleButton.Size = UDim2.new(0, 230, 0, 40)
    aimbotToggleButton.Position = UDim2.new(0, 10, 0, 100)
    aimbotToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    aimbotToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    aimbotToggleButton.Text = "Aimbot: ON"
    aimbotToggleButton.Parent = mainFrame
    aimbotToggleButton.Font = Enum.Font.Code

    local afkFarmButton = Instance.new("TextButton")
    afkFarmButton.Size = UDim2.new(0, 230, 0, 40)
    afkFarmButton.Position = UDim2.new(0, 10, 0, 150)
    afkFarmButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    afkFarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    afkFarmButton.Text = "AFK Farm: OFF"
    afkFarmButton.Parent = mainFrame
    afkFarmButton.Font = Enum.Font.Code

    local circleAimbotButton = Instance.new("TextButton")
    circleAimbotButton.Size = UDim2.new(0, 230, 0, 40)
    circleAimbotButton.Position = UDim2.new(0, 10, 0, 200)
    circleAimbotButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    circleAimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    circleAimbotButton.Text = "Circle Aimbot: OFF"
    circleAimbotButton.Parent = mainFrame
    circleAimbotButton.Font = Enum.Font.Code

    local circleSizeSlider = Instance.new("TextButton")
    circleSizeSlider.Size = UDim2.new(0, 230, 0, 40)
    circleSizeSlider.Position = UDim2.new(0, 10, 0, 250)
    circleSizeSlider.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    circleSizeSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
    circleSizeSlider.Text = "Circle Size: " .. CircleAimbot.Radius
    circleSizeSlider.Parent = mainFrame
    circleSizeSlider.Font = Enum.Font.Code

    local espToggleButton = Instance.new("TextButton")
    espToggleButton.Size = UDim2.new(0, 230, 0, 40)
    espToggleButton.Position = UDim2.new(0, 10, 0, 300)
    espToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    espToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    espToggleButton.Text = "ESP: OFF"
    espToggleButton.Parent = mainFrame
    espToggleButton.Font = Enum.Font.Code

    local espLinesToggleButton = Instance.new("TextButton")
    espLinesToggleButton.Size = UDim2.new(0, 230, 0, 40)
    espLinesToggleButton.Position = UDim2.new(0, 10, 0, 350)
    espLinesToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    espLinesToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    espLinesToggleButton.Text = "ESP Lines: OFF"
    espLinesToggleButton.Parent = mainFrame
    espLinesToggleButton.Font = Enum.Font.Code

    openCloseButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
        openCloseButton.Text = mainFrame.Visible and "Close" or "Open"
    end)

    ffaToggleButton.MouseButton1Click:Connect(function()
        FFA.Enabled = not FFA.Enabled
        ffaToggleButton.Text = "FFA Mode: " .. (FFA.Enabled and "ON" or "OFF")
    end)

    aimbotToggleButton.MouseButton1Click:Connect(function()
        Aimbot.Enabled = not Aimbot.Enabled
        aimbotToggleButton.Text = "Aimbot: " .. (Aimbot.Enabled and "ON" or "OFF")
    end)

    afkFarmButton.MouseButton1Click:Connect(function()
        AFKFarm.Enabled = not AFKFarm.Enabled
        afkFarmButton.Text = "AFK Farm: " .. (AFKFarm.Enabled and "ON" or "OFF")
    end)

    circleAimbotButton.MouseButton1Click:Connect(function()
        CircleAimbot.Enabled = not CircleAimbot.Enabled
        circleAimbotButton.Text = "Circle Aimbot: " .. (CircleAimbot.Enabled and "ON" or "OFF")
    end)

    circleSizeSlider.MouseButton1Click:Connect(function()
        local newSize = CircleAimbot.Radius + 50
        CircleAimbot.Radius = (newSize <= 300) and newSize or 50  -- Kreisradius anpassen (Schrittweise um 50 Pixel)
        circleSizeSlider.Text = "Circle Size: " .. CircleAimbot.Radius
    end)

    espToggleButton.MouseButton1Click:Connect(function()
        ESP.Enabled = not ESP.Enabled
        espToggleButton.Text = "ESP: " .. (ESP.Enabled and "ON" or "OFF")
        espLinesToggleButton.Visible = ESP.Enabled
    end)

    espLinesToggleButton.MouseButton1Click:Connect(function()
        ESP.LinesEnabled = not ESP.LinesEnabled
        espLinesToggleButton.Text = "ESP Lines: " .. (ESP.LinesEnabled and "ON" or "OFF")
    end)
end

CreateMainGUI()
EnableESP()
EnableAFKFarm()
CreateCrosshair()
CreateCircleAimbot()
