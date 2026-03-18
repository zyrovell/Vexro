--[[
    Vexro UI Notification Library
    Version: 1.0.0 (Ultimate Edition)
    
    Features:
    - Smart Dragging & Screen Clamping (Bounds)
    - Swipe Up to Delete Animation
    - Error Shake Animation
    - Anti-Spam (Silent Update on Duplicate)
    - Pinning System & Interactive Buttons
    - RichText Support
    
    Usage Example:
    local VexroUI = loadstring(game:HttpGet("YOUR_GITHUB_RAW_LINK_HERE"))()
    
    VexroUI:Notify("Injected", "Vexro Hub successfully loaded.", 5, "Success")
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Debris = game:GetService("Debris")

local VexroUI = {}

-- === VEXRO SETTINGS ===
VexroUI.ThemeColor = Color3.fromRGB(255, 255, 255)
VexroUI.EnableSounds = true

-- Official Roblox UI Sound IDs
local Sounds = {
    Pop = "rbxassetid://6114358883",
    Success = "rbxassetid://2865227271",
    Error = "rbxassetid://1444853324",
    Warning = "rbxassetid://2865228021",
    Click = "rbxassetid://6895086153",
    Hover = "rbxassetid://6895050726",
    SwipeOut = "rbxassetid://6895079853",
}

-- Destroy previous UI instance if exists
if CoreGui:FindFirstChild("VexroNotifyUI") then
    CoreGui.VexroNotifyUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VexroNotifyUI"
ScreenGui.Parent = CoreGui

-- === NOTIFICATION CENTER (Draggable Area) ===
local Container = Instance.new("Frame")
Container.Name = "NotifyContainer"
Container.Size = UDim2.new(0.25, 0, 0, 0) 
Container.AutomaticSize = Enum.AutomaticSize.Y 
Container.AnchorPoint = Vector2.new(0.5, 0)
Container.Position = UDim2.new(0.5, 0, 0, 20)
Container.BackgroundTransparency = 1
Container.Parent = ScreenGui

local SizeConstraint = Instance.new("UISizeConstraint")
SizeConstraint.MinSize = Vector2.new(250, 0)
SizeConstraint.MaxSize = Vector2.new(400, math.huge)
SizeConstraint.Parent = Container

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = Container
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
ListLayout.Padding = UDim.new(0, 10)

local ActiveToasts = {}

local function PlayUISound(soundId, volume, pitch)
    if not VexroUI.EnableSounds then return end
    local s = Instance.new("Sound")
    s.SoundId = soundId
    s.Volume = volume or 0.5
    s.PlaybackSpeed = pitch or 1
    s.Parent = CoreGui
    s:Play()
    Debris:AddItem(s, 2)
end

-- === CORE TOAST ENGINE ===
local function CreateToast(titleText, descText, duration, toastType, buttonText, buttonColor, callback)
    duration = duration or 3
    toastType = toastType or "Info"
    
    local toastId = titleText .. "|" .. descText .. "|" .. toastType .. "|" .. tostring(buttonText)

    local TypeColor = VexroUI.ThemeColor
    local TypeIcon = ""
    local EnterSound = Sounds.Pop
    
    if toastType == "Success" then
        TypeColor = Color3.fromRGB(46, 204, 113) 
        TypeIcon = "rbxassetid://71514022902819" 
        EnterSound = Sounds.Success 
    elseif toastType == "Error" then
        TypeColor = Color3.fromRGB(231, 76, 60) 
        TypeIcon = "rbxassetid://124605172367281" 
        EnterSound = Sounds.Error 
    elseif toastType == "Warning" then
        TypeColor = Color3.fromRGB(243, 156, 18)
        TypeIcon = "rbxassetid://6026568210" 
        EnterSound = Sounds.Warning
    end

    if buttonColor then TypeColor = buttonColor end
    local targetHeight = buttonText and 95 or 65

    local active = ActiveToasts[toastId]
    if active and not active.IsClosed then
        active.Count = active.Count + 1
        active.MultiplierLabel.Text = "x" .. active.Count
        active.MultiplierLabel.Visible = true 
        active.TimeLeft = duration
        
        -- Silent update for spam protection
        if active.ProgressTween then active.ProgressTween:Cancel() end
        active.ProgressBar.Size = UDim2.new(1, 0, 1, 0)
        active.ProgressTween = TweenService:Create(active.ProgressBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)})
        
        if not active.IsPinned then active.ProgressTween:Play() end
        
        local popUp = TweenService:Create(active.ToastWrapper, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, targetHeight + 3)})
        local popDown = TweenService:Create(active.ToastWrapper, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Size = UDim2.new(1, 0, 0, targetHeight)})
        popUp:Play()
        popUp.Completed:Connect(function() popDown:Play() end)
        
        return 
    end

    local ToastData = { Count = 1, IsClosed = false, TimeLeft = duration, IsPinned = false }
    ActiveToasts[toastId] = ToastData

    local ToastWrapper = Instance.new("Frame")
    ToastWrapper.Size = UDim2.new(1, 0, 0, 0)
    ToastWrapper.BackgroundTransparency = 1
    ToastWrapper.ClipsDescendants = true
    ToastWrapper.Parent = Container
    ToastData.ToastWrapper = ToastWrapper

    -- Solid Black Background
    local Toast = Instance.new("Frame")
    Toast.Size = UDim2.new(1, 0, 1, 0)
    Toast.BackgroundColor3 = Color3.fromRGB(0, 0, 0) 
    Toast.BackgroundTransparency = 0 
    Toast.BorderSizePixel = 0
    Toast.Active = true
    Toast.Parent = ToastWrapper

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(40, 40, 40)
    Stroke.Thickness = 1
    Stroke.Parent = Toast

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Toast

    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 3, 1, -20)
    Indicator.Position = UDim2.new(0, 10, 0.5, 0)
    Indicator.AnchorPoint = Vector2.new(0, 0.5)
    Indicator.BackgroundColor3 = TypeColor
    Indicator.BorderSizePixel = 0
    Indicator.Parent = Toast

    local IndCorner = Instance.new("UICorner")
    IndCorner.CornerRadius = UDim.new(1, 0)
    IndCorner.Parent = Indicator

    local textOffset = 20
    if TypeIcon ~= "" then
        textOffset = 48 
        local StatusIcon = Instance.new("ImageLabel")
        StatusIcon.Size = UDim2.new(0, 24, 0, 24)
        StatusIcon.Position = UDim2.new(0, 16, 0, 20)
        StatusIcon.BackgroundTransparency = 1
        StatusIcon.Image = TypeIcon
        StatusIcon.ImageColor3 = TypeColor
        StatusIcon.ImageTransparency = 1
        StatusIcon.Parent = Toast
        ToastData.StatusIcon = StatusIcon
    end

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -95 - (textOffset-20), 0.35, 0) 
    Title.Position = UDim2.new(0, textOffset, 0, 8)
    Title.BackgroundTransparency = 1
    Title.Text = titleText
    Title.RichText = true 
    Title.TextColor3 = TypeColor
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextTransparency = 1
    Title.TextScaled = true
    Title.Parent = Toast
    
    local TitleConstraint = Instance.new("UITextSizeConstraint")
    TitleConstraint.MaxTextSize = 16
    TitleConstraint.MinTextSize = 12
    TitleConstraint.Parent = Title

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -95 - (textOffset-20), 0.35, 0)
    Desc.Position = UDim2.new(0, textOffset, 0, 32)
    Desc.BackgroundTransparency = 1
    Desc.Text = descText
    Desc.RichText = true 
    Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
    Desc.Font = Enum.Font.GothamMedium
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextTransparency = 1
    Desc.TextScaled = true
    Desc.Parent = Toast
    
    local DescConstraint = Instance.new("UITextSizeConstraint")
    DescConstraint.MaxTextSize = 13
    DescConstraint.MinTextSize = 10
    DescConstraint.Parent = Desc

    local PinButton = Instance.new("ImageButton")
    PinButton.Size = UDim2.new(0, 24, 0, 24)
    PinButton.Position = UDim2.new(1, -34, 0, 10) 
    PinButton.BackgroundTransparency = 1
    PinButton.Image = "rbxassetid://114173430996633" 
    PinButton.ImageColor3 = VexroUI.ThemeColor 
    PinButton.ImageTransparency = 1 
    PinButton.Parent = Toast

    PinButton.MouseEnter:Connect(function() PlayUISound(Sounds.Hover, 0.2, 1.5) end)

    local Multiplier = Instance.new("TextLabel")
    Multiplier.Size = UDim2.new(0, 40, 0, 20)
    Multiplier.Position = UDim2.new(1, -80, 0, 12) 
    Multiplier.BackgroundTransparency = 1
    Multiplier.Text = ""
    Multiplier.TextColor3 = VexroUI.ThemeColor
    Multiplier.Font = Enum.Font.GothamBold
    Multiplier.TextSize = 14
    Multiplier.TextXAlignment = Enum.TextXAlignment.Right
    Multiplier.Visible = false 
    Multiplier.Parent = Toast
    ToastData.MultiplierLabel = Multiplier

    if buttonText then
        local ActionBtn = Instance.new("TextButton")
        ActionBtn.Size = UDim2.new(1, -40, 0, 24)
        ActionBtn.Position = UDim2.new(0, 20, 0, 60)
        ActionBtn.BackgroundColor3 = TypeColor 
        ActionBtn.Text = buttonText
        ActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        ActionBtn.Font = Enum.Font.GothamBold
        ActionBtn.TextSize = 13
        ActionBtn.BackgroundTransparency = 1
        ActionBtn.TextTransparency = 1
        ActionBtn.Parent = Toast
        ToastData.ActionBtn = ActionBtn

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 4)
        BtnCorner.Parent = ActionBtn

        ActionBtn.MouseEnter:Connect(function() PlayUISound(Sounds.Hover, 0.3, 1) end)
        ActionBtn.MouseButton1Click:Connect(function()
            PlayUISound(Sounds.Click, 0.6, 0.9)
            if callback then callback() end
        end)
    end

    local ProgressBarBg = Instance.new("Frame")
    ProgressBarBg.Size = UDim2.new(1, 0, 0, 2)
    ProgressBarBg.AnchorPoint = Vector2.new(0, 1)
    ProgressBarBg.Position = UDim2.new(0, 0, 1, 0)
    ProgressBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ProgressBarBg.BorderSizePixel = 0
    ProgressBarBg.Parent = Toast

    local ProgressBar = Instance.new("Frame")
    ProgressBar.Size = UDim2.new(1, 0, 1, 0)
    ProgressBar.BackgroundColor3 = TypeColor 
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Parent = ProgressBarBg
    ToastData.ProgressBar = ProgressBar

    -- Play sound on first appearance
    PlayUISound(EnterSound, 0.6)

    local openInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    TweenService:Create(ToastWrapper, openInfo, {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
    TweenService:Create(Title, openInfo, {TextTransparency = 0}):Play()
    TweenService:Create(Desc, openInfo, {TextTransparency = 0}):Play()
    TweenService:Create(PinButton, openInfo, {ImageTransparency = 0}):Play()
    if ToastData.StatusIcon then TweenService:Create(ToastData.StatusIcon, openInfo, {ImageTransparency = 0}):Play() end
    if ToastData.ActionBtn then 
        TweenService:Create(ToastData.ActionBtn, openInfo, {TextTransparency = 0, BackgroundTransparency = 0}):Play()
    end

    ToastData.ProgressTween = TweenService:Create(ProgressBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)})
    ToastData.ProgressTween:Play()

    -- Error Shake Animation
    if toastType == "Error" then
        task.spawn(function()
            task.wait(0.3) 
            local shakeOffset = 8
            for i = 1, 3 do
                TweenService:Create(Toast, TweenInfo.new(0.05, Enum.EasingStyle.Sine), {Position = UDim2.new(0, shakeOffset, 0, 0)}):Play()
                task.wait(0.05)
                TweenService:Create(Toast, TweenInfo.new(0.05, Enum.EasingStyle.Sine), {Position = UDim2.new(0, -shakeOffset, 0, 0)}):Play()
                task.wait(0.05)
            end
            TweenService:Create(Toast, TweenInfo.new(0.05, Enum.EasingStyle.Sine), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        end)
    end

    PinButton.MouseButton1Click:Connect(function()
        ToastData.IsPinned = not ToastData.IsPinned 
        if ToastData.IsPinned then
            PlayUISound(Sounds.Click, 0.6, 1.3) 
            PinButton.Image = "rbxassetid://95800328782333" 
            if ToastData.ProgressTween then ToastData.ProgressTween:Pause() end 
            TweenService:Create(ProgressBarBg, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            TweenService:Create(ProgressBar, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        else
            PlayUISound(Sounds.Click, 0.6, 0.8) 
            PinButton.Image = "rbxassetid://114173430996633" 
            if ToastData.ProgressTween then ToastData.ProgressTween:Play() end 
            TweenService:Create(ProgressBarBg, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
            TweenService:Create(ProgressBar, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        end
    end)

    local function CloseToast(isSwiped)
        if ToastData.IsClosed then return end
        ToastData.IsClosed = true
        ActiveToasts[toastId] = nil
        
        -- Swipe up to delete animation
        if isSwiped then 
            PlayUISound(Sounds.SwipeOut, 0.4, 1.1) 
            TweenService:Create(Toast, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0, 0, -1.2, 0)}):Play()
            task.wait(0.2)
        end

        if ToastData.ProgressTween then ToastData.ProgressTween:Cancel() end

        local closeInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        TweenService:Create(ToastWrapper, closeInfo, {Size = UDim2.new(1, 0, 0, 0)}):Play()
        TweenService:Create(Toast, closeInfo, {BackgroundTransparency = 1}):Play()
        TweenService:Create(Stroke, closeInfo, {Transparency = 1}):Play()
        TweenService:Create(Title, closeInfo, {TextTransparency = 1}):Play()
        TweenService:Create(Desc, closeInfo, {TextTransparency = 1}):Play()
        TweenService:Create(PinButton, closeInfo, {ImageTransparency = 1}):Play()
        TweenService:Create(Indicator, closeInfo, {BackgroundTransparency = 1}):Play()
        TweenService:Create(ProgressBarBg, closeInfo, {BackgroundTransparency = 1}):Play()
        TweenService:Create(ProgressBar, closeInfo, {BackgroundTransparency = 1}):Play()
        TweenService:Create(Multiplier, closeInfo, {TextTransparency = 1}):Play()
        if ToastData.StatusIcon then TweenService:Create(ToastData.StatusIcon, closeInfo, {ImageTransparency = 1}):Play() end
        if ToastData.ActionBtn then TweenService:Create(ToastData.ActionBtn, closeInfo, {TextTransparency = 1, BackgroundTransparency = 1}):Play() end
        
        task.delay(0.35, function()
            if ToastWrapper then ToastWrapper:Destroy() end
        end)
    end

    -- === SMART SCREEN CLAMPING & DRAG LOGIC ===
    local dragStartMouse = nil
    local containerStartPos = nil
    local dragging = false
    local isSwipeDeleteMode = false

    Toast.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStartMouse = input.Position
            containerStartPos = Container.Position
            
            local relativeY = input.Position.Y - Toast.AbsolutePosition.Y
            if relativeY > (Toast.AbsoluteSize.Y * 0.6) then
                isSwipeDeleteMode = true
            else
                isSwipeDeleteMode = false
            end
        end
    end)

    Toast.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStartMouse
            
            if isSwipeDeleteMode then
                if delta.Y < -30 then
                    dragging = false
                    CloseToast(true) 
                end
            else
                -- CALCULATE SCREEN BOUNDARIES (Clamp)
                local screen = ScreenGui.AbsoluteSize
                local size = Container.AbsoluteSize
                
                local minX = -(screen.X / 2) + (size.X / 2) + 15
                local maxX = math.max(minX, (screen.X / 2) - (size.X / 2) - 15)
                local minY = 15
                local maxY = math.max(minY, screen.Y - size.Y - 15)
                
                local clampedX = math.clamp(containerStartPos.X.Offset + delta.X, minX, maxX)
                local clampedY = math.clamp(containerStartPos.Y.Offset + delta.Y, minY, maxY)

                Container.Position = UDim2.new(
                    containerStartPos.X.Scale, clampedX,
                    containerStartPos.Y.Scale, clampedY
                )
            end
        end
    end)

    Toast.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    task.spawn(function()
        while ToastData.TimeLeft > 0 and not ToastData.IsClosed do
            local dt = task.wait()
            if not ToastData.IsPinned then
                ToastData.TimeLeft = ToastData.TimeLeft - dt
            end
        end
        if not ToastData.IsClosed then CloseToast(false) end 
    end)
end

-- === EXPORTED API FUNCTIONS ===

-- Standard Notification (Info, Success, Error, Warning)
function VexroUI:Notify(title, desc, duration, toastType)
    CreateToast(title, desc, duration, toastType, nil, nil, nil)
end

-- Interactive Notification with Button
function VexroUI:NotifyButton(title, desc, duration, toastType, buttonText, buttonColor, callback)
    CreateToast(title, desc, duration, toastType, buttonText, buttonColor, callback)
end

return VexroUI
