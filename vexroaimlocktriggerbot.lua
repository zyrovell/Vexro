-- ═══════════════════════════════════════════════════════════
--                    AIMBOT v1.1
--                    OPEN SOURCE
-- ═══════════════════════════════════════════════════════════

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Re-get camera on change (Fix for some games)
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    Camera = workspace.CurrentCamera
end)

local Settings = {
    AimbotEnabled = false,
    TriggerbotEnabled = false,
    TeamCheck = false,
    WallCheck = true,
    ShowFOV = true,
    FOVRadius = 150,
    Smoothness = 0.15,
    MaxDistance = 500,
    TriggerDelay = 0.05,
    UnlockKey = Enum.KeyCode.Q,
    TargetUpdateRate = 0.05,
}

local BodyParts = {"Head", "UpperTorso", "HumanoidRootPart", "LowerTorso", "Torso"}
local CurrentTarget = nil
local IsTargetLocked = false
local Debounce = false
local LastTargetSearch = 0
local CachedClosestPart = nil

-- ═══════════════════════════════════════════════════════════
--                    RAYFIELD WINDOW
-- ═══════════════════════════════════════════════════════════

local Window = Rayfield:CreateWindow({
    Name = "🎯 Aimbot Suite v1.1",
    LoadingTitle = "Loading Aimbot",
    LoadingSubtitle = "by Oyuncu15q",
    ConfigurationSaving = { Enabled = true, FolderName = "AimbotConfig", FileName = "Settings" },
    KeySystem = false,
    Theme = "Default"
})

local MainTab = Window:CreateTab("🎯 Main")
MainTab:CreateSection("Main Features")

MainTab:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Flag = "AimbotToggle",
    Callback = function(Value)
        Settings.AimbotEnabled = Value
        if not Value then CurrentTarget = nil; IsTargetLocked = false end
    end,
})

MainTab:CreateToggle({
    Name = "Triggerbot",
    CurrentValue = false,
    Flag = "TriggerbotToggle",
    Callback = function(Value)
        Settings.TriggerbotEnabled = Value
    end,
})

local TargetLabel = MainTab:CreateLabel("Target: None")

local SettingsTab = Window:CreateTab("⚙️ Settings")
SettingsTab:CreateSection("Safety & Visuals")

SettingsTab:CreateToggle({
    Name = "Team Check",
    CurrentValue = false,
    Flag = "TeamCheck",
    Callback = function(Value) Settings.TeamCheck = Value end,
})

SettingsTab:CreateToggle({
    Name = "Wall Check",
    CurrentValue = true,
    Flag = "WallCheck",
    Callback = function(Value) Settings.WallCheck = Value end,
})

SettingsTab:CreateSlider({
    Name = "FOV Radius",
    Range = {50, 500},
    Increment = 10,
    CurrentValue = 150,
    Flag = "FOVSlider",
    Callback = function(Value) Settings.FOVRadius = Value end,
})

SettingsTab:CreateSlider({
    Name = "Smoothness",
    Range = {0.01, 1},
    Increment = 0.05,
    CurrentValue = 0.15,
    Flag = "Smoothness",
    Callback = function(Value) Settings.Smoothness = Value end,
})

-- ═══════════════════════════════════════════════════════════
--                    CORE FUNCTIONS
-- ═══════════════════════════════════════════════════════════

local function IsVisible(Part, Character)
    if not Settings.WallCheck then return true end
    local RayParams = RaycastParams.new()
    RayParams.FilterType = Enum.RaycastFilterType.Exclude
    RayParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    local Result = workspace:Raycast(Camera.CFrame.Position, (Part.Position - Camera.CFrame.Position), RayParams)
    return Result and Result.Instance:IsDescendantOf(Character)
end

local function GetClosestPart(Character)
    local ClosestPart = nil
    local ShortestDist = math.huge
    local MousePos = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

    for _, Name in ipairs(BodyParts) do
        local Part = Character:FindFirstChild(Name)
        if Part then
            local ScreenPos, OnScreen = Camera:WorldToViewportPoint(Part.Position)
            if OnScreen then
                local Dist = (Vector2.new(ScreenPos.X, ScreenPos.Y) - MousePos).Magnitude
                if Dist < ShortestDist and IsVisible(Part, Character) then
                    ShortestDist = Dist
                    ClosestPart = Part
                end
            end
        end
    end
    return ClosestPart
end

local function GetTarget()
    local BestTarget = nil
    local BestDist = Settings.FOVRadius
    local MousePos = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 then
            if Settings.TeamCheck and Player.Team == LocalPlayer.Team then continue end
            
            local Root = Player.Character:FindFirstChild("HumanoidRootPart")
            if Root then
                local ScreenPos, OnScreen = Camera:WorldToViewportPoint(Root.Position)
                if OnScreen then
                    local Dist = (Vector2.new(ScreenPos.X, ScreenPos.Y) - MousePos).Magnitude
                    if Dist < BestDist then
                        local VisiblePart = GetClosestPart(Player.Character)
                        if VisiblePart then
                            BestDist = Dist
                            BestTarget = Player
                        end
                    end
                end
            end
        end
    end
    return BestTarget
end

-- ═══════════════════════════════════════════════════════════
--                    FOV VISUAL
-- ═══════════════════════════════════════════════════════════

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.NumSides = 100
FOVCircle.Radius = Settings.FOVRadius
FOVCircle.Filled = false
FOVCircle.Visible = true
FOVCircle.Color = Color3.fromRGB(255, 255, 255)

-- ═══════════════════════════════════════════════════════════
--                    MAIN LOOP
-- ═══════════════════════════════════════════════════════════

RunService.RenderStepped:Connect(function()
    FOVCircle.Visible = Settings.ShowFOV and Settings.AimbotEnabled
    FOVCircle.Radius = Settings.FOVRadius
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

    if Settings.AimbotEnabled then
        if not CurrentTarget or not CurrentTarget.Character or not CurrentTarget.Character:FindFirstChild("Humanoid") or CurrentTarget.Character.Humanoid.Health <= 0 then
            CurrentTarget = GetTarget()
        end

        if CurrentTarget and CurrentTarget.Character then
            local TargetPart = GetClosestPart(CurrentTarget.Character)
            if TargetPart then
                CachedClosestPart = TargetPart
                TargetLabel:Set("Target: " .. CurrentTarget.Name)
                local TargetCFrame = CFrame.new(Camera.CFrame.Position, TargetPart.Position)
                Camera.CFrame = Camera.CFrame:Lerp(TargetCFrame, Settings.Smoothness)
            else
                CurrentTarget = nil
            end
        else
            TargetLabel:Set("Target: None")
        end
    end

    -- Triggerbot
    if Settings.TriggerbotEnabled then
        local MousePos = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        local UnitRay = Camera:ViewportPointToRay(MousePos.X, MousePos.Y)
        local RayParams = RaycastParams.new()
        RayParams.FilterType = Enum.RaycastFilterType.Exclude
        RayParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
        
        local Result = workspace:Raycast(UnitRay.Origin, UnitRay.Direction * 1000, RayParams)
        
        if Result and Result.Instance and Result.Instance.Parent:FindFirstChild("Humanoid") then
            local HitPlayer = Players:GetPlayerFromCharacter(Result.Instance.Parent)
            if HitPlayer and (not Settings.TeamCheck or HitPlayer.Team ~= LocalPlayer.Team) then
                if not Debounce then
                    Debounce = true
                    VirtualInputManager:SendMouseButtonEvent(MousePos.X, MousePos.Y, 0, true, game, 1)
                    task.wait(0.02)
                    VirtualInputManager:SendMouseButtonEvent(MousePos.X, MousePos.Y, 0, false, game, 1)
                    task.wait(Settings.TriggerDelay)
                    Debounce = false
                end
            end
        end
    end
end)

-- Keybind fix for unlocking
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Settings.UnlockKey then
        CurrentTarget = nil
    end
end)

Rayfield:Notify({Title = "Aimbot Fix Loaded", Content = "Trigger & Aim stabilized!", Duration = 3})
