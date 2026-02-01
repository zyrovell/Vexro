local LanguageSelection = {}
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

function LanguageSelection.Show(translations, config)
    translations = translations or {}
    config = config or {}

    local TitleText = config.Title or "VEXRO HUB"
    
    local selectedLang = nil
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "VexroLanguageSelection"
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 999
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Mobile Friendly Scaling (Inspired by RedzLib)
    local uiScale = Instance.new("UIScale")
    local viewportSize = workspace.CurrentCamera.ViewportSize
    uiScale.Scale = math.clamp(viewportSize.Y / 450, 0.7, 1.2) -- Base scale on 450px height
    uiScale.Parent = gui
    
    -- AMOLED / Deep Black Background
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1.5, 0, 1.5, 0) -- Extra large to cover screen during scale
    bg.Position = UDim2.new(0.5, 0, 0.5, 0)
    bg.AnchorPoint = Vector2.new(0.5, 0.5)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BorderSizePixel = 0
    bg.Parent = gui
    
    -- Particle Logic (White things süzülüyor)
    local particleContainer = Instance.new("Frame")
    particleContainer.Size = UDim2.new(1/uiScale.Scale, 0, 1/uiScale.Scale, 0)
    particleContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    particleContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    particleContainer.BackgroundTransparency = 1
    particleContainer.Parent = bg
    
    local function createParticle()
        local p = Instance.new("Frame")
        local size = math.random(1, 4)
        p.Size = UDim2.new(0, size, 0, size)
        p.Position = UDim2.new(math.random(), 0, 1.1, 0)
        p.BackgroundColor3 = Color3.new(1, 1, 1)
        p.BackgroundTransparency = math.random(3, 8) / 10
        p.BorderSizePixel = 0
        p.Parent = particleContainer
        
        Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)
        
        local speed = math.random(10, 25)
        local drift = (math.random() - 0.5) * 0.15
        
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
            task.wait(0.2)
        end
    end)
    
    -- Center UI Panel
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 420, 0, 260)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    main.BorderSizePixel = 0
    main.Parent = gui -- Parent to gui so it scales with UIScale
    
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)
    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Color = Color3.fromRGB(60, 60, 60)
    mainStroke.Thickness = 2
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    
    -- Glow effect
    local outerGlow = Instance.new("ImageLabel")
    outerGlow.Name = "Glow"
    outerGlow.BackgroundTransparency = 1
    outerGlow.Position = UDim2.new(0, -15, 0, -15)
    outerGlow.Size = UDim2.new(1, 30, 1, 30)
    outerGlow.ZIndex = 0
    outerGlow.Image = "rbxassetid://1316045217"
    outerGlow.ImageColor3 = Color3.fromRGB(255, 255, 255)
    outerGlow.ImageTransparency = 0.95
    outerGlow.ScaleType = Enum.ScaleType.Slice
    outerGlow.SliceCenter = Rect.new(10, 10, 118, 118)
    outerGlow.Parent = main

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 70)
    title.Position = UDim2.new(0, 0, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = TitleText
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 30
    title.Parent = main
    
    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 20)
    sub.Position = UDim2.new(0, 0, 0, 85)
    sub.BackgroundTransparency = 1
    sub.Text = "Dil Seçimi / Language Selection"
    sub.TextColor3 = Color3.fromRGB(180, 180, 180)
    sub.Font = Enum.Font.GothamMedium
    sub.TextSize = 14
    sub.Parent = main
    
    local btnContainer = Instance.new("Frame")
    btnContainer.Size = UDim2.new(1, 0, 0, 100)
    btnContainer.Position = UDim2.new(0, 0, 0.5, 0)
    btnContainer.BackgroundTransparency = 1
    btnContainer.Parent = main
    
    local function makeBtn(text, isR)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 175, 0, 55)
        b.Position = isR and UDim2.new(0.5, 10, 0.5, 0) or UDim2.new(0.5, -185, 0.5, 0)
        b.AnchorPoint = Vector2.new(0, 0.5)
        b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        b.Text = text
        b.TextColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 17
        b.AutoButtonColor = false
        b.Parent = btnContainer
        
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 12)
        local s = Instance.new("UIStroke", b)
        s.Color = Color3.fromRGB(80, 80, 80)
        s.Thickness = 2
        s.Transparency = 0.5
        
        b.MouseEnter:Connect(function()
            TweenService:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
            TweenService:Create(s, TweenInfo.new(0.3), {Transparency = 0, Thickness = 2.5}):Play()
            TweenService:Create(b, TweenInfo.new(0.3), {TextSize = 18}):Play()
        end)
        b.MouseLeave:Connect(function()
            TweenService:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
            TweenService:Create(s, TweenInfo.new(0.3), {Transparency = 0.5, Thickness = 2}):Play()
            TweenService:Create(b, TweenInfo.new(0.3), {TextSize = 17}):Play()
        end)
        
        return b
    end
    
    local tr = makeBtn("🇹🇷 TÜRKÇE", false)
    local en = makeBtn("🇺🇸 ENGLISH", true)
    
    -- Animation In
    main.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(main, TweenInfo.new(0.8, Enum.EasingStyle.Back), {Size = UDim2.new(0, 420, 0, 260)}):Play()
    
    tr.MouseButton1Click:Connect(function() selectedLang = "tr" end)
    en.MouseButton1Click:Connect(function() selectedLang = "en" end)
    
    while not selectedLang do task.wait() end
    
    -- Animation Out
    TweenService:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.5)
    gui:Destroy()
    
    return translations[selectedLang] or translations["en"]
end

return LanguageSelection
