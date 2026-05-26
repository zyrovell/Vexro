if shared.RYR then shared.RYR.dead=true task.wait(0.2) end
shared.RYR={dead=false}
local _env=shared.RYR
local Rayfield=loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local W=Rayfield:CreateWindow({Name="Vexro | RYR",LoadingTitle="Vexro",LoadingSubtitle="Auto Collect",Theme="Default",ConfigurationSaving={Enabled=true,FolderName="VX",FileName="RYR"},KeySystem=false})
local T=W:CreateTab("Main",4483362458)
local S=W:CreateTab("Settings",4483362458)
local cfg={on=false,delay=0.2}
local lp=game:GetService("Players").LocalPlayer
local ws=game:GetService("Workspace")
local char=lp.Character or lp.CharacterAdded:Wait()
local hrp=char:WaitForChild("HumanoidRootPart")
local hum=char:WaitForChild("Humanoid")
lp.CharacterAdded:Connect(function(c) char=c hrp=c:WaitForChild("HumanoidRootPart") hum=c:WaitForChild("Humanoid") end)
local lbl
local function st(t) if lbl then lbl:Set("Status: "..t) end end
local function teleport(pos)
    hrp.CFrame=CFrame.new(pos+Vector3.new(0,3,0))
end
local RANGE=300
local function isVisible(obj)
    if obj:IsA("BasePart") then return obj.Transparency<1 end
    for _,p in ipairs(obj:GetDescendants()) do
        if p:IsA("BasePart") and p.Transparency<1 then return true end
    end
    return false
end
local function getCash()
    local out={}
    local tycoons=ws:FindFirstChild("Tycoons")
    if not tycoons then st("No Tycoons folder!") return out end
    for _,v in ipairs(tycoons:GetDescendants()) do
        if v:IsA("ProximityPrompt") and v.Enabled then
            local part=v.Parent
            if part and part:IsA("BasePart") then
                local dist=(hrp.Position-part.Position).Magnitude
                if dist<RANGE and isVisible(part) then
                    local n=(v.ActionText..v.ObjectText..v.Name):lower()
                    if n:find("collect") or n:find("payment") then
                        table.insert(out,{part=part,prompt=v})
                    end
                end
            end
        end
    end
    return out
end
local function collect(item)
    teleport(item.part.Position)
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
        while cfg.on and not _env.dead do
            local items=getCash()
            if #items>0 then
                st(#items.." cash found!")
                for _,i in ipairs(items) do
                    if not cfg.on or _env.dead then break end
                    collect(i)
                    task.wait(0.3)
                end
            end
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
Rayfield:Notify({Title="Vexro",Content="RYR loaded!",Duration=4})
Rayfield:LoadConfiguration()
