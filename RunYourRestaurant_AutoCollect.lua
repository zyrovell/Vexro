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

local cfg = { on = false, walk = true, delay = 0.2, speed = 16 }

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
    repeat task.wait(0.05) until (hrp.Position - pos).Magnitude < 5 or tick() - t > (timeout or 6)
end

-- Find all ProximityPrompts related to collecting payment
local function getPrompts()
    local out = {}
    for _, v in ipairs(game.Workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            local n = v.ActionText:lower() .. v.ObjectText:lower() .. v.Name:lower()
            if n:find("collect") or n:find("payment") or n:find("pay") then
                table.insert(out, v)
            end
        end
    end
    return out
end

-- Get the world position of a ProximityPrompt's parent part
local function getPromptPos(prompt)
    local p = prompt.Parent
    while p do
        if p:IsA("BasePart") then return p.Position end
        p = p.Parent
    end
    return nil
end

local function doCollect(prompt)
    if not prompt or not prompt.Enabled then return end
    local pos = getPromptPos(prompt)
    if cfg.walk and pos then
        setStatus("Walking to customer...")
        walkTo(pos, 6)
    end
    task.wait(cfg.delay)
    -- Fire the proximity prompt (executor built-in function)
    if fireproximityprompt then
        fireproximityprompt(prompt)
    else
        -- Fallback: trigger via internal hold events
        prompt.TriggerEnded:Fire(lp)
        task.wait(0.05)
        prompt:InputHoldBegin()
        task.wait(0.1)
        prompt:InputHoldEnd()
    end
    setStatus("Collected!")
end

local loop = nil

local function startLoop()
    if loop then return end
    setStatus("Running...")
    loop = task.spawn(function()
        while cfg.on do
            local prompts = getPrompts()
            if #prompts > 0 then
                setStatus(#prompts .. " customer(s) found!")
                for _, p in ipairs(prompts) do
                    if not cfg.on then break end
                    doCollect(p)
                    task.wait(0.3)
                end
            else
                setStatus("Waiting for customers...")
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
        if v then
            startLoop()
        else
            cfg.on = false
            setStatus("Stopped")
        end
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
        local prompts = getPrompts()
        if #prompts == 0 then
            setStatus("No customer found!")
        else
            for _, p in ipairs(prompts) do
                doCollect(p)
                task.wait(0.3)
            end
        end
    end,
})

SetTab:CreateSection("Speed")

SetTab:CreateSlider({
    Name = "Collect Delay",
    Range = {0, 2},
    Increment = 0.1,
    Suffix = "s",
    CurrentValue = 0.2,
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
