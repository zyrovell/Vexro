local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Vexro | Run Your Restaurant",
    LoadingTitle = "Vexro Scripts",
    LoadingSubtitle = "Auto Collect",
    Theme = "Default",
    ConfigurationSaving = { Enabled = true, FolderName = "VexroScripts", FileName = "RYR" },
    KeySystem = false,
})

local Tab = Window:CreateTab("Main", 4483362458)
local SetTab = Window:CreateTab("Settings", 4483362458)

local cfg = { on = false, walk = true, delay = 0.3, speed = 16 }

local lp = game:GetService("Players").LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

lp.CharacterAdded:Connect(function(c)
    char = c
    hrp = c:WaitForChild("HumanoidRootPart")
    hum = c:WaitForChild("Humanoid")
end)

local lbl

local function setStatus(t)
    if lbl then lbl:Set("Status: " .. t) end
end

local function walkTo(pos, timeout)
    hum:MoveTo(pos)
    local t = tick()
    repeat task.wait(0.05) until (hrp.Position - pos).Magnitude < 5 or tick() - t > (timeout or 5)
end

local function getPos(btn)
    local bg = btn:FindFirstAncestorWhichIsA("BillboardGui") or btn:FindFirstAncestorWhichIsA("SurfaceGui")
    if not bg then return nil end
    if bg.Adornee and bg.Adornee:IsA("BasePart") then return bg.Adornee.Position end
    local p = bg.Parent
    while p do
        if p:IsA("BasePart") then return p.Position end
        p = p.Parent
    end
    return nil
end

local function getButtons()
    local out = {}
    local function check(obj)
        if (obj:IsA("TextButton") or obj:IsA("ImageButton")) and obj.Visible and obj.Active then
            local n = obj.Name:lower()
            local tx = (obj:IsA("TextButton") and obj.Text:lower()) or ""
            if n:find("collect") or n:find("payment") or n:find("pay")
                or tx:find("collect") or tx:find("payment") or tx:find("pay") then
                table.insert(out, obj)
            end
        end
    end
    local pg = lp:FindFirstChild("PlayerGui")
    if pg then for _, v in ipairs(pg:GetDescendants()) do check(v) end end
    for _, v in ipairs(game.Workspace:GetDescendants()) do check(v) end
    return out
end

local function doCollect(btn)
    if not btn or not btn.Visible or not btn.Active then return end
    local pos = getPos(btn)
    if cfg.walk and pos then
        setStatus("Walking to customer...")
        walkTo(pos, 6)
    end
    task.wait(cfg.delay)
    pcall(function() btn.MouseButton1Click:Fire() end)
    setStatus("Collected!")
end

local loop = nil

local function startLoop()
    if loop then return end
    setStatus("Running...")
    loop = task.spawn(function()
        while cfg.on do
            local btns = getButtons()
            if #btns > 0 then
                setStatus(#btns .. " found!")
                for _, b in ipairs(btns) do
                    if not cfg.on then break end
                    doCollect(b)
                    task.wait(0.2)
                end
            else
                setStatus("Waiting...")
            end
            task.wait(0.5)
        end
        loop = nil
        setStatus("Stopped")
    end)
end

Tab:CreateSection("Collect Payment")

Tab:CreateToggle({
    Name = "Auto Collect Payment",
    CurrentValue = false,
    Flag = "ac",
    Callback = function(v)
        cfg.on = v
        if v then startLoop() else cfg.on = false setStatus("Stopped") end
    end,
})

Tab:CreateToggle({
    Name = "Walk To Customer",
    CurrentValue = true,
    Flag = "wt",
    Callback = function(v) cfg.walk = v end,
})

Tab:CreateSection("Status")
lbl = Tab:CreateLabel("Status: Idle")

Tab:CreateButton({
    Name = "Collect Once",
    Callback = function()
        local btns = getButtons()
        if #btns == 0 then
            setStatus("No button found!")
        else
            for _, b in ipairs(btns) do doCollect(b) task.wait(0.2) end
        end
    end,
})

SetTab:CreateSection("Speed")

SetTab:CreateSlider({
    Name = "Collect Delay",
    Range = {0, 2},
    Increment = 0.1,
    Suffix = "s",
    CurrentValue = 0.3,
    Flag = "cd",
    Callback = function(v) cfg.delay = v end,
})

SetTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = 16,
    Flag = "ws",
    Callback = function(v)
        cfg.speed = v
        if hum then hum.WalkSpeed = v end
    end,
})

Rayfield:Notify({ Title = "Vexro", Content = "RYR loaded! Enable Auto Collect.", Duration = 4 })
Rayfield:LoadConfiguration()
