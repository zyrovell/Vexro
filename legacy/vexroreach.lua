-- SOCCER LEAGUE REACH - ENGLISH VERSION
-- Made by Oyuncu15q

repeat task.wait() until game:IsLoaded()
wait(2)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Default Settings
local Defaults = {
    KickSize = 15,
    GoalieSize = 15,
    SlideSize = 10,
    DribbleSize = 8,
    HeaderSize = 2.5 -- Normal size roughly
}

local Settings = {
    Enabled = false,
    KickSize = Defaults.KickSize,
    GoalieSize = Defaults.GoalieSize,
    SlideSize = Defaults.SlideSize,
    DribbleSize = Defaults.DribbleSize,
    HeaderSize = Defaults.HeaderSize,
    ShowVisual = true,
    OriginalSizes = {}
}

local visualPart = nil

-- Visual Helper Functions
local function createVisual()
    if visualPart then visualPart:Destroy() end
    visualPart = Instance.new("Part")
    visualPart.Name = "ReachVisual"
    visualPart.Anchored = true
    visualPart.CanCollide = false
    visualPart.Material = Enum.Material.ForceField
    visualPart.Color = Color3.fromRGB(0, 255, 0)
    visualPart.Transparency = 0.7
    visualPart.Shape = Enum.PartType.Ball
    visualPart.Parent = workspace
end

local function removeVisual()
    if visualPart then visualPart:Destroy() visualPart = nil end
end

local function restoreOriginals()
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Hitbox") then
            for name, size in pairs(Settings.OriginalSizes) do
                local part = char.Hitbox:FindFirstChild(name)
                if part then part.Size = size end
            end
        end
    end)
end

-- UI Construction
local Window = Rayfield:CreateWindow({
    Name = "⚽ Vexro Reach",
    LoadingTitle = "Made by Oyuncu15q",
    LoadingSubtitle = "Loading...",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

local MainTab = Window:CreateTab("Main", 4483362458)

MainTab:CreateSection("Master Switch")

local MainToggle = MainTab:CreateToggle({
    Name = "Enable Reach",
    CurrentValue = false,
    Flag = "ReachToggle",
    Callback = function(Value)
        Settings.Enabled = Value
        if Value then
            createVisual()
        else
            removeVisual()
            restoreOriginals()
        end
    end
})

MainTab:CreateSection("Hitbox Settings")

local KickSlider = MainTab:CreateSlider({
    Name = "Kick Reach (Normal)",
    Range = {3, 25},
    Increment = 1,
    CurrentValue = Defaults.KickSize,
    Callback = function(v) Settings.KickSize = v end
})

local GoalieSlider = MainTab:CreateSlider({
    Name = "Goalie Reach (Save)",
    Range = {3, 25},
    Increment = 1,
    CurrentValue = Defaults.GoalieSize,
    Callback = function(v) Settings.GoalieSize = v end
})

local SlideSlider = MainTab:CreateSlider({
    Name = "Slide Reach",
    Range = {3, 20},
    Increment = 1,
    CurrentValue = Defaults.SlideSize,
    Callback = function(v) Settings.SlideSize = v end
})

local DribbleSlider = MainTab:CreateSlider({
    Name = "Dribble Reach",
    Range = {3, 15},
    Increment = 1,
    CurrentValue = Defaults.DribbleSize,
    Callback = function(v) Settings.DribbleSize = v end
})

-- Header Section (Warning)
MainTab:CreateSection("Header Settings")
MainTab:CreateLabel("⚠️ Header Reach (Not Recommended)")

local HeaderSlider = MainTab:CreateSlider({
    Name = "Header Size",
    Range = {2, 10},
    Increment = 0.5,
    CurrentValue = Defaults.HeaderSize,
    Callback = function(v) Settings.HeaderSize = v end
})

-- Visuals Tab
local VisualTab = Window:CreateTab("Visuals", 4483345998)

VisualTab:CreateToggle({
    Name = "Show Visual Hitbox",
    CurrentValue = true,
    Callback = function(v)
        Settings.ShowVisual = v
        if visualPart then visualPart.Transparency = v and 0.7 or 1 end
    end
})

VisualTab:CreateColorPicker({
    Name = "Visual Color",
    Color = Color3.fromRGB(0, 255, 0),
    Callback = function(v)
        if visualPart then visualPart.Color = v end
    end
})

-- Settings / Reset Tab
local SettingsTab = Window:CreateTab("Settings", 4483345998)

SettingsTab:CreateButton({
    Name = "Reset All Settings",
    Callback = function()
        -- Reset Values
        Settings.KickSize = Defaults.KickSize
        Settings.GoalieSize = Defaults.GoalieSize
        Settings.SlideSize = Defaults.SlideSize
        Settings.DribbleSize = Defaults.DribbleSize
        Settings.HeaderSize = Defaults.HeaderSize
        
        -- Update Sliders (Rayfield specific update method)
        KickSlider:Set(Defaults.KickSize)
        GoalieSlider:Set(Defaults.GoalieSize)
        SlideSlider:Set(Defaults.SlideSize)
        DribbleSlider:Set(Defaults.DribbleSize)
        HeaderSlider:Set(Defaults.HeaderSize)
        
        Rayfield:Notify({
            Title = "Reset",
            Content = "All settings reset to default!",
            Duration = 2
        })
    end
})

SettingsTab:CreateButton({
    Name = "Close Script",
    Callback = function()
        Settings.Enabled = false
        removeVisual()
        restoreOriginals()
        Rayfield:Destroy()
    end
})

-- MAIN LOOP
RunService.RenderStepped:Connect(function()
    if not Settings.Enabled then return end
    
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hitbox = char:FindFirstChild("Hitbox")
        if not hitbox then return end
        
        -- Store Originals
        if not Settings.OriginalSizes.Kick then
            for _, child in pairs(hitbox:GetChildren()) do
                if child:IsA("BasePart") then
                    Settings.OriginalSizes[child.Name] = child.Size
                end
            end
        end
        
        -- Apply Sizes
        local kick = hitbox:FindFirstChild("Kick")
        if kick then kick.Size = Vector3.new(Settings.KickSize, Settings.KickSize, Settings.KickSize) end
        
        local goalie = hitbox:FindFirstChild("Goalie")
        if goalie then goalie.Size = Vector3.new(Settings.GoalieSize, Settings.GoalieSize, Settings.GoalieSize) end
        
        local slide = hitbox:FindFirstChild("Slide")
        if slide then slide.Size = Vector3.new(Settings.SlideSize, Settings.SlideSize, Settings.SlideSize) end
        
        local dribble = hitbox:FindFirstChild("Dribble")
        if dribble then dribble.Size = Vector3.new(Settings.DribbleSize, Settings.DribbleSize, Settings.DribbleSize) end
        
        local header = hitbox:FindFirstChild("Header")
        if header then header.Size = Vector3.new(Settings.HeaderSize, Settings.HeaderSize, Settings.HeaderSize) end
        
        -- Update Visual
        if visualPart and hrp and Settings.ShowVisual then
            visualPart.CFrame = hrp.CFrame
            -- Size based on the largest active reach
            local maxSize = math.max(Settings.KickSize, Settings.GoalieSize)
            visualPart.Size = Vector3.new(maxSize * 2, maxSize * 2, maxSize * 2)
        end
    end)
end)

-- Character Added Event
LocalPlayer.CharacterAdded:Connect(function()
    Settings.OriginalSizes = {}
    removeVisual()
    wait(1)
    if Settings.Enabled then createVisual() end
end)

-- Credit Notification
Rayfield:Notify({
    Title = "Vexro Reach",
    Content = "Made by Oyuncu15q",
    Duration = 8,
    Image = 4483345998
})
