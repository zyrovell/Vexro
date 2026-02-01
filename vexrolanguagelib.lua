local LanguageSelection = {}
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

function LanguageSelection.Show(translations, config)
    translations = translations or {}
    config = config or {}

    local TitleText = config.Title or "VEXRO HUB"
    local selectedLang = nil

    -- Create UI
    local gui = Instance.new("ScreenGui")
    gui.Name = "VexroLanguageSelection"
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 9999
    gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Blur Effect
    local blur = Instance.new("BlurEffect")
    blur.Size = 0
    blur.Parent = Lighting

    -- Scale Logic
    local uiScale = Instance.new("UIScale")
    local viewportSize = workspace.CurrentCamera.ViewportSize
    uiScale.Scale = math.clamp(viewportSize.Y / 1080, 0.8, 1.5) -- Optimized scale
    uiScale.Parent = gui

    -- Background (Darken World)
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BackgroundTransparency = 1
    bg.Parent = gui

    -- Particles Background
    local particleContainer = Instance.new("Frame")
    particleContainer.Size = UDim2.new(1, 0, 1, 0)
    particleContainer.BackgroundTransparency = 1
    particleContainer.Parent = bg

    local function spawnParticle()
        local p = Instance.new("Frame")
        local size = math.random(2, 5)
        p.Size = UDim2.fromOffset(size, size)
        p.Position = UDim2.fromScale(math.random(), 1.1)
        p.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        p.BackgroundTransparency = math.random(4, 8)/10
        p.Parent = particleContainer
        
        Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)

        local duration = math.random(5, 12)
        local targetPos = UDim2.fromScale(p.Position.X.Scale + (math.random(-2, 2)/10), -0.1)
        
        TweenService:Create(p, TweenInfo.new(duration, Enum.EasingStyle.Sine), {
            Position = targetPos,
            BackgroundTransparency = 1
        }):Play()

        task.delay(duration, function() p:Destroy() end)
    end

    task.spawn(function()
        while gui.Parent do
            spawnParticle()
            task.wait(0.1)
        end
    end)

    -- Main Card
    local main = Instance.new("Frame")
    main.Size = UDim2.fromOffset(450, 300)
    main.Position = UDim2.fromScale(0.5, 0.5)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    main.BackgroundTransparency = 1 -- Start invisible
    main.BorderSizePixel = 0
    main.Parent = gui

    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

    -- Card Stroke (Border)
    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.fromRGB(60, 60, 60)
    mainStroke.Thickness = 1.5
    mainStroke.Transparency = 1
    mainStroke.Parent = main

    -- Card Gradient
    local mainGradient = Instance.new("UIGradient")
    mainGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
    }
    mainGradient.Rotation = 45
    mainGradient.Parent = main

    -- Shadow/Glow
    local glow = Instance.new("ImageLabel")
    glow.Name = "Shadow"
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.Position = UDim2.fromScale(0.5, 0.5)
    glow.Size = UDim2.new(1, 140, 1, 140)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://6015897843" -- Soft shadow asset
    glow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    glow.ImageTransparency = 1
    glow.ZIndex = 0
    glow.Parent = main

    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0, 25)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = TitleText
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 32
    titleLabel.TextTransparency = 1
    titleLabel.Parent = main

    -- Subtitle
    local subLabel = Instance.new("TextLabel")
    subLabel.Size = UDim2.new(1, 0, 0, 20)
    subLabel.Position = UDim2.new(0, 0, 0, 70)
    subLabel.BackgroundTransparency = 1
    subLabel.Text = "Dil Seçimi / Choose Language"
    subLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    subLabel.Font = Enum.Font.Gotham
    subLabel.TextSize = 16
    subLabel.TextTransparency = 1
    subLabel.Parent = main

    -- Button Container
    local btnContainer = Instance.new("Frame")
    btnContainer.Size = UDim2.new(1, -60, 0, 100)
    btnContainer.Position = UDim2.fromScale(0.5, 0.65)
    btnContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    btnContainer.BackgroundTransparency = 1
    btnContainer.Parent = main

    local listLayout = Instance.new("UIListLayout")
    listLayout.FillDirection = Enum.FillDirection.Horizontal
    listLayout.Padding = UDim.new(0, 20)
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    listLayout.Parent = btnContainer

    -- Button Creator
    local function createButton(text, flagEmoji)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.5, -10, 0, 60)
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.AutoButtonColor = false
        btn.Parent = btnContainer

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 10)
        btnCorner.Parent = btn

        local btnStroke = Instance.new("UIStroke")
        btnStroke.Color = Color3.fromRGB(80, 80, 80)
        btnStroke.Thickness = 1.5
        btnStroke.Transparency = 1
        btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        btnStroke.Parent = btn

        local btnGradient = Instance.new("UIGradient")
        btnGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
        }
        btnGradient.Rotation = 90
        btnGradient.Parent = btn

        -- Content
        local flag = Instance.new("TextLabel")
        flag.Text = flagEmoji
        flag.Size = UDim2.fromScale(0.3, 1)
        flag.Position = UDim2.fromScale(0.1, 0)
        flag.BackgroundTransparency = 1
        flag.TextSize = 30
        flag.Parent = btn

        local label = Instance.new("TextLabel")
        label.Text = text
        label.Size = UDim2.fromScale(0.6, 1)
        label.Position = UDim2.fromScale(0.4, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(240, 240, 240)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 18
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextTransparency = 1
        label.Parent = btn

        -- Hover Effects
        btn.MouseEnter:Connect(function()
            TweenService:Create(btnStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
        end)

        btn.MouseLeave:Connect(function()
            TweenService:Create(btnStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(80, 80, 80)}):Play()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
        end)

        return btn, btnStroke, label
    end

    local trBtn, trStroke, trLabel = createButton("TÜRKÇE", "🇹🇷")
    local enBtn, enStroke, enLabel = createButton("ENGLISH", "🇺🇸")

    -- Intro Animation
    TweenService:Create(blur, TweenInfo.new(1), {Size = 20}):Play()
    TweenService:Create(bg, TweenInfo.new(1), {BackgroundTransparency = 0.3}):Play()
    
    task.wait(0.2)
    main.BackgroundTransparency = 0
    main.Size = UDim2.fromOffset(400, 260) -- Start slightly smaller
    TweenService:Create(main, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(450, 300),
        BackgroundTransparency = 0
    }):Play()
    TweenService:Create(mainStroke, TweenInfo.new(0.6), {Transparency = 0}):Play()
    TweenService:Create(glow, TweenInfo.new(1), {ImageTransparency = 0.6}):Play()

    -- Text Stagger
    task.spawn(function()
        task.wait(0.3)
        TweenService:Create(titleLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
        task.wait(0.1)
        TweenService:Create(subLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    end)

    -- Button Stagger
    task.spawn(function()
        task.wait(0.5)
        TweenService:Create(trBtn, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
        TweenService:Create(trStroke, TweenInfo.new(0.5), {Transparency = 0}):Play()
        TweenService:Create(trLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
        
        task.wait(0.1)
        TweenService:Create(enBtn, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
        TweenService:Create(enStroke, TweenInfo.new(0.5), {Transparency = 0}):Play()
        TweenService:Create(enLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    end)

    -- Click Handlers
    trBtn.MouseButton1Click:Connect(function() selectedLang = translations.tr end)
    enBtn.MouseButton1Click:Connect(function() selectedLang = translations.en end)

    -- Wait for selection
    while not selectedLang do task.wait() end

    -- Outro Animation
    TweenService:Create(blur, TweenInfo.new(0.5), {Size = 0}):Play()
    TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.fromOffset(400, 260),
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(mainStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
    TweenService:Create(glow, TweenInfo.new(0.4), {ImageTransparency = 1}):Play()
    
    -- Fade out text/buttons faster
    TweenService:Create(titleLabel, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
    TweenService:Create(subLabel, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
    TweenService:Create(trBtn, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    TweenService:Create(enBtn, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    
    task.wait(0.6)
    blur:Destroy()
    gui:Destroy()

    return selectedLang
end

return LanguageSelection
