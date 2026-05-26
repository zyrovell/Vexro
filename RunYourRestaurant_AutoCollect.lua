if shared.RYR then shared.RYR.dead=true task.wait(0.2) end
shared.RYR={dead=false}
local _env=shared.RYR
local Rayfield=loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local W=Rayfield:CreateWindow({Name="Vexro | RYR",LoadingTitle="Vexro",LoadingSubtitle="Auto Collect",Theme="Default",ConfigurationSaving={Enabled=true,FolderName="VX",FileName="RYR"},KeySystem=false})
local T=W:CreateTab("Main",4483362458)
local S=W:CreateTab("Settings",4483362458)
local cfg={collect=false,tray=false,delay=0.2}
local lp=game:GetService("Players").LocalPlayer
local ws=game:GetService("Workspace")
local char=lp.Character or lp.CharacterAdded:Wait()
local hrp=char:WaitForChild("HumanoidRootPart")
local hum=char:WaitForChild("Humanoid")
lp.CharacterAdded:Connect(function(c) char=c hrp=c:WaitForChild("HumanoidRootPart") hum=c:WaitForChild("Humanoid") end)
local lbl
local function st(t) if lbl then lbl:Set("Status: "..t) end end
local function tp(pos) hrp.CFrame=CFrame.new(pos+Vector3.new(0,3,0)) end
local function fire(pp) if fireproximityprompt then fireproximityprompt(pp) else pp:InputHoldBegin() task.wait(0.1) pp:InputHoldEnd() end end
local RANGE=300
local function isVisible(o) for _,p in ipairs(o:GetDescendants()) do if p:IsA("BasePart") and p.Transparency<1 then return true end end return o:IsA("BasePart") and o.Transparency<1 end
local function findP(filter) local out={} local ty=ws:FindFirstChild("Tycoons") if not ty then return out end for _,v in ipairs(ty:GetDescendants()) do if v:IsA("ProximityPrompt") and v.Enabled then local p=v.Parent if p and p:IsA("BasePart") and (hrp.Position-p.Position).Magnitude<RANGE then local n=(v.ActionText..v.ObjectText..v.Name):lower() if filter(n,p) then table.insert(out,{part=p,prompt=v}) end end end end return out end
local function getCash() return findP(function(n,p) return (n:find("collect") or n:find("payment")) and isVisible(p) end) end
local function getDirtyTrays() return findP(function(n) return n:find("grab") and n:find("tray") end) end
-- Read maxDeposits from ConveyerConfig
local maxDeposits = 3
local ok, convCfg = pcall(function()
    return require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("ConveyerConfig"))
end)
if ok and type(convCfg) == "table" then
    maxDeposits = convCfg.maxDeposits or maxDeposits
end

local function getCount(part)
    -- Read current deposit count from InputBillboard TextLabel (e.g. "2/3")
    local function scan(o)
        if not o then return nil end
        for _, v in ipairs(o:GetDescendants()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") then
                local c = v.Text:match("^(%d+)/")
                if c then return tonumber(c) end
            end
        end
        return nil
    end
    return scan(part) or scan(part.Parent) or scan(part.Parent and part.Parent.Parent)
end

local function getDelivery()
    local avail = {}
    local tycoons = ws:FindFirstChild("Tycoons")
    if not tycoons then return avail end
    for _, ty in ipairs(tycoons:GetChildren()) do
        local main = ty:FindFirstChild("TycoonMain")
        if not main then continue end
        local cf = main:FindFirstChild("Conveyers")
        if not cf then continue end
        for _, meal in ipairs(cf:GetChildren()) do
            local cv = meal:FindFirstChild("Conveyer")
            if not cv then continue end
            for _, conv in ipairs(cv:GetChildren()) do
                local ctr = conv:FindFirstChild("Counter")
                if not ctr then continue end
                local part = ctr:FindFirstChild("Part")
                if not part or not part:IsA("BasePart") then continue end
                if (hrp.Position - part.Position).Magnitude > RANGE then continue end
                local pp = part:FindFirstChildWhichIsA("ProximityPrompt")
                if not pp or not pp.Enabled then continue end
                local cur = getCount(part) or 0
                if cur < maxDeposits then
                    table.insert(avail, {item = {part = part, prompt = pp}, cur = cur})
                end
            end
        end
    end
    table.sort(avail, function(a, b) return a.cur < b.cur end)
    local out = {}
    for _, v in ipairs(avail) do table.insert(out, v.item) end
    return out
end
local function hasTray()
    for _,v in ipairs(char:GetChildren()) do if v.Name:lower():find("dirty") or v.Name:lower():find("tray") then return true end end
    local bp=lp:FindFirstChild("Backpack") if bp then for _,v in ipairs(bp:GetChildren()) do if v.Name:lower():find("dirty") or v.Name:lower():find("tray") then return true end end end
    return false
end
local collectLoop=nil
local function startCollect()
    if collectLoop then return end st("Collect: Running...")
    collectLoop=task.spawn(function()
        while cfg.collect and not _env.dead do
            local items=getCash()
            if #items>0 then st(#items.." cash found!") for _,i in ipairs(items) do if not cfg.collect or _env.dead then break end tp(i.part.Position) task.wait(cfg.delay) fire(i.prompt) st("Collected!") task.wait(0.3) end end
            task.wait(0.5)
        end collectLoop=nil
    end)
end
local trayLoop=nil
local function startTray()
    if trayLoop then return end st("Tray: Running...")
    trayLoop=task.spawn(function()
        while cfg.tray and not _env.dead do
            if not hasTray() then
                local t=getDirtyTrays() if #t>0 then st("Grabbing tray...") tp(t[1].part.Position) task.wait(cfg.delay) fire(t[1].prompt) task.wait(0.5) end
            else
                local d=getDelivery()
                if #d>0 then st("Delivering...") tp(d[1].part.Position) task.wait(cfg.delay) fire(d[1].prompt) task.wait(0.5)
                else st("All slots full!") end
            end
            task.wait(0.4)
        end trayLoop=nil
    end)
end
T:CreateSection("Collect Payment")
T:CreateToggle({Name="Auto Collect Payment",CurrentValue=false,Flag="ac",Callback=function(v) cfg.collect=v if v then startCollect() end end})
T:CreateSection("Dirty Tray")
T:CreateToggle({Name="Auto Dirty Tray",CurrentValue=false,Flag="at",Callback=function(v) cfg.tray=v if v then startTray() end end})
T:CreateSection("Status")
lbl=T:CreateLabel("Status: Idle")
S:CreateSlider({Name="Action Delay",Range={0,2},Increment=0.1,Suffix="s",CurrentValue=0.2,Flag="cd",Callback=function(v) cfg.delay=v end})
Rayfield:Notify({Title="Vexro",Content="RYR loaded!",Duration=4})
Rayfield:LoadConfiguration()
