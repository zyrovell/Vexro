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
local RANGE=300
local function isVisible(obj)
    if obj:IsA("BasePart") then return obj.Transparency<1 end
    for _,p in ipairs(obj:GetDescendants()) do
        if p:IsA("BasePart") and p.Transparency<1 then return true end
    end
    return false
end
local function fire(pp) if fireproximityprompt then fireproximityprompt(pp) else pp:InputHoldBegin() task.wait(0.1) pp:InputHoldEnd() end end
local function findPrompts(filter)
    local out={}
    local tycoons=ws:FindFirstChild("Tycoons")
    if not tycoons then return out end
    for _,v in ipairs(tycoons:GetDescendants()) do
        if v:IsA("ProximityPrompt") and v.Enabled then
            local part=v.Parent
            if part and part:IsA("BasePart") and (hrp.Position-part.Position).Magnitude<RANGE then
                local n=(v.ActionText..v.ObjectText..v.Name):lower()
                if filter(n,part) then table.insert(out,{part=part,prompt=v}) end
            end
        end
    end
    return out
end
local function getCash() return findPrompts(function(n,p) return (n:find("collect") or n:find("payment")) and isVisible(p) end) end
local function getDirtyTrays() return findPrompts(function(n) return n:find("grab") and n:find("tray") end) end
local function getSlotCount(part)
    local searched={}
    local function searchIn(obj)
        if not obj or searched[obj] then return nil,nil end
        searched[obj]=true
        for _,v in ipairs(obj:GetDescendants()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") then
                local c,m=v.Text:match("(%d+)/(%d+)")
                if c then return tonumber(c),tonumber(m) end
            end
        end
        return nil,nil
    end
    -- search part itself, its parent model, and grandparent
    local c,m=searchIn(part)
    if c then return c,m end
    c,m=searchIn(part.Parent)
    if c then return c,m end
    if part.Parent then c,m=searchIn(part.Parent.Parent) end
    return c,m
end
local function getDelivery()
    local all=findPrompts(function(n) return n:find("deliver") end)
    local avail={}
    for _,item in ipairs(all) do
        local c,m=getSlotCount(item.part)
        local full=(c and m and c>=m)
        if not full then table.insert(avail,{item=item,cur=c or 0,max=m or 99}) end
    end
    table.sort(avail,function(a,b) return a.cur<b.cur end)
    local out={}
    for _,v in ipairs(avail) do table.insert(out,v.item) end
    return out
end
local function hasTray()
    for _,v in ipairs(char:GetChildren()) do
        if v.Name:lower():find("dirty") or v.Name:lower():find("tray") then return true end
    end
    local bp=lp:FindFirstChild("Backpack")
    if bp then for _,v in ipairs(bp:GetChildren()) do if v.Name:lower():find("dirty") or v.Name:lower():find("tray") then return true end end end
    return false
end
-- Collect Payment loop
local collectLoop=nil
local function startCollect()
    if collectLoop then return end
    st("Collect: Running...")
    collectLoop=task.spawn(function()
        while cfg.collect and not _env.dead do
            local items=getCash()
            if #items>0 then
                st(#items.." cash found!")
                for _,i in ipairs(items) do
                    if not cfg.collect or _env.dead then break end
                    tp(i.part.Position) task.wait(cfg.delay) fire(i.prompt) st("Collected!") task.wait(0.3)
                end
            end
            task.wait(0.5)
        end
        collectLoop=nil
    end)
end
-- Dirty Tray loop
local trayLoop=nil
local function startTray()
    if trayLoop then return end
    st("Tray: Running...")
    trayLoop=task.spawn(function()
        while cfg.tray and not _env.dead do
            if not hasTray() then
                local trays=getDirtyTrays()
                if #trays>0 then
                    local t=trays[1]
                    st("Going to dirty tray...")
                    tp(t.part.Position) task.wait(cfg.delay) fire(t.prompt)
                    task.wait(0.5)
                end
            else
                local deliveries=getDelivery()
                if #deliveries>0 then
                    local d=deliveries[1]
                    st("Delivering tray...")
                    tp(d.part.Position) task.wait(cfg.delay) fire(d.prompt)
                    task.wait(0.5)
                else st("No delivery point!") end
            end
            task.wait(0.4)
        end
        trayLoop=nil
    end)
end
-- UI
T:CreateSection("Collect Payment")
T:CreateToggle({Name="Auto Collect Payment",CurrentValue=false,Flag="ac",Callback=function(v) cfg.collect=v if v then startCollect() end end})
T:CreateSection("Dirty Tray")
T:CreateToggle({Name="Auto Dirty Tray",CurrentValue=false,Flag="at",Callback=function(v) cfg.tray=v if v then startTray() end end})
T:CreateSection("Status")
lbl=T:CreateLabel("Status: Idle")
S:CreateSlider({Name="Action Delay",Range={0,2},Increment=0.1,Suffix="s",CurrentValue=0.2,Flag="cd",Callback=function(v) cfg.delay=v end})
Rayfield:Notify({Title="Vexro",Content="RYR loaded!",Duration=4})
Rayfield:LoadConfiguration()
