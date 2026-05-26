-- Run Your Restaurant | Auto Collect Payment
-- UI: Rayfield Library
-- Vexro Scripts

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Vexro | Run Your Restaurant",
    Icon = 0,
    LoadingTitle = "Vexro Scripts",
    LoadingSubtitle = "Run Your Restaurant",
    Theme = "Default",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "VexroScripts",
        FileName = "RunYourRestaurant"
    },
    KeySystem = false,
})

local MainTab = Window:CreateTab("Auto Farm", 4483362458)
local SettingsTab = Window:CreateTab("Settings", 4483362458)

local StatusLabel

local Settings = {
    AutoCollect = false,
    WalkToCustomer = true,
    CollectDelay = 0.3,
    WalkSpeed = 16,
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    Humanoid = newChar:WaitForChild("Humanoid")
end)

local function setStatus(text)
    if StatusLabel then
        StatusLabel:Set("Status: " .. text)
    end
end

local function walkTo(position, timeout)
    timeout = timeout or 5
    Humanoid:MoveTo(position)
    local startTime = tick()
    repeat
        task.wait(0.05)
    until (HumanoidRootPart.Position - position).Magnitude < 5
        or (tick() - startTime) > timeout
end

local function findCollectButtons()
    local buttons = {}

    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        for _, gui in ipairs(playerGui:GetDescendants()) do
            if gui:IsA("TextButton") or gui:IsA("ImageButton") then
                local name = gui.Name:lower()
                local text = (gui:IsA("TextButton") and gui.Text:lower()) or ""
                if name:find("collect") or text:find("collect")
                    or name:find("payment") or text:find("payment")
                    or name:find("pay") or text:find("pay") then
                    if gui.Visible and gui.Active then
                        table.insert(buttons, gui)
                    end
                end
            end
        end
    end

    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
            for _, child in ipairs(obj:GetDescendants()) do
                if child:IsA("TextButton") or child:IsA("ImageButton") then
                    local name = child.Name:lower()
                    local text = (child:IsA("TextButton") and child.Text:lower()) or ""
                    if name:find("collect") or text:find("collect")
                        or name:find("payment") or text:find("payment")
                        or name:find("pay") or text:find("pay") then
                        if child.Visible and child.Active then
                            table.insert(buttons, child)
                        end
                    end
                end
            end
        end
    end

    return buttons
end

local function getButtonWorldPosition(button)
    local bg = button:FindFirstAncestorWhichIsA("BillboardGui")
        or button:FindFirstAncestorWhichIsA("SurfaceGui")
    if bg then
        local adornee = bg.Adornee
        if adornee and adornee:IsA("BasePart") then
            return adornee.Position
        end
        local p = bg.Parent
        while p do
            if p:IsA("BasePart") then
                return p.Position
            end
            p = p.Parent
        end
    end
    return nil
end

local function collectFromButton(button)
    if not button or not button.Visible or not button.Active then
        return
    end

    local worldPos = getButtonWorldPosition(button)

    if Settings.WalkToCustomer and worldPos then
        setStatus("Walking to customer...")
        walkTo(worldPos, 6)
    end

    task.wait(Settings.CollectDelay)

    local ok = pcall(function()
        button.MouseButton1Click:Fire()
    end)

    if not ok then
        pcall(function()
            button.MouseButton1Down:Fire(0, 0, Enum.UserInputType.MouseButton1)
        end)
        task.wait(0.05)
        pcall(function()
            button.MouseButton1Up:Fire(0, 0, Enum.UserInputType.MouseButton1)
        end)
    end

    setStatus("Payment collected!")
end

local collectLoop = nil

local function startAutoCollect()
    if collectLoop then
        return
    end
    setStatus("Running...")

    collectLoop = task.spawn(function()
        while Settings.AutoCollect do
            local buttons = findCollectButtons()
            if #buttons > 0 then
                setStatus(#buttons .. " payment(s) found!")
                for _, btn in ipairs(buttons) do
                    if not Settings.AutoCollect then
                        break
                    end
                    collectFromButton(btn)
                    task.wait(0.2)
                end
            else
                setStatus("Waiting for customers...")
            end
            task.wait(0.5)
        end
        collectLoop = nil
        setStatus("Stopped")
    end)
end

local function stopAutoCollect()
    Settings.AutoCollect = false
    collectLoop = nil
    setStatus("Stopped")
end

-- Main Tab UI

MainTab:CreateSection("Collect Payment")

MainTab:CreateToggle({
    Name = "Auto Collect Payment",
    CurrentValue = false,
    Flag = "AutoCollect",
    Callback = function(value)
        Settings.AutoCollect = value
        if value then
            startAutoCollect()
        else
            stopAutoCollect()
        end
    end,
})

MainTab:CreateToggle({
    Name = "Walk To Customer",
    CurrentValue = true,
    Flag = "WalkToCustomer",
    Callback = function(value)
        Settings.WalkToCustomer = value
    end,
})

MainTab:CreateSection("Status")

StatusLabel = MainTab:CreateLabel("Status: Idle")

MainTab:CreateButton({
    Name = "Collect Once (Manual)",
    Callback = function()
        local buttons = findCollectButtons()
        if #buttons == 0 then
            setStatus("No button found!")
            Rayfield:Notify({
                Title = "Vexro",
                Content = "Collect Payment button not found!",
                Duration = 3,
                Image = 4483362458,
            })
        else
            for _, btn in ipairs(buttons) do
                collectFromButton(btn)
                task.wait(0.2)
            end
        end
    end,
})

-- Settings Tab UI

SettingsTab:CreateSection("Speed Settings")

SettingsTab:CreateSlider({
    Name = "Collect Delay (seconds)",
    Range = {0, 2},
    Increment = 0.1,
    Suffix = "s",
    CurrentValue = Settings.CollectDelay,
    Flag = "CollectDelay",
    Callback = function(value)
        Settings.CollectDelay = value
    end,
})

SettingsTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 100},
    Increment = 1,
    Suffix = "",
    CurrentValue = Settings.WalkSpeed,
    Flag = "WalkSpeed",
    Callback = function(value)
        Settings.WalkSpeed = value
        if Humanoid then
            Humanoid.WalkSpeed = value
        end
    end,
})

SettingsTab:CreateSection("Info")

SettingsTab:CreateLabel("Vexro Scripts | Run Your Restaurant")
SettingsTab:CreateLabel("Auto Collect Payment v1.1")

-- Startup notification

Rayfield:Notify({
    Title = "Vexro Scripts",
    Content = "Run Your Restaurant loaded!\nEnable Auto Collect to start.",
    Duration = 5,
    Image = 4483362458,
})

Rayfield:LoadConfiguration()
