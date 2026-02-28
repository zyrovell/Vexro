-- VexroUI Library

local VexroUI = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

VexroUI.Themes = {
	Dark = {
		primary = Color3.fromRGB(8, 8, 8),
		secondary = Color3.fromRGB(16, 16, 16),
		tertiary = Color3.fromRGB(22, 22, 22),
		sidebar = Color3.fromRGB(12, 12, 12),
		accent = Color3.fromRGB(100, 100, 100),
		text = Color3.new(1, 1, 1),
		textDim = Color3.fromRGB(130, 130, 130),
		stroke = Color3.fromRGB(50, 50, 50),
		critical = Color3.fromRGB(200, 60, 60),
		success = Color3.fromRGB(80, 200, 100)
	},
	Purple = {
		primary = Color3.fromRGB(18, 10, 28),
		secondary = Color3.fromRGB(35, 20, 55),
		tertiary = Color3.fromRGB(45, 28, 68),
		sidebar = Color3.fromRGB(28, 15, 42),
		accent = Color3.fromRGB(180, 100, 255),
		text = Color3.new(1, 1, 1),
		textDim = Color3.fromRGB(180, 160, 200),
		stroke = Color3.fromRGB(120, 80, 160),
		critical = Color3.fromRGB(220, 50, 100),
		success = Color3.fromRGB(140, 220, 100)
	},
	Blue = {
		primary = Color3.fromRGB(8, 15, 25),
		secondary = Color3.fromRGB(15, 30, 50),
		tertiary = Color3.fromRGB(22, 40, 65),
		sidebar = Color3.fromRGB(12, 22, 38),
		accent = Color3.fromRGB(60, 140, 220),
		text = Color3.new(1, 1, 1),
		textDim = Color3.fromRGB(140, 170, 200),
		stroke = Color3.fromRGB(60, 100, 150),
		critical = Color3.fromRGB(220, 70, 70),
		success = Color3.fromRGB(80, 210, 160)
	},
	Green = {
		primary = Color3.fromRGB(8, 18, 12),
		secondary = Color3.fromRGB(15, 35, 22),
		tertiary = Color3.fromRGB(22, 48, 32),
		sidebar = Color3.fromRGB(12, 28, 18),
		accent = Color3.fromRGB(80, 200, 120),
		text = Color3.new(1, 1, 1),
		textDim = Color3.fromRGB(140, 200, 160),
		stroke = Color3.fromRGB(60, 120, 80),
		critical = Color3.fromRGB(200, 80, 80),
		success = Color3.fromRGB(100, 220, 100)
	},
	Red = {
		primary = Color3.fromRGB(20, 10, 12),
		secondary = Color3.fromRGB(40, 18, 22),
		tertiary = Color3.fromRGB(55, 25, 30),
		sidebar = Color3.fromRGB(32, 14, 18),
		accent = Color3.fromRGB(220, 80, 100),
		text = Color3.new(1, 1, 1),
		textDim = Color3.fromRGB(200, 150, 160),
		stroke = Color3.fromRGB(140, 70, 80),
		critical = Color3.fromRGB(255, 50, 50),
		success = Color3.fromRGB(100, 200, 100)
	},
	Light = {
		primary = Color3.fromRGB(240, 242, 245),
		secondary = Color3.fromRGB(255, 255, 255),
		tertiary = Color3.fromRGB(230, 232, 238),
		sidebar = Color3.fromRGB(248, 249, 252),
		accent = Color3.fromRGB(100, 80, 200),
		text = Color3.fromRGB(30, 30, 40),
		textDim = Color3.fromRGB(100, 100, 120),
		stroke = Color3.fromRGB(180, 180, 200),
		critical = Color3.fromRGB(220, 80, 80),
		success = Color3.fromRGB(80, 180, 100)
	}
}

function VexroUI:CreateWindow(config)
	local winTitle = config.Name or "VexroUI"
	local themeName = config.Theme or "Dark"
	local winSize = config.Size or (isMobile and UDim2.new(0, 400, 0, 300) or UDim2.new(0, 500, 0, 350))
	local hideSplash = config.HideSplash or false
	local logoImage = config.Logo or ""
	
	local currentTheme = VexroUI.Themes[themeName] or VexroUI.Themes.Dark
	local themeElements = {}
	
	local function RegisterTheme(el, prop, key)
		if el then themeElements[#themeElements + 1] = {el = el, prop = prop, key = key} end
	end
	
	local function ApplyTheme(name)
		currentTheme = VexroUI.Themes[name] or VexroUI.Themes.Dark
		for i = 1, #themeElements do
			local t = themeElements[i]
			if t.el and t.el.Parent and currentTheme[t.key] then
				pcall(function()
					TweenService:Create(t.el, TweenInfo.new(0.3), {[t.prop] = currentTheme[t.key]}):Play()
				end)
			end
		end
	end

	local gui = Instance.new("ScreenGui")
	gui.Name = winTitle
	gui.ResetOnSpawn = false
	gui.DisplayOrder = 999
	local success = pcall(function() gui.Parent = CoreGui end)
	if not success then gui.Parent = player:WaitForChild("PlayerGui") end

	local Vexro = {
		Tabs = {},
		CurrentTab = nil,
		ApplyTheme = ApplyTheme,
		Gui = gui
	}
	
	-- Notification System Built-in
	function Vexro:Notify(title, text)
		local container = gui:FindFirstChild("NotificationContainer")
		if not container then
			container = Instance.new("Frame")
			container.Name = "NotificationContainer"
			container.Size = UDim2.new(0, 300, 1, -40)
			container.Position = UDim2.new(1, -310, 0, 20)
			container.BackgroundTransparency = 1
			container.ZIndex = 30000
			container.Parent = gui
			
			local uiList = Instance.new("UIListLayout")
			uiList.Padding = UDim.new(0, 10)
			uiList.HorizontalAlignment = Enum.HorizontalAlignment.Right
			uiList.VerticalAlignment = Enum.VerticalAlignment.Top
			uiList.Parent = container
		end
		
		local wrapper = Instance.new("Frame")
		wrapper.BackgroundTransparency = 1
		wrapper.Size = UDim2.new(1, 0, 0, 60)
		wrapper.ClipsDescendants = true
		wrapper.Parent = container
		
		local toast = Instance.new("Frame")
		toast.Size = UDim2.new(1, 0, 1, 0)
		toast.Position = UDim2.new(1, 310, 0, 0)
		toast.BackgroundColor3 = currentTheme.secondary
		toast.ZIndex = 30001
		toast.Parent = wrapper
		Instance.new("UICorner", toast).CornerRadius = UDim.new(0, 10)
		
		local toastStroke = Instance.new("UIStroke")
		toastStroke.Color = currentTheme.stroke
		toastStroke.Thickness = 2
		toastStroke.Parent = toast
		
		local titleLbl = Instance.new("TextLabel")
		titleLbl.Size = UDim2.new(1, -15, 0, 25)
		titleLbl.Position = UDim2.new(0, 10, 0, 5)
		titleLbl.BackgroundTransparency = 1
		titleLbl.Text = title
		titleLbl.Font = Enum.Font.GothamBold
		titleLbl.TextSize = 15
		titleLbl.TextColor3 = currentTheme.text
		titleLbl.TextXAlignment = Enum.TextXAlignment.Left
		titleLbl.ZIndex = 30002
		titleLbl.Parent = toast
		
		local textLbl = Instance.new("TextLabel")
		textLbl.Size = UDim2.new(1, -15, 0, 25)
		textLbl.Position = UDim2.new(0, 10, 0, 30)
		textLbl.BackgroundTransparency = 1
		textLbl.Text = text
		textLbl.Font = Enum.Font.Gotham
		textLbl.TextSize = 13
		textLbl.TextColor3 = currentTheme.textDim
		textLbl.TextXAlignment = Enum.TextXAlignment.Left
		textLbl.TextWrapped = true
		textLbl.ZIndex = 30002
		textLbl.Parent = toast
		
		TweenService:Create(toast, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
		
		task.delay(3, function()
			local outTween = TweenService:Create(toast, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(1, 310, 0, 0)})
			outTween:Play()
			task.wait(0.4)
			wrapper:Destroy()
		end)
	end

	-- SPLASH SCREEN
	if not hideSplash then
		local splash = Instance.new("Frame")
		splash.Size = UDim2.fromScale(1, 1)
		splash.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
		splash.ZIndex = 10000
		splash.Parent = gui
		
		local splashBox = Instance.new("Frame")
		splashBox.Size = UDim2.new(0, 0, 0, 0)
		splashBox.Position = UDim2.fromScale(0.5, 0.5)
		splashBox.AnchorPoint = Vector2.new(0.5, 0.5)
		splashBox.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
		splashBox.Rotation = -180
		splashBox.ZIndex = 10001
		splashBox.Parent = splash
		Instance.new("UICorner", splashBox).CornerRadius = UDim.new(0, 16)
		
		local splashStroke = Instance.new("UIStroke")
		splashStroke.Color = currentTheme.accent
		splashStroke.Thickness = 3
		splashStroke.Parent = splashBox
		
		local logo = Instance.new("TextLabel")
		logo.Size = UDim2.new(1, 0, 0, 60)
		logo.Position = UDim2.new(0, 0, 0, 60)
		logo.BackgroundTransparency = 1
		logo.Text = winTitle
		logo.TextColor3 = Color3.new(1, 1, 1)
		logo.Font = Enum.Font.GothamBlack
		logo.TextSize = 34
		logo.ZIndex = 10003
		logo.Parent = splashBox
		
		local loadingBarBg = Instance.new("Frame")
		loadingBarBg.Size = UDim2.new(0.8, 0, 0, 6)
		loadingBarBg.Position = UDim2.new(0.1, 0, 0, 130)
		loadingBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
		loadingBarBg.ZIndex = 10003
		loadingBarBg.Parent = splashBox
		Instance.new("UICorner", loadingBarBg).CornerRadius = UDim.new(1, 0)
		
		local loadingBar = Instance.new("Frame")
		loadingBar.Size = UDim2.new(0, 0, 1, 0)
		loadingBar.BackgroundColor3 = currentTheme.accent
		loadingBar.ZIndex = 10004
		loadingBar.Parent = loadingBarBg
		Instance.new("UICorner", loadingBar).CornerRadius = UDim.new(1, 0)
		
		local splashSize = isMobile and UDim2.new(0, 260, 0, 180) or UDim2.new(0, 320, 0, 200)
		TweenService:Create(splashBox, TweenInfo.new(0.7, Enum.EasingStyle.Back), {Size = splashSize, Rotation = 0}):Play()
		task.wait(0.7)
		TweenService:Create(loadingBar, TweenInfo.new(1, Enum.EasingStyle.Sine), {Size = UDim2.new(1, 0, 1, 0)}):Play()
		task.wait(1.2)
		
		TweenService:Create(splash, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		TweenService:Create(splashBox, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), Rotation = 360}):Play()
		task.wait(0.5)
		splash:Destroy()
	end

	-- MAIN WINDOW
	local main = Instance.new("Frame")
	main.Name = "Main"
	main.Size = UDim2.new(0, 0, 0, 0)
	main.Position = UDim2.fromScale(0.5, 0.5)
	main.AnchorPoint = Vector2.new(0.5, 0.5)
	main.BackgroundColor3 = currentTheme.primary
	main.BackgroundTransparency = 1
	main.Parent = gui
	main.ClipsDescendants = true
	Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)
	RegisterTheme(main, "BackgroundColor3", "primary")

	local mainStroke = Instance.new("UIStroke")
	mainStroke.Color = currentTheme.stroke
	mainStroke.Thickness = 2
	mainStroke.Transparency = 1
	mainStroke.Parent = main
	RegisterTheme(mainStroke, "Color", "stroke")

	local sideBarW = isMobile and 50 or 60
	local titleH = isMobile and 38 or 46

	local sidebar = Instance.new("Frame")
	sidebar.Size = UDim2.new(0, sideBarW, 1, 0)
	sidebar.BackgroundColor3 = currentTheme.sidebar
	sidebar.BackgroundTransparency = 0.2
	sidebar.ZIndex = 8
	sidebar.Parent = main
	Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 14)
	RegisterTheme(sidebar, "BackgroundColor3", "sidebar")

	-- Overlay to hide right curve of sidebar
	local sideOverlay = Instance.new("Frame")
	sideOverlay.Size = UDim2.new(0, 10, 1, 0)
	sideOverlay.Position = UDim2.new(1, -10, 0, 0)
	sideOverlay.BackgroundColor3 = currentTheme.sidebar
	sideOverlay.BackgroundTransparency = 0.2
	sideOverlay.BorderSizePixel = 0
	sideOverlay.ZIndex = 7
	sideOverlay.Parent = sidebar
	RegisterTheme(sideOverlay, "BackgroundColor3", "sidebar")

	local content = Instance.new("Frame")
	content.Size = UDim2.new(1, -sideBarW, 1, 0)
	content.Position = UDim2.new(0, sideBarW, 0, 0)
	content.BackgroundTransparency = 1
	content.Parent = main

	local titleBar = Instance.new("Frame")
	titleBar.Size = UDim2.new(1, 0, 0, titleH)
	titleBar.BackgroundColor3 = currentTheme.secondary
	titleBar.BackgroundTransparency = 0.3
	titleBar.ZIndex = 5
	titleBar.Parent = content
	Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 14)
	RegisterTheme(titleBar, "BackgroundColor3", "secondary")

	local titleOverlay = Instance.new("Frame")
	titleOverlay.Size = UDim2.new(0, 14, 1, 0)
	titleOverlay.BackgroundColor3 = currentTheme.secondary
	titleOverlay.BackgroundTransparency = 0.3
	titleOverlay.BorderSizePixel = 0
	titleOverlay.ZIndex = 4
	titleOverlay.Parent = titleBar
	RegisterTheme(titleOverlay, "BackgroundColor3", "secondary")

	local titleLbl = Instance.new("TextLabel")
	titleLbl.Size = UDim2.new(1, -160, 1, 0)
	titleLbl.Position = UDim2.new(0, 15, 0, 0)
	titleLbl.BackgroundTransparency = 1
	titleLbl.Text = winTitle
	titleLbl.TextColor3 = currentTheme.text
	titleLbl.Font = Enum.Font.GothamBold
	titleLbl.TextSize = isMobile and 16 or 20
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left
	titleLbl.ZIndex = 5
	titleLbl.Parent = titleBar
	RegisterTheme(titleLbl, "TextColor3", "text")

	local closeBtn = Instance.new("TextButton")
	closeBtn.Size = UDim2.new(0, 30, 0, 30)
	closeBtn.Position = UDim2.new(1, -40, 0.5, -15)
	closeBtn.BackgroundColor3 = currentTheme.critical
	closeBtn.Text = "×"
	closeBtn.TextColor3 = Color3.new(1, 1, 1)
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.TextSize = 20
	closeBtn.ZIndex = 10
	closeBtn.Parent = titleBar
	Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
	RegisterTheme(closeBtn, "BackgroundColor3", "critical")

	closeBtn.MouseButton1Click:Connect(function()
		TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1, Rotation = -30}):Play()
		TweenService:Create(mainStroke, TweenInfo.new(0.2), {Transparency = 1}):Play()
		task.wait(0.25)
		gui:Destroy()
	end)

	-- Dragging Logic
	local dragging, dragStart, startPos = false, nil, nil
	titleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = main.Position
		end
	end)
	sidebar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = main.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	main.Rotation = -10
	TweenService:Create(main, TweenInfo.new(0.45, Enum.EasingStyle.Back), {Size = winSize, BackgroundTransparency = 0.15, Rotation = 0}):Play()
	TweenService:Create(mainStroke, TweenInfo.new(0.45), {Transparency = 0.5}):Play()
	
	-- API Methods
	function Vexro:SaveConfig(folderName, fileName, data)
		pcall(function()
			if not isfolder(folderName) then makefolder(folderName) end
			if writefile then writefile(folderName .. "/" .. fileName .. ".json", HttpService:JSONEncode(data)) end
		end)
	end
	
	function Vexro:LoadConfig(folderName, fileName)
		local data = {}
		pcall(function()
			local path = folderName .. "/" .. fileName .. ".json"
			if isfile(path) and readfile then
				data = HttpService:JSONDecode(readfile(path))
			end
		end)
		return data
	end

	function Vexro:MakeTab(tabConfig)
		local tName = tabConfig.Name
		local tIcon = tabConfig.Icon or "📂"
		
		local tabCount = 0
		for _, _ in pairs(Vexro.Tabs) do tabCount = tabCount + 1 end
		
		local tabBtnS = isMobile and 40 or 48
		local yPos = 8 + (tabBtnS + 6) * tabCount
		
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0, tabBtnS, 0, tabBtnS)
		btn.Position = UDim2.new(0.5, -tabBtnS/2, 0, yPos)
		btn.BackgroundColor3 = currentTheme.sidebar
		btn.BackgroundTransparency = 0.8
		btn.Text = tIcon
		btn.TextSize = 22
		btn.ZIndex = 9
		btn.Parent = sidebar
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
		
		local stroke = Instance.new("UIStroke")
		stroke.Color = currentTheme.sidebar
		stroke.Thickness = 2
		stroke.Transparency = 0.7
		stroke.Parent = btn
		
		local scroll = Instance.new("ScrollingFrame")
		scroll.Size = UDim2.new(1, -16, 1, -(titleH + 16))
		scroll.Position = UDim2.new(0, 8, 0, titleH + 8)
		scroll.BackgroundTransparency = 1
		scroll.ScrollBarThickness = 4
		scroll.Visible = false
		scroll.ZIndex = 5
		scroll.Parent = content
		RegisterTheme(scroll, "ScrollBarImageColor3", "stroke")
		
		local layout = Instance.new("UIListLayout")
		layout.Padding = UDim.new(0, 8)
		layout.Parent = scroll
		
		layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
		end)
		
		local TabAPI = {
			Name = tName,
			Button = btn,
			Scroll = scroll,
			Elements = {}
		}
		
		btn.MouseButton1Click:Connect(function()
			-- Switch Tabs
			Vexro.CurrentTab = tName
			for name, t in pairs(Vexro.Tabs) do
				local active = name == tName
				t.Scroll.Visible = active
				
				TweenService:Create(t.Button, TweenInfo.new(0.2), {
					BackgroundTransparency = active and 0.2 or 0.8,
					BackgroundColor3 = active and currentTheme.accent or currentTheme.sidebar,
					Size = UDim2.new(0, active and tabBtnS + 4 or tabBtnS, 0, active and tabBtnS + 4 or tabBtnS)
				}):Play()
				
				local str = t.Button:FindFirstChildOfClass("UIStroke")
				if str then
					TweenService:Create(str, TweenInfo.new(0.2), {
						Transparency = active and 0 or 0.7,
						Color = active and currentTheme.accent or currentTheme.stroke,
						Thickness = active and 3 or 2
					}):Play()
				end
			end
			titleLbl.Text = winTitle .. " - " .. tName
		end)
		
		-- Tab Elements Setup
		function TabAPI:MakeButton(cfg)
			local btnRow = Instance.new("TextButton")
			btnRow.Size = UDim2.new(1, 0, 0, 45)
			btnRow.BackgroundColor3 = currentTheme.tertiary
			btnRow.BackgroundTransparency = 0.3
			btnRow.Text = cfg.Name or "Button"
			btnRow.TextColor3 = currentTheme.text
			btnRow.Font = Enum.Font.GothamBold
			btnRow.TextSize = 14
			btnRow.ZIndex = 6
			btnRow.Parent = scroll
			Instance.new("UICorner", btnRow).CornerRadius = UDim.new(0, 8)
			RegisterTheme(btnRow, "BackgroundColor3", "tertiary")
			RegisterTheme(btnRow, "TextColor3", "text")
			
			btnRow.MouseButton1Click:Connect(function()
				-- Click Effect
				TweenService:Create(btnRow, TweenInfo.new(0.1), {BackgroundColor3 = currentTheme.accent}):Play()
				task.delay(0.1, function()
					if btnRow.Parent then
						TweenService:Create(btnRow, TweenInfo.new(0.2), {BackgroundColor3 = currentTheme.tertiary}):Play()
					end
				end)
				if cfg.Callback then cfg.Callback() end
			end)
		end
		
		function TabAPI:MakeToggle(cfg)
			local defaultState = cfg.Default or false
			local state = defaultState
			
			local row = Instance.new("Frame")
			row.Size = UDim2.new(1, 0, 0, 45)
			row.BackgroundColor3 = currentTheme.tertiary
			row.BackgroundTransparency = 0.3
			row.ZIndex = 6
			row.Parent = scroll
			Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
			RegisterTheme(row, "BackgroundColor3", "tertiary")
			
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(0.6, 0, 1, 0)
			lbl.Position = UDim2.new(0, 15, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Name or "Toggle"
			lbl.TextColor3 = currentTheme.text
			lbl.Font = Enum.Font.GothamBold
			lbl.TextSize = 14
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.ZIndex = 7
			lbl.Parent = row
			RegisterTheme(lbl, "TextColor3", "text")
			
			local togBtn = Instance.new("TextButton")
			togBtn.Size = UDim2.new(0, 60, 0, 30)
			togBtn.Position = UDim2.new(1, -75, 0.5, -15)
			togBtn.BackgroundColor3 = state and currentTheme.success or currentTheme.critical
			togBtn.Text = state and "ON" or "OFF"
			togBtn.TextColor3 = Color3.new(1, 1, 1)
			togBtn.Font = Enum.Font.GothamBold
			togBtn.ZIndex = 8
			togBtn.Parent = row
			Instance.new("UICorner", togBtn).CornerRadius = UDim.new(0, 6)
			
			local function UpdateTog()
				togBtn.Text = state and "ON" or "OFF"
				TweenService:Create(togBtn, TweenInfo.new(0.2), {
					BackgroundColor3 = state and currentTheme.success or currentTheme.critical
				}):Play()
				if cfg.Callback then cfg.Callback(state) end
			end
			
			togBtn.MouseButton1Click:Connect(function()
				state = not state
				UpdateTog()
			end)
		end
		
		function TabAPI:MakeLabel(text)
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, 0, 0, 30)
			lbl.BackgroundTransparency = 1
			lbl.Text = text
			lbl.TextColor3 = currentTheme.textDim
			lbl.Font = Enum.Font.Gotham
			lbl.TextSize = 13
			lbl.ZIndex = 6
			lbl.Parent = scroll
			RegisterTheme(lbl, "TextColor3", "textDim")
		end

		function TabAPI:MakeSlider(cfg)
			local default = cfg.Default or cfg.Min
			local min = cfg.Min or 0
			local max = cfg.Max or 100
			local value = default
			
			local row = Instance.new("Frame")
			row.Size = UDim2.new(1, 0, 0, 60)
			row.BackgroundColor3 = currentTheme.tertiary
			row.BackgroundTransparency = 0.3
			row.ZIndex = 6
			row.Parent = scroll
			Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
			RegisterTheme(row, "BackgroundColor3", "tertiary")
			
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(0.6, 0, 0, 30)
			lbl.Position = UDim2.new(0, 15, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Name or "Slider"
			lbl.TextColor3 = currentTheme.text
			lbl.Font = Enum.Font.GothamBold
			lbl.TextSize = 14
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.ZIndex = 7
			lbl.Parent = row
			RegisterTheme(lbl, "TextColor3", "text")
			
			local valLbl = Instance.new("TextLabel")
			valLbl.Size = UDim2.new(0.4, -15, 0, 30)
			valLbl.Position = UDim2.new(0.6, 0, 0, 0)
			valLbl.BackgroundTransparency = 1
			valLbl.Text = tostring(value)
			valLbl.TextColor3 = currentTheme.accent
			valLbl.Font = Enum.Font.GothamBold
			valLbl.TextSize = 14
			valLbl.TextXAlignment = Enum.TextXAlignment.Right
			valLbl.ZIndex = 7
			valLbl.Parent = row
			RegisterTheme(valLbl, "TextColor3", "accent")
			
			local sliderBg = Instance.new("Frame")
			sliderBg.Size = UDim2.new(1, -30, 0, 6)
			sliderBg.Position = UDim2.new(0, 15, 0, 40)
			sliderBg.BackgroundColor3 = currentTheme.secondary
			sliderBg.ZIndex = 7
			sliderBg.Parent = row
			Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)
			RegisterTheme(sliderBg, "BackgroundColor3", "secondary")
			
			local sliderFill = Instance.new("Frame")
			local startAlpha = (value - min) / (max - min)
			sliderFill.Size = UDim2.new(startAlpha, 0, 1, 0)
			sliderFill.BackgroundColor3 = currentTheme.accent
			sliderFill.ZIndex = 8
			sliderFill.Parent = sliderBg
			Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)
			RegisterTheme(sliderFill, "BackgroundColor3", "accent")
			
			local sliderKnob = Instance.new("TextButton")
			sliderKnob.Size = UDim2.new(0, 14, 0, 14)
			sliderKnob.Position = UDim2.new(startAlpha, 0, 0.5, 0)
			sliderKnob.AnchorPoint = Vector2.new(0.5, 0.5)
			sliderKnob.BackgroundColor3 = Color3.new(1, 1, 1)
			sliderKnob.Text = ""
			sliderKnob.ZIndex = 9
			sliderKnob.Parent = sliderBg
			Instance.new("UICorner", sliderKnob).CornerRadius = UDim.new(1, 0)
			
			local dragging = false
			sliderKnob.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
				end
			end)
			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = false
				end
			end)
			
			local function UpdateSlider(input)
				local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
				value = math.floor(min + (max - min) * pos)
				valLbl.Text = tostring(value)
				TweenService:Create(sliderFill, TweenInfo.new(0.1), {Size = UDim2.new(pos, 0, 1, 0)}):Play()
				TweenService:Create(sliderKnob, TweenInfo.new(0.1), {Position = UDim2.new(pos, 0, 0.5, 0)}):Play()
				if cfg.Callback then cfg.Callback(value) end
			end
			
			UserInputService.InputChanged:Connect(function(input)
				if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					UpdateSlider(input)
				end
			end)
		end
		
		function TabAPI:MakeDropdown(cfg)
			local options = cfg.Options or {}
			local current = options[1] or ""
			local expanded = false
			
			local row = Instance.new("Frame")
			row.Size = UDim2.new(1, 0, 0, 45)
			row.BackgroundColor3 = currentTheme.tertiary
			row.BackgroundTransparency = 0.3
			row.ClipsDescendants = true
			row.ZIndex = 6
			row.Parent = scroll
			Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
			RegisterTheme(row, "BackgroundColor3", "tertiary")
			
			local titleBtn = Instance.new("TextButton")
			titleBtn.Size = UDim2.new(1, 0, 0, 45)
			titleBtn.BackgroundTransparency = 1
			titleBtn.Text = ""
			titleBtn.ZIndex = 7
			titleBtn.Parent = row
			
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(0.5, 0, 1, 0)
			lbl.Position = UDim2.new(0, 15, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Name or "Dropdown"
			lbl.TextColor3 = currentTheme.text
			lbl.Font = Enum.Font.GothamBold
			lbl.TextSize = 14
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.ZIndex = 7
			lbl.Parent = titleBtn
			RegisterTheme(lbl, "TextColor3", "text")
			
			local valLbl = Instance.new("TextLabel")
			valLbl.Size = UDim2.new(0.5, -35, 1, 0)
			valLbl.Position = UDim2.new(0.5, 0, 0, 0)
			valLbl.BackgroundTransparency = 1
			valLbl.Text = current
			valLbl.TextColor3 = currentTheme.textDim
			valLbl.Font = Enum.Font.GothamBold
			valLbl.TextSize = 13
			valLbl.TextXAlignment = Enum.TextXAlignment.Right
			valLbl.ZIndex = 7
			valLbl.Parent = titleBtn
			RegisterTheme(valLbl, "TextColor3", "textDim")
			
			local icon = Instance.new("TextLabel")
			icon.Size = UDim2.new(0, 20, 1, 0)
			icon.Position = UDim2.new(1, -30, 0, 0)
			icon.BackgroundTransparency = 1
			icon.Text = "▼"
			icon.TextColor3 = currentTheme.textDim
			icon.Font = Enum.Font.GothamBold
			icon.TextSize = 12
			icon.ZIndex = 7
			icon.Parent = titleBtn
			RegisterTheme(icon, "TextColor3", "textDim")
			
			local dropLayout = Instance.new("UIListLayout")
			dropLayout.Padding = UDim.new(0, 4)
			dropLayout.Parent = row
			
			local function UpdateDrop()
				local targetH = expanded and (45 + #options * 35 + 10) or 45
				TweenService:Create(row, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 0, targetH)}):Play()
				TweenService:Create(icon, TweenInfo.new(0.3), {Rotation = expanded and 180 or 0}):Play()
			end
			
			titleBtn.MouseButton1Click:Connect(function()
				expanded = not expanded
				UpdateDrop()
			end)
			
			for i, opt in ipairs(options) do
				local optBtn = Instance.new("TextButton")
				optBtn.Size = UDim2.new(1, -20, 0, 30)
				optBtn.Position = UDim2.new(0, 10, 0, 45 + (i-1)*34)
				optBtn.BackgroundColor3 = currentTheme.secondary
				optBtn.Text = opt
				optBtn.TextColor3 = currentTheme.text
				optBtn.Font = Enum.Font.Gotham
				optBtn.TextSize = 13
				optBtn.ZIndex = 8
				optBtn.Parent = row
				Instance.new("UICorner", optBtn).CornerRadius = UDim.new(0, 6)
				RegisterTheme(optBtn, "BackgroundColor3", "secondary")
				RegisterTheme(optBtn, "TextColor3", "text")
				
				optBtn.MouseButton1Click:Connect(function()
					current = opt
					valLbl.Text = current
					expanded = false
					UpdateDrop()
					if cfg.Callback then cfg.Callback(current) end
				end)
			end
		end
		
		function TabAPI:MakeTextbox(cfg)
			local row = Instance.new("Frame")
			row.Size = UDim2.new(1, 0, 0, 45)
			row.BackgroundColor3 = currentTheme.tertiary
			row.BackgroundTransparency = 0.3
			row.ZIndex = 6
			row.Parent = scroll
			Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
			RegisterTheme(row, "BackgroundColor3", "tertiary")
			
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(0.4, 0, 1, 0)
			lbl.Position = UDim2.new(0, 15, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Name or "Textbox"
			lbl.TextColor3 = currentTheme.text
			lbl.Font = Enum.Font.GothamBold
			lbl.TextSize = 14
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.ZIndex = 7
			lbl.Parent = row
			RegisterTheme(lbl, "TextColor3", "text")
			
			local box = Instance.new("TextBox")
			box.Size = UDim2.new(0.6, -25, 0, 30)
			box.Position = UDim2.new(0.4, 10, 0.5, -15)
			box.BackgroundColor3 = currentTheme.secondary
			box.PlaceholderText = cfg.Placeholder or "Type here..."
			box.PlaceholderColor3 = currentTheme.stroke
			box.Text = ""
			box.TextColor3 = currentTheme.text
			box.Font = Enum.Font.Gotham
			box.TextSize = 13
			box.ClearTextOnFocus = false
			box.ZIndex = 8
			box.Parent = row
			Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
			RegisterTheme(box, "BackgroundColor3", "secondary")
			RegisterTheme(box, "TextColor3", "text")
			RegisterTheme(box, "PlaceholderColor3", "stroke")
			
			box.FocusLost:Connect(function(enterPressed)
				if cfg.Callback then cfg.Callback(box.Text) end
			end)
		end
		
		function TabAPI:MakeKeybind(cfg)
			local key = cfg.Default or Enum.KeyCode.E
			local listening = false
			
			local row = Instance.new("Frame")
			row.Size = UDim2.new(1, 0, 0, 45)
			row.BackgroundColor3 = currentTheme.tertiary
			row.BackgroundTransparency = 0.3
			row.ZIndex = 6
			row.Parent = scroll
			Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
			RegisterTheme(row, "BackgroundColor3", "tertiary")
			
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(0.6, 0, 1, 0)
			lbl.Position = UDim2.new(0, 15, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Name or "Keybind"
			lbl.TextColor3 = currentTheme.text
			lbl.Font = Enum.Font.GothamBold
			lbl.TextSize = 14
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.ZIndex = 7
			lbl.Parent = row
			RegisterTheme(lbl, "TextColor3", "text")
			
			local bindBtn = Instance.new("TextButton")
			bindBtn.Size = UDim2.new(0, 100, 0, 30)
			bindBtn.Position = UDim2.new(1, -115, 0.5, -15)
			bindBtn.BackgroundColor3 = currentTheme.secondary
			bindBtn.Text = key.Name
			bindBtn.TextColor3 = currentTheme.accent
			bindBtn.Font = Enum.Font.GothamBold
			bindBtn.TextSize = 13
			bindBtn.ZIndex = 8
			bindBtn.Parent = row
			Instance.new("UICorner", bindBtn).CornerRadius = UDim.new(0, 6)
			RegisterTheme(bindBtn, "BackgroundColor3", "secondary")
			RegisterTheme(bindBtn, "TextColor3", "accent")
			
			bindBtn.MouseButton1Click:Connect(function()
				listening = true
				bindBtn.Text = "..."
				TweenService:Create(bindBtn, TweenInfo.new(0.2), {BackgroundColor3 = currentTheme.stroke}):Play()
			end)
			
			UserInputService.InputBegan:Connect(function(input, gp)
				if listening and input.UserInputType == Enum.UserInputType.Keyboard then
					key = input.KeyCode
					bindBtn.Text = key.Name
					listening = false
					TweenService:Create(bindBtn, TweenInfo.new(0.2), {BackgroundColor3 = currentTheme.secondary}):Play()
				elseif not listening and not gp and input.KeyCode == key then
					if cfg.Callback then cfg.Callback() end
				end
			end)
		end
		
		function TabAPI:MakeSection(cfg)
			local name = cfg.Name or "Section"
			
			local sec = Instance.new("Frame")
			sec.Size = UDim2.new(1, 0, 0, 30)
			sec.BackgroundTransparency = 1
			sec.ZIndex = 6
			sec.Parent = scroll
			
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, 0, 1, 0)
			lbl.Position = UDim2.new(0, 5, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = name
			lbl.TextColor3 = currentTheme.text
			lbl.Font = Enum.Font.GothamBlack
			lbl.TextSize = 14
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.ZIndex = 7
			lbl.Parent = sec
			RegisterTheme(lbl, "TextColor3", "text")

			local line = Instance.new("Frame")
			line.Size = UDim2.new(1, -10, 0, 2)
			line.Position = UDim2.new(0, 5, 1, -5)
			line.BackgroundColor3 = currentTheme.stroke
			line.BorderSizePixel = 0
			line.ZIndex = 7
			line.Parent = sec
			RegisterTheme(line, "BackgroundColor3", "stroke")
		end
		
		function TabAPI:MakeParagraph(cfg)
			local title = cfg.Title or "Paragraph Title"
			local content = cfg.Content or "Paragraph content here."
			
			local row = Instance.new("Frame")
			row.Size = UDim2.new(1, 0, 0, 0)
			row.AutomaticSize = Enum.AutomaticSize.Y
			row.BackgroundColor3 = currentTheme.tertiary
			row.BackgroundTransparency = 0.3
			row.ZIndex = 6
			row.Parent = scroll
			Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
			RegisterTheme(row, "BackgroundColor3", "tertiary")
			
			local layout = Instance.new("UIListLayout")
			layout.SortOrder = Enum.SortOrder.LayoutOrder
			layout.Padding = UDim.new(0, 5)
			layout.Parent = row
			
			local pad = Instance.new("UIPadding")
			pad.PaddingTop = UDim.new(0, 10)
			pad.PaddingBottom = UDim.new(0, 10)
			pad.PaddingLeft = UDim.new(0, 15)
			pad.PaddingRight = UDim.new(0, 15)
			pad.Parent = row
			
			local titleLbl = Instance.new("TextLabel")
			titleLbl.Size = UDim2.new(1, 0, 0, 15)
			titleLbl.BackgroundTransparency = 1
			titleLbl.Text = title
			titleLbl.TextColor3 = currentTheme.text
			titleLbl.Font = Enum.Font.GothamBold
			titleLbl.TextSize = 14
			titleLbl.TextXAlignment = Enum.TextXAlignment.Left
			titleLbl.ZIndex = 7
			titleLbl.LayoutOrder = 1
			titleLbl.Parent = row
			RegisterTheme(titleLbl, "TextColor3", "text")
			
			local contentLbl = Instance.new("TextLabel")
			contentLbl.Size = UDim2.new(1, 0, 0, 0)
			contentLbl.AutomaticSize = Enum.AutomaticSize.Y
			contentLbl.BackgroundTransparency = 1
			contentLbl.Text = content
			contentLbl.TextColor3 = currentTheme.textDim
			contentLbl.Font = Enum.Font.Gotham
			contentLbl.TextSize = 13
			contentLbl.TextXAlignment = Enum.TextXAlignment.Left
			contentLbl.TextYAlignment = Enum.TextYAlignment.Top
			contentLbl.TextWrapped = true
			contentLbl.ZIndex = 7
			contentLbl.LayoutOrder = 2
			contentLbl.Parent = row
			RegisterTheme(contentLbl, "TextColor3", "textDim")
		end
		
		function TabAPI:MakeColorPicker(cfg)
			local defaultColor = cfg.Default or Color3.fromRGB(255, 255, 255)
			local color = defaultColor
			
			local row = Instance.new("Frame")
			row.Size = UDim2.new(1, 0, 0, 45)
			row.BackgroundColor3 = currentTheme.tertiary
			row.BackgroundTransparency = 0.3
			row.ZIndex = 6
			row.Parent = scroll
			Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
			RegisterTheme(row, "BackgroundColor3", "tertiary")
			
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(0.6, 0, 1, 0)
			lbl.Position = UDim2.new(0, 15, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Name or "Color Picker"
			lbl.TextColor3 = currentTheme.text
			lbl.Font = Enum.Font.GothamBold
			lbl.TextSize = 14
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.ZIndex = 7
			lbl.Parent = row
			RegisterTheme(lbl, "TextColor3", "text")
			
			local colorBtn = Instance.new("TextButton")
			colorBtn.Size = UDim2.new(0, 60, 0, 25)
			colorBtn.Position = UDim2.new(1, -75, 0.5, -12.5)
			colorBtn.BackgroundColor3 = color
			colorBtn.Text = ""
			colorBtn.ZIndex = 8
			colorBtn.Parent = row
			Instance.new("UICorner", colorBtn).CornerRadius = UDim.new(0, 6)
			
			local stroke = Instance.new("UIStroke")
			stroke.Color = currentTheme.stroke
			stroke.Thickness = 2
			stroke.Parent = colorBtn
			RegisterTheme(stroke, "Color", "stroke")
			
			local h, s, v = Color3.toHSV(color)
			colorBtn.MouseButton1Click:Connect(function()
				h = (h + 0.1) % 1
				color = Color3.fromHSV(h, 0.8, 1)
				TweenService:Create(colorBtn, TweenInfo.new(0.3), {BackgroundColor3 = color}):Play()
				if cfg.Callback then cfg.Callback(color) end
			end)
		end
		
		function TabAPI:MakeLinkButton(cfg)
			local btnRow = Instance.new("TextButton")
			btnRow.Size = UDim2.new(1, 0, 0, 45)
			btnRow.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
			btnRow.Text = "- " .. (cfg.Name or "Join Discord")
			btnRow.TextColor3 = Color3.new(1, 1, 1)
			btnRow.Font = Enum.Font.GothamBold
			btnRow.TextSize = 14
			btnRow.ZIndex = 6
			btnRow.Parent = scroll
			Instance.new("UICorner", btnRow).CornerRadius = UDim.new(0, 8)
			
			local ripple = Instance.new("Frame")
			ripple.Size = UDim2.new(0, 0, 0, 0)
			ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
			ripple.AnchorPoint = Vector2.new(0.5, 0.5)
			ripple.BackgroundColor3 = Color3.new(1, 1, 1)
			ripple.BackgroundTransparency = 0.7
			ripple.ZIndex = 7
			ripple.Parent = btnRow
			Instance.new("UICorner", ripple).CornerRadius = UDim.new(1, 0)
			
			btnRow.MouseButton1Click:Connect(function()
				pcall(function() if setclipboard then setclipboard(cfg.Link or "") end end)
				TweenService:Create(ripple, TweenInfo.new(0.4), {Size = UDim2.new(2, 0, 2, 0), BackgroundTransparency = 1}):Play()
				task.delay(0.4, function()
					ripple.Size = UDim2.new(0, 0, 0, 0)
					ripple.BackgroundTransparency = 0.7
				end)
				if Vexro.Notify then Vexro:Notify("Copied!", "Link copied to clipboard!") end
				if cfg.Callback then cfg.Callback() end
			end)
		end

		Vexro.Tabs[tName] = TabAPI
		
		-- Automatically select first tab
		if Vexro.CurrentTab == nil then
			btnRow = btn
			task.spawn(function()
				-- Delay required to let other elements initialize
				task.wait(0.1)
				btnRow.Parent = sidebar -- keep reference
				local _, firstTab = next(Vexro.Tabs)
				if firstTab and firstTab.Name == tName then
					firstTab.Button.BackgroundColor3 = currentTheme.accent
					firstTab.Scroll.Visible = true
					Vexro.CurrentTab = tName
					titleLbl.Text = winTitle .. " - " .. tName
				end
			end)
		end
		
		return TabAPI
	end

	return Vexro
end

return VexroUI
