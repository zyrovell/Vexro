local LanguageLib = {}
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

function LanguageLib.Show(translations, config)
    config = config or {}
    local TitleText = config.Title or "VEXRO HUB"
    local TR_Color = config.TR_Color or Color3.fromRGB(200, 0, 0)
    local EN_Color = config.EN_Color or Color3.fromRGB(0, 120, 255)
    
    local selectedLang = nil
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "VexroLanguageSelection"
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 999
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- AMOLED / Deep Black Background
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BorderSizePixel = 0
    bg.Parent = gui
    
    -- Particle Logic (White things süzülüyor)
    local particleContainer = Instance.new("Frame")
    particleContainer.Size = UDim2.new(1, 0, 1, 0)
    particleContainer.BackgroundTransparency = 1
    particleContainer.Parent = bg
    
    local function createParticle()
        local p = Instance.new("Frame")
        local size = math.random(1, 3)
        p.Size = UDim2.new(0, size, 0, size)
        p.Position = UDim2.new(math.random(), 0, 1.1, 0)
        p.BackgroundColor3 = Color3.new(1, 1, 1)
        p.BackgroundTransparency = math.random(2, 7) / 10
        p.BorderSizePixel = 0
        p.Parent = particleContainer
        
        Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)
        
        local speed = math.random(8, 20)
        local drift = (math.random() - 0.5) * 0.1
        
        local tween = TweenService:Create(p, TweenInfo.new(speed, Enum.EasingStyle.Linear), {
            Position = UDim2.new(p.Position.X.Scale + drift, 0, -0.1, 0),
            BackgroundTransparency = 1
        })
        
        tween:Play()
        tween.Completed:Connect(function() p:Destroy() end)
    end
    
    task.spawn(function()
        while gui.Parent do
            createParticle()
            task.wait(0.15)
        end
    end)
    
    -- Center UI Panel
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 420, 0, 260)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    main.BorderSizePixel = 0
    main.Parent = bg
    
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)
    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Color = Color3.fromRGB(50, 50, 50)
    mainStroke.Thickness = 2
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    
    -- Shine effect for the panel
    local shine = Instance.new("Frame")
    shine.Size = UDim2.new(1, 0, 0, 1)
    shine.Position = UDim2.new(0, 0, 0, 0)
    shine.BackgroundColor3 = Color3.new(1, 1, 1)
    shine.BackgroundTransparency = 0.8
    shine.BorderSizePixel = 0
    shine.Parent = main
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 70)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = TitleText
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 28
    title.Parent = main
    
    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 20)
    sub.Position = UDim2.new(0, 0, 0, 80)
    sub.BackgroundTransparency = 1
    sub.Text = "Please Select Your Language"
    sub.TextColor3 = Color3.fromRGB(150, 150, 150)
    sub.Font = Enum.Font.GothamMedium
    sub.TextSize = 14
    sub.Parent = main
    
    local btnContainer = Instance.new("Frame")
    btnContainer.Size = UDim2.new(1, 0, 0, 100)
    btnContainer.Position = UDim2.new(0, 0, 0, 130)
    btnContainer.BackgroundTransparency = 1
    btnContainer.Parent = main
    
    local function makeBtn(text, color, isR)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 170, 0, 60)
        b.Position = isR and UDim2.new(0.5, 10, 0.5, -30) or UDim2.new(0.5, -180, 0.5, -30)
        b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        b.Text = text
        b.TextColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 16
        b.AutoButtonColor = false
        b.Parent = btnContainer
        
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
        local s = Instance.new("UIStroke", b)
        s.Color = color
        s.Thickness = 2
        s.Transparency = 0.5
        
        b.MouseEnter:Connect(function()
            TweenService:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
            TweenService:Create(s, TweenInfo.new(0.3), {Transparency = 0, Thickness = 3}):Play()
        end)
        b.MouseLeave:Connect(function()
            TweenService:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
            TweenService:Create(s, TweenInfo.new(0.3), {Transparency = 0.5, Thickness = 2}):Play()
        end)
        
        return b
    end
    
    local tr = makeBtn("TÜRKÇE", TR_Color, false)
    local en = makeBtn("ENGLISH", EN_Color, true)
    
    -- Animation In
    main.Size = UDim2.new(0, 0, 0, 0)
    main.GroupTransparency = 1
    local group = Instance.new("CanvasGroup", bg) -- Using CanvasGroup for group transparency if supported, otherwise frame
    main.Parent = group
    group.Size = UDim2.new(1, 0, 1, 0)
    group.BackgroundTransparency = 1
    
    TweenService:Create(main, TweenInfo.new(0.7, Enum.EasingStyle.Back), {Size = UDim2.new(0, 420, 0, 260)}):Play()
    
    tr.MouseButton1Click:Connect(function() selectedLang = translations.tr end)
    en.MouseButton1Click:Connect(function() selectedLang = translations.en end)
    
    while not selectedLang do task.wait() end
    
    -- Animation Out
    TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.4)
    gui:Destroy()
    
    return selectedLang
end

return LanguageLib
