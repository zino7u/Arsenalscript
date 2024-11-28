local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local validKey = "762009"
local discordLink = "https://discord.gg/Kj2HnR3ga2"
local scriptExecutionTime = 6 * 60 * 60 -- 6 hours in seconds

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "KeyLoginSystem"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0.6, 0, 0.8, 0)
MainFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0

local UICornerMain = Instance.new("UICorner", MainFrame)
UICornerMain.CornerRadius = UDim.new(0, 15)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "🔒 ARSENAL SCRIPT Z"
Title.Size = UDim2.new(1, 0, 0.1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(200, 200, 200)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold

local KeyBox = Instance.new("TextBox", MainFrame)
KeyBox.PlaceholderText = "Enter Key"
KeyBox.Size = UDim2.new(0.8, 0, 0.08, 0)
KeyBox.Position = UDim2.new(0.1, 0, 0.2, 0)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextColor3 = Color3.fromRGB(200, 200, 200)
KeyBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
KeyBox.TextScaled = true

local UICornerKeyBox = Instance.new("UICorner", KeyBox)
UICornerKeyBox.CornerRadius = UDim.new(0, 10)

local GetKeyButton = Instance.new("TextButton", MainFrame)
GetKeyButton.Text = "Get Key"
GetKeyButton.Size = UDim2.new(0.4, 0, 0.08, 0)
GetKeyButton.Position = UDim2.new(0.3, 0, 0.3, 0)
GetKeyButton.Font = Enum.Font.Gotham
GetKeyButton.TextColor3 = Color3.fromRGB(200, 200, 200)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
GetKeyButton.TextScaled = true

local UICornerGetKey = Instance.new("UICorner", GetKeyButton)
UICornerGetKey.CornerRadius = UDim.new(0, 10)

local DiscordLink = Instance.new("TextButton", MainFrame)
DiscordLink.Text = "Join Discord for the Key!"
DiscordLink.Size = UDim2.new(0.8, 0, 0.08, 0)
DiscordLink.Position = UDim2.new(0.1, 0, 0.4, 0)
DiscordLink.Font = Enum.Font.Gotham
DiscordLink.TextColor3 = Color3.fromRGB(120, 120, 120)
DiscordLink.BackgroundTransparency = 1
DiscordLink.TextScaled = true

-- Beispielkorrektur: Initialisierung einer Funktion
if not setclipboard then
    setclipboard = function() end -- Dummy-Funktion, wenn sie nicht definiert ist
end

-- Sicherstellen, dass die Funktion korrekt zugewiesen ist
DiscordLink.MouseButton1Click:Connect(function()
    setclipboard(discordLink)
    DiscordLink.Text = "Copied to clipboard!"
    wait(2)
    DiscordLink.Text = "Join Discord for the Key!"
end)


local NextButton = Instance.new("TextButton", MainFrame)
NextButton.Text = "Next"
NextButton.Size = UDim2.new(0.4, 0, 0.08, 0)
NextButton.Position = UDim2.new(0.3, 0, 0.5, 0)
NextButton.Font = Enum.Font.Gotham
NextButton.TextColor3 = Color3.fromRGB(200, 200, 200)
NextButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
NextButton.TextScaled = true

local UICornerNext = Instance.new("UICorner", NextButton)
UICornerNext.CornerRadius = UDim.new(0, 10)

NextButton.MouseButton1Click:Connect(function()
    if KeyBox.Text == validKey then
        Title.Text = "Verifying..."
        wait(2)
        Title.Text = "Login Page"
        
        KeyBox:Destroy()
        GetKeyButton:Destroy()
        NextButton:Destroy()
        DiscordLink:Destroy()

        local EmailBox = Instance.new("TextBox", MainFrame)
        EmailBox.PlaceholderText = "Enter Email"
        EmailBox.Size = UDim2.new(0.8, 0, 0.08, 0)
        EmailBox.Position = UDim2.new(0.1, 0, 0.2, 0)
        EmailBox.Font = Enum.Font.Gotham
        EmailBox.TextColor3 = Color3.fromRGB(200, 200, 200)
        EmailBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        EmailBox.TextScaled = true

        local UICornerEmail = Instance.new("UICorner", EmailBox)
        UICornerEmail.CornerRadius = UDim.new(0, 10)

        local PasswordBox = Instance.new("TextBox", MainFrame)
        PasswordBox.PlaceholderText = "Enter Password"
        PasswordBox.Size = UDim2.new(0.8, 0, 0.08, 0)
        PasswordBox.Position = UDim2.new(0.1, 0, 0.3, 0)
        PasswordBox.Font = Enum.Font.Gotham
        PasswordBox.TextColor3 = Color3.fromRGB(200, 200, 200)
        PasswordBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        PasswordBox.TextScaled = true

        local UICornerPassword = Instance.new("UICorner", PasswordBox)
        UICornerPassword.CornerRadius = UDim.new(0, 10)

        local LoginButton = Instance.new("TextButton", MainFrame)
        LoginButton.Text = "Login"
        LoginButton.Size = UDim2.new(0.4, 0, 0.08, 0)
        LoginButton.Position = UDim2.new(0.3, 0, 0.4, 0)
        LoginButton.Font = Enum.Font.Gotham
        LoginButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        LoginButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
        LoginButton.TextScaled = true

        local UICornerLogin = Instance.new("UICorner", LoginButton)
        UICornerLogin.CornerRadius = UDim.new(0, 10)

        local SkipButton = Instance.new("TextButton", MainFrame)
        SkipButton.Text = "Skip"
        SkipButton.Size = UDim2.new(0.3, 0, 0.05, 0)
        SkipButton.Position = UDim2.new(0.35, 0, 0.5, 0)
        SkipButton.Font = Enum.Font.Gotham
        SkipButton.TextColor3 = Color3.fromRGB(120, 120, 120)
        SkipButton.BackgroundTransparency = 1
        SkipButton.TextScaled = true

        local function runScript()
            Title.Text = "Welcome, " .. LocalPlayer.Name .. "!"
            EmailBox:Destroy()
            PasswordBox:Destroy()
            LoginButton:Destroy()
            SkipButton:Destroy()
            wait(2)
            MainFrame:Destroy()

            -- Insert your code here
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

            local CircleAimbot = {
                Enabled = false,
                Radius = 150,
                Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
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
    return hit and hit:IsDescendantOf(targetPart.Parent) -- Diese Zeile ist korrekt, keine Klammern notwendig
end


            local function GetClosestTarget()
                local closestTarget = nil
                local closestDistance = Aimbot.MaxDistance

                for _, player in pairs(Players:GetPlayers()) do
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

local function CreateCircleAimbot()
    local circle = Drawing.new("Circle")
    circle.Position = CircleAimbot.Position
    circle.Radius = CircleAimbot.Radius
    circle.Visible = true
    circle.Color = Color3.fromRGB(255, 0, 0)
    circle.Thickness = 2
    circle.Filled = false

    RunService.RenderStepped:Connect(function()
        circle.Visible = CircleAimbot.Enabled
        circle.Position = CircleAimbot.Position
        circle.Radius = CircleAimbot.Radius
    end)

    return circle
end

local function IsPlayerInCircle(target)
    local targetPosition = Camera:WorldToScreenPoint(target.Character.HumanoidRootPart.Position)
    local distance = (Vector2.new(targetPosition.X, targetPosition.Y) - CircleAimbot.Position).Magnitude
    return distance <= CircleAimbot.Radius
end

RunService.RenderStepped:Connect(function()
    if CircleAimbot.Enabled then
        local closestTarget = GetClosestTarget()
        if closestTarget and IsPlayerInCircle(closestTarget) then
            AimAt(closestTarget)
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

        local line = Drawing.new("Line")
        line.Thickness = 2
        line.Color = Color3.fromRGB(0, 255, 0)
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
    mainFrame.Size = UDim2.new(0, 250, 0, 450)
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
        CircleAimbot.Radius = (newSize <= 300) and newSize or 50
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

    CreateMainGUI()
    EnableESP()
    EnableAFKFarm()
    CreateCrosshair()
    CreateCircleAimbot()

    wait(scriptExecutionTime)
    print("Script ended!") -- Effect ends here
end

LoginButton.MouseButton1Click:Connect(runScript)
SkipButton.MouseButton1Click:Connect(runScript)
else
    KeyBox.Text = "Invalid Key!"
end
end)
