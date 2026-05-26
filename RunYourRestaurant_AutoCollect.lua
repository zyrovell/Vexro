local Rayfield=loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local W=Window=Rayfield:CreateWindow({Name="Vexro | RYR",LoadingTitle="Vexro",LoadingSubtitle="Auto Collect",Theme="Default",ConfigurationSaving={Enabled=true,FolderName="VX",FileName="RYR"},KeySystem=false})
local T=W:CreateTab("Main",4483362458)
local S=W:CreateTab("Settings",4483362458)
local cfg={on=false,delay=0.2,speed=16}
local lp=game:GetService("Players").LocalPlayer
local ws=game:GetService("Workspace")
local char=lp.Character or lp.CharacterAdded:Wait()
local hrp=char:WaitForChild("HumanoidRootPart")
local hum=char:WaitForChild("Humanoid")
lp.CharacterAdded:Connect(function(c) char=c hrp=c:WaitForChild("HumanoidRootPart") hum=c:WaitForChild("Humanoid") end)
local lbl
local function st(t) if lbl then lbl:Set("Status: "..t) end end
local function walk(pos)
    hum:MoveTo(pos)
    local t=tick()
    repeat task.wait(0.05) until (hrp.Position-pos).Magnitude<4 or tick()-t>6
end
local function getTycoon()
    local tycoons=ws:FindFirstChild("Tycoons")
    if not tycoons then return nil end
    for _,ty in ipairs(tycoons:GetChildren()) do
        local owner=ty:FindFirstChild("Owner") or ty:FindFirstChild("owner")
        if owner and owner.Value==lp then return ty end
        if ty.Name==lp.Name then return ty end
    end
    return nil
end
local function getCash()
    local out={}
    local ty=getTycoon()
    if not ty then return out end
    local main=ty:FindFirstChild("TycoonMain")
    if not main then return out end
    local tables=main:FindFirstChild("Tables")
    if not tables then return out end
    for _,tbl in ipairs(tables:GetChildren()) do
        local opt=tbl:FindFirstChild("TableOption")
        if opt then
            local set=opt:FindFirstChild("TableSet")
            if set then
                for _,cash in ipairs(set:GetChildren()) do
                    local c=cash:FindFirstChild("Cash")
                    if c then
                        local pp=c:FindFirstChildWhichIsA("ProximityPrompt")
                        if pp and pp.Enabled then table.insert(out,{part=c,prompt=pp}) end
                    end
                end
            end
        end
    end
    return out
end
local function collect(item)
    walk(item.part.Position)
    task.wait(cfg.delay)
    if fireproximityprompt then
        fireproximityprompt(item.prompt)
    else
        item.prompt:InputHoldBegin()
        task.wait(0.1)
        item.prompt:InputHoldEnd()
    end
    st("Collected!")
end
local loop=nil
local function startLoop()
    if loop then return end
    st("Running...")
    loop=task.spawn(function()
        while cfg.on do
            local items=getCash()
            if #items>0 then
                st(#items.." cash found!")
                for _,i in ipairs(items) do
                    if not cfg.on then break end
                    collect(i)
                    task.wait(0.3)
                end
            else st("Waiting...") end
            task.wait(0.5)
        end
        loop=nil st("Stopped")
    end)
end
T:CreateSection("Collect Payment")
T:CreateToggle({Name="Auto Collect Payment",CurrentValue=false,Flag="ac",Callback=function(v) cfg.on=v if v then startLoop() else st("Stopped") end end})
T:CreateSection("Status")
lbl=T:CreateLabel("Status: Idle")
T:CreateButton({Name="Collect Once",Callback=function()
    local items=getCash()
    if #items==0 then st("No cash found!") else for _,i in ipairs(items) do collect(i) task.wait(0.3) end end
end})
S:CreateSlider({Name="Collect Delay",Range={0,2},Increment=0.1,Suffix="s",CurrentValue=0.2,Flag="cd",Callback=function(v) cfg.delay=v end})
S:CreateSlider({Name="Walk Speed",Range={16,100},Increment=1,CurrentValue=16,Flag="ws",Callback=function(v) cfg.speed=v if hum then hum.WalkSpeed=v end end})
Rayfield:Notify({Title="Vexro",Content="RYR loaded!",Duration=4})
Rayfield:LoadConfiguration()
