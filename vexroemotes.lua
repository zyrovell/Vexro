--Made by Zyrovell Roblox:Oyuncu15q Discord:_ege.
-- V3 Dynamic Theme / Added Emote Player Like Video Players
-- OPEN SOURCE FOREVER!

--[[



$$\    $$\ $$$$$$$$\ $$\   $$\ $$$$$$$\   $$$$$$\         $$$$$$\  $$\   $$\       $$$$$$$$\  $$$$$$\  $$$$$$$\        $$\ 
$$ |   $$ |$$  _____|$$ |  $$ |$$  __$$\ $$  __$$\       $$  __$$\ $$$\  $$ |      \__$$  __|$$  __$$\ $$  __$$\       $$ |
$$ |   $$ |$$ |      \$$\ $$  |$$ |  $$ |$$ /  $$ |      $$ /  $$ |$$$$\ $$ |         $$ |   $$ /  $$ |$$ |  $$ |      $$ |
\$$\  $$  |$$$$$\     \$$$$  / $$$$$$$  |$$ |  $$ |      $$ |  $$ |$$ $$\$$ |         $$ |   $$ |  $$ |$$$$$$$  |      $$ |
 \$$\$$  / $$  __|    $$  $$<  $$  __$$< $$ |  $$ |      $$ |  $$ |$$ \$$$$ |         $$ |   $$ |  $$ |$$  ____/       \__|
  \$$$  /  $$ |      $$  /\$$\ $$ |  $$ |$$ |  $$ |      $$ |  $$ |$$ |\$$$ |         $$ |   $$ |  $$ |$$ |                
   \$  /   $$$$$$$$\ $$ /  $$ |$$ |  $$ | $$$$$$  |       $$$$$$  |$$ | \$$ |         $$ |    $$$$$$  |$$ |            $$\ 
    \_/    \________|\__|  \__|\__|  \__| \______/        \______/ \__|  \__|         \__|    \______/ \__|            \__|
                                                                                                                           
                                                                                                                           
                                                                                                                           
]]

-- Önceki instance temizle (re-run desteği)
if getgenv().VexroEmotesCleanup then
	pcall(getgenv().VexroEmotesCleanup)
	getgenv().VexroEmotesCleanup = nil
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then return end

local old = playerGui:FindFirstChild("VexroEmotes")
if old then old:Destroy() end

-- ===============================================================
-- DATA SYSTEM
-- ===============================================================

local DATA_FILE = "VexroEmotes_Data.json"
local Settings = {theme = "Dark", speed = 1, notifications = true, loopEmote = true, language = nil, copyEmoteEnabled = false, stopOnWalk = true, showHUD = true}

local FriendData = {
	friends        = {},   -- [userId:string] = {name, syncEnabled}
	autoReject     = false,
	acceptRequests = true,
	playFriendEmote = true,
	syncEmote      = true,
	addModeActive  = false,
	currentSyncPartner = nil,
}
local _friendConns = {}
local RefreshFriendList  -- forward declaration
local ShowFriendRequestPanel  -- forward declaration
local Favorites = {}
local RecentEmotes = {}
-- Bridge: _VexroExtend içindeki HUD fonksiyonlarını dış kapsama bağlar
local _onSpeedChanged  -- function(); HUD hız butonlarını + info panel'i günceller
local _onPauseStateChanged  -- function(isPaused); HUD duraklat butonunu günceller
local MAX_RECENT = 20

local function SaveData()
	pcall(function()
		if writefile then
			writefile(DATA_FILE, HttpService:JSONEncode({
				favorites = Favorites,
				recent = RecentEmotes,
				settings = Settings
			}))
		end
	end)
end

local function LoadData()
	pcall(function()
		if readfile and isfile and isfile(DATA_FILE) then
			local data = HttpService:JSONDecode(readfile(DATA_FILE))
			if data then
				-- FIX: ID'leri sayıya çevirerek yüklüyoruz (String hatasını önler)
				Favorites = {}
				if data.favorites then
					for _, v in pairs(data.favorites) do
						table.insert(Favorites, tonumber(v)) 
					end
				end
				
				RecentEmotes = {}
				if data.recent then
					for _, v in pairs(data.recent) do
						table.insert(RecentEmotes, tonumber(v))
					end
				end

				if data.settings then
					Settings.theme = data.settings.theme or "Dark"
					Settings.speed = data.settings.speed or 1
					Settings.notifications = data.settings.notifications ~= false
					Settings.loopEmote = data.settings.loopEmote ~= false
					Settings.language = data.settings.language or nil
					Settings.copyEmoteEnabled = data.settings.copyEmoteEnabled == true
					Settings.stopOnWalk = data.settings.stopOnWalk ~= false
					Settings.showHUD = data.settings.showHUD ~= false
				end
			end
		end
	end)
end

LoadData()

-- Hash set for O(1) favorite lookups
local FavoritesSet = {}
for _, v in ipairs(Favorites) do FavoritesSet[v] = true end

-- Lookup table for O(1) emote-by-ID access (populated after emotes load)
local EmotesById = {}

-- Cache for async-fetched Roblox catalog metadata (keyed by numeric asset ID)
local _emoteMetaCache = {}

-- ===============================================================
-- UTILITIES
-- ===============================================================

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Auto Image/Decal resolver with cache
local _resolvedCache = {}
local function ResolveAssetImage(assetIdOrUrl)
	if not assetIdOrUrl then return "" end
	local str = tostring(assetIdOrUrl)
	local rawId = str:gsub("rbxassetid://", ""):gsub("[^%d]", "")
	if rawId == "" then return str end
	if _resolvedCache[rawId] then return _resolvedCache[rawId] end
	local resolved = nil
	pcall(function()
		local objects = game:GetObjects("rbxassetid://" .. rawId)
		if objects and #objects > 0 then
			local obj = objects[1]
			if obj:IsA("Decal") or obj:IsA("Texture") then
				resolved = obj.Texture
			elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
				resolved = obj.Image
			end
		end
	end)
	if not resolved or resolved == "" then
		resolved = "rbxthumb://type=Asset&id=" .. rawId .. "&w=420&h=420"
	end
	_resolvedCache[rawId] = resolved
	return resolved
end

local logo = [[

                                                                                  
                                                                               ▄▄ 
██  ██ ██████ ██  ██ █████▄  ▄████▄   ▄████▄ ███  ██   ██████ ▄████▄ █████▄    ██ 
██▄▄██ ██▄▄    ████  ██▄▄██▄ ██  ██   ██  ██ ██ ▀▄██     ██   ██  ██ ██▄▄█▀    ██ 
 ▀██▀  ██▄▄▄▄ ██  ██ ██   ██ ▀████▀   ▀████▀ ██   ██     ██   ▀████▀ ██        ▄▄ 
                                                                                                                                                                                                            
]]

print(logo)

-- ===============================================================
-- THEMES
-- ===============================================================

local Themes = {
	Dark = {
		primary = Color3.fromRGB(12, 12, 16),
		secondary = Color3.fromRGB(18, 18, 24),
		tertiary = Color3.fromRGB(26, 26, 34),
		sidebar = Color3.fromRGB(10, 10, 14),
		accent = Color3.fromRGB(180, 180, 180),
		text = Color3.new(1, 1, 1),
		textDim = Color3.fromRGB(150, 150, 160),
		stroke = Color3.fromRGB(60, 60, 80),
		critical = Color3.fromRGB(220, 60, 60),
		success = Color3.fromRGB(80, 200, 100)
	},
	Purple = {
		primary = Color3.fromRGB(12, 8, 20),
		secondary = Color3.fromRGB(20, 15, 34),
		tertiary = Color3.fromRGB(30, 22, 50),
		sidebar = Color3.fromRGB(15, 10, 26),
		accent = Color3.fromRGB(138, 43, 226),
		text = Color3.new(1, 1, 1),
		textDim = Color3.fromRGB(180, 160, 220),
		stroke = Color3.fromRGB(75, 0, 130),
		critical = Color3.fromRGB(255, 60, 100),
		success = Color3.fromRGB(100, 240, 120)
	},
	Blue = {
		primary = Color3.fromRGB(8, 12, 22),
		secondary = Color3.fromRGB(16, 22, 38),
		tertiary = Color3.fromRGB(24, 32, 54),
		sidebar = Color3.fromRGB(10, 16, 30),
		accent = Color3.fromRGB(0, 160, 255),
		text = Color3.new(1, 1, 1),
		textDim = Color3.fromRGB(150, 180, 220),
		stroke = Color3.fromRGB(30, 80, 160),
		critical = Color3.fromRGB(250, 60, 80),
		success = Color3.fromRGB(60, 230, 140)
	},
	Green = {
		primary = Color3.fromRGB(8, 16, 12),
		secondary = Color3.fromRGB(14, 28, 20),
		tertiary = Color3.fromRGB(22, 40, 30),
		sidebar = Color3.fromRGB(10, 22, 14),
		accent = Color3.fromRGB(0, 230, 120),
		text = Color3.new(1, 1, 1),
		textDim = Color3.fromRGB(160, 220, 180),
		stroke = Color3.fromRGB(30, 120, 60),
		critical = Color3.fromRGB(240, 80, 80),
		success = Color3.fromRGB(120, 255, 120)
	},
	Red = {
		primary = Color3.fromRGB(22, 8, 10),
		secondary = Color3.fromRGB(36, 14, 18),
		tertiary = Color3.fromRGB(50, 20, 26),
		sidebar = Color3.fromRGB(28, 10, 12),
		accent = Color3.fromRGB(255, 60, 80),
		text = Color3.new(1, 1, 1),
		textDim = Color3.fromRGB(220, 160, 170),
		stroke = Color3.fromRGB(150, 40, 60),
		critical = Color3.fromRGB(255, 30, 30),
		success = Color3.fromRGB(80, 240, 100)
	},
	Light = {
		primary = Color3.fromRGB(240, 240, 245),
		secondary = Color3.fromRGB(250, 250, 255),
		tertiary = Color3.fromRGB(255, 255, 255),
		sidebar = Color3.fromRGB(235, 235, 242),
		accent = Color3.fromRGB(90, 90, 110),
		text = Color3.fromRGB(30, 30, 36),
		textDim = Color3.fromRGB(120, 120, 130),
		stroke = Color3.fromRGB(200, 200, 215),
		critical = Color3.fromRGB(220, 60, 60),
		success = Color3.fromRGB(60, 180, 80)
	},
	MaterialYou = {
		primary = Color3.fromRGB(17, 19, 27),
		secondary = Color3.fromRGB(25, 28, 40),
		tertiary = Color3.fromRGB(33, 37, 52),
		sidebar = Color3.fromRGB(13, 15, 22),
		accent = Color3.fromRGB(130, 177, 255),
		text = Color3.fromRGB(225, 228, 240),
		textDim = Color3.fromRGB(140, 145, 165),
		stroke = Color3.fromRGB(55, 65, 92),
		critical = Color3.fromRGB(255, 130, 120),
		success = Color3.fromRGB(120, 210, 160)
	}
}

local currentTheme = Themes[Settings.theme] or Themes.Dark
local themeElements = {}
local mainStrokeGrad, miniIconGrad -- Forward declaration for the theme system
local UpdateTabStyles
local UpdateTabData

local function RegisterTheme(el, prop, key)
	if el then themeElements[#themeElements + 1] = {el = el, prop = prop, key = key} end
end

local function Notify(title, text, iconId)
	if not Settings.notifications then return end
	pcall(function()
		local screenGui = playerGui:FindFirstChild("VexroEmotes") or game:GetService("CoreGui"):FindFirstChild("VexroEmotes")
		if not screenGui then
			game:GetService("StarterGui"):SetCore("SendNotification", {Title = title, Text = text, Duration = 3})
			return
		end
		
		local container = screenGui:FindFirstChild("NotificationContainer")
		if not container then
			container = Instance.new("Frame")
			container.Name = "NotificationContainer"
			container.Size = UDim2.new(0, 300, 1, -40)
			container.Position = UDim2.new(0.5, -150, 0, 20)
			container.BackgroundTransparency = 1
			container.ZIndex = 30000
			container.Parent = screenGui
			
			local uiList = Instance.new("UIListLayout")
			uiList.Padding = UDim.new(0, 10)
			uiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
			uiList.VerticalAlignment = Enum.VerticalAlignment.Top
			uiList.Parent = container
		end
		
		local theme = currentTheme or Themes.Dark
		
		-- Wrapper for animation compatibility with UIListLayout
		local wrapper = Instance.new("Frame")
		wrapper.BackgroundTransparency = 1
		wrapper.Size = UDim2.new(1, 0, 0, 60)
		wrapper.ClipsDescendants = true
		wrapper.Parent = container
		
		local toast = Instance.new("Frame")
		toast.Size = UDim2.new(1, 0, 1, 0)
		toast.Position = UDim2.new(0, 0, -1, -20)
		toast.BackgroundColor3 = theme.secondary
		toast.ZIndex = 30001
		toast.Parent = wrapper
		Instance.new("UICorner", toast).CornerRadius = UDim.new(0, 10)
		
		local toastStroke = Instance.new("UIStroke")
		toastStroke.Color = theme.stroke
		toastStroke.Thickness = 2
		toastStroke.Parent = toast
		
		local iconOffset = 0
		if iconId then
			local notifIcon = Instance.new("ImageLabel")
			notifIcon.Size = UDim2.new(0, 22, 0, 22)
			notifIcon.AnchorPoint = Vector2.new(0, 0.5)
			notifIcon.Position = UDim2.new(0, 10, 0, 16)
			notifIcon.BackgroundTransparency = 1
			notifIcon.Image = ResolveAssetImage("rbxassetid://" .. tostring(iconId))
			notifIcon.ZIndex = 30003
			notifIcon.Parent = toast
			iconOffset = 28
		end

		local titleLbl = Instance.new("TextLabel")
		titleLbl.Size = UDim2.new(1, -(15 + iconOffset), 0, 25)
		titleLbl.Position = UDim2.new(0, 10 + iconOffset, 0, 5)
		titleLbl.BackgroundTransparency = 1
		titleLbl.Text = title
		titleLbl.Font = Enum.Font.GothamBold
		titleLbl.TextSize = 15
		titleLbl.TextColor3 = theme.text
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
		textLbl.TextColor3 = theme.textDim
		textLbl.TextXAlignment = Enum.TextXAlignment.Left
		textLbl.TextWrapped = true
		textLbl.ZIndex = 30002
		textLbl.Parent = toast
		
		-- Tween inside wrapper
		TweenService:Create(toast, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
		
		task.delay(3, function()
			local outTween = TweenService:Create(toast, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0, 0, -1, -20)})
			outTween:Play()
			task.wait(0.4)
			wrapper:Destroy()
		end)
	end)
end

local function ApplyTheme(name)
	currentTheme = Themes[name] or Themes.Dark
	-- Clean up destroyed elements and apply theme
	local alive = {}
	for i = 1, #themeElements do
		local t = themeElements[i]
		if t.el and t.el.Parent then
			alive[#alive + 1] = t
			if currentTheme[t.key] then
				pcall(function()
					TweenService:Create(t.el, TweenInfo.new(0.3), {[t.prop] = currentTheme[t.key]}):Play()
				end)
			end
		end
	end
	themeElements = alive
	
	if mainStrokeGrad then
		mainStrokeGrad.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, currentTheme.stroke),
			ColorSequenceKeypoint.new(0.33, currentTheme.accent),
			ColorSequenceKeypoint.new(0.66, currentTheme.stroke),
			ColorSequenceKeypoint.new(1, currentTheme.accent)
		}
	end
	
	if miniIconGrad then
		miniIconGrad.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, currentTheme.stroke),
			ColorSequenceKeypoint.new(0.33, currentTheme.accent),
			ColorSequenceKeypoint.new(0.66, currentTheme.stroke),
			ColorSequenceKeypoint.new(1, currentTheme.accent)
		}
	end

	if UpdateTabStyles then UpdateTabStyles() end
end

-- ===============================================================
-- GUI
-- ===============================================================

local gui = Instance.new("ScreenGui")
gui.Name = "VexroEmotes"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = playerGui

-- ===============================================================
-- LANGUAGE SELECTION
-- ===============================================================

local selectedLang = nil
local rememberLang = false

-- Kayıtlı dil varsa direkt kullan, dil ekranını atla
if Settings.language and Settings.language ~= "" then
	selectedLang = Settings.language
end

if not selectedLang then

local langScreen = Instance.new("Frame")
langScreen.Size = UDim2.fromScale(1, 1)
langScreen.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
langScreen.ZIndex = 20000
langScreen.Parent = gui

for i = 1, 15 do
	local particle = Instance.new("Frame")
	local s = math.random(3, 8)
	particle.Size = UDim2.new(0, s, 0, s)
	particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
	particle.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
	particle.BackgroundTransparency = math.random(5, 8) / 10
	particle.ZIndex = 20000
	particle.Parent = langScreen
	Instance.new("UICorner", particle).CornerRadius = UDim.new(1, 0)
	
	task.spawn(function()
		while particle.Parent do
			TweenService:Create(particle, TweenInfo.new(math.random(3, 6), Enum.EasingStyle.Sine), {
				Position = UDim2.new(math.random(), 0, math.random(), 0)
			}):Play()
			task.wait(math.random(3, 6))
		end
	end)
end

local langBox = Instance.new("Frame")
langBox.Size = UDim2.new(0, 0, 0, 0)
langBox.Position = UDim2.fromScale(0.5, 0.5)
langBox.AnchorPoint = Vector2.new(0.5, 0.5)
langBox.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
langBox.ZIndex = 20001
langBox.Rotation = -15
langBox.Parent = langScreen
Instance.new("UICorner", langBox).CornerRadius = UDim.new(0, 20)

local langBoxStroke = Instance.new("UIStroke")
langBoxStroke.Color = Color3.fromRGB(100, 100, 180)
langBoxStroke.Thickness = 2
langBoxStroke.Parent = langBox

local langStrokeGrad = Instance.new("UIGradient")
langStrokeGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(75, 0, 130)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
}
langStrokeGrad.Parent = langBoxStroke

task.spawn(function()
	local rot = 0
	while langBoxStroke.Parent do
		rot = rot + 360
		TweenService:Create(langStrokeGrad, TweenInfo.new(2, Enum.EasingStyle.Linear), {Rotation = rot}):Play()
		task.wait(2)
	end
end)

local langTitle = Instance.new("TextLabel")
langTitle.Size = UDim2.new(1, 0, 0, 45)
langTitle.Position = UDim2.new(0, 0, 0, 20)
langTitle.BackgroundTransparency = 1
langTitle.Text = "🌐 Select Language"
langTitle.TextColor3 = Color3.new(1, 1, 1)
langTitle.Font = Enum.Font.GothamBold
langTitle.TextScaled = true
langTitle.ZIndex = 20002
langTitle.Parent = langBox

local function MakeLangBtn(txt, index, lang)
	local col = index <= 4 and 0 or 1
	local row = (index - 1) % 4
	local x = col == 0 and 0.04 or 0.52
	local y = 80 + (row * 65)

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.44, 0, 0, 55)
	btn.Position = UDim2.new(x, 0, 0, y)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
	btn.Text = txt
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = isMobile and 14 or 16
	btn.ZIndex = 20003
	btn.Parent = langBox
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
	
	local btnStroke = Instance.new("UIStroke")
	btnStroke.Color = Color3.fromRGB(70, 70, 100)
	btnStroke.Transparency = 0.5
	btnStroke.Parent = btn
	
	local shine = Instance.new("Frame")
	shine.Size = UDim2.new(0, 0, 1, 0)
	shine.BackgroundColor3 = Color3.new(1, 1, 1)
	shine.BackgroundTransparency = 0.9
	shine.ZIndex = 20004
	shine.Parent = btn
	Instance.new("UICorner", shine).CornerRadius = UDim.new(0, 12)
	
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 90)}):Play()
		TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0, Color = Color3.fromRGB(138, 43, 226)}):Play()
		TweenService:Create(shine, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 1, 0)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 60)}):Play()
		TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.5, Color = Color3.fromRGB(70, 70, 100)}):Play()
		TweenService:Create(shine, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 1, 0)}):Play()
	end)
	btn.MouseButton1Click:Connect(function()
		local ripple = Instance.new("Frame")
		ripple.Size = UDim2.new(0, 0, 0, 0)
		ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
		ripple.AnchorPoint = Vector2.new(0.5, 0.5)
		ripple.BackgroundColor3 = Color3.new(1, 1, 1)
		ripple.BackgroundTransparency = 0.7
		ripple.ZIndex = 20005
		ripple.Parent = btn
		Instance.new("UICorner", ripple).CornerRadius = UDim.new(1, 0)
		
		TweenService:Create(ripple, TweenInfo.new(0.4), {Size = UDim2.new(2, 0, 2, 0), BackgroundTransparency = 1}):Play()
		TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(138, 43, 226)}):Play()
		task.delay(0.4, function() ripple:Destroy() end)
		task.wait(0.15)
		selectedLang = lang
	end)
end

MakeLangBtn("🇹🇷  Türkçe",   1, "TR")
MakeLangBtn("🇬🇧  English",  2, "EN")
MakeLangBtn("🇪🇸  Español",  3, "ES")
MakeLangBtn("🇸🇦  العربية",  4, "AR")
MakeLangBtn("🇫🇷  Français", 5, "FR")
MakeLangBtn("🇮🇳  हिन्दी",   6, "HI")
MakeLangBtn("🇵🇹  Português",7, "PT")
MakeLangBtn("🇷🇺  Русский",  8, "RU")

-- Remember Language butonu
local rememberBtn = Instance.new("TextButton")
rememberBtn.Size = UDim2.new(0.92, 0, 0, 40)
rememberBtn.Position = UDim2.new(0.04, 0, 1, -50)
rememberBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
rememberBtn.Text = "💾  Remember Language"
rememberBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
rememberBtn.Font = Enum.Font.GothamBold
rememberBtn.TextSize = isMobile and 13 or 15
rememberBtn.ZIndex = 20003
rememberBtn.Parent = langBox
Instance.new("UICorner", rememberBtn).CornerRadius = UDim.new(0, 12)

local rememberStroke = Instance.new("UIStroke")
rememberStroke.Color = Color3.fromRGB(70, 70, 100)
rememberStroke.Transparency = 0.5
rememberStroke.Parent = rememberBtn

rememberBtn.MouseButton1Click:Connect(function()
	rememberLang = not rememberLang
	if rememberLang then
		TweenService:Create(rememberBtn, TweenInfo.new(0.2),
			{BackgroundColor3 = Color3.fromRGB(60, 140, 80)}):Play()
		rememberBtn.Text       = "✅  Remember Language"
		rememberBtn.TextColor3 = Color3.new(1, 1, 1)
	else
		TweenService:Create(rememberBtn, TweenInfo.new(0.2),
			{BackgroundColor3 = Color3.fromRGB(40, 40, 60)}):Play()
		rememberBtn.Text       = "💾  Remember Language"
		rememberBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
	end
end)

local targetSize = isMobile and UDim2.new(0, 380, 0, 410) or UDim2.new(0, 480, 0, 410)
TweenService:Create(langBox, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = targetSize, Rotation = 0}):Play()

repeat task.wait(0.1) until selectedLang

-- Dil hatırlama seçiliyse kaydet
if rememberLang then
	Settings.language = selectedLang
	SaveData()
end

TweenService:Create(langBox, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), Rotation = 360}):Play()
TweenService:Create(langScreen, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
task.wait(0.4)
langScreen:Destroy()

end -- if not selectedLang

-- ===============================================================
-- LANGUAGE
-- ===============================================================

local isTR, isES, isAR, isFR, isHI, isPT, isRU = selectedLang == "TR", selectedLang == "ES", selectedLang == "AR", selectedLang == "FR", selectedLang == "HI", selectedLang == "PT", selectedLang == "RU"
local L = {
	r6Msg = isTR and "Sadece R15!" or (isES and "Solo R15!" or (isAR and "R15 فقط!" or (isFR and "R15 uniquement!" or (isHI and "केवल R15!" or (isPT and "Apenas R15!" or (isRU and "Только R15!" or "R15 only!")))))),
	loading = isTR and "Yükleniyor..." or (isES and "Cargando..." or (isAR and "جار التحميل..." or (isFR and "Chargement..." or (isHI and "लोड हो रहा है..." or (isPT and "Carregando..." or (isRU and "Загрузка..." or "Loading...")))))),
	madeBy = isTR and "Oyuncu15q tarafından yapıldı" or (isES and "Hecho por Oyuncu15q" or (isAR and "صنع بواسطة Oyuncu15q" or (isFR and "Fait par Oyuncu15q" or (isHI and "Oyuncu15q द्वारा निर्मित" or (isPT and "Feito por Oyuncu15q" or (isRU and "Сделано Oyuncu15q" or "Made by Oyuncu15q")))))),
	search = isTR and "Ara..." or (isES and "Buscar..." or (isAR and "بحث..." or (isFR and "Rechercher..." or (isHI and "खोजें..." or (isPT and "Pesquisar..." or (isRU and "Поиск..." or "Search...")))))),
	playing = isTR and "Oynatılıyor" or (isES and "Reproduciendo" or (isAR and "تشغيل" or (isFR and "En lecture" or (isHI and "चल रहा है" or (isPT and "Reproduzindo" or (isRU and "Воспроизведение" or "Playing")))))),
	stopped = isTR and "Durduruldu" or (isES and "Detenido" or (isAR and "توقف" or (isFR and "Arrêté" or (isHI and "रुक गया" or (isPT and "Parado" or (isRU and "Остановлено" or "Stopped")))))),
	ready = isTR and "Hazır!" or (isES and "Listo!" or (isAR and "جاهز!" or (isFR and "Prêt!" or (isHI and "तैयार!" or (isPT and "Pronto!" or (isRU and "Готово!" or "Ready!")))))),
	emotes = isTR and "Emoteler" or (isES and "Emotes" or (isAR and "رقصات" or (isFR and "Emotes" or (isHI and "इमोट्स" or (isPT and "Emotes" or (isRU and "Эмоции" or "Emotes")))))),
	favorites = isTR and "Favoriler" or (isES and "Favoritos" or (isAR and "المفضلة" or (isFR and "Favoris" or (isHI and "पसंदीदा" or (isPT and "Favoritos" or (isRU and "Избранное" or "Favorites")))))),
	recent = isTR and "Son Kullanılanlar" or (isES and "Recientes" or (isAR and "الأخيرة" or (isFR and "Récents" or (isHI and "हाल ही के" or (isPT and "Recentes" or (isRU and "Недавние" or "Recent")))))),
	settings = isTR and "Ayarlar" or (isES and "Ajustes" or (isAR and "الإعدادات" or (isFR and "Paramètres" or (isHI and "सेटिंग्स" or (isPT and "Configurações" or (isRU and "Настройки" or "Settings")))))),
	noFav = isTR and "Favori yok" or (isES and "Sin favoritos" or (isAR and "لا يوجد مفضلة" or (isFR and "Pas de favoris" or (isHI and "कोई पसंदीदा नहीं" or (isPT and "Sem favoritos" or (isRU and "Нет избранного" or "No favorites")))))),
	noRecent = isTR and "Geçmiş yok" or (isES and "Sin recientes" or (isAR and "لا يوجد سجل" or (isFR and "Pas de récents" or (isHI and "कोई हाल का नहीं" or (isPT and "Sem recentes" or (isRU and "Нет недавних" or "No recent")))))),
	theme = isTR and "Tema" or (isES and "Tema" or (isAR and "المظهر" or (isFR and "Thème" or (isHI and "थीम" or (isPT and "Tema" or (isRU and "Тема" or "Theme")))))),
	speed = isTR and "Hız" or (isES and "Velocidad" or (isAR and "السرعة" or (isFR and "Vitesse" or (isHI and "गति" or (isPT and "Velocidade" or (isRU and "Скорость" or "Speed")))))),
	notif = isTR and "Bildirimler" or (isES and "Notificaciones" or (isAR and "الإشعارات" or (isFR and "Notifications" or (isHI and "सूचनाएं" or (isPT and "Notificações" or (isRU and "Уведомления" or "Notifications")))))),
	on = isTR and "Açık" or (isES and "On" or (isAR and "تشغيل" or (isFR and "Activé" or (isHI and "चालू" or (isPT and "Ligado" or (isRU and "Вкл" or "On")))))),
	off = isTR and "Kapalı" or (isES and "Off" or (isAR and "إيقاف" or (isFR and "Désactivé" or (isHI and "बंद" or (isPT and "Desligado" or (isRU and "Выкл" or "Off")))))),
	copied = isTR and "Kopyalandı!" or (isES and "Copiado!" or (isAR and "تم النسخ!" or (isFR and "Copié!" or (isHI and "कॉपी किया गया!" or (isPT and "Copiado!" or (isRU and "Скопировано!" or "Copied!")))))),
	loopText    = isTR and "Döngü"         or (isES and "Bucle"         or (isAR and "تكرار"        or (isFR and "Boucle"          or (isHI and "लूप"           or (isPT and "Loop"        or (isRU and "Цикл"         or "Loop")))))),
	comboTitle  = isTR and "Combo Sırası" or (isES and "Cola de Combo" or (isAR and "قائمة الكومبو" or (isFR and "File Combo"       or (isHI and "कॉम्बो कतार"    or (isPT and "Fila de Combo" or (isRU and "Очередь комбо" or "Combo Queue")))))),
	addEmote    = isTR and "+ Ekle"       or (isES and "+ Añadir"      or (isAR and "+ إضافة"       or (isFR and "+ Ajouter"        or (isHI and "+ जोड़ें"       or (isPT and "+ Adicionar"   or (isRU and "+ Добавить"    or "+ Add")))))),
	playCombo   = isTR and "Oynat"        or (isES and "Reproducir"    or (isAR and "تشغيل"         or (isFR and "Jouer"            or (isHI and "चलाएं"         or (isPT and "Reproduzir"    or (isRU and "Играть"        or "Play")))))),
	clearCombo  = isTR and "Temizle"      or (isES and "Limpiar"       or (isAR and "مسح"           or (isFR and "Effacer"          or (isHI and "साफ़ करें"      or (isPT and "Limpar"        or (isRU and "Очистить"      or "Clear")))))),
	selectFirst = isTR and "Önce seç!"      or (isES and "¡Selecciona!"   or (isAR and "اختر أولاً!"    or (isFR and "Choisir d'abord!" or (isHI and "पहले चुनें!"    or (isPT and "Selecione!"     or (isRU and "Выберите!"      or "Select first!")))))),
	slotLabel   = isTR and "Slot"           or (isES and "Ranura"         or (isAR and "خانة"           or (isFR and "Slot"             or (isHI and "स्लॉट"          or (isPT and "Slot"           or (isRU and "Слот"           or "Slot")))))),
	-- Bilgi paneli
	infoTitle   = isTR and "Emote Bilgisi" or (isES and "Info del Emote" or (isAR and "معلومات الحركة" or (isFR and "Infos de l'Emote" or (isHI and "इमोट जानकारी"   or (isPT and "Info do Emote"  or (isRU and "Инфо Эмоции"    or "Emote Info")))))),
	noDesc      = isTR and "Açıklama yok"  or (isES and "Sin descripción" or (isAR and "لا يوجد وصف"   or (isFR and "Sans description" or (isHI and "कोई विवरण नहीं" or (isPT and "Sem descrição"   or (isRU and "Нет описания"   or "No description")))))),
	freePrice   = isTR and "Ücretsiz"      or (isES and "Gratis"          or (isAR and "مجاني"          or (isFR and "Gratuit"          or (isHI and "मुफ़्त"          or (isPT and "Grátis"          or (isRU and "Бесплатно"      or "Free")))))),
	copyId           = isTR and "ID Kopyala"         or (isES and "Copiar ID"              or (isAR and "نسخ المعرف"          or (isFR and "Copier ID"             or (isHI and "ID कॉपी करें"      or (isPT and "Copiar ID"            or (isRU and "Скопировать ID"    or "Copy ID")))))),
	copyEmote        = isTR and "Emote Kopyala"      or (isES and "Copiar Emote"           or (isAR and "نسخ الحركة"           or (isFR and "Copier Emote"          or (isHI and "इमोट कॉपी करें"    or (isPT and "Copiar Emote"         or (isRU and "Скопировать"       or "Copy Emote")))))),
	favLimit         = isTR and "Maksimum 25 favori!" or (isES and "¡Máximo 25 favoritos!"  or (isAR and "الحد الأقصى 25!"       or (isFR and "Maximum 25 favoris!"   or (isHI and "अधिकतम 25 पसंदीदा!" or (isPT and "Máximo 25 favoritos!" or (isRU and "Максимум 25!"       or "Max 25 favorites!")))))),
	copyEmoteDesc    = isTR and "Bir oyuncunun kullandığı emote'u kopyalar" or (isES and "Copia el emote que usa otro jugador" or (isAR and "ينسخ حركة يستخدمها لاعب آخر" or (isFR and "Copie l'émote utilisé par un autre joueur" or (isHI and "किसी खिलाड़ी का इमोट कॉपी करता है" or (isPT and "Copia o emote de outro jogador" or (isRU and "Копирует эмоцию другого игрока" or "Copies the emote used by another player")))))),
	stopOnWalk       = isTR and "Yürüyünce emote'u durdur" or (isES and "Parar emote al caminar" or (isAR and "ايقاف الحركة عند المشي" or (isFR and "Arreter emote en marchant" or (isHI and "चलने पर इमोट रोकें" or (isPT and "Parar emote ao andar" or (isRU and "Остановить эмоцию при ходьбе" or "Stop emote when walking")))))),
	stopOnWalkDesc   = isTR and "Oyuncu yürüdüğü zaman emote durur" or (isES and "El emote se detiene al caminar" or (isAR and "تتوقف الحركة تلقائيا عند المشي" or (isFR and "L'emote s'arrete automatiquement en marchant" or (isHI and "चलने पर इमोट अपने आप रुक जाता है" or (isPT and "O emote para automaticamente ao andar" or (isRU and "Эмоция останавливается при ходьбе" or "Emote stops automatically when walking")))))),
	showHUD          = isTR and "Oynatma barını göster" or (isES and "Mostrar barra de reproducción" or (isAR and "إظهار شريط التشغيل" or (isFR and "Afficher la barre de lecture" or (isHI and "प्लेबार दिखाएं" or (isPT and "Mostrar barra de reprodução" or (isRU and "Показать панель воспроизведения" or "Show playback bar")))))),
	friendTab        = isTR and "Arkadaşlar"                       or (isES and "Amigos"                  or (isAR and "الأصدقاء"            or (isFR and "Amis"                  or (isHI and "दोस्त"                  or (isPT and "Amigos"                 or (isRU and "Друзья"                 or "Friends")))))),
	accept           = isTR and "Kabul Et"                         or (isES and "Aceptar"                 or (isAR and "قبول"                  or (isFR and "Accepter"              or (isHI and "स्वीकार करें"              or (isPT and "Aceitar"                or (isRU and "Принять"                or "Accept")))))),
	reject           = isTR and "Reddet"                           or (isES and "Rechazar"                or (isAR and "رفض"                   or (isFR and "Refuser"               or (isHI and "अस्वीकार करें"              or (isPT and "Rejeitar"               or (isRU and "Отклонить"              or "Reject")))))),
	friendAlreadySyncing = isTR and "Hata! Oyuncu zaten başka birisiyle beraber emote oynuyor." or (isES and "Error! El jugador ya está sincronizado con otro." or (isAR and "خطأ! اللاعب يلعب مع شخص آخر." or (isFR and "Erreur! Le joueur est déjà synchronisé avec quelqu'un d'autre." or (isHI and "त्रुटि! खिलाड़ी पहले से किसी और के साथ खेल रहा है।" or (isPT and "Erro! O jogador já está sincronizado com outro." or (isRU and "Ошибка! Игрок уже играет с другим." or "Error! Player is already syncing with someone else.")))))),
	showHUDDesc      = isTR and "Emote oynarken altta oynatma barı görünsün" or (isES and "Muestra la barra de control al reproducir emotes" or (isAR and "يظهر شريط التحكم أسفل الشاشة أثناء تشغيل الحركة" or (isFR and "Affiche la barre de controle en bas lors de la lecture" or (isHI and "इमोट चलाते समय नीचे प्लेबार दिखाता है" or (isPT and "Exibe a barra de controle na parte inferior ao reproduzir" or (isRU and "Показывает панель управления внизу при воспроизведении" or "Shows the playback control bar while emote plays")))))),
}

local Icons = {
	Emote = "rbxassetid://138124492647096",
	Sort = "rbxassetid://113816420281431", 
	Refresh = "rbxassetid://105648271243690",
	Info = "rbxassetid://84622089809608",
	Crown = "rbxassetid://73989246452336",
	Minus = "rbxassetid://113043537756950", 
	Close = "rbxassetid://71734731066706", -- X
	Search = "rbxassetid://100759629447583",
	FavoriteEmpty = "rbxassetid://139336655769578",
	FavoriteFull = "rbxassetid://114412745011584",
	Stop = "STOP_SHAPE", 
	Settings = "rbxassetid://94488099205692", 
	Recent = "rbxassetid://89358357551545", 
	Check = "rbxassetid://71514022902819",
	Quatrefoil = "rbxassetid://98400541052448", 
}

-- ===============================================================
-- R15 CHECK
-- ===============================================================

local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid", 5)
if not hum or hum.RigType == Enum.HumanoidRigType.R6 then
	Notify(utf8.char(0x274C), L.r6Msg)
	gui:Destroy()
	return
end

-- ===============================================================
-- SPLASH SCREEN
-- ===============================================================

local splash = Instance.new("Frame")
splash.Size = UDim2.fromScale(1, 1)
splash.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
splash.ZIndex = 10000
splash.Parent = gui

local splashBgGrad = Instance.new("UIGradient")
splashBgGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 8, 18)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(18, 10, 30)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 18))
}
splashBgGrad.Rotation = 45
splashBgGrad.Parent = splash

task.spawn(function()
	local rot = 0
	while splash.Parent do
		rot = (rot + 1) % 360
		splashBgGrad.Rotation = rot
		task.wait(0.05)
	end
end)

local splashBox = Instance.new("Frame")
splashBox.Size = UDim2.new(0, 0, 0, 0)
splashBox.Position = UDim2.fromScale(0.5, 0.5)
splashBox.AnchorPoint = Vector2.new(0.5, 0.5)
splashBox.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
splashBox.Rotation = -180
splashBox.ZIndex = 10001
splashBox.Parent = splash
Instance.new("UICorner", splashBox).CornerRadius = UDim.new(0, 22)

local splashStroke = Instance.new("UIStroke")
splashStroke.Color = Color3.fromRGB(138, 43, 226)
splashStroke.Thickness = 3
splashStroke.Parent = splashBox

local splashStrokeGrad = Instance.new("UIGradient")
splashStrokeGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
	ColorSequenceKeypoint.new(0.33, Color3.fromRGB(75, 0, 130)),
	ColorSequenceKeypoint.new(0.66, Color3.fromRGB(186, 85, 211)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
}
splashStrokeGrad.Parent = splashStroke

task.spawn(function()
	local rot = 0
	while splashStroke.Parent do
		rot = rot + 360
		TweenService:Create(splashStrokeGrad, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {Rotation = rot}):Play()
		task.wait(1.5)
	end
end)

local avatarHolder = Instance.new("Frame")
avatarHolder.Size = UDim2.new(1, -24, 0, 50)
avatarHolder.Position = UDim2.new(0, 12, 0, 12)
avatarHolder.BackgroundTransparency = 1
avatarHolder.ZIndex = 10002
avatarHolder.Parent = splashBox

local avatar = Instance.new("ImageLabel")
avatar.Size = UDim2.new(0, 44, 0, 44)
avatar.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=3164346931&width=150&height=150&format=png"
avatar.ZIndex = 10003
avatar.Parent = avatarHolder
Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)

local avatarGlow = Instance.new("UIStroke")
avatarGlow.Color = Color3.fromRGB(138, 43, 226)
avatarGlow.Thickness = 2
avatarGlow.Parent = avatar

task.spawn(function()
	while avatar.Parent do
		TweenService:Create(avatarGlow, TweenInfo.new(1, Enum.EasingStyle.Sine), {Color = Color3.fromRGB(186, 85, 211)}):Play()
		task.wait(1)
		TweenService:Create(avatarGlow, TweenInfo.new(1, Enum.EasingStyle.Sine), {Color = Color3.fromRGB(138, 43, 226)}):Play()
		task.wait(1)
	end
end)

local madeByLbl = Instance.new("TextLabel")
madeByLbl.Size = UDim2.new(1, -54, 1, 0)
madeByLbl.Position = UDim2.new(0, 52, 0, 0)
madeByLbl.BackgroundTransparency = 1
madeByLbl.Text = L.madeBy
madeByLbl.TextColor3 = Color3.fromRGB(180, 180, 220)
madeByLbl.Font = Enum.Font.GothamBold
madeByLbl.TextScaled = true
madeByLbl.TextXAlignment = Enum.TextXAlignment.Left
madeByLbl.ZIndex = 10003
madeByLbl.Parent = avatarHolder

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, -24, 0, 60)
logo.Position = UDim2.new(0, 12, 0, 70)
logo.BackgroundTransparency = 1
logo.Text = "Vexro Emotes"
logo.TextColor3 = Color3.new(1, 1, 1)
logo.Font = Enum.Font.GothamBlack
logo.TextScaled = true
logo.ZIndex = 10003
logo.Parent = splashBox

local logoGrad = Instance.new("UIGradient")
logoGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
	ColorSequenceKeypoint.new(0.25, Color3.fromRGB(186, 85, 211)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(75, 0, 130)),
	ColorSequenceKeypoint.new(0.75, Color3.fromRGB(186, 85, 211)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
}
logoGrad.Parent = logo

task.spawn(function()
	while logo.Parent do
		TweenService:Create(logoGrad, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Offset = Vector2.new(1, 0)}):Play()
		task.wait(2)
		TweenService:Create(logoGrad, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Offset = Vector2.new(-1, 0)}):Play()
		task.wait(2)
	end
end)

local loadingLbl = Instance.new("TextLabel")
loadingLbl.Size = UDim2.new(1, 0, 0, 30)
loadingLbl.Position = UDim2.new(0, 0, 0, 140)
loadingLbl.BackgroundTransparency = 1
loadingLbl.Text = L.loading
loadingLbl.TextColor3 = Color3.fromRGB(150, 150, 180)
loadingLbl.Font = Enum.Font.GothamBold
loadingLbl.TextSize = 16
loadingLbl.ZIndex = 10003
loadingLbl.Parent = splashBox

task.spawn(function()
	local dots = {"", ".", "..", "..."}
	local i = 1
	while loadingLbl.Parent do
		loadingLbl.Text = "Vexro Emotes " .. L.loading .. dots[i]
		i = i % 4 + 1
		task.wait(0.4)
	end
end)

local loadingBarBg = Instance.new("Frame")
loadingBarBg.Size = UDim2.new(0.8, 0, 0, 6)
loadingBarBg.Position = UDim2.new(0.1, 0, 0, 175)
loadingBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
loadingBarBg.ZIndex = 10003
loadingBarBg.Parent = splashBox
Instance.new("UICorner", loadingBarBg).CornerRadius = UDim.new(1, 0)

local loadingBar = Instance.new("Frame")
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
loadingBar.ZIndex = 10004
loadingBar.Parent = loadingBarBg
Instance.new("UICorner", loadingBar).CornerRadius = UDim.new(1, 0)

local loadingBarGrad = Instance.new("UIGradient")
loadingBarGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(186, 85, 211)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
}
loadingBarGrad.Parent = loadingBar

local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.new(0.85, 0, 0, 42)
discordBtn.Position = UDim2.new(0.075, 0, 1, -55)
discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
discordBtn.Text = "Discord: 4Bs9WYSabf"
discordBtn.TextColor3 = Color3.new(1, 1, 1)
discordBtn.Font = Enum.Font.GothamBold
discordBtn.TextSize = 14
discordBtn.ZIndex = 10003
discordBtn.Parent = splashBox
Instance.new("UICorner", discordBtn).CornerRadius = UDim.new(0, 10)

discordBtn.MouseButton1Click:Connect(function()
	pcall(function() if setclipboard then setclipboard("https://discord.gg/4Bs9WYSabf") end end)
	Notify(utf8.char(0x2705), L.copied)
end)

local splashSize = isMobile and UDim2.new(0, 300, 0, 240) or UDim2.new(0, 400, 0, 280)
TweenService:Create(splashBox, TweenInfo.new(0.7, Enum.EasingStyle.Back), {Size = splashSize, Rotation = 0}):Play()

-- ===============================================================
-- EMOTE LOADING
-- ===============================================================

local Emotes = {}

TweenService:Create(loadingBar, TweenInfo.new(0.5), {Size = UDim2.new(0.3, 0, 1, 0)}):Play()
task.wait(0.3)

local function LoadEmotes()
	local success, result = pcall(function()
		local response = game:HttpGet("https://raw.githubusercontent.com/zyrovell/Vexro/main/emotes.json")
		return HttpService:JSONDecode(response)
	end)
	
	if success and result then
		local data = type(result) == "table" and (result.data or result)
		for _, emote in ipairs(data) do
			if emote.id and emote.name then
				local numId = tonumber(emote.id)
				if numId then
					Emotes[#Emotes + 1] = {
						name          = tostring(emote.name),
						id            = numId,
						creatorName   = tostring(emote.creatorName      or ""),
						description   = tostring(emote.description      or ""),
						price         = emote.price,
						priceStatus   = tostring(emote.priceStatus      or ""),
						favoriteCount = emote.favoriteCount,
						createdUtc    = tostring(emote.itemCreatedUtc   or ""),
					}
				end
			end
		end
	end
	
	if #Emotes == 0 then
		Emotes = {
			{name = "Wave", id = 3576686446},
			{name = "Point", id = 3576823880},
			{name = "Dance", id = 3576720708},
			{name = "Laugh", id = 3576777185},
			{name = "Cheer", id = 3576738018}
		}
	end
end

LoadEmotes()

-- Build lookup table for O(1) emote access by ID
for _, emote in ipairs(Emotes) do
	EmotesById[emote.id] = emote
end
TweenService:Create(loadingBar, TweenInfo.new(1), {Size = UDim2.new(1, 0, 1, 0)}):Play()
task.wait(1)

loadingLbl.Text = utf8.char(0x2705) .. " " .. #Emotes .. " emotes!"
task.wait(1)

TweenService:Create(splash, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(splashBox, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), Rotation = 720}):Play()
task.wait(0.5)
splash:Destroy()

-- ===============================================================
-- UI SIZE SETTINGS
-- ===============================================================
local ICON_SCALE = 1.5     -- İkonların resim boyutu (1.0 = normal, 1.5 = %50 daha büyük)
local BUTTON_SCALE = 1.1   -- Kırpılmayı önlemek için buton kutusunu büyütme (1.0 = normal)
local FONT_SCALE = 1.2     -- Yazı karakteri ve zar/menü sembol boyutu

-- ===============================================================
-- VARIABLES
-- ===============================================================

local EMOTE_ICON = "rbxassetid://120313093991132"
local currentData, filtered = Emotes, Emotes
local currentTab = "emotes"
local page, perPage, pages, cols = 1, 14, 1, 7 -- Default to 7 cols
local cards = {}
local sideBarW = math.floor((isMobile and 50 or 60) * BUTTON_SCALE)
local bottomBarH = isMobile and 26 or 22
local currentCardSize = 0 -- Dynamic card size

-- ===============================================================
-- FAVORITES & RECENT
-- ===============================================================

local function IsFavorite(id)
	return FavoritesSet[tonumber(id)] == true
end

local MAX_FAVORITES = 25

local function ToggleFavorite(id)
	id = tonumber(id)
	if FavoritesSet[id] then
		FavoritesSet[id] = nil
		for i = #Favorites, 1, -1 do
			if Favorites[i] == id then
				table.remove(Favorites, i)
				break
			end
		end
		SaveData()
		return false
	end
	if #Favorites >= MAX_FAVORITES then
		Notify("⭐ " .. L.favLimit, "")
		return false
	end
	FavoritesSet[id] = true
	Favorites[#Favorites + 1] = id
	SaveData()
	return true
end

local function AddToRecent(id)
	id = tonumber(id)
	for i = #RecentEmotes, 1, -1 do
		if RecentEmotes[i] == id then
			table.remove(RecentEmotes, i)
		end
	end
	table.insert(RecentEmotes, 1, id)
	while #RecentEmotes > MAX_RECENT do
		table.remove(RecentEmotes)
	end
	SaveData()
end

-- ===============================================================
-- EMOTE & SPEED SYSTEM
-- ===============================================================

local currentAnimTrack = nil
local lastEmoteTime = 0

local function GetAnimator()
	local character = player.Character
	if not character then return nil end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return nil end
	local animator = humanoid:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end
	return animator
end

local function StopAllTracks()
	local animator = GetAnimator()
	if animator then
		for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
			pcall(function() 
				track:Stop(0.1)
			end)
		end
	end
	currentAnimTrack = nil
end

local function ApplySpeedToAllTracks()
	local animator = GetAnimator()
	if animator then
		for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
			pcall(function() track:AdjustSpeed(Settings.speed) end)
		end
	end
end


local function StopEmote(showNotif)
	StopAllTracks()
	if showNotif then Notify(L.stopped, "", 113416463749658) end
	if getgenv().VexroBroadcastStop then
		pcall(getgenv().VexroBroadcastStop)
	end
end

local _heartbeatConn = RunService.Heartbeat:Connect(function()
	if Settings.stopOnWalk and currentAnimTrack and currentAnimTrack.IsPlaying then
		local character = player.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.MoveDirection.Magnitude > 0 then
				StopEmote(false)
			end
		end
	end
end)

-- Animation objesi cache (her emote ID için bir kez GetObjects çağrılır, lag önlenir)
local _animCache = {}

local function PlayEmote(id, name, silent)
	local animator = GetAnimator()
	if not animator then return end
	
	-- FIX: Yeni emote çalmadan önce eski emoteyi durdur (hareket etmeden geçişte takılmayı önler)
	StopAllTracks()
	
	-- MODIFIED: Save last played emote for Auto-Reload (Continue)
	getgenv().lastVexroEmote = {id = id, name = name}
	
	-- FIX: Catalog ID'leri direkt LoadAnimation ile çalışmadığı için game:GetObjects ile asıl Animation'ı çekiyoruz.
	-- Cache kullanarak tekrarlanan çağrılardan kaynaklanan kasılmayı önlüyoruz.
	local success, err = pcall(function()
		local anim = _animCache[id]
		
		if not anim then
			local successObj, objects = pcall(function()
				return game:GetObjects("rbxassetid://" .. id)
			end)
			
			if successObj and objects and #objects > 0 then
				local item = objects[1]
				if item:IsA("Animation") then
					anim = item
				else
					-- Folder içindeki asıl Animation objesini bul (Face animasyonları yerine vücudu bulur)
					anim = item:FindFirstChildWhichIsA("Animation", true)
				end
			end
			
			-- Eğer exploit GetObjects desteklemiyorsa veya çalışmazsa normal şekilde dene
			if not anim then
				anim = Instance.new("Animation")
				anim.AnimationId = "rbxassetid://" .. id
			end
			
			_animCache[id] = anim
		end
		
		local track = animator:LoadAnimation(anim)
		track.Priority = Enum.AnimationPriority.Action4
		track.Looped = Settings.loopEmote
		track:Play(0.1)
		
		task.delay(0.05, function()
			track:AdjustSpeed(Settings.speed)
		end)
		
		currentAnimTrack = track
		AddToRecent(id)
	end)
	
	if success then
		if not silent then
			local speedTxt = Settings.speed ~= 1 and " (" .. Settings.speed .. "x)" or ""
			Notify(L.playing .. speedTxt, name, 129338178452237)
		end
		lastEmoteTime = tick()
		-- Arkadaşlara sync gönder
		if getgenv().VexroBroadcastSync then
			pcall(getgenv().VexroBroadcastSync, id, name)
		end
	else
		Notify(utf8.char(0x274C), "Emote yüklenemedi!")
	end
end

-- ===============================================================
-- MAIN MENU
-- ===============================================================

-- TARGET CARD SIZES (Made larger for better visibility)
local TARGET_PC_CARD = 75 -- Was 75
local TARGET_MOBILE_CARD = 55 -- Was 55

local function GetDefaultSize()
	-- Calculate width needed for 7 columns exactly + padding
	local PAD = isMobile and 4 or 6
	local targetCard = isMobile and TARGET_MOBILE_CARD or TARGET_PC_CARD
	
	-- Width for 7 cards + sidebar
	local perfectWidth = (targetCard * 7) + (PAD * 6) + sideBarW + 20
	
	local vp = workspace.CurrentCamera.ViewportSize
	local finalW = math.clamp(perfectWidth, 400, vp.X * 0.95)
	
	-- Height for 2 rows approx
	local cardH = targetCard + (targetCard * 0.3 * 2) + PAD -- approx card total height
	local perfectHeight = (cardH * 2) + 60 + bottomBarH + 20
	
	local finalH = math.clamp(perfectHeight, 300, vp.Y * 0.8)
	
	return UDim2.new(0, finalW, 0, finalH)
end

local main = Instance.new("Frame")
main.Name = "MainMenu"
main.Size = UDim2.new(0, 0, 0, 0)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = currentTheme.primary
main.BackgroundTransparency = 0 -- Saydamlığı kaldırdık ki içi dolsun
main.ClipsDescendants = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 20) -- Daha yumuşak köşeler
RegisterTheme(main, "BackgroundColor3", "primary")

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.new(1, 1, 1) -- Gradient kullanılacak
mainStroke.Thickness = 3
mainStroke.Transparency = 0
mainStroke.Parent = main

mainStrokeGrad = Instance.new("UIGradient")
mainStrokeGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, currentTheme.stroke),
	ColorSequenceKeypoint.new(0.33, currentTheme.accent),
	ColorSequenceKeypoint.new(0.66, currentTheme.stroke),
	ColorSequenceKeypoint.new(1, currentTheme.accent)
}
mainStrokeGrad.Parent = mainStroke

-- Animasyonu başlat
task.spawn(function()
	local rot = 0
	while mainStroke.Parent do
		rot = rot + 360
		TweenService:Create(mainStrokeGrad, TweenInfo.new(2, Enum.EasingStyle.Linear), {Rotation = rot}):Play()
		task.wait(2)
	end
end)

-- Background Particles
local bgParticles = Instance.new("Frame")
bgParticles.Name = "BgParticles"
bgParticles.Size = UDim2.new(1, 0, 1, 0)
bgParticles.BackgroundTransparency = 1
bgParticles.ZIndex = 1
bgParticles.Parent = main

for i = 1, 20 do
	local particle = Instance.new("Frame")
	local s = math.random(5, 12)
	particle.Size = UDim2.new(0, s, 0, s)
	particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
	particle.BackgroundColor3 = currentTheme.accent
	particle.BackgroundTransparency = math.random(4, 8) / 10
	particle.ZIndex = 1
	particle.Parent = bgParticles
	Instance.new("UICorner", particle).CornerRadius = UDim.new(1, 0)
	
	RegisterTheme(particle, "BackgroundColor3", "accent")
	
	task.spawn(function()
		while particle.Parent do
			TweenService:Create(particle, TweenInfo.new(math.random(4, 8), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				Position = UDim2.new(math.random(), 0, math.random(), 0)
			}):Play()
			task.wait(math.random(4, 8))
		end
	end)
end

-- ===============================================================
-- SIDEBAR
-- ===============================================================

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, sideBarW, 1, 0)
sidebar.BackgroundColor3 = currentTheme.sidebar
sidebar.ZIndex = 8
sidebar.Parent = main
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 14)
RegisterTheme(sidebar, "BackgroundColor3", "sidebar")

local sideOverlay = Instance.new("Frame")
sideOverlay.Size = UDim2.new(0, 10, 1, 0)
sideOverlay.Position = UDim2.new(1, -10, 0, 0)
sideOverlay.BackgroundColor3 = currentTheme.sidebar
sideOverlay.BorderSizePixel = 0
sideOverlay.ZIndex = 7
sideOverlay.Parent = sidebar
RegisterTheme(sideOverlay, "BackgroundColor3", "sidebar")

local tabBtns = {}
local tabBtnS = math.floor((isMobile and 40 or 48) * BUTTON_SCALE)

local function CreateTabBtn(icon, tabName, yPos, customScale)
	local isUrl = type(icon) == "string" and (string.find(icon, "rbxassetid://") or string.find(icon, "http") or string.find(icon, "rbxthumb://"))
	
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, tabBtnS, 0, tabBtnS)
	btn.Position = UDim2.new(0.5, -tabBtnS/2, 0, yPos)
	btn.BackgroundColor3 = currentTheme.sidebar
	btn.BackgroundTransparency = 0.8
	btn.Text = ""
	btn.TextSize = isMobile and 28 or 34
	btn.Font = Enum.Font.GothamBold
	btn.TextColor3 = currentTheme.text
	btn.ZIndex = 9
	btn.Parent = sidebar
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = currentTheme.sidebar
	stroke.Thickness = 2
	stroke.Transparency = 0.7
	stroke.Parent = btn
	
	local imgElement = nil
	if isUrl then
		local img = Instance.new("ImageLabel")
		local s = (tabName == "emotes") and 0.85 or (0.95 * ICON_SCALE)
		img.Size = UDim2.fromScale(s, s)
		img.Position = UDim2.fromScale(0.5, 0.5)
		img.AnchorPoint = Vector2.new(0.5, 0.5)
		img.BackgroundTransparency = 1
		img.Image = ResolveAssetImage(icon)
		img.ImageColor3 = currentTheme.text
		img.ZIndex = 110
		img.Parent = btn
		RegisterTheme(img, "ImageColor3", "text")
		imgElement = img
	else
		btn.Text = icon
		RegisterTheme(btn, "TextColor3", "text")
	end
	
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.4, Size = UDim2.new(0, tabBtnS + 4, 0, tabBtnS + 4)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		local active = currentTab == tabName
		TweenService:Create(btn, TweenInfo.new(0.15), {
			BackgroundTransparency = active and 0.2 or 0.8,
			Size = UDim2.new(0, tabBtnS, 0, tabBtnS)
		}):Play()
	end)
	
	-- Quatrefoil indicator (MaterialYou theme - asset tabanlı)
	local qSize = tabBtnS + 10
	local quatrefoil = Instance.new("ImageLabel")
	quatrefoil.Name = "Quatrefoil"
	quatrefoil.Size = UDim2.new(0, qSize, 0, qSize)
	quatrefoil.Position = UDim2.new(0.5, -qSize/2, 0, yPos + tabBtnS/2 - qSize/2)
	quatrefoil.BackgroundTransparency = 1
	quatrefoil.Image = ResolveAssetImage(Icons.Quatrefoil)
	quatrefoil.ImageColor3 = currentTheme.accent
	quatrefoil.ImageTransparency = 0.3
	quatrefoil.ScaleType = Enum.ScaleType.Fit
	quatrefoil.ZIndex = 9
	quatrefoil.Visible = false
	quatrefoil.Parent = sidebar
	
	tabBtns[tabName] = {btn = btn, stroke = stroke, img = imgElement, quatrefoil = quatrefoil}
	return btn
end

CreateTabBtn(Icons.Emote, "emotes", 8)
CreateTabBtn(Icons.FavoriteFull, "favorites", 8 + tabBtnS + 6)
CreateTabBtn(Icons.Recent, "recent", 8 + (tabBtnS + 6) * 2)
CreateTabBtn(Icons.Settings, "settings", 8 + (tabBtnS + 6) * 3)
CreateTabBtn("rbxassetid://115725480722697", "friends", 8 + (tabBtnS + 6) * 4)

-- ===============================================================
-- CONTENT
-- ===============================================================

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -sideBarW, 1, 0)
content.Position = UDim2.new(0, sideBarW, 0, 0)
content.BackgroundTransparency = 1
content.Parent = main

local titleH = isMobile and 38 or 46
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, titleH)
titleBar.BackgroundColor3 = currentTheme.secondary
titleBar.ZIndex = 5
titleBar.Parent = content
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 14)
RegisterTheme(titleBar, "BackgroundColor3", "secondary")

local titleOverlay = Instance.new("Frame")
titleOverlay.Size = UDim2.new(0, 14, 1, 0)
titleOverlay.BackgroundColor3 = currentTheme.secondary
titleOverlay.BorderSizePixel = 0
titleOverlay.ZIndex = 4
titleOverlay.Parent = titleBar
RegisterTheme(titleOverlay, "BackgroundColor3", "secondary")

local titleIconSz = math.floor((isMobile and 32 or 36) * ICON_SCALE)
local titleIcon = Instance.new("ImageLabel")
titleIcon.Size = UDim2.new(0, titleIconSz, 0, titleIconSz)
titleIcon.Position = UDim2.new(0, 10, 0.5, 0)
titleIcon.AnchorPoint = Vector2.new(0, 0.5)
titleIcon.BackgroundTransparency = 1
titleIcon.Image = ResolveAssetImage(Icons.Emote)
titleIcon.ImageColor3 = currentTheme.text
titleIcon.ZIndex = 6
titleIcon.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -160, 1, 0)
title.Position = UDim2.new(0, 10 + titleIconSz + 6, 0, 0)
title.BackgroundTransparency = 1
title.Text = L.emotes
title.TextColor3 = currentTheme.text
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 5
title.Parent = titleBar
Instance.new("UITextSizeConstraint", title).MaxTextSize = isMobile and 16 or 20
RegisterTheme(title, "TextColor3", "text")

local btnS = math.floor((isMobile and 28 or 36) * BUTTON_SCALE)

local function MakeBtn(icon, px, colorKey, customSize)
	local s = customSize or btnS
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0, s, 0, s)
	b.Position = UDim2.new(1, px, 0.5, -s/2)
	b.BackgroundColor3 = currentTheme.tertiary
	b.Text = ""
	b.ZIndex = 10
	b.Parent = titleBar
	Instance.new("UICorner", b).CornerRadius = UDim.new(0.25, 0)
	
	local useWhite = (colorKey == "critical" or colorKey == "accent" or colorKey == "success")
	
	local isImg = type(icon) == "string" and (string.find(icon, "rbxassetid://") or string.find(icon, "http") or string.find(icon, "rbxthumb://"))
	if isImg then
		local img = Instance.new("ImageLabel")
		img.Size = UDim2.new(0, math.floor(42 * ICON_SCALE), 0, math.floor(42 * ICON_SCALE))
		img.Position = UDim2.new(0.5, 0, 0.5, 0)
		img.AnchorPoint = Vector2.new(0.5, 0.5)
		img.BackgroundTransparency = 1
		img.Parent = b
		img.Image = ResolveAssetImage(icon)
		img.ImageColor3 = useWhite and Color3.new(1, 1, 1) or currentTheme.text
		img.ZIndex = 110
		if not useWhite then
			RegisterTheme(img, "ImageColor3", "text")
		end
	else
		-- Minus için bold metin kullan (Görünürlük için en iyisi)
		if icon == "STOP_SHAPE" then
			b.Text = ""
			local sq = Instance.new("ImageLabel")
			sq.Size = UDim2.new(0.75, 0, 0.75, 0)
			sq.Position = UDim2.new(0.5, 0, 0.5, 0)
			sq.AnchorPoint = Vector2.new(0.5, 0.5)
			sq.BackgroundTransparency = 1
			sq.Image = ResolveAssetImage("rbxassetid://113416463749658")
			sq.ImageColor3 = Color3.new(1, 1, 1)
			sq.ScaleType = Enum.ScaleType.Fit
			sq.ZIndex = 110
			sq.Parent = b
		elseif icon == "CLOSE_SHAPE" then
			b.Text = ""
			local line1 = Instance.new("Frame")
			line1.BorderSizePixel = 0
			line1.Size = UDim2.new(0.40, 0, 0, math.floor(2 * math.max(1, ICON_SCALE))) -- Fixed: Reduced X size
			line1.Position = UDim2.new(0.5, 0, 0.5, 0)
			line1.AnchorPoint = Vector2.new(0.5, 0.5)
			line1.Rotation = 45
			line1.BackgroundColor3 = useWhite and Color3.new(1, 1, 1) or currentTheme.text
			line1.ZIndex = 110
			line1.Parent = b
			Instance.new("UICorner", line1).CornerRadius = UDim.new(0, 2)
			
			local line2 = line1:Clone()
			line2.Rotation = -45
			line2.Parent = b
			
			if not useWhite then
				RegisterTheme(line1, "BackgroundColor3", "text")
				RegisterTheme(line2, "BackgroundColor3", "text")
			end
		elseif icon == Icons.Minus or icon == "-" then
			b.Text = ""
			local line = Instance.new("Frame")
			line.BorderSizePixel = 0
			line.Size = UDim2.new(0.40, 0, 0, math.floor(2 * math.max(1, ICON_SCALE))) -- Fixed: Reduced Minus size
			line.Position = UDim2.new(0.5, 0, 0.5, 0)
			line.AnchorPoint = Vector2.new(0.5, 0.5)
			line.BackgroundColor3 = useWhite and Color3.new(1, 1, 1) or currentTheme.text
			line.ZIndex = 110
			line.Parent = b
			Instance.new("UICorner", line).CornerRadius = UDim.new(0, 2)
			if not useWhite then
				RegisterTheme(line, "BackgroundColor3", "text")
			end
		elseif icon == Icons.Sort then
			b.Text = icon
			b.TextSize = math.floor((isMobile and 32 or 46) * FONT_SCALE)
		else
			b.Text = icon
			b.TextSize = math.floor((isMobile and 12 or 16) * FONT_SCALE)
		end
		b.TextColor3 = useWhite and Color3.new(1, 1, 1) or currentTheme.text
		b.Font = Enum.Font.GothamBlack
		if not useWhite then
			RegisterTheme(b, "TextColor3", "text")
		end
	end

	b.MouseEnter:Connect(function()
		local s = customSize or btnS
		TweenService:Create(b, TweenInfo.new(0.1), {
			Size = UDim2.new(0, s + 4, 0, s + 4),
			Position = UDim2.new(1, px - 2, 0.5, -(s + 4)/2)
		}):Play()
	end)
	b.MouseLeave:Connect(function()
		local s = customSize or btnS
		TweenService:Create(b, TweenInfo.new(0.1), {
			Size = UDim2.new(0, s, 0, s),
			Position = UDim2.new(1, px, 0.5, -s/2)
		}):Play()
	end)
	return b
end

local copyEmoteBtn = MakeBtn("rbxassetid://77508802666652", -(btnS*5 + 24), "critical")
local stopBtn = MakeBtn("STOP_SHAPE", -(btnS*4 + 18), "critical")
local randBtn = MakeBtn(Icons.Sort, -(btnS*3 + 12), "accent")
local minBtn = MakeBtn("-", -(btnS*2 + 6), "textDim")
local closeBtn = MakeBtn("CLOSE_SHAPE", -(btnS + 2), "critical")

if Settings.copyEmoteEnabled then
	RegisterTheme(copyEmoteBtn, "BackgroundColor3", "success")
else
	RegisterTheme(copyEmoteBtn, "BackgroundColor3", "critical")
end
RegisterTheme(stopBtn, "BackgroundColor3", "critical")
RegisterTheme(randBtn, "BackgroundColor3", "accent")
RegisterTheme(minBtn, "BackgroundColor3", "stroke")
RegisterTheme(closeBtn, "BackgroundColor3", "critical")

local _isPaused = false
-- stopBtn içindeki stop karesi (duraklat/devam durumuna göre gizlenir)
local _stopBtnSquare = stopBtn:FindFirstChildWhichIsA("ImageLabel")

local _pauseTextSize = math.floor((isMobile and 14 or 18) * (ICON_SCALE or 1))

local function _SetPauseState(paused)
	_isPaused = paused
	-- stopBtn görselini güncelle: duraklat = kare gizli + ">" yaz, devam = kare göster
	if _stopBtnSquare then
		_stopBtnSquare.Image = paused and ResolveAssetImage("rbxassetid://129338178452237") or ResolveAssetImage("rbxassetid://113416463749658")
	end
	-- HUD duraklat butonunu güncelle (bridge)
	if _onPauseStateChanged then _onPauseStateChanged(paused) end
end

stopBtn.MouseButton1Click:Connect(function()
	-- Onceligi duraklat halini kontrol etmeye ver (hiz=0 oldugu icin IsPlaying hala true)
	if currentAnimTrack and _isPaused then
		-- Duraklatilmissa devam ettir
		pcall(function() currentAnimTrack:AdjustSpeed(Settings.speed) end)
		_SetPauseState(false)
	elseif currentAnimTrack and currentAnimTrack.IsPlaying then
		-- Calan emoteyi mevcut pozisyonda dondur (hiz=0)
		pcall(function() currentAnimTrack:AdjustSpeed(0) end)
		_SetPauseState(true)
	else
		StopEmote(true)
	end
end)
randBtn.MouseButton1Click:Connect(function()
	if #currentData > 0 then
		local r = currentData[math.random(#currentData)]
		local speedTxt = Settings.speed ~= 1 and " (" .. Settings.speed .. "x)" or ""
		Notify("[~] " .. L.playing .. speedTxt, r.name)
		PlayEmote(r.id, r.name, true) -- Passing true to silence the default notification
	end
end)

local searchH = isMobile and 32 or 38
local search = Instance.new("TextBox")
search.Size = UDim2.new(1, -16, 0, searchH)
search.Position = UDim2.new(0, 8, 0, titleH + 6)
search.BackgroundColor3 = currentTheme.tertiary
search.PlaceholderText = L.search
search.PlaceholderColor3 = currentTheme.textDim
search.Text = ""
search.TextColor3 = currentTheme.text
search.TextSize = isMobile and 13 or 15
search.Font = Enum.Font.Gotham
search.ZIndex = 5
search.ClearTextOnFocus = false
search.Parent = content
Instance.new("UICorner", search).CornerRadius = UDim.new(0, 10)
Instance.new("UIPadding", search).PaddingLeft = UDim.new(0, 10)
RegisterTheme(search, "BackgroundColor3", "tertiary")
RegisterTheme(search, "TextColor3", "text")

local pageH = isMobile and 30 or 36
local pageBar = Instance.new("Frame")
pageBar.Size = UDim2.new(1, -16, 0, pageH)
pageBar.Position = UDim2.new(0, 8, 1, -(pageH + bottomBarH + 8))
pageBar.BackgroundColor3 = currentTheme.secondary
pageBar.ZIndex = 5
pageBar.Parent = content
Instance.new("UICorner", pageBar).CornerRadius = UDim.new(0, 10)
RegisterTheme(pageBar, "BackgroundColor3", "secondary")

local pageBtnW = isMobile and 45 or 60

local prevBtn = Instance.new("TextButton")
prevBtn.Size = UDim2.new(0, pageBtnW, 1, -4)
prevBtn.Position = UDim2.new(0, 2, 0, 2)
prevBtn.BackgroundColor3 = currentTheme.accent
prevBtn.Text = ""
prevBtn.ZIndex = 6
prevBtn.Parent = pageBar
Instance.new("UICorner", prevBtn).CornerRadius = UDim.new(0, 8)
RegisterTheme(prevBtn, "BackgroundColor3", "accent")

local function CreateChevron(parent, isNext)
	local container = Instance.new("Frame")
	container.Name = "ChevronIcon"
	container.Size = UDim2.new(1, 0, 1, 0)
	container.BackgroundTransparency = 1
	container.ZIndex = 7
	container.Parent = parent
	
	local effScale = math.min(ICON_SCALE, 1.4)
	local len = math.floor(14 * effScale)
	local thick = math.floor(1.6 * math.max(1, effScale))
	local offset = math.floor(len * 0.353)
	
	local tipX = isNext and offset or -offset
	local dx = isNext and -offset or offset
	
	local topL = Instance.new("Frame")
	topL.BorderSizePixel = 0
	topL.Size = UDim2.new(0, len, 0, thick)
	topL.AnchorPoint = Vector2.new(0.5, 0.5)
	topL.Position = UDim2.new(0.5, tipX + dx, 0.5, -offset)
	topL.Rotation = isNext and 45 or -45
	topL.BackgroundColor3 = Color3.new(1, 1, 1)
	topL.ZIndex = 7
	topL.Parent = container
	Instance.new("UICorner", topL).CornerRadius = UDim.new(0, 2)
	
	local botL = Instance.new("Frame")
	botL.BorderSizePixel = 0
	botL.Size = UDim2.new(0, len, 0, thick)
	botL.AnchorPoint = Vector2.new(0.5, 0.5)
	botL.Position = UDim2.new(0.5, tipX + dx, 0.5, offset)
	botL.Rotation = isNext and -45 or 45
	botL.BackgroundColor3 = Color3.new(1, 1, 1)
	botL.ZIndex = 7
	botL.Parent = container
	Instance.new("UICorner", botL).CornerRadius = UDim.new(0, 2)
end

local nextBtn = prevBtn:Clone()
nextBtn.Position = UDim2.new(1, -(pageBtnW + 2), 0, 2)
nextBtn.Parent = pageBar

CreateChevron(prevBtn, false)
CreateChevron(nextBtn, true)
RegisterTheme(nextBtn, "BackgroundColor3", "accent")

local pageNum = Instance.new("TextLabel")
pageNum.Size = UDim2.new(1, -(pageBtnW*2 + 16), 1, 0)
pageNum.Position = UDim2.new(0, pageBtnW + 8, 0, 0)
pageNum.BackgroundTransparency = 1
pageNum.Text = "1/1"
pageNum.TextColor3 = currentTheme.textDim
pageNum.Font = Enum.Font.GothamBold
pageNum.TextScaled = true
pageNum.ZIndex = 6
pageNum.Parent = pageBar
RegisterTheme(pageNum, "TextColor3", "textDim")

local emptyLbl = Instance.new("TextLabel")
emptyLbl.Size = UDim2.new(1, -20, 0, 50)
emptyLbl.Position = UDim2.fromScale(0.5, 0.45)
emptyLbl.AnchorPoint = Vector2.new(0.5, 0.5)
emptyLbl.BackgroundTransparency = 1
emptyLbl.Text = ""
emptyLbl.TextColor3 = currentTheme.textDim
emptyLbl.Font = Enum.Font.GothamBold
emptyLbl.TextScaled = true
emptyLbl.Visible = false
emptyLbl.ZIndex = 5
emptyLbl.Parent = content
RegisterTheme(emptyLbl, "TextColor3", "textDim")

-- ===============================================================
-- SETTINGS PANEL
-- ===============================================================

local settingsPanel = Instance.new("ScrollingFrame")
settingsPanel.Size = UDim2.new(1, -16, 1, -(titleH + bottomBarH + 20))
settingsPanel.Position = UDim2.new(0, 8, 0, titleH + 8)
settingsPanel.BackgroundTransparency = 1
settingsPanel.ScrollBarThickness = isMobile and 6 or 4
settingsPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
settingsPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
settingsPanel.Visible = false
settingsPanel.ZIndex = 5
settingsPanel.Parent = content

local settingsLayout = Instance.new("UIListLayout")
settingsLayout.Padding = UDim.new(0, 10)
settingsLayout.Parent = settingsPanel

local function MakeSettingRow(imgId, txt, order, height)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, height or 50)
	row.BackgroundColor3 = currentTheme.tertiary
	row.LayoutOrder = order
	row.ZIndex = 6
	row.Parent = settingsPanel
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 12)
	RegisterTheme(row, "BackgroundColor3", "tertiary")
	
	local iconSize = 0
	if imgId and imgId ~= "" then
		iconSize = math.floor(44 * ICON_SCALE)
		local rowH = height or 50
		iconSize = math.min(iconSize, rowH - 6) 
		
		local icon = Instance.new("ImageLabel")
		icon.Size = UDim2.new(0, iconSize, 0, iconSize)
		icon.AnchorPoint = Vector2.new(0, 0.5)
		icon.Position = UDim2.new(0, 12, 0.5, 0)
		icon.BackgroundTransparency = 1
		icon.Image = "rbxassetid://" .. imgId
		icon.ImageColor3 = currentTheme.text
		icon.ZIndex = 7
		icon.Parent = row
		RegisterTheme(icon, "ImageColor3", "text")
	end
	
	local lblOffset = iconSize > 0 and (12 + iconSize + 10) or 12
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(0.5, -lblOffset, 1, 0)
	lbl.Position = UDim2.new(0, lblOffset, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text = txt
	lbl.TextColor3 = currentTheme.text
	lbl.Font = Enum.Font.GothamBold
	lbl.TextSize = isMobile and 13 or 15
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.ZIndex = 7
	lbl.Parent = row
	RegisterTheme(lbl, "TextColor3", "text")
	
	return row, lbl
end

local themeNames = {"Dark", "Purple", "Blue", "Green", "Red", "Light", "MaterialYou"}
do
	local themeRow = MakeSettingRow("110192525313214", L.theme, 1)
	local themeBtn = Instance.new("TextButton")
	themeBtn.Size = UDim2.new(0.4, 0, 0, 36)
	themeBtn.Position = UDim2.new(0.56, 0, 0.5, -18)
	themeBtn.BackgroundColor3 = currentTheme.accent
	themeBtn.Text = Settings.theme
	themeBtn.TextColor3 = Color3.new(1, 1, 1)
	themeBtn.Font = Enum.Font.GothamBold
	themeBtn.TextSize = isMobile and 12 or 14
	themeBtn.ZIndex = 8
	themeBtn.Parent = themeRow
	Instance.new("UICorner", themeBtn).CornerRadius = UDim.new(0, 10)
	RegisterTheme(themeBtn, "BackgroundColor3", "accent")

	local themeIdx = 1
	for i, n in ipairs(themeNames) do if n == Settings.theme then themeIdx = i end end

	themeBtn.MouseButton1Click:Connect(function()
		themeIdx = themeIdx % #themeNames + 1
		Settings.theme = themeNames[themeIdx]
		themeBtn.Text = Settings.theme
		ApplyTheme(Settings.theme)
		SaveData()
	end)
end -- theme row scope

-- --- SPEED SLIDER SECTION ---
do
	local speedRow, speedTitle = MakeSettingRow("113837085020684", L.speed, 2, 70)
	speedTitle.Size = UDim2.new(0.2, 0, 0, 30) -- Shrink title to allow slider space
	speedTitle.TextYAlignment = Enum.TextYAlignment.Center
	local speedIcon = speedRow:FindFirstChildOfClass("ImageLabel")
	if speedIcon then speedIcon.Position = UDim2.new(0, 4, 0.5, 0) end

	local speeds = {0.25, 0.5, 0.75, 1, 1.25, 1.5, 2, 3}
	local speedIdx = 4
	for i, s in ipairs(speeds) do if s == Settings.speed then speedIdx = i end end

	local speedValueLbl = Instance.new("TextLabel")
	speedValueLbl.Size = UDim2.new(1, 0, 0, 20)
	speedValueLbl.Position = UDim2.new(0, 0, 0, 5)
	speedValueLbl.BackgroundTransparency = 1
	speedValueLbl.Text = Settings.speed .. "x"
	speedValueLbl.TextColor3 = currentTheme.accent
	speedValueLbl.Font = Enum.Font.GothamBlack
	speedValueLbl.TextSize = 16
	speedValueLbl.ZIndex = 7
	speedValueLbl.Parent = speedRow
	RegisterTheme(speedValueLbl, "TextColor3", "accent")

	local speedMinus = Instance.new("TextButton")
	speedMinus.Size = UDim2.new(0, 30, 0, 30)
	speedMinus.Position = UDim2.new(0.1, 0, 0, 30)
	speedMinus.BackgroundColor3 = currentTheme.critical
	speedMinus.Text = "-"
	speedMinus.TextColor3 = Color3.new(1, 1, 1)
	speedMinus.Font = Enum.Font.GothamBold
	speedMinus.TextSize = 20
	speedMinus.ZIndex = 8
	speedMinus.Parent = speedRow
	Instance.new("UICorner", speedMinus).CornerRadius = UDim.new(0, 8)
	RegisterTheme(speedMinus, "BackgroundColor3", "critical")

	local speedPlus = speedMinus:Clone()
	speedPlus.Position = UDim2.new(0.9, -30, 0, 30)
	speedPlus.BackgroundColor3 = currentTheme.success
	speedPlus.Text = "+"
	speedPlus.Parent = speedRow
	RegisterTheme(speedPlus, "BackgroundColor3", "success")

	-- SLIDER UI
	local sliderBg = Instance.new("Frame")
	sliderBg.Size = UDim2.new(0.6, 0, 0, 6)
	sliderBg.Position = UDim2.new(0.5, 0, 0, 42)
	sliderBg.AnchorPoint = Vector2.new(0.5, 0)
	sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	sliderBg.ZIndex = 8
	sliderBg.Parent = speedRow
	Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)

	local sliderFill = Instance.new("Frame")
	sliderFill.Size = UDim2.new(0.5, 0, 1, 0) -- Starts at half
	sliderFill.BackgroundColor3 = currentTheme.accent
	sliderFill.ZIndex = 9
	sliderFill.Parent = sliderBg
	Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)
	RegisterTheme(sliderFill, "BackgroundColor3", "accent")

	local sliderKnob = Instance.new("TextButton") -- Button for input
	sliderKnob.Size = UDim2.new(0, 16, 0, 16)
	sliderKnob.AnchorPoint = Vector2.new(0.5, 0.5)
	sliderKnob.Position = UDim2.new(0.5, 0, 0.5, 0)
	sliderKnob.BackgroundColor3 = Color3.new(1, 1, 1)
	sliderKnob.Text = ""
	sliderKnob.ZIndex = 10
	sliderKnob.Parent = sliderBg
	Instance.new("UICorner", sliderKnob).CornerRadius = UDim.new(1, 0)

	local function UpdateSpeedUI()
		Settings.speed = speeds[speedIdx]
		speedValueLbl.Text = Settings.speed .. "x"

		local alpha = (speedIdx - 1) / (#speeds - 1)
		TweenService:Create(sliderFill, TweenInfo.new(0.2), {Size = UDim2.new(alpha, 0, 1, 0)}):Play()
		TweenService:Create(sliderKnob, TweenInfo.new(0.2), {Position = UDim2.new(alpha, 0, 0.5, 0)}):Play()

		SaveData()
		ApplySpeedToAllTracks()
		if _onSpeedChanged then _onSpeedChanged() end
	end

	speedMinus.MouseButton1Click:Connect(function()
		if speedIdx > 1 then speedIdx = speedIdx - 1; UpdateSpeedUI() end
	end)
	speedPlus.MouseButton1Click:Connect(function()
		if speedIdx < #speeds then speedIdx = speedIdx + 1; UpdateSpeedUI() end
	end)

	local sliderDragging = false
	sliderKnob.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			sliderDragging = true
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			sliderDragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if sliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local mousePos = input.Position.X
			local startPos = sliderBg.AbsolutePosition.X
			local width = sliderBg.AbsoluteSize.X
			local alpha = math.clamp((mousePos - startPos) / width, 0, 1)

			local exactIdx = alpha * (#speeds - 1) + 1
			local newIdx = math.floor(exactIdx + 0.5)

			if newIdx ~= speedIdx then
				speedIdx = newIdx
				UpdateSpeedUI()
			end
		end
	end)

	UpdateSpeedUI() -- Init slider pos
end -- speed slider scope

do
	local notifRow = MakeSettingRow("99427666057293", L.notif, 3)
	local notifBtn = Instance.new("TextButton")
	notifBtn.Size = UDim2.new(0.4, 0, 0, 36)
	notifBtn.Position = UDim2.new(0.56, 0, 0.5, -18)
	notifBtn.BackgroundColor3 = Settings.notifications and currentTheme.success or currentTheme.critical
	notifBtn.Text = Settings.notifications and L.on or L.off
	notifBtn.TextColor3 = Color3.new(1, 1, 1)
	notifBtn.Font = Enum.Font.GothamBold
	notifBtn.TextSize = isMobile and 12 or 14
	notifBtn.ZIndex = 8
	notifBtn.Parent = notifRow
	Instance.new("UICorner", notifBtn).CornerRadius = UDim.new(0, 10)

	notifBtn.MouseButton1Click:Connect(function()
		Settings.notifications = not Settings.notifications
		notifBtn.Text = Settings.notifications and L.on or L.off
		TweenService:Create(notifBtn, TweenInfo.new(0.2), {
			BackgroundColor3 = Settings.notifications and currentTheme.success or currentTheme.critical
		}):Play()
		SaveData()
	end)
end -- notif row scope

do
	local contRow = MakeSettingRow("103179694587186", L.loopText or "Loop", 4)
	local contBtn = Instance.new("TextButton")
	contBtn.Size = UDim2.new(0.4, 0, 0, 36)
	contBtn.Position = UDim2.new(0.56, 0, 0.5, -18)
	contBtn.BackgroundColor3 = Settings.loopEmote and currentTheme.success or currentTheme.critical
	contBtn.Text = Settings.loopEmote and L.on or L.off
	contBtn.TextColor3 = Color3.new(1, 1, 1)
	contBtn.Font = Enum.Font.GothamBold
	contBtn.TextSize = isMobile and 12 or 14
	contBtn.ZIndex = 8
	contBtn.Parent = contRow
	Instance.new("UICorner", contBtn).CornerRadius = UDim.new(0, 10)

	contBtn.MouseButton1Click:Connect(function()
		Settings.loopEmote = not Settings.loopEmote
		getgenv().autoReloadEnabled_Vexro = Settings.loopEmote
		contBtn.Text = Settings.loopEmote and L.on or L.off
		TweenService:Create(contBtn, TweenInfo.new(0.2), {
			BackgroundColor3 = Settings.loopEmote and currentTheme.success or currentTheme.critical
		}):Play()
		SaveData()
	end)
end -- cont row scope

-- Yuruyunce Emote Dur ayari (do...end ile lokal sayisini sinirla)
do
	local stopOnWalkRow, stopOnWalkTitleLbl = MakeSettingRow("", L.stopOnWalk, 5, 68)
	stopOnWalkTitleLbl.Size     = UDim2.new(0.52, -12, 0, 24)
	stopOnWalkTitleLbl.Position = UDim2.new(0, 12, 0, 6)

	local stopOnWalkDescLbl = Instance.new("TextLabel")
	stopOnWalkDescLbl.Size                   = UDim2.new(0.52, -12, 0, 34)
	stopOnWalkDescLbl.Position               = UDim2.new(0, 12, 0, 28)
	stopOnWalkDescLbl.BackgroundTransparency = 1
	stopOnWalkDescLbl.Text                   = L.stopOnWalkDesc
	stopOnWalkDescLbl.TextColor3             = Color3.fromRGB(110, 110, 135)
	stopOnWalkDescLbl.Font                   = Enum.Font.Gotham
	stopOnWalkDescLbl.TextSize               = isMobile and 10 or 11
	stopOnWalkDescLbl.TextXAlignment         = Enum.TextXAlignment.Left
	stopOnWalkDescLbl.TextYAlignment         = Enum.TextYAlignment.Top
	stopOnWalkDescLbl.TextWrapped            = true
	stopOnWalkDescLbl.ZIndex                 = 7
	stopOnWalkDescLbl.Parent                 = stopOnWalkRow
	RegisterTheme(stopOnWalkDescLbl, "TextColor3", "textDim")

	local stopOnWalkBtn = Instance.new("TextButton")
	stopOnWalkBtn.Size             = UDim2.new(0.4, 0, 0, 36)
	stopOnWalkBtn.Position         = UDim2.new(0.56, 0, 0.5, -18)
	stopOnWalkBtn.BackgroundColor3 = Settings.stopOnWalk and currentTheme.success or currentTheme.critical
	stopOnWalkBtn.Text             = Settings.stopOnWalk and L.on or L.off
	stopOnWalkBtn.TextColor3       = Color3.new(1, 1, 1)
	stopOnWalkBtn.Font             = Enum.Font.GothamBold
	stopOnWalkBtn.TextSize         = isMobile and 12 or 14
	stopOnWalkBtn.ZIndex           = 8
	stopOnWalkBtn.Parent           = stopOnWalkRow
	Instance.new("UICorner", stopOnWalkBtn).CornerRadius = UDim.new(0, 10)

	stopOnWalkBtn.MouseButton1Click:Connect(function()
		Settings.stopOnWalk = not Settings.stopOnWalk
		stopOnWalkBtn.Text = Settings.stopOnWalk and L.on or L.off
		TweenService:Create(stopOnWalkBtn, TweenInfo.new(0.2), {
			BackgroundColor3 = Settings.stopOnWalk and currentTheme.success or currentTheme.critical
		}):Play()
		SaveData()
	end)
end

-- Oynatma Bari Goster ayari
do
	local showHUDRow, showHUDTitleLbl = MakeSettingRow("", L.showHUD, 6, 68)
	showHUDTitleLbl.Size     = UDim2.new(0.52, -12, 0, 24)
	showHUDTitleLbl.Position = UDim2.new(0, 12, 0, 6)

	local showHUDDescLbl = Instance.new("TextLabel")
	showHUDDescLbl.Size                   = UDim2.new(0.52, -12, 0, 34)
	showHUDDescLbl.Position               = UDim2.new(0, 12, 0, 28)
	showHUDDescLbl.BackgroundTransparency = 1
	showHUDDescLbl.Text                   = L.showHUDDesc
	showHUDDescLbl.TextColor3             = Color3.fromRGB(110, 110, 135)
	showHUDDescLbl.Font                   = Enum.Font.Gotham
	showHUDDescLbl.TextSize               = isMobile and 10 or 11
	showHUDDescLbl.TextXAlignment         = Enum.TextXAlignment.Left
	showHUDDescLbl.TextYAlignment         = Enum.TextYAlignment.Top
	showHUDDescLbl.TextWrapped            = true
	showHUDDescLbl.ZIndex                 = 7
	showHUDDescLbl.Parent                 = showHUDRow
	RegisterTheme(showHUDDescLbl, "TextColor3", "textDim")

	local showHUDBtn = Instance.new("TextButton")
	showHUDBtn.Size             = UDim2.new(0.4, 0, 0, 36)
	showHUDBtn.Position         = UDim2.new(0.56, 0, 0.5, -18)
	showHUDBtn.BackgroundColor3 = Settings.showHUD and currentTheme.success or currentTheme.critical
	showHUDBtn.Text             = Settings.showHUD and L.on or L.off
	showHUDBtn.TextColor3       = Color3.new(1, 1, 1)
	showHUDBtn.Font             = Enum.Font.GothamBold
	showHUDBtn.TextSize         = isMobile and 12 or 14
	showHUDBtn.ZIndex           = 8
	showHUDBtn.Parent           = showHUDRow
	Instance.new("UICorner", showHUDBtn).CornerRadius = UDim.new(0, 10)

	showHUDBtn.MouseButton1Click:Connect(function()
		Settings.showHUD = not Settings.showHUD
		showHUDBtn.Text = Settings.showHUD and L.on or L.off
		TweenService:Create(showHUDBtn, TweenInfo.new(0.2), {
			BackgroundColor3 = Settings.showHUD and currentTheme.success or currentTheme.critical
		}):Play()
		if not Settings.showHUD then HideEmoteHUD() end
		SaveData()
	end)
end

-- Reset Language butonu
do
	local langResetRow = MakeSettingRow("76975628127992", "Reset Language", 7)
	local langResetBtn = Instance.new("TextButton")
	langResetBtn.Size = UDim2.new(0.4, 0, 0, 36)
	langResetBtn.Position = UDim2.new(0.56, 0, 0.5, -18)
	langResetBtn.BackgroundColor3 = currentTheme.critical
	langResetBtn.Text = "Reset"
	langResetBtn.TextColor3 = Color3.new(1, 1, 1)
	langResetBtn.Font = Enum.Font.GothamBold
	langResetBtn.TextSize = isMobile and 12 or 14
	langResetBtn.ZIndex = 8
	langResetBtn.Parent = langResetRow
	Instance.new("UICorner", langResetBtn).CornerRadius = UDim.new(0, 10)
	RegisterTheme(langResetBtn, "BackgroundColor3", "critical")

	langResetBtn.MouseButton1Click:Connect(function()
		Settings.language = nil
		SaveData()
		gui:Destroy()
		pcall(function()
			if getgenv and getgenv().lastVexroEmote then
				getgenv().lastVexroEmote = nil
			end
		end)
		loadstring(game:HttpGet("https://raw.githubusercontent.com/zyrovell/Vexro/main/vexroemotes.lua"))()
	end)
end -- langReset row scope


local PROMPT_TAG = "VexroCopyEmotePrompt"

local function MakeCopyPrompt(targetChar)
	local root = targetChar:FindFirstChild("HumanoidRootPart")
	if not root then return end
	if root:FindFirstChild(PROMPT_TAG) then return end
	local prompt = Instance.new("ProximityPrompt")
	prompt.Name              = PROMPT_TAG
	prompt.ActionText        = L.copyEmote
	prompt.ObjectText        = ""
	prompt.MaxActivationDistance = 10
	prompt.HoldDuration      = 0
	prompt.RequiresLineOfSight = false
	prompt.Enabled           = true
	prompt.Parent            = root
	prompt.Triggered:Connect(function()
		local h = targetChar:FindFirstChildOfClass("Humanoid")
		if not h then return end
		local anim = h:FindFirstChildOfClass("Animator")
		if not anim then return end
		for _, track in ipairs(anim:GetPlayingAnimationTracks()) do
			local animId = tonumber(track.Animation.AnimationId:match("%d+"))
			if animId and EmotesById[animId] then
				PlayEmote(animId, EmotesById[animId].name)
				return
			end
		end
	end)
end

local function RemoveCopyPrompt(targetChar)
	local root = targetChar:FindFirstChild("HumanoidRootPart")
	if root then
		local p = root:FindFirstChild(PROMPT_TAG)
		if p then p:Destroy() end
	end
end

local _copyEmoteConns = {}

local function EnableCopyEmotePrompts()
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			MakeCopyPrompt(p.Character)
		end
	end
	_copyEmoteConns[#_copyEmoteConns + 1] = Players.PlayerAdded:Connect(function(p)
		_copyEmoteConns[#_copyEmoteConns + 1] = p.CharacterAdded:Connect(function(char)
			if Settings.copyEmoteEnabled then MakeCopyPrompt(char) end
		end)
	end)
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then
			_copyEmoteConns[#_copyEmoteConns + 1] = p.CharacterAdded:Connect(function(char)
				if Settings.copyEmoteEnabled then MakeCopyPrompt(char) end
			end)
		end
	end
end

local function DisableCopyEmotePrompts()
	for _, conn in ipairs(_copyEmoteConns) do conn:Disconnect() end
	_copyEmoteConns = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			RemoveCopyPrompt(p.Character)
		end
	end
end

if Settings.copyEmoteEnabled then
	EnableCopyEmotePrompts()
end

copyEmoteBtn.MouseButton1Click:Connect(function()
	Settings.copyEmoteEnabled = not Settings.copyEmoteEnabled
	TweenService:Create(copyEmoteBtn, TweenInfo.new(0.2), {
		BackgroundColor3 = Settings.copyEmoteEnabled and currentTheme.success or currentTheme.critical
	}):Play()
	if Settings.copyEmoteEnabled then
		EnableCopyEmotePrompts()
	else
		DisableCopyEmotePrompts()
	end
	SaveData()
end)

-- ===============================================================
-- ===============================================================
-- ARKADAŞ & BERABER EMOTE SİSTEMİ
-- ===============================================================
do
local ATTR_REQ  = "VFR_Req"   -- "<targetUserId>"
local ATTR_RESP = "VFR_Resp"  -- "<senderId>:1|0"
local ATTR_SYNC = "VFR_Sync"  -- "<emoteId>|<emoteName>"
local ATTR_STOP = "VFR_Stop"  -- tick() as string

-- Spam koruması
local REQ_COOLDOWN        = 5   -- aynı kişiye tekrar istek için bekleme (sn)
local REQ_SPAM_WINDOW     = 5   -- spam penceresi (sn)
local REQ_SPAM_LIMIT      = 3   -- bu kadar hızlı istek → timeout
local REQ_TIMEOUT_DUR     = 30  -- timeout süresi (sn)
local INCOMING_COOLDOWN   = 5   -- aynı kişiden gelen isteği tekrar gösterme eşiği (sn)

local _reqCooldowns      = {}   -- [targetUserId] = lastSendTime
local _reqSpamStart      = 0
local _reqSpamCount      = 0
local _reqTimeoutUntil   = 0   -- timeout bitiş zamanı
local _incomingCooldowns = {}  -- [senderUserId] = lastReceivedTime

-- Kaydet / Yükle
local function _SaveFriend()
	pcall(function()
		local enc = HttpService:JSONEncode({
			friends        = FriendData.friends,
			autoReject     = FriendData.autoReject,
			acceptRequests = FriendData.acceptRequests,
			playFriendEmote = FriendData.playFriendEmote,
			syncEmote      = FriendData.syncEmote,
		})
		getgenv().VexroFriendSave = enc
	end)
end

local function _LoadFriend()
	pcall(function()
		local raw = getgenv().VexroFriendSave
		if not raw then return end
		local ok, d = pcall(HttpService.JSONDecode, HttpService, raw)
		if not ok then return end
		FriendData.friends        = d.friends or {}
		FriendData.autoReject     = d.autoReject or false
		FriendData.acceptRequests = d.acceptRequests ~= false
		FriendData.playFriendEmote = d.playFriendEmote ~= false
		FriendData.syncEmote      = d.syncEmote ~= false
	end)
end
_LoadFriend()

-- Kendi karakterine attr yaz
local function _MyAttr(attr, val)
	pcall(function()
		local c = player.Character
		if c then c:SetAttribute(attr, val) end
	end)
end

-- Gelen istek paneli
ShowFriendRequestPanel = function(senderUserId, senderName)
	-- Arka plan karartıcı
	local dimmer = Instance.new("Frame")
	dimmer.Size = UDim2.new(1,0,1,0)
	dimmer.BackgroundColor3 = Color3.new(0,0,0)
	dimmer.BackgroundTransparency = 0.45
	dimmer.ZIndex = 98000
	dimmer.Parent = gui

	local panel = Instance.new("Frame")
	panel.Size = UDim2.new(0, 340, 0, 215)
	panel.AnchorPoint = Vector2.new(0.5, 0.5)
	panel.Position = UDim2.new(0.5, 0, 0.5, 0)
	panel.BackgroundColor3 = currentTheme.secondary
	panel.ZIndex = 98001
	panel.Parent = gui
	Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 16)
	local ps = Instance.new("UIStroke", panel); ps.Color = currentTheme.stroke; ps.Thickness = 1.5

	-- Brand
	local brand = Instance.new("TextLabel")
	brand.Size = UDim2.new(1, 0, 0, 20); brand.Position = UDim2.new(0,0,0,8)
	brand.BackgroundTransparency = 1; brand.Text = "Vexro Emote Player"
	brand.TextColor3 = currentTheme.accent; brand.Font = Enum.Font.GothamBold
	brand.TextSize = 11; brand.ZIndex = 98002; brand.Parent = panel

	-- Avatar
	local av = Instance.new("ImageLabel")
	av.Size = UDim2.new(0,48,0,48); av.Position = UDim2.new(0,14,0,34)
	av.BackgroundTransparency = 1
	av.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(senderUserId) .. "&w=150&h=150"
	av.ZIndex = 98002; av.Parent = panel
	Instance.new("UICorner", av).CornerRadius = UDim.new(1,0)

	-- İstek metni
	local reqTxt = Instance.new("TextLabel")
	reqTxt.Size = UDim2.new(1,-80,0,48); reqTxt.Position = UDim2.new(0,70,0,34)
	reqTxt.BackgroundTransparency = 1
	reqTxt.Text = tostring(senderName) .. " sizi arkadaş eklemek istiyor."
	reqTxt.TextColor3 = currentTheme.text; reqTxt.Font = Enum.Font.Gotham
	reqTxt.TextSize = 12; reqTxt.TextWrapped = true
	reqTxt.TextXAlignment = Enum.TextXAlignment.Left
	reqTxt.TextYAlignment = Enum.TextYAlignment.Center
	reqTxt.ZIndex = 98002; reqTxt.Parent = panel

	-- Otomatik reddet barı
	local bar = Instance.new("Frame")
	bar.Size = UDim2.new(1,-28,0,34); bar.Position = UDim2.new(0,14,0,90)
	bar.BackgroundColor3 = currentTheme.tertiary; bar.ZIndex = 98002; bar.Parent = panel
	Instance.new("UICorner", bar).CornerRadius = UDim.new(0,10)

	local cbBtn = Instance.new("TextButton")
	cbBtn.Size = UDim2.new(0,20,0,20); cbBtn.Position = UDim2.new(0,7,0.5,-10)
	cbBtn.BackgroundColor3 = currentTheme.secondary; cbBtn.Text = ""; cbBtn.ZIndex = 98003; cbBtn.Parent = bar
	Instance.new("UICorner", cbBtn).CornerRadius = UDim.new(1,0)
	local cbStroke = Instance.new("UIStroke", cbBtn); cbStroke.Color = currentTheme.stroke; cbStroke.Thickness = 1.5

	local cbDot = Instance.new("Frame")
	cbDot.Size = UDim2.new(0,10,0,10); cbDot.AnchorPoint = Vector2.new(0.5,0.5)
	cbDot.Position = UDim2.new(0.5,0,0.5,0); cbDot.BackgroundColor3 = currentTheme.accent
	cbDot.Visible = FriendData.autoReject; cbDot.ZIndex = 98004; cbDot.Parent = cbBtn
	Instance.new("UICorner", cbDot).CornerRadius = UDim.new(1,0)

	local autoLbl = Instance.new("TextLabel")
	autoLbl.Size = UDim2.new(1,-34,1,0); autoLbl.Position = UDim2.new(0,32,0,0)
	autoLbl.BackgroundTransparency = 1; autoLbl.Text = "Arkadaş isteklerini otomatik reddet."
	autoLbl.TextColor3 = currentTheme.textDim; autoLbl.Font = Enum.Font.Gotham
	autoLbl.TextSize = 11; autoLbl.TextXAlignment = Enum.TextXAlignment.Left
	autoLbl.ZIndex = 98003; autoLbl.Parent = bar

	cbBtn.MouseButton1Click:Connect(function()
		FriendData.autoReject = not FriendData.autoReject
		cbDot.Visible = FriendData.autoReject
		_SaveFriend()
	end)

	local function _close()
		pcall(function() dimmer:Destroy() end)
		pcall(function() panel:Destroy() end)
	end

	-- Reddet butonu
	local rejBtn = Instance.new("TextButton")
	rejBtn.Size = UDim2.new(0.46,0,0,40); rejBtn.Position = UDim2.new(0,14,0,138)
	rejBtn.BackgroundColor3 = currentTheme.critical; rejBtn.Text = L.reject or "Reddet"
	rejBtn.TextColor3 = Color3.new(1,1,1); rejBtn.Font = Enum.Font.GothamBold
	rejBtn.TextSize = 13; rejBtn.ZIndex = 98002; rejBtn.Parent = panel
	Instance.new("UICorner", rejBtn).CornerRadius = UDim.new(0,12)

	-- Kabul Et butonu
	local accBtn = Instance.new("TextButton")
	accBtn.Size = UDim2.new(0.46,0,0,40); accBtn.Position = UDim2.new(0.54,-14,0,138)
	accBtn.BackgroundColor3 = currentTheme.success; accBtn.Text = L.accept or "Kabul Et"
	accBtn.TextColor3 = Color3.new(1,1,1); accBtn.Font = Enum.Font.GothamBold
	accBtn.TextSize = 13; accBtn.ZIndex = 98002; accBtn.Parent = panel
	Instance.new("UICorner", accBtn).CornerRadius = UDim.new(0,12)

	rejBtn.MouseButton1Click:Connect(function()
		_MyAttr(ATTR_RESP, tostring(senderUserId) .. ":0")
		task.delay(1, function() _MyAttr(ATTR_RESP, "") end)
		_close()
	end)

	accBtn.MouseButton1Click:Connect(function()
		FriendData.friends[tostring(senderUserId)] = {name = senderName, syncEnabled = true}
		_SaveFriend()
		_MyAttr(ATTR_RESP, tostring(senderUserId) .. ":1")
		task.delay(1, function() _MyAttr(ATTR_RESP, "") end)
		RefreshFriendList()
		Notify(tostring(senderName) .. " arkadaşlık isteğini kabul ettin!", "", nil)
		_close()
	end)

	-- Otomatik reddet aktifse hemen kapat
	if FriendData.autoReject then
		_MyAttr(ATTR_RESP, tostring(senderUserId) .. ":0")
		task.delay(0.5, function() _MyAttr(ATTR_RESP, "") end)
		_close()
	end
end

-- Bir karakteri izle (attr değişikliklerini dinle)
local function _WatchChar(char, uid, uname)
	local function _conn(attr, fn)
		local ok, sig = pcall(function() return char:GetAttributeChangedSignal(attr) end)
		if ok and sig then
			local c = sig:Connect(fn)
			_friendConns[#_friendConns+1] = c
		end
	end

	-- Arkadaş isteği bana mı geliyor?
	_conn(ATTR_REQ, function()
		local v = char:GetAttribute(ATTR_REQ)
		if tostring(v) ~= tostring(player.UserId) then return end
		if not FriendData.acceptRequests then return end
		-- Aynı kişiden spam isteği yoksay
		local now = tick()
		local uid_s = tostring(uid)
		local lastIn = _incomingCooldowns[uid_s] or 0
		if now - lastIn < INCOMING_COOLDOWN then return end
		_incomingCooldowns[uid_s] = now
		ShowFriendRequestPanel(uid, uname)
	end)

	-- İstek cevabı (benim isteğime cevap)
	_conn(ATTR_RESP, function()
		local v = char:GetAttribute(ATTR_RESP)
		if not v then return end
		local parts = v:split(":")
		if #parts ~= 2 then return end
		if tostring(parts[1]) ~= tostring(player.UserId) then return end
		if parts[2] == "1" then
			FriendData.friends[tostring(uid)] = {name = uname, syncEnabled = true}
			_SaveFriend()
			RefreshFriendList()
			Notify(uname .. " arkadaşlık isteğini kabul etti!", "", nil)
		end
	end)

	-- Emote senkron
	_conn(ATTR_SYNC, function()
		if not FriendData.playFriendEmote then return end
		local fdata = FriendData.friends[tostring(uid)]
		if not fdata or not fdata.syncEnabled then return end
		local v = char:GetAttribute(ATTR_SYNC)
		if not v or v == "" then return end
		-- Çakışma kontrolü
		if FriendData.currentSyncPartner and FriendData.currentSyncPartner ~= tostring(uid) then
			Notify(L.friendAlreadySyncing or "Hata! Zaten başka birisiyle senkrondayız.", "", nil)
			return
		end
		local sep = v:find("|")
		if not sep then return end
		local eid = tonumber(v:sub(1, sep-1))
		local ename = v:sub(sep+1)
		if eid and FriendData.syncEmote then
			FriendData.currentSyncPartner = tostring(uid)
			PlayEmote(eid, ename, true)
		end
	end)

	-- Emote durdurma
	_conn(ATTR_STOP, function()
		if FriendData.currentSyncPartner == tostring(uid) then
			FriendData.currentSyncPartner = nil
			StopEmote(false)
		end
	end)
end

-- Tüm oyuncuları izle
local function _WatchAll()
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then
			if p.Character then _WatchChar(p.Character, p.UserId, p.Name) end
			local cc = p.CharacterAdded:Connect(function(c)
				c:WaitForChild("HumanoidRootPart", 8)
				_WatchChar(c, p.UserId, p.Name)
				if FriendData.addModeActive then
					task.wait(0.3)
					pcall(function()
						if not FriendData.addModeActive then return end
						local head = c:FindFirstChild("Head")
						if head and not head:FindFirstChild("VexroFriendBB") then
							_MakeBillboard(p)
						end
					end)
				end
			end)
			_friendConns[#_friendConns+1] = cc
		end
	end
	local pa = Players.PlayerAdded:Connect(function(p)
		if p == player then return end
		local cc = p.CharacterAdded:Connect(function(c)
			c:WaitForChild("HumanoidRootPart", 8)
			_WatchChar(c, p.UserId, p.Name)
		end)
		_friendConns[#_friendConns+1] = cc
	end)
	_friendConns[#_friendConns+1] = pa
end
_WatchAll()

-- BillboardGui yönetimi
local _billConns = {}
local _MakeBillboard
local function _RemoveBillboard(p)
	pcall(function()
		local head = p.Character and p.Character:FindFirstChild("Head")
		if head then
			local bb = head:FindFirstChild("VexroFriendBB")
			if bb then bb:Destroy() end
		end
	end)
end

_MakeBillboard = function(p)
	if not p.Character then return end
	local head = p.Character:FindFirstChild("Head")
	if not head or head:FindFirstChild("VexroFriendBB") then return end

	local bb = Instance.new("BillboardGui")
	bb.Name = "VexroFriendBB"
	bb.Size = UDim2.new(0, 140, 0, 34)
	bb.StudsOffset = Vector3.new(0, 2.8, 0)
	bb.AlwaysOnTop = false
	bb.ResetOnSpawn = false
	bb.Parent = head

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1,0,1,0)
	btn.BackgroundColor3 = currentTheme.accent
	btn.Text = "+ Arkadaş Ekle"
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 11
	btn.Parent = bb
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

	btn.MouseButton1Click:Connect(function()
		if FriendData.friends[tostring(p.UserId)] then
			Notify("Zaten arkadaşsınız!", "", nil); return
		end

		local now = tick()
		local uid_s = tostring(p.UserId)

		-- Global timeout kontrolü
		if now < _reqTimeoutUntil then
			local rem = math.ceil(_reqTimeoutUntil - now)
			Notify("Spam koruması aktif! " .. rem .. "s bekle", "", nil)
			return
		end

		-- Aynı kişiye tekrar istek cooldown
		local lastSent = _reqCooldowns[uid_s] or 0
		if now - lastSent < REQ_COOLDOWN then
			local rem = math.ceil(REQ_COOLDOWN - (now - lastSent))
			Notify("Bu oyuncuya istek için " .. rem .. "s bekle", "", nil)
			return
		end

		-- Spam sayacı güncelle
		if now - _reqSpamStart > REQ_SPAM_WINDOW then
			_reqSpamStart = now
			_reqSpamCount = 0
		end
		_reqSpamCount = _reqSpamCount + 1

		if _reqSpamCount >= REQ_SPAM_LIMIT then
			_reqTimeoutUntil = now + REQ_TIMEOUT_DUR
			_reqSpamCount = 0
			Notify("Çok hızlı istek! " .. REQ_TIMEOUT_DUR .. "s timeout", "", nil)
			btn.Text = "Engellendi"
			btn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
			return
		end

		-- İstek gönder
		_reqCooldowns[uid_s] = now
		_MyAttr(ATTR_REQ, uid_s)
		btn.Text = "İstek Gönderildi"
		btn.BackgroundColor3 = Color3.fromRGB(70, 70, 110)
		task.delay(3, function() _MyAttr(ATTR_REQ, "") end)
	end)
end

local function _SetAddMode(on)
	FriendData.addModeActive = on
	-- Mevcut billboard bağlantılarını temizle
	for _, c in ipairs(_billConns) do pcall(function() c:Disconnect() end) end
	_billConns = {}
	if on then
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player then _MakeBillboard(p) end
		end
	else
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player then _RemoveBillboard(p) end
		end
	end
	-- Renk güncelle
	TweenService:Create(friendAddModeBtn, TweenInfo.new(0.2), {
		BackgroundColor3 = on and currentTheme.success or currentTheme.critical
	}):Play()
end

friendAddModeBtn.MouseButton1Click:Connect(function()
	_SetAddMode(not FriendData.addModeActive)
end)

-- Emote sync broadcast (PlayEmote sonrası çağrılır)
getgenv().VexroBroadcastSync = function(emoteId, emoteName)
	if not FriendData.syncEmote then return end
	local hasSyncFriend = false
	for _, fd in pairs(FriendData.friends) do
		if fd.syncEnabled then hasSyncFriend = true; break end
	end
	if not hasSyncFriend then return end
	_MyAttr(ATTR_SYNC, tostring(emoteId) .. "|" .. tostring(emoteName))
end

getgenv().VexroBroadcastStop = function()
	_MyAttr(ATTR_STOP, tostring(tick()))
	FriendData.currentSyncPartner = nil
end

-- Arkadaş sekmesi içeriği
local function _MakeFriendToggle(txt, desc, order, getVal, setVal)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1,0,0,60)
	row.BackgroundColor3 = currentTheme.tertiary
	row.LayoutOrder = order; row.ZIndex = 6; row.Parent = friendsPanel
	Instance.new("UICorner", row).CornerRadius = UDim.new(0,12)
	RegisterTheme(row, "BackgroundColor3", "tertiary")

	local tl = Instance.new("TextLabel")
	tl.Size = UDim2.new(0.55,0,0,22); tl.Position = UDim2.new(0,12,0,8)
	tl.BackgroundTransparency = 1; tl.Text = txt; tl.TextColor3 = currentTheme.text
	tl.Font = Enum.Font.GothamBold; tl.TextSize = isMobile and 11 or 12
	tl.TextXAlignment = Enum.TextXAlignment.Left; tl.ZIndex = 7; tl.Parent = row
	RegisterTheme(tl, "TextColor3", "text")

	local dl = Instance.new("TextLabel")
	dl.Size = UDim2.new(0.55,0,0,26); dl.Position = UDim2.new(0,12,0,30)
	dl.BackgroundTransparency = 1; dl.Text = desc; dl.TextColor3 = currentTheme.textDim
	dl.Font = Enum.Font.Gotham; dl.TextSize = isMobile and 9 or 10
	dl.TextXAlignment = Enum.TextXAlignment.Left; dl.TextWrapped = true; dl.ZIndex = 7; dl.Parent = row
	RegisterTheme(dl, "TextColor3", "textDim")

	local tb = Instance.new("TextButton")
	tb.Size = UDim2.new(0.38,0,0,30); tb.Position = UDim2.new(0.58,0,0.5,-15)
	tb.BackgroundColor3 = getVal() and currentTheme.success or currentTheme.critical
	tb.Text = getVal() and (L.on or "Açık") or (L.off or "Kapalı")
	tb.TextColor3 = Color3.new(1,1,1); tb.Font = Enum.Font.GothamBold
	tb.TextSize = isMobile and 11 or 12; tb.ZIndex = 8; tb.Parent = row
	Instance.new("UICorner", tb).CornerRadius = UDim.new(0,10)

	tb.MouseButton1Click:Connect(function()
		local v = not getVal(); setVal(v)
		tb.Text = v and (L.on or "Açık") or (L.off or "Kapalı")
		TweenService:Create(tb, TweenInfo.new(0.2), {
			BackgroundColor3 = v and currentTheme.success or currentTheme.critical
		}):Play()
		_SaveFriend()
	end)
end

_MakeFriendToggle(
	"Arkadaşımın emote'unu oynat",
	"Arkadaşın emote başlattığında sende de otomatik oynar",
	1,
	function() return FriendData.playFriendEmote end,
	function(v) FriendData.playFriendEmote = v end
)
_MakeFriendToggle(
	"Emote'u arkadaşınla beraber oynat",
	"Emote oynatınca arkadaşlarına da senkron gönderir",
	2,
	function() return FriendData.syncEmote end,
	function(v) FriendData.syncEmote = v end
)

-- Arkadaş listesi başlığı
local flHeader = Instance.new("TextLabel")
flHeader.Size = UDim2.new(1,0,0,22); flHeader.BackgroundTransparency = 1
flHeader.Text = "Arkadaş Listesi"; flHeader.TextColor3 = currentTheme.textDim
flHeader.Font = Enum.Font.GothamBold; flHeader.TextSize = 11
flHeader.LayoutOrder = 3; flHeader.ZIndex = 5; flHeader.Parent = friendsPanel
RegisterTheme(flHeader, "TextColor3", "textDim")

local friendListContainer = Instance.new("Frame")
friendListContainer.Size = UDim2.new(1,0,0,0)
friendListContainer.AutomaticSize = Enum.AutomaticSize.Y
friendListContainer.BackgroundTransparency = 1
friendListContainer.LayoutOrder = 4; friendListContainer.ZIndex = 5; friendListContainer.Parent = friendsPanel
local flListLayout = Instance.new("UIListLayout")
flListLayout.Padding = UDim.new(0,6); flListLayout.Parent = friendListContainer

local emptyFriendLbl = Instance.new("TextLabel")
emptyFriendLbl.Size = UDim2.new(1,0,0,36); emptyFriendLbl.BackgroundTransparency = 1
emptyFriendLbl.Text = "Henüz arkadaş yok. Arkadaş Ekle butonunu kullan!"
emptyFriendLbl.TextColor3 = currentTheme.textDim; emptyFriendLbl.Font = Enum.Font.Gotham
emptyFriendLbl.TextSize = 11; emptyFriendLbl.TextWrapped = true
emptyFriendLbl.ZIndex = 6; emptyFriendLbl.Parent = friendListContainer
RegisterTheme(emptyFriendLbl, "TextColor3", "textDim")

RefreshFriendList = function()
	for _, ch in ipairs(friendListContainer:GetChildren()) do
		if ch:IsA("Frame") then ch:Destroy() end
	end
	local hasAny = false
	for userId, fdata in pairs(FriendData.friends) do
		hasAny = true
		local uid = tonumber(userId)
		local row = Instance.new("Frame")
		row.Size = UDim2.new(1,0,0,50); row.BackgroundColor3 = currentTheme.tertiary
		row.ZIndex = 6; row.Parent = friendListContainer
		Instance.new("UICorner", row).CornerRadius = UDim.new(0,10)
		RegisterTheme(row, "BackgroundColor3", "tertiary")

		local av = Instance.new("ImageLabel")
		av.Size = UDim2.new(0,36,0,36); av.Position = UDim2.new(0,8,0.5,-18)
		av.BackgroundTransparency = 1
		av.Image = uid and ("rbxthumb://type=AvatarHeadShot&id=" .. uid .. "&w=150&h=150") or ""
		av.ZIndex = 7; av.Parent = row
		Instance.new("UICorner", av).CornerRadius = UDim.new(1,0)

		local nl = Instance.new("TextLabel")
		nl.Size = UDim2.new(1,-130,1,0); nl.Position = UDim2.new(0,52,0,0)
		nl.BackgroundTransparency = 1; nl.Text = fdata.name or userId
		nl.TextColor3 = currentTheme.text; nl.Font = Enum.Font.GothamBold
		nl.TextSize = isMobile and 11 or 12; nl.TextXAlignment = Enum.TextXAlignment.Left
		nl.ZIndex = 7; nl.Parent = row
		RegisterTheme(nl, "TextColor3", "text")

		local syncBtn = Instance.new("TextButton")
		syncBtn.Size = UDim2.new(0,46,0,24); syncBtn.Position = UDim2.new(1,-84,0.5,-12)
		syncBtn.BackgroundColor3 = fdata.syncEnabled and currentTheme.success or currentTheme.critical
		syncBtn.Text = fdata.syncEnabled and "Sync" or "Off"
		syncBtn.TextColor3 = Color3.new(1,1,1); syncBtn.Font = Enum.Font.GothamBold
		syncBtn.TextSize = 10; syncBtn.ZIndex = 7; syncBtn.Parent = row
		Instance.new("UICorner", syncBtn).CornerRadius = UDim.new(0,8)

		syncBtn.MouseButton1Click:Connect(function()
			fdata.syncEnabled = not fdata.syncEnabled
			syncBtn.Text = fdata.syncEnabled and "Sync" or "Off"
			TweenService:Create(syncBtn, TweenInfo.new(0.2), {
				BackgroundColor3 = fdata.syncEnabled and currentTheme.success or currentTheme.critical
			}):Play()
			_SaveFriend()
		end)

		local rmBtn = Instance.new("TextButton")
		rmBtn.Size = UDim2.new(0,28,0,24); rmBtn.Position = UDim2.new(1,-30,0.5,-12)
		rmBtn.BackgroundColor3 = currentTheme.critical; rmBtn.Text = "-"
		rmBtn.TextColor3 = Color3.new(1,1,1); rmBtn.Font = Enum.Font.GothamBold
		rmBtn.TextSize = 16; rmBtn.ZIndex = 7; rmBtn.Parent = row
		Instance.new("UICorner", rmBtn).CornerRadius = UDim.new(0,8)

		rmBtn.MouseButton1Click:Connect(function()
			FriendData.friends[userId] = nil
			if FriendData.currentSyncPartner == userId then FriendData.currentSyncPartner = nil end
			_SaveFriend(); RefreshFriendList()
		end)
	end
	emptyFriendLbl.Visible = not hasAny
end
RefreshFriendList()

-- Ayarlar paneline "Arkadaş istekleri al" satırı
do
	local arRow = MakeSettingRow("", "Arkadaş istekleri al", 9, 50)
	local arBtn = Instance.new("TextButton")
	arBtn.Size = UDim2.new(0.4,0,0,30); arBtn.Position = UDim2.new(0.56,0,0.5,-15)
	arBtn.BackgroundColor3 = FriendData.acceptRequests and currentTheme.success or currentTheme.critical
	arBtn.Text = FriendData.acceptRequests and (L.on or "Açık") or (L.off or "Kapalı")
	arBtn.TextColor3 = Color3.new(1,1,1); arBtn.Font = Enum.Font.GothamBold
	arBtn.TextSize = isMobile and 11 or 13; arBtn.ZIndex = 8; arBtn.Parent = arRow
	Instance.new("UICorner", arBtn).CornerRadius = UDim.new(0,10)
	arBtn.MouseButton1Click:Connect(function()
		FriendData.acceptRequests = not FriendData.acceptRequests
		arBtn.Text = FriendData.acceptRequests and (L.on or "Açık") or (L.off or "Kapalı")
		TweenService:Create(arBtn, TweenInfo.new(0.2), {
			BackgroundColor3 = FriendData.acceptRequests and currentTheme.success or currentTheme.critical
		}):Play()
		_SaveFriend()
	end)
end

-- Cleanup kaydı güncelle
local _prevClean = getgenv().VexroEmotesCleanup
getgenv().VexroEmotesCleanup = function()
	if _prevClean then pcall(_prevClean) end
	for _, c in ipairs(_friendConns) do pcall(function() c:Disconnect() end) end
	_friendConns = {}
	_SetAddMode(false)
	pcall(function() getgenv().VexroBroadcastSync = nil end)
	pcall(function() getgenv().VexroBroadcastStop = nil end)
end

end -- arkadaş sistemi do...end sonu

-- BOTTOM BAR
-- ===============================================================

local bottomBar = Instance.new("Frame")
bottomBar.Size = UDim2.new(1, 0, 0, bottomBarH)
bottomBar.Position = UDim2.new(0, 0, 1, -bottomBarH)
bottomBar.BackgroundColor3 = currentTheme.tertiary
bottomBar.ZIndex = 15
bottomBar.Parent = content
Instance.new("UICorner", bottomBar).CornerRadius = UDim.new(0, 14)
RegisterTheme(bottomBar, "BackgroundColor3", "tertiary")

local bottomOverlay = Instance.new("Frame")
bottomOverlay.Size = UDim2.new(1, 0, 0, 8)
bottomOverlay.BackgroundColor3 = currentTheme.tertiary
bottomOverlay.BorderSizePixel = 0
bottomOverlay.ZIndex = 14
bottomOverlay.Parent = bottomBar
RegisterTheme(bottomOverlay, "BackgroundColor3", "tertiary")

local grip = Instance.new("Frame")
grip.Size = UDim2.new(0, 40, 0, 4)
grip.Position = UDim2.new(0.5, -20, 0.5, -2)
grip.BackgroundColor3 = currentTheme.textDim
grip.ZIndex = 16
grip.Parent = bottomBar
Instance.new("UICorner", grip).CornerRadius = UDim.new(1, 0)
RegisterTheme(grip, "BackgroundColor3", "textDim")

local scrollY = titleH + searchH + 14
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -16, 1, -(scrollY + pageH + bottomBarH + 18))
scroll.Position = UDim2.new(0, 8, 0, scrollY)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = isMobile and 3 or 5
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarImageColor3 = currentTheme.stroke
scroll.ZIndex = 1
scroll.Parent = content
RegisterTheme(scroll, "ScrollBarImageColor3", "stroke")

-- ===============================================================
-- CARD SYSTEM (RESPONSIVE GRID)
-- ===============================================================

local function CalcLayout()
	local PAD = isMobile and 4 or 6
	local w = scroll.AbsoluteSize.X
	
	-- Determine minimal viable card size to allow more columns
	local minCardSize = isMobile and TARGET_MOBILE_CARD or TARGET_PC_CARD
	
	-- Calculate how many columns fit
	cols = math.floor(w / (minCardSize + PAD))
	if cols < 1 then cols = 1 end
	
	-- Expand card size slightly to fill gaps
	currentCardSize = (w - (PAD * (cols - 1))) / cols
	
	-- Calculate rows based on available height to fill page mostly
	local NAME_H = math.clamp(currentCardSize * 0.35, 18, 28)
	local FAV_H = math.clamp(currentCardSize * 0.3, 18, 24)
	local CARD_TOTAL_H = currentCardSize + NAME_H + FAV_H
	
	local rowsVisible = math.floor(scroll.AbsoluteSize.Y / (CARD_TOTAL_H + PAD))
	if rowsVisible < 2 then rowsVisible = 2 end
	
	-- Determine items per page dynamically
	perPage = cols * rowsVisible
	
	pages = math.max(1, math.ceil(#filtered / perPage))
	page = math.clamp(page, 1, pages)
end

local function UpdatePageUI()
	pageNum.Text = page .. "/" .. pages
	local show = pages > 1
	prevBtn.Visible = show
	nextBtn.Visible = show
	
	if prevBtn:FindFirstChild("ChevronIcon") then 
		for _, c in ipairs(prevBtn.ChevronIcon:GetChildren()) do c.BackgroundColor3 = Color3.new(0, 0, 0) end
	end
	if nextBtn:FindFirstChild("ChevronIcon") then 
		for _, c in ipairs(nextBtn.ChevronIcon:GetChildren()) do c.BackgroundColor3 = Color3.new(0, 0, 0) end
	end
	
	pageBar.Visible = currentTab ~= "settings" and pages > 1
	
	local empty = #filtered == 0 and currentTab ~= "settings"
	emptyLbl.Visible = empty
	if currentTab == "favorites" then emptyLbl.Text = L.noFav
	elseif currentTab == "recent" then emptyLbl.Text = L.noRecent end
end

local function ClearCards()
	for _, c in pairs(cards) do
		if c and c.Parent then c:Destroy() end
	end
	cards = {}
end

local function MakeCard(emote, ci, animate)
	local CARD = currentCardSize
	local PAD = isMobile and 4 or 6
	
	-- Dynamic text height based on card size, but capped
	local NAME_H = math.clamp(CARD * 0.35, 18, 28)
	local FAV_H = math.clamp(CARD * 0.3, 18, 24)
	local CARD_TOTAL_H = CARD + NAME_H + FAV_H
	
	-- Ana kart container
	local cardContainer = Instance.new("Frame")
	cardContainer.Size = UDim2.new(0, CARD, 0, CARD_TOTAL_H)
	cardContainer.BackgroundTransparency = 1
	cardContainer.ZIndex = 2
	cardContainer.Parent = scroll
	
	local col = ci % cols
	local row = math.floor(ci / cols)
	
	-- Position logic for grid
	local targetX = col * (CARD + PAD)
	local targetY = PAD + row * (CARD_TOTAL_H + PAD)
	
	if animate then
		cardContainer.Position = UDim2.new(0, targetX, 0, targetY + 30)
		cardContainer.BackgroundTransparency = 1
		
		task.delay(ci * 0.02, function()
			if cardContainer.Parent then
				TweenService:Create(cardContainer, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
					Position = UDim2.new(0, targetX, 0, targetY)
				}):Play()
			end
		end)
	else
		cardContainer.Position = UDim2.new(0, targetX, 0, targetY)
	end
	
	local card = Instance.new("ImageButton")
	card.Size = UDim2.new(1, 0, 0, CARD)
	card.Position = UDim2.new(0, 0, 0, 0)
	card.BackgroundColor3 = currentTheme.tertiary
	card.ScaleType = Enum.ScaleType.Fit
	card.ZIndex = 3
	card.Parent = cardContainer
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
	
	card.Image = "rbxthumb://type=Asset&id=" .. emote.id .. "&w=420&h=420"
	-- Cards are dynamic, register/unregister is complex. We set color directly on refresh.
	card.BackgroundColor3 = currentTheme.tertiary 
	
	if animate then
		card.ImageTransparency = 1
		task.delay(ci * 0.02, function()
			if card.Parent then
				TweenService:Create(card, TweenInfo.new(0.25), {ImageTransparency = 0}):Play()
			end
		end)
	end
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = currentTheme.accent
	stroke.Thickness = 2
	stroke.Transparency = 0.6
	stroke.Parent = card
	
	-- İsim Label (resmin altında)
	local nameLbl = Instance.new("TextLabel")
	nameLbl.Size = UDim2.new(1, -4, 0, NAME_H - 2) 
	nameLbl.Position = UDim2.new(0, 2, 0, CARD)
	nameLbl.BackgroundColor3 = currentTheme.secondary
	nameLbl.Text = emote.name
	nameLbl.TextColor3 = currentTheme.text
	nameLbl.Font = Enum.Font.GothamBold
	nameLbl.TextScaled = true
	nameLbl.TextWrapped = true 
	nameLbl.Active = true 
	nameLbl.ZIndex = 3
	nameLbl.Parent = cardContainer
	Instance.new("UICorner", nameLbl).CornerRadius = UDim.new(0, 4)
	
	nameLbl.MouseEnter:Connect(function()
		TweenService:Create(nameLbl, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
			Size = UDim2.new(1, 4, 0, NAME_H + 4),
			Rotation = math.random(-2, 2)
		}):Play()
	end)
	
	nameLbl.MouseLeave:Connect(function()
		TweenService:Create(nameLbl, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			Size = UDim2.new(1, -4, 0, NAME_H - 2),
			Rotation = 0
		}):Play()
	end)
	
	
	local isFav = IsFavorite(emote.id)
	local favBtn = Instance.new("TextButton")
	favBtn.Size = UDim2.new(1, 0, 0, FAV_H)
	favBtn.Position = UDim2.new(0, 0, 0, CARD + NAME_H)
	favBtn.BackgroundColor3 = currentTheme.accent
	favBtn.BackgroundTransparency = 1 -- Kareyi kaldır
	favBtn.Text = ""
	favBtn.ZIndex = 4
	favBtn.Parent = cardContainer
	Instance.new("UICorner", favBtn).CornerRadius = UDim.new(0, 4)

	local favIcon = Instance.new("TextLabel")
	local iconSize = isMobile and 28 or 34
	favIcon.Size = UDim2.new(0, iconSize, 0, iconSize)
	favIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
	favIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	favIcon.BackgroundTransparency = 1
	favIcon.Text = isFav and utf8.char(0x2605) or utf8.char(0x2606)
	favIcon.TextColor3 = isFav and Color3.fromRGB(255, 215, 0) or currentTheme.accent
	favIcon.Font = Enum.Font.SourceSansLight
	favIcon.TextSize = isMobile and 26 or 32
	favIcon.TextScaled = false
	favIcon.ZIndex = 50
	favIcon.Parent = favBtn
	
	favBtn.MouseEnter:Connect(function()
		TweenService:Create(favBtn, TweenInfo.new(0.15, Enum.EasingStyle.Back), {
			BackgroundColor3 = isFav and currentTheme.tertiary or currentTheme.accent,
			Size = UDim2.new(1, 6, 0, FAV_H + 6),
			Rotation = math.random(-2, 2)
		}):Play()
	end)
	favBtn.MouseLeave:Connect(function()
		TweenService:Create(favBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
			BackgroundColor3 = isFav and currentTheme.tertiary or currentTheme.stroke,
			Size = UDim2.new(1, 0, 0, FAV_H),
			Rotation = 0
		}):Play()
	end)
	
	favBtn.MouseButton1Click:Connect(function()
		isFav = ToggleFavorite(emote.id)
		
		if isFav then
			favIcon.Text = utf8.char(0x2605)
			favIcon.TextColor3 = Color3.fromRGB(255, 215, 0)
		else
			favIcon.Text = utf8.char(0x2606)
			favIcon.TextColor3 = currentTheme.accent
		end
		
		TweenService:Create(favBtn, TweenInfo.new(0.2), {
			BackgroundColor3 = isFav and currentTheme.tertiary or currentTheme.stroke
		}):Play()
		
		-- YILDIZ PATLAMA ANİMASYONU
		if isFav then
			favIcon.Size = UDim2.new(0, 0, 0, 0)
			TweenService:Create(favIcon, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, iconSize + 6, 0, iconSize + 6)
			}):Play()
			task.delay(0.2, function()
				TweenService:Create(favIcon, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
					Size = UDim2.new(0, iconSize, 0, iconSize)
				}):Play()
			end)
			
			local ripple = Instance.new("Frame")
			ripple.Size = UDim2.new(0, 0, 0, 0)
			ripple.Position = UDim2.fromScale(0.5, 0.5)
			ripple.AnchorPoint = Vector2.new(0.5, 0.5)
			ripple.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
			ripple.BackgroundTransparency = 0.3
			ripple.ZIndex = 4
			ripple.Parent = favBtn
			Instance.new("UICorner", ripple).CornerRadius = UDim.new(1, 0)
			
			TweenService:Create(ripple, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(2, 0, 2, 0),
				BackgroundTransparency = 1
			}):Play()
			task.delay(0.4, function() if ripple then ripple:Destroy() end end)
		else
			-- Geri alırken küçük bir küçülme efekti
			TweenService:Create(favIcon, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
				Size = UDim2.new(0, iconSize - 4, 0, iconSize - 4)
			}):Play()
			task.delay(0.2, function()
				TweenService:Create(favIcon, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					Size = UDim2.new(0, iconSize, 0, iconSize)
				}):Play()
			end)
		end
		
		if currentTab == "favorites" then
			task.delay(0.4, function()
				if currentTab == "favorites" then UpdateTabData() end
			end)
		end
	end)
	
	
	card.MouseEnter:Connect(function()
		-- Hafif büyütme ve tilt efekti
		TweenService:Create(card, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
			Size = UDim2.new(1, 6, 0, CARD + 6),
			Rotation = math.random(-2, 2)
		}):Play()
		-- Stroke parlaması
		TweenService:Create(stroke, TweenInfo.new(0.2), {Transparency = 0, Thickness = 2.5, Color = currentTheme.accent}):Play()
	end)
	
	card.MouseLeave:Connect(function()
		-- Normale dönüş
		TweenService:Create(card, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			Size = UDim2.new(1, 0, 0, CARD),
			Rotation = 0
		}):Play()
		TweenService:Create(stroke, TweenInfo.new(0.2), {Transparency = 0.6, Thickness = 2, Color = currentTheme.accent}):Play()
	end)
	
	
	card.MouseButton1Click:Connect(function()
		-- İçeri göçme (Jelly)
		TweenService:Create(card, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(0.9, 0, 0, CARD * 0.9)}):Play()
		
		task.delay(0.1, function()
			-- Geri fırlama
			TweenService:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {Size = UDim2.new(1, 0, 0, CARD)}):Play()
		end)
		
		TweenService:Create(stroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(80, 220, 120)}):Play()
		task.delay(0.3, function()
			if card.Parent then
				TweenService:Create(stroke, TweenInfo.new(0.2), {Color = currentTheme.accent}):Play()
			end
		end)
		
		PlayEmote(emote.id, emote.name)
	end)
	
	return cardContainer
end

local function UpdateCards(animate)
	ClearCards()
	
	local startIdx = (page - 1) * perPage + 1
	local endIdx = math.min(page * perPage, #filtered)
	
	local ci = 0
	for i = startIdx, endIdx do
		if filtered[i] then
			cards[i] = MakeCard(filtered[i], ci, animate)
			ci = ci + 1
		end
	end
	
	local CARD = currentCardSize
	local PAD = isMobile and 4 or 6
	local NAME_H = math.clamp(CARD * 0.35, 18, 28)
	local FAV_H = math.clamp(CARD * 0.3, 18, 24)
	local CARD_TOTAL_H = CARD + NAME_H + FAV_H
	
	local rows = math.ceil(ci / math.max(cols, 1))
	scroll.CanvasSize = UDim2.new(0, 0, 0, rows * (CARD_TOTAL_H + PAD) + PAD)
	scroll.CanvasPosition = Vector2.zero
end

local function Refresh(animate)
	CalcLayout()
	UpdatePageUI()
	UpdateCards(animate ~= false)
end

prevBtn.MouseButton1Click:Connect(function()
	if pages <= 1 then return end
	if page > 1 then 
		page = page - 1
	else 
		page = pages -- Loop to end
	end
	Refresh(true)
end)
nextBtn.MouseButton1Click:Connect(function()
	if pages <= 1 then return end
	if page < pages then 
		page = page + 1
	else 
		page = 1 -- Loop to start
	end
	Refresh(true)
end)

-- ===============================================================
-- TAB SYSTEM
-- ===============================================================

UpdateTabStyles = function()
	local isM3 = Settings.theme == "MaterialYou"
	for name, data in pairs(tabBtns) do
		local active = currentTab == name
		local targetColor = active and currentTheme.accent or currentTheme.sidebar
		local targetIconColor = active and Color3.new(1, 1, 1) or currentTheme.text
		
		-- Quatrefoil göstergesi (sadece MaterialYou)
		if data.quatrefoil then
			if isM3 and active then
				data.quatrefoil.Visible = true
				data.quatrefoil.ImageColor3 = currentTheme.accent
				local qSize = tabBtnS + 10
				data.quatrefoil.Size = UDim2.new(0, 0, 0, 0)
				TweenService:Create(data.quatrefoil, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					Size = UDim2.new(0, qSize, 0, qSize),
					ImageTransparency = 0.3
				}):Play()
			else
				if data.quatrefoil.Visible then
					local qRef = data.quatrefoil
					TweenService:Create(qRef, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						Size = UDim2.new(0, 0, 0, 0),
						ImageTransparency = 1
					}):Play()
					task.delay(0.2, function()
						if qRef and qRef.Parent then qRef.Visible = false end
					end)
				end
			end
		end
		
		if isM3 then
			TweenService:Create(data.btn, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
				BackgroundTransparency = active and 1 or 0.85,
				BackgroundColor3 = currentTheme.sidebar,
				Size = UDim2.new(0, tabBtnS, 0, tabBtnS)
			}):Play()
			TweenService:Create(data.stroke, TweenInfo.new(0.25), {
				Transparency = 1
			}):Play()
		else
			TweenService:Create(data.btn, TweenInfo.new(0.2), {
				BackgroundTransparency = active and 0.2 or 0.8,
				BackgroundColor3 = targetColor,
				Size = UDim2.new(0, active and tabBtnS + 4 or tabBtnS, 0, active and tabBtnS + 4 or tabBtnS)
			}):Play()
			TweenService:Create(data.stroke, TweenInfo.new(0.2), {
				Transparency = active and 0 or 0.7,
				Color = active and currentTheme.accent or currentTheme.stroke,
				Thickness = active and 3 or 2
			}):Play()
		end
		
		if data.img then
			TweenService:Create(data.img, TweenInfo.new(0.2), {
				ImageColor3 = targetIconColor
			}):Play()
		else
			TweenService:Create(data.btn, TweenInfo.new(0.2), {
				TextColor3 = targetIconColor
			}):Play()
		end
	end
end

UpdateTabData = function()
	search.Text = ""
	page = 1
	
	local isSettings = currentTab == "settings"
	local isFriends  = currentTab == "friends"
	settingsPanel.Visible = isSettings
	friendsPanel.Visible  = isFriends
	scroll.Visible  = not isSettings and not isFriends
	search.Visible  = not isSettings and not isFriends
	pageBar.Visible = not isSettings and not isFriends
	if isSettings or isFriends then
		emptyLbl.Visible = false
	end
	
	if currentTab == "emotes" then
		currentData = Emotes
		filtered = Emotes
		title.Text = L.emotes
		titleIcon.Image = ResolveAssetImage(Icons.Emote)
		titleIcon.ImageColor3 = currentTheme.text
		titleIcon.Visible = true
	elseif currentTab == "favorites" then
		currentData = {}
		for i = 1, #Favorites do
			local emote = EmotesById[Favorites[i]]
			if emote then
				currentData[#currentData + 1] = emote
			end
		end
		filtered = currentData
		title.Text = L.favorites
		titleIcon.Image = ResolveAssetImage(Icons.FavoriteFull)
		titleIcon.ImageColor3 = currentTheme.text
		titleIcon.Visible = true

	elseif currentTab == "recent" then
		currentData = {}
		for i = 1, #RecentEmotes do
			local emote = EmotesById[RecentEmotes[i]]
			if emote then
				currentData[#currentData + 1] = emote
			end
		end
		filtered = currentData
		title.Text = L.recent
		titleIcon.Image = ResolveAssetImage(Icons.Recent)
		titleIcon.ImageColor3 = currentTheme.text
		titleIcon.Visible = true
	elseif currentTab == "settings" then
		title.Text = L.settings
		titleIcon.Image = ResolveAssetImage(Icons.Settings)
		titleIcon.ImageColor3 = currentTheme.text
		titleIcon.Visible = true
	elseif currentTab == "friends" then
		title.Text = L.friendTab or "Arkadaşlar"
		titleIcon.Image = ResolveAssetImage("rbxassetid://115725480722697")
		titleIcon.ImageColor3 = currentTheme.accent
		titleIcon.Visible = true
	end
	
	local tabIconSz = titleIconSz
	if currentTab ~= "emotes" then
		tabIconSz = math.floor(titleIconSz * 1.3)
	end
	titleIcon.Size = UDim2.new(0, tabIconSz, 0, tabIconSz)
	title.Position = UDim2.new(0, titleIcon.Visible and (10 + tabIconSz + 6) or 10, 0, 0)
	
	UpdateTabStyles()
	if not isSettings then Refresh(true) end
end

tabBtns["emotes"].btn.MouseButton1Click:Connect(function() currentTab = "emotes"; UpdateTabData() end)
tabBtns["favorites"].btn.MouseButton1Click:Connect(function() currentTab = "favorites"; UpdateTabData() end)

tabBtns["recent"].btn.MouseButton1Click:Connect(function() currentTab = "recent"; UpdateTabData() end)
tabBtns["settings"].btn.MouseButton1Click:Connect(function() currentTab = "settings"; UpdateTabData() end)
tabBtns["friends"].btn.MouseButton1Click:Connect(function() currentTab = "friends"; UpdateTabData() end)

local searchToken = 0
search:GetPropertyChangedSignal("Text"):Connect(function()
	if currentTab == "settings" then return end
	searchToken = searchToken + 1
	local myToken = searchToken
	task.wait(0.08)
	if myToken ~= searchToken then return end -- Newer input supersedes
	local q = search.Text:lower()
	filtered = {}
	for i = 1, #currentData do
		local e = currentData[i]
		if q == "" or e.name:lower():find(q, 1, true) then
			filtered[#filtered + 1] = e
		end
	end
	page = 1
	Refresh(true)
end)

-- ===============================================================
-- MINI ICON
-- ===============================================================

do
local iconS = isMobile and 50 or 60
local miniIcon = Instance.new("ImageButton")
miniIcon.Size = UDim2.new(0, iconS, 0, iconS)
miniIcon.Position = UDim2.new(0, 20, 0.5, -iconS/2)
miniIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
miniIcon.Image = "rbxassetid://88874992610290"
miniIcon.Visible = false
miniIcon.ZIndex = 1000
miniIcon.Parent = gui
Instance.new("UICorner", miniIcon).CornerRadius = UDim.new(1, 0)

local miniIconStroke = Instance.new("UIStroke")
miniIconStroke.Color = Color3.new(1, 1, 1) -- Gradient için beyaz taban
miniIconStroke.Thickness = 3
miniIconStroke.Parent = miniIcon

miniIconGrad = Instance.new("UIGradient")
miniIconGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, currentTheme.stroke),
	ColorSequenceKeypoint.new(0.33, currentTheme.accent),
	ColorSequenceKeypoint.new(0.66, currentTheme.stroke),
	ColorSequenceKeypoint.new(1, currentTheme.accent)
}
miniIconGrad.Parent = miniIconStroke

task.spawn(function()
	local rot = 0
	while miniIcon.Parent do
		rot = rot + 360
		TweenService:Create(miniIconGrad, TweenInfo.new(2, Enum.EasingStyle.Linear), {Rotation = rot}):Play()
		task.wait(2)
	end
end)

task.spawn(function()
	while miniIcon.Parent do
		if miniIcon.Visible then
			TweenService:Create(miniIcon, TweenInfo.new(1, Enum.EasingStyle.Sine), {Size = UDim2.new(0, iconS + 4, 0, iconS + 4)}):Play()
			task.wait(1)
			TweenService:Create(miniIcon, TweenInfo.new(1, Enum.EasingStyle.Sine), {Size = UDim2.new(0, iconS, 0, iconS)}):Play()
			task.wait(1)
		else
			task.wait(0.5)
		end
	end
end)

do
local savedPos, savedSize = nil, nil
local iconDragging, iconDragStart, iconStartPos = false, nil, nil

miniIcon.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		iconDragging = true
		iconDragStart = input.Position
		iconStartPos = miniIcon.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if iconDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - iconDragStart
		miniIcon.Position = UDim2.new(iconStartPos.X.Scale, iconStartPos.X.Offset + delta.X, iconStartPos.Y.Scale, iconStartPos.Y.Offset + delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		if iconDragging then
			local delta = input.Position - iconDragStart
			if math.abs(delta.X) < 5 and math.abs(delta.Y) < 5 then
				miniIcon.Visible = false
				main.Visible = true
				main.ClipsDescendants = true
				main.Size = UDim2.new(0, 0, 0, 0)
				main.BackgroundTransparency = 1
				main.Rotation = -15
				
				local targetSize = savedSize or GetDefaultSize()
				local targetPos = savedPos or UDim2.fromScale(0.5, 0.5)
				main.Position = targetPos
				
				TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Back), {Size = targetSize, BackgroundTransparency = 0, Rotation = 0}):Play()
				TweenService:Create(mainStroke, TweenInfo.new(0.35), {Transparency = 0}):Play()
				
				task.delay(0.4, function()
					main.ClipsDescendants = false
					if currentTab ~= "settings" then Refresh(true) end
				end)
			end
		end
		iconDragging = false
	end
end)

minBtn.MouseButton1Click:Connect(function()
	savedPos = main.Position
	savedSize = main.Size
	
	TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1, Rotation = 15}):Play()
	TweenService:Create(mainStroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
	
	task.delay(0.3, function()
		main.Visible = false
		miniIcon.Visible = true
	end)
end)

-- Tüm bağlantıları kesip scripti temizle
local function _CleanupScript()
	pcall(function() _heartbeatConn:Disconnect() end)
	pcall(function() _charAddedConn:Disconnect() end)
	pcall(function() DisableCopyEmotePrompts() end)
	pcall(function() StopHUDTracking() end)
	getgenv().VexroEmotesCleanup = nil
	getgenv().lastVexroEmote = nil
	getgenv().autoReloadEnabled_Vexro = nil
	pcall(function() gui:Destroy() end)
end

getgenv().VexroEmotesCleanup = _CleanupScript

closeBtn.MouseButton1Click:Connect(function()
	TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1, Rotation = -30}):Play()
	task.wait(0.25)
	_CleanupScript()
end)
end -- iconDrag scope
end -- miniIcon/iconS scope

-- ===============================================================
-- DRAG & RESIZE
-- ===============================================================

do
local dragging, dragStart, startPos = false, nil, nil

local function StartDrag(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end

titleBar.InputBegan:Connect(StartDrag)
bottomBar.InputBegan:Connect(StartDrag)
sidebar.InputBegan:Connect(StartDrag)

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

local resizeS = isMobile and 28 or 22
local resizeBtn = Instance.new("TextButton")
resizeBtn.Size = UDim2.new(0, resizeS, 0, resizeS)
resizeBtn.Position = UDim2.new(1, -resizeS - 3, 1, -resizeS - 3)
resizeBtn.BackgroundColor3 = currentTheme.stroke
resizeBtn.BackgroundTransparency = 0.4
resizeBtn.Text = "/"
resizeBtn.TextColor3 = currentTheme.textDim
resizeBtn.TextSize = isMobile and 12 or 14
resizeBtn.ZIndex = 100
resizeBtn.Parent = main
Instance.new("UICorner", resizeBtn).CornerRadius = UDim.new(0, 8)

do
local resizing, resizeStart, sizeStart = false, nil, nil
local lastRefreshTime = 0

resizeBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		resizing = true
		resizeStart = input.Position
		sizeStart = main.AbsoluteSize
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - resizeStart
		local newW = math.clamp(sizeStart.X + delta.X, 400, 1200) -- Expanded max width
		local newH = math.clamp(sizeStart.Y + delta.Y, 300, 800)
		main.Size = UDim2.new(0, newW, 0, newH)
		
		local now = tick()
		if now - lastRefreshTime > 0.1 then
			lastRefreshTime = now
			if currentTab ~= "settings" then Refresh(false) end
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and resizing then
		resizing = false
		if currentTab ~= "settings" then Refresh(false) end
	end
end)
end -- resize scope
end -- drag scope

-- ===============================================================
-- CHARACTER RESPAWN & AUTO-RELOAD
-- ===============================================================

-- Enable auto reload before listener registration
getgenv().autoReloadEnabled_Vexro = Settings.loopEmote

local _charAddedConn = player.CharacterAdded:Connect(function(newChar)
	local newHum = newChar:WaitForChild("Humanoid", 5)
	if not newHum then return end
	
	-- R6 check
	if newHum.RigType == Enum.HumanoidRigType.R6 then
		Notify(utf8.char(0x274C), L.r6Msg)
		task.wait(2)
		gui:Destroy()
		return
	end
	
	-- Auto-reload last emote after respawn
	if getgenv().lastVexroEmote and getgenv().autoReloadEnabled_Vexro then
		task.wait(1)
		PlayEmote(getgenv().lastVexroEmote.id, getgenv().lastVexroEmote.name, true)
		Notify("[R]", L.ready or "Emote reapplied")
	end
end)

-- ===============================================================
-- INITIALIZE
-- ===============================================================

main.Rotation = -10
local openSize = GetDefaultSize()
TweenService:Create(main, TweenInfo.new(0.45, Enum.EasingStyle.Back), {Size = openSize, BackgroundTransparency = 0, Rotation = 0}):Play()
TweenService:Create(mainStroke, TweenInfo.new(0.45), {Transparency = 0}):Play()

task.wait(0.5)

main.ClipsDescendants = false
ApplyTheme(Settings.theme)
UpdateTabStyles()
UpdateTabData()

task.wait(0.25)
Notify(utf8.char(0x2705) .. " " .. L.ready, #Emotes .. " emotes")

-- ================================================================
-- VEXRO EXTENDED MODULES v1.0
-- Bölüm 1: Dinamik Tema  |  Bölüm 2: Animation Blending & Combo
-- Bölüm 3: Canlı Emote HUD  |  Bölüm 4: Entegrasyon
-- NOT: do...end bloğu Lua'nın 200 local sınırını aşmamak için
-- ================================================================
local function _VexroExtend() -- Ayrı fonksiyon: kendi 200 register tablosu

-- ----------------------------------------------------------------
-- BÖLÜM 1 — DİNAMİK TEMA (Dynamic Theme)
-- BackgroundTransparency 0.6-0.7, Lighting tabanlı renk takibi,
-- TweenService ile 2 saniyelik yumuşak geçişler.
-- ----------------------------------------------------------------

-- "Dynamic" seçeneğini tema listesine ekle (script tekrar çalıştırılırsa iki kez eklenmesin)
if not table.find(themeNames, "Dynamic") then
	table.insert(themeNames, "Dynamic")
end

-- Dynamic için başlangıç tema tanımı (Dark tabanlı, Lighting ile güncellenir)
Themes["Dynamic"] = {
	primary   = Color3.fromRGB(12, 12, 16),
	secondary = Color3.fromRGB(18, 18, 24),
	tertiary  = Color3.fromRGB(26, 26, 34),
	sidebar   = Color3.fromRGB(10, 10, 14),
	accent    = Color3.fromRGB(130, 160, 220),
	text      = Color3.new(1, 1, 1),
	textDim   = Color3.fromRGB(150, 150, 160),
	stroke    = Color3.fromRGB(55, 65, 100),
	critical  = Color3.fromRGB(220, 60, 60),
	success   = Color3.fromRGB(80, 200, 100),
}

local isDynamicActive = false

-- Lighting.OutdoorAmbient → vurgu rengi
-- Max 0.72 ile sınırlıyoruz: buton arka planı asla beyaza dönmesin
local function GetLightingAccent()
	local lighting = game:GetService("Lighting")
	local c = lighting.OutdoorAmbient
	local r = math.clamp(c.R * 2.0 + 0.10, 0.15, 0.72)
	local g = math.clamp(c.G * 2.0 + 0.10, 0.15, 0.72)
	local b = math.clamp(c.B * 2.2 + 0.14, 0.18, 0.82)
	-- En az 1 kanal belirgin olsun (gri olmaya çalışmasın)
	local maxC = math.max(r, g, b)
	if maxC < 0.30 then
		local boost = 0.30 / maxC
		r = math.min(r * boost, 0.72)
		g = math.min(g * boost, 0.72)
		b = math.min(b * boost, 0.82)
	end
	return Color3.new(r, g, b)
end

-- Lighting.Ambient → arkaplan rengi
local function GetLightingPrimary()
	local lighting = game:GetService("Lighting")
	local c = lighting.Ambient
	local r = math.clamp(c.R * 0.85, 0.04, 0.14)
	local g = math.clamp(c.G * 0.85, 0.04, 0.14)
	local b = math.clamp(c.B * 0.90, 0.05, 0.18)
	return Color3.new(r, g, b)
end

-- Dynamic tema güncelleme döngüsü (2 saniyelik periyot)
local function RunDynamicThemeLoop()
	task.spawn(function()
		while isDynamicActive do
			local accent  = GetLightingAccent()
			local primary = GetLightingPrimary()

			-- Tema renklerini Lighting değerlerine göre güncelle
			Themes["Dynamic"].accent    = accent
			-- Stroke: accent'in %35'i, max 0.30 → asla beyazlaşmasın
			Themes["Dynamic"].stroke    = Color3.new(
				math.min(accent.R * 0.35, 0.30),
				math.min(accent.G * 0.35, 0.30),
				math.min(accent.B * 0.35, 0.30)
			)
			Themes["Dynamic"].primary   = primary
			Themes["Dynamic"].secondary = Color3.new(
				math.clamp(primary.R * 1.5, 0, 0.20),
				math.clamp(primary.G * 1.5, 0, 0.20),
				math.clamp(primary.B * 1.5, 0, 0.26)
			)
			Themes["Dynamic"].sidebar   = Color3.new(
				math.clamp(primary.R * 0.65, 0, 0.09),
				math.clamp(primary.G * 0.65, 0, 0.09),
				math.clamp(primary.B * 0.65, 0, 0.11)
			)

			currentTheme = Themes["Dynamic"]
			local tweenInfo = TweenInfo.new(1.8, Enum.EasingStyle.Sine)

			-- Tüm kayıtlı elementlere renk tween uygula
			local alive = {}
			for _, t in ipairs(themeElements) do
				if t.el and t.el.Parent then
					alive[#alive + 1] = t
					if currentTheme[t.key] then
						pcall(function()
							TweenService:Create(t.el, tweenInfo, {[t.prop] = currentTheme[t.key]}):Play()
						end)
					end
				end
			end
			themeElements = alive

			-- Gradient renklerini güncelle
			local newSeq = ColorSequence.new{
				ColorSequenceKeypoint.new(0,    currentTheme.stroke),
				ColorSequenceKeypoint.new(0.33, currentTheme.accent),
				ColorSequenceKeypoint.new(0.66, currentTheme.stroke),
				ColorSequenceKeypoint.new(1,    currentTheme.accent),
			}
			if mainStrokeGrad then mainStrokeGrad.Color = newSeq end
			if miniIconGrad   then miniIconGrad.Color   = newSeq end

			task.wait(2) -- 2 saniyelik periyot
		end
	end)
end

-- Forward declarations: BÖLÜM 3'te tanımlanır; SetDynamicTransparency closure'ı için gerekli
local HUD, infoPanel, infoSpeedLbl, comboSlots, comboQueue_UI
local _currentInfoId, _currentInfoName
local _comboLoopEnabled = false   -- combo döngü modu
local _comboLoopList    = {}      -- döngü için orijinal liste kopyası

-- Frosted glass overlay'leri (sadece ilgili panellerin arkasında)
local _frostOverlays = {}

local function MakeFrostOverlay(target, zindex)
	local f = Instance.new("Frame")
	f.Name                   = "FrostOverlay"
	f.Size                   = UDim2.new(1, 0, 1, 0)
	f.Position               = UDim2.new(0, 0, 0, 0)
	f.BackgroundColor3       = Color3.new(1, 1, 1)
	f.BackgroundTransparency = 1   -- başlangıçta görünmez
	f.BorderSizePixel        = 0
	f.ZIndex                 = zindex
	f.Parent                 = target
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 20)
	-- Hafif gradient: üst beyaz, alt şeffaf
	local grad = Instance.new("UIGradient")
	grad.Rotation    = 90
	grad.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.82),
		NumberSequenceKeypoint.new(1, 0.92),
	}
	grad.Parent = f
	return f
end

-- Dynamic tema aktifken panel şeffaflığı + lokal frosted glass
local function SetDynamicTransparency(enable)
	local ti = TweenInfo.new(0.6, Enum.EasingStyle.Sine)

	-- Panel şeffaflıkları
	TweenService:Create(main,      ti, {BackgroundTransparency = enable and 0.35 or 0}):Play()
	TweenService:Create(sidebar,   ti, {BackgroundTransparency = enable and 0.28 or 0}):Play()
	TweenService:Create(titleBar,  ti, {BackgroundTransparency = enable and 0.22 or 0}):Play()
	TweenService:Create(bottomBar, ti, {BackgroundTransparency = enable and 0.28 or 0}):Play()

	if enable then
		-- Her panele bir kez overlay ekle
		local targets = {
			{el = main,       z = 2},
			{el = infoPanel,  z = 699},
			{el = HUD,        z = 499},
		}
		for _, t in ipairs(targets) do
			-- Önceki varsa kullan, yoksa yeni oluştur
			local existing = t.el:FindFirstChild("FrostOverlay")
			local ov = existing or MakeFrostOverlay(t.el, t.z)
			_frostOverlays[#_frostOverlays + 1] = ov
			TweenService:Create(ov, ti, {BackgroundTransparency = 0.82}):Play()
		end
	else
		-- Tüm overlay'leri soldur ve sil
		for _, ov in ipairs(_frostOverlays) do
			if ov and ov.Parent then
				TweenService:Create(ov, ti, {BackgroundTransparency = 1}):Play()
				task.delay(0.6, function() pcall(function() ov:Destroy() end) end)
			end
		end
		_frostOverlays = {}
	end
end

-- ApplyTheme fonksiyonunu Dynamic için genişlet (upvalue sarmalama)
local _baseApplyTheme = ApplyTheme
ApplyTheme = function(name)
	if name ~= "Dynamic" then
		-- Dynamic döngüsünü durdur ve opaklığa dön
		isDynamicActive = false
		SetDynamicTransparency(false)
		_baseApplyTheme(name)
	else
		isDynamicActive = false -- Önceki döngüyü güvenle durdur
		task.wait(0.05)
		isDynamicActive = true
		currentTheme = Themes["Dynamic"]
		_baseApplyTheme("Dynamic")
		SetDynamicTransparency(true)
		RunDynamicThemeLoop()
	end
end

-- Başlangıçta Dynamic kayıtlıysa otomatik başlat
if Settings.theme == "Dynamic" then
	task.defer(function()
		isDynamicActive = true
		SetDynamicTransparency(true)
		RunDynamicThemeLoop()
	end)
end

-- ----------------------------------------------------------------
-- BÖLÜM 2 — ANİMASYON BLENDING & SEQUENCING (Combo Sistemi)
-- AnimationTrack:Play(0.3) ile 0.3s fade-in/out harmanlama,
-- Stopped sinyali ile otomatik sıralama, max 3 emote combo.
-- ----------------------------------------------------------------

-- Forward declaration: HUD fonksiyonları aşağıda tanımlanır
local ShowEmoteHUD, HideEmoteHUD

local ComboQueue    = {} -- {id, name} tablosu
local isComboActive = false

-- 0.3 saniyelik smooth fade ile tek bir combo adımını oynat
local function PlayComboStep(emoteId, emoteName)
	local animator = GetAnimator()
	if not animator then return end

	-- Mevcut animasyonu 0.3s fade-out ile durdur
	if currentAnimTrack and currentAnimTrack.IsPlaying then
		currentAnimTrack:Stop(0.3)
		task.wait(0.08)
	end

	-- Animasyonu cache'den al veya yükle
	local anim = _animCache[emoteId]
	if not anim then
		pcall(function()
			local ok, objects = pcall(function()
				return game:GetObjects("rbxassetid://" .. emoteId)
			end)
			if ok and objects and #objects > 0 then
				local item = objects[1]
				anim = item:IsA("Animation") and item
					or item:FindFirstChildWhichIsA("Animation", true)
			end
			if not anim then
				anim = Instance.new("Animation")
				anim.AnimationId = "rbxassetid://" .. emoteId
			end
			_animCache[emoteId] = anim
		end)
	end
	if not anim then return end

	pcall(function()
		local track = animator:LoadAnimation(anim)
		track.Priority = Enum.AnimationPriority.Action4
		track.Looped   = false             -- Combo modunda döngü kapalı

		track:Play(0.3)                    -- 0.3s FADE-IN (harmanlama)
		task.delay(0.05, function()
			if track.IsPlaying then
				track:AdjustSpeed(Settings.speed)
			end
		end)

		currentAnimTrack = track
		getgenv().lastVexroEmote = {id = emoteId, name = emoteName}
		AddToRecent(emoteId)

		-- HUD'u göster (defer: ShowEmoteHUD aşağıda tanımlanır)
		task.defer(function()
			if ShowEmoteHUD then ShowEmoteHUD(emoteId, emoteName) end
		end)

		-- Track durduğunda → kuyrukta sonraki varsa çal, yoksa bitir
		track.Stopped:Connect(function()
			if not isComboActive then return end
			if #ComboQueue > 0 then
				local nxt = table.remove(ComboQueue, 1)
				PlayComboStep(nxt.id, nxt.name)
			else
				-- Döngü açıksa listeyi yeniden başlat, kuyruğu sıfırlama
				if _comboLoopEnabled and #_comboLoopList > 0 then
					ComboQueue = {}
					for i = 2, #_comboLoopList do
						ComboQueue[#ComboQueue + 1] = _comboLoopList[i]
					end
					PlayComboStep(_comboLoopList[1].id, _comboLoopList[1].name)
				else
					isComboActive = false
					task.defer(function()
						if HideEmoteHUD then HideEmoteHUD() end
					end)
					-- Combo bitince slot UI'ını sıfırla
					task.defer(function()
						if comboQueue_UI then comboQueue_UI = {} end
						if comboSlots then
							for j = 1, 3 do
								if comboSlots[j] then
									comboSlots[j].Text = L.slotLabel .. " " .. j
									TweenService:Create(comboSlots[j], TweenInfo.new(0.15), {
										BackgroundColor3 = Color3.fromRGB(30, 30, 46)
									}):Play()
								end
							end
						end
					end)
				end
			end
		end)
	end)
end

-- Combo sıralamasını başlat
local function StartCombo(emoteList)
	if #emoteList == 0 then return end
	isComboActive = true
	-- Döngü için orijinal listeyi sakla
	_comboLoopList = {}
	for _, e in ipairs(emoteList) do
		_comboLoopList[#_comboLoopList + 1] = {id = e.id, name = e.name}
	end
	ComboQueue = {}
	for i = 2, #emoteList do
		ComboQueue[#ComboQueue + 1] = emoteList[i]
	end
	PlayComboStep(emoteList[1].id, emoteList[1].name)
end

-- ----------------------------------------------------------------
-- BÖLÜM 3 — CANLI EMOTE HUD (Alt-Orta Şeffaf Panel)
-- RenderStepped canlı slider, hız butonları (0.1x–2x),
-- bilgi popup, sürüklenebilir knob, Disconnect ile FPS koruması.
-- ----------------------------------------------------------------

local hudTrackerConn = nil  -- RenderStepped bağlantısı (yönetilir)
local _hudHideToken  = 0   -- Hızlı emote geçişlerinde eski hide task'ını iptal eder

-- ▸ Ana HUD çerçevesi (forward declared above — do NOT add local here)
HUD = Instance.new("Frame")
HUD.Name                   = "VexroHUD"
HUD.Size                   = isMobile and UDim2.new(0, 320, 0, 100) or UDim2.new(0, 500, 0, 104)
HUD.Position               = UDim2.new(0.5, 0, 1, -120)
HUD.AnchorPoint            = Vector2.new(0.5, 1)
HUD.BackgroundColor3       = Color3.fromRGB(8, 8, 12)
HUD.BackgroundTransparency = 0.30
HUD.BorderSizePixel        = 0
HUD.Visible                = false
HUD.ZIndex                 = 500
HUD.ClipsDescendants       = false
HUD.Parent                 = gui
Instance.new("UICorner", HUD).CornerRadius = UDim.new(0, 14)

local hudStroke = Instance.new("UIStroke")
hudStroke.Color        = currentTheme.stroke
hudStroke.Thickness    = 1.5
hudStroke.Transparency = 0.25
hudStroke.Parent       = HUD

-- ▸ Sol üst: Favori yıldızı
local hudFavBtn = Instance.new("ImageButton")
hudFavBtn.Size                   = UDim2.new(0, 22, 0, 22)
hudFavBtn.Position               = UDim2.new(0, 9, 0, 6)
hudFavBtn.BackgroundColor3       = Color3.fromRGB(30, 30, 46)
hudFavBtn.BackgroundTransparency = 0.20
hudFavBtn.Image                  = ResolveAssetImage(Icons.FavoriteEmpty)
hudFavBtn.ImageColor3            = currentTheme.accent
hudFavBtn.ZIndex                 = 502
hudFavBtn.Parent                 = HUD
Instance.new("UICorner", hudFavBtn).CornerRadius = UDim.new(1, 0)

local function RefreshHUDFavBtn()
	if not _currentInfoId then return end
	local isFav = IsFavorite(_currentInfoId)
	hudFavBtn.Image      = ResolveAssetImage(isFav and Icons.FavoriteFull or Icons.FavoriteEmpty)
	TweenService:Create(hudFavBtn, TweenInfo.new(0.15), {
		ImageColor3      = isFav and Color3.fromRGB(255, 215, 0) or currentTheme.accent,
		BackgroundColor3 = isFav and Color3.fromRGB(55, 45, 10) or Color3.fromRGB(30, 30, 46)
	}):Play()
end

hudFavBtn.MouseButton1Click:Connect(function()
	if not _currentInfoId then return end
	ToggleFavorite(_currentInfoId)
	RefreshHUDFavBtn()
end)

-- ▸ Sol alt: "i" bilgi ikonu
local hudInfoBtn = Instance.new("TextButton")
hudInfoBtn.Size                   = UDim2.new(0, 22, 0, 22)
hudInfoBtn.Position               = UDim2.new(0, 9, 0, 32)
hudInfoBtn.BackgroundColor3       = currentTheme.accent
hudInfoBtn.BackgroundTransparency = 0.40
hudInfoBtn.Text                   = "i"
hudInfoBtn.TextColor3             = Color3.new(1, 1, 1)
hudInfoBtn.Font                   = Enum.Font.GothamBold
hudInfoBtn.TextSize               = 12
hudInfoBtn.ZIndex                 = 502
hudInfoBtn.Parent                 = HUD
Instance.new("UICorner", hudInfoBtn).CornerRadius = UDim.new(1, 0)

-- ▸ Orta üst: Emote adı
local hudName = Instance.new("TextLabel")
hudName.Size                   = UDim2.new(1, -130, 0, 22)
hudName.Position               = UDim2.new(0, 44, 0, 7)
hudName.BackgroundTransparency = 1
hudName.Text                   = ""
hudName.TextColor3             = Color3.new(1, 1, 1)
hudName.Font                   = Enum.Font.GothamBold
hudName.TextSize               = isMobile and 13 or 15
hudName.TextXAlignment         = Enum.TextXAlignment.Left
hudName.TextTruncate           = Enum.TextTruncate.AtEnd
hudName.ZIndex                 = 501
hudName.Parent                 = HUD

-- ▸ Orta alt: Creator (daha küçük, sönük)
local hudCreator = Instance.new("TextLabel")
hudCreator.Size                   = UDim2.new(1, -130, 0, 15)
hudCreator.Position               = UDim2.new(0, 44, 0, 30)
hudCreator.BackgroundTransparency = 1
hudCreator.Text                   = "Vexro Emotes"
hudCreator.TextColor3             = Color3.fromRGB(120, 120, 145)
hudCreator.Font                   = Enum.Font.Gotham
hudCreator.TextSize               = isMobile and 10 or 11
hudCreator.TextXAlignment         = Enum.TextXAlignment.Left
hudCreator.ZIndex                 = 501
hudCreator.Parent                 = HUD

-- ▸ Progress slider arka planı
local hudSliderBg = Instance.new("Frame")
hudSliderBg.Size             = UDim2.new(1, -148, 0, 4)
hudSliderBg.Position         = UDim2.new(0, 44, 0, 54)
hudSliderBg.BackgroundColor3 = Color3.fromRGB(42, 42, 58)
hudSliderBg.ZIndex           = 501
hudSliderBg.Parent           = HUD
Instance.new("UICorner", hudSliderBg).CornerRadius = UDim.new(1, 0)

-- İlerleme (fill) kısmı
local hudFill = Instance.new("Frame")
hudFill.Size             = UDim2.new(0, 0, 1, 0)
hudFill.BackgroundColor3 = currentTheme.accent
hudFill.ZIndex           = 502
hudFill.Parent           = hudSliderBg
Instance.new("UICorner", hudFill).CornerRadius = UDim.new(1, 0)

-- Sürüklenebilir tutaç (knob)
local hudKnob = Instance.new("TextButton")
hudKnob.Size             = UDim2.new(0, 12, 0, 12)
hudKnob.AnchorPoint      = Vector2.new(0.5, 0.5)
hudKnob.Position         = UDim2.new(0, 0, 0.5, 0)
hudKnob.BackgroundColor3 = Color3.new(1, 1, 1)
hudKnob.Text             = ""
hudKnob.ZIndex           = 503
hudKnob.Parent           = hudSliderBg
Instance.new("UICorner", hudKnob).CornerRadius = UDim.new(1, 0)

-- ▸ Orta-alt: Duraklat / Devam Et butonu
local hudPauseBtn = Instance.new("ImageButton")
hudPauseBtn.Size                   = UDim2.new(0, 60, 0, 22)
hudPauseBtn.AnchorPoint            = Vector2.new(0.5, 0)
hudPauseBtn.Position               = UDim2.new(0.5, 0, 0, 66)
hudPauseBtn.BackgroundColor3       = Color3.fromRGB(30, 30, 46)
hudPauseBtn.BackgroundTransparency = 0.10
hudPauseBtn.Image                  = ResolveAssetImage("rbxassetid://113416463749658")
hudPauseBtn.ImageColor3            = Color3.new(1, 1, 1)
hudPauseBtn.ScaleType              = Enum.ScaleType.Fit
hudPauseBtn.ZIndex                 = 503
hudPauseBtn.Parent                 = HUD
Instance.new("UICorner", hudPauseBtn).CornerRadius = UDim.new(0, 7)

local hudPauseBtnStroke = Instance.new("UIStroke")
hudPauseBtnStroke.Color       = currentTheme.stroke
hudPauseBtnStroke.Thickness   = 1
hudPauseBtnStroke.Transparency = 0.40
hudPauseBtnStroke.Parent      = hudPauseBtn

local function RefreshHudPauseBtn()
	if _isPaused then
		hudPauseBtn.Image = ResolveAssetImage("rbxassetid://129338178452237")
		hudPauseBtn.BackgroundColor3 = currentTheme.accent
	else
		hudPauseBtn.Image = ResolveAssetImage("rbxassetid://113416463749658")
		hudPauseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 46)
	end
end

hudPauseBtn.MouseButton1Click:Connect(function()
	-- Onceligi duraklat halini kontrol etmeye ver (hiz=0 iken IsPlaying hala true)
	if currentAnimTrack and _isPaused then
		pcall(function() currentAnimTrack:AdjustSpeed(Settings.speed) end)
		_SetPauseState(false)
	elseif currentAnimTrack and currentAnimTrack.IsPlaying then
		pcall(function() currentAnimTrack:AdjustSpeed(0) end)
		_SetPauseState(true)
	end
end)

-- Bridge'i buraya bağla: stopBtn _onPauseStateChanged'i çağırınca hudPauseBtn güncellenir
_onPauseStateChanged = function(paused)
	RefreshHudPauseBtn()
end

-- ▸ Sağ: Hız kontrol butonları (0.1x  0.5x  1x  1.5x  2x)
local HUD_SPEEDS = {0.1, 0.5, 1, 1.5, 2}
local HUD_LABELS = {"0.1", "0.5", "1x", "1.5", "2x"}
local hudSpeedBtns = {}
local spBtnW   = isMobile and 26 or 30
local spBtnGap = 3
local spTotalW = #HUD_SPEEDS * spBtnW + (#HUD_SPEEDS - 1) * spBtnGap

-- Aktif hız butonunu vurgula
local function RefreshHUDSpeedBtns()
	for i, btn in ipairs(hudSpeedBtns) do
		local active = math.abs(HUD_SPEEDS[i] - Settings.speed) < 0.01
		TweenService:Create(btn, TweenInfo.new(0.15), {
			BackgroundColor3 = active and currentTheme.accent or Color3.fromRGB(30, 30, 46)
		}):Play()
	end
end

for si, spd in ipairs(HUD_SPEEDS) do
	local xOff = -(spTotalW + 8) + (si - 1) * (spBtnW + spBtnGap)
	local sBtn = Instance.new("TextButton")
	sBtn.Size                   = UDim2.new(0, spBtnW, 0, 20)
	sBtn.Position               = UDim2.new(1, xOff, 0, 7)
	sBtn.BackgroundColor3       = (math.abs(spd - Settings.speed) < 0.01)
		and currentTheme.accent or Color3.fromRGB(30, 30, 46)
	sBtn.BackgroundTransparency = 0.15
	sBtn.Text                   = HUD_LABELS[si]
	sBtn.TextColor3             = Color3.new(1, 1, 1)
	sBtn.Font                   = Enum.Font.GothamBold
	sBtn.TextSize               = 10
	sBtn.ZIndex                 = 502
	sBtn.Parent                 = HUD
	Instance.new("UICorner", sBtn).CornerRadius = UDim.new(0, 5)
	hudSpeedBtns[si] = sBtn

	sBtn.MouseButton1Click:Connect(function()
		Settings.speed = spd
		-- Anlık hız uygula (AdjustSpeed)
		if currentAnimTrack and currentAnimTrack.IsPlaying then
			pcall(function() currentAnimTrack:AdjustSpeed(spd) end)
		end
		RefreshHUDSpeedBtns()
		SaveData()
	end)
end

-- ▸ Bilgi Paneli — gui'ye bağlı ayrı sekme (HUD'a değil)
-- HUD'dan bağımsız; ClipsDescendants sorunu olmaz (forward declared above — do NOT add local here)
infoPanel = Instance.new("Frame")
infoPanel.Name                   = "VexroInfoPanel"
infoPanel.Size                   = UDim2.new(0, 270, 0, 260)
infoPanel.Position               = UDim2.new(0, -290, 1, -285) -- Başlangıç: sol dışarıda
infoPanel.BackgroundColor3       = Color3.fromRGB(10, 10, 18)
infoPanel.BackgroundTransparency = 0.08
infoPanel.BorderSizePixel        = 0
infoPanel.Visible                = false
infoPanel.ZIndex                 = 700
infoPanel.Parent                 = gui
Instance.new("UICorner", infoPanel).CornerRadius = UDim.new(0, 14)

local infoPanelStroke = Instance.new("UIStroke")
infoPanelStroke.Color       = currentTheme.accent
infoPanelStroke.Thickness   = 1.5
infoPanelStroke.Transparency = 0.30
infoPanelStroke.Parent      = infoPanel

-- Başlık çubuğu (sürükleme tutacağı)
local infoPanelTitle = Instance.new("Frame")
infoPanelTitle.Size             = UDim2.new(1, 0, 0, 36)
infoPanelTitle.BackgroundColor3 = currentTheme.accent
infoPanelTitle.BackgroundTransparency = 0.55
infoPanelTitle.ZIndex           = 701
infoPanelTitle.Active           = true   -- input alabilsin
infoPanelTitle.Parent           = infoPanel
Instance.new("UICorner", infoPanelTitle).CornerRadius = UDim.new(0, 14)
-- Alt köşeleri düzeltmek için overlay
local infoPanelTitleOverlay = Instance.new("Frame")
infoPanelTitleOverlay.Size             = UDim2.new(1, 0, 0, 14)
infoPanelTitleOverlay.Position         = UDim2.new(0, 0, 1, -14)
infoPanelTitleOverlay.BackgroundColor3 = currentTheme.accent
infoPanelTitleOverlay.BackgroundTransparency = 0.55
infoPanelTitleOverlay.BorderSizePixel  = 0
infoPanelTitleOverlay.ZIndex           = 701
infoPanelTitleOverlay.Parent           = infoPanelTitle

-- Başlık ikonu (Icons.Info)
local infoPanelTitleIcon = Instance.new("ImageLabel")
infoPanelTitleIcon.Size             = UDim2.new(0, 20, 0, 20)
infoPanelTitleIcon.Position         = UDim2.new(0, 10, 0.5, -10)
infoPanelTitleIcon.BackgroundTransparency = 1
infoPanelTitleIcon.Image            = ResolveAssetImage(Icons.Info)
infoPanelTitleIcon.ImageColor3      = Color3.new(1, 1, 1)
infoPanelTitleIcon.ZIndex           = 702
infoPanelTitleIcon.Parent           = infoPanelTitle

local infoPanelTitleLbl = Instance.new("TextLabel")
infoPanelTitleLbl.Size                   = UDim2.new(1, -62, 1, 0)
infoPanelTitleLbl.Position               = UDim2.new(0, 36, 0, 0)
infoPanelTitleLbl.BackgroundTransparency = 1
infoPanelTitleLbl.Text                   = L.infoTitle
infoPanelTitleLbl.TextColor3             = Color3.new(1, 1, 1)
infoPanelTitleLbl.Font                   = Enum.Font.GothamBold
infoPanelTitleLbl.TextSize               = 14
infoPanelTitleLbl.TextXAlignment         = Enum.TextXAlignment.Left
infoPanelTitleLbl.ZIndex                 = 702
infoPanelTitleLbl.Parent                 = infoPanelTitle

-- Kapat butonu — orijinal CLOSE_SHAPE (iki çapraz çizgi, emoji yok)
local infoPanelClose = Instance.new("TextButton")
infoPanelClose.Size             = UDim2.new(0, 24, 0, 24)
infoPanelClose.Position         = UDim2.new(1, -30, 0.5, -12)
infoPanelClose.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
infoPanelClose.BackgroundTransparency = 0.30
infoPanelClose.Text             = ""
infoPanelClose.ZIndex           = 703
infoPanelClose.Parent           = infoPanelTitle
Instance.new("UICorner", infoPanelClose).CornerRadius = UDim.new(1, 0)

-- Çarpı çizgileri (MakeBtn'deki CLOSE_SHAPE ile aynı mantık)
do
	local thick = 2
	local lineLen = 10
	local cl1 = Instance.new("Frame")
	cl1.BorderSizePixel = 0
	cl1.Size       = UDim2.new(0, lineLen, 0, thick)
	cl1.AnchorPoint = Vector2.new(0.5, 0.5)
	cl1.Position   = UDim2.fromScale(0.5, 0.5)
	cl1.Rotation   = 45
	cl1.BackgroundColor3 = Color3.new(1, 1, 1)
	cl1.ZIndex     = 704
	cl1.Parent     = infoPanelClose
	Instance.new("UICorner", cl1).CornerRadius = UDim.new(0, 2)
	local cl2 = cl1:Clone()
	cl2.Rotation  = -45
	cl2.Parent    = infoPanelClose
end

-- İçerik alanı
local infoPanelBody = Instance.new("Frame")
infoPanelBody.Size                   = UDim2.new(1, -24, 1, -46)
infoPanelBody.Position               = UDim2.new(0, 12, 0, 42)
infoPanelBody.BackgroundTransparency = 1
infoPanelBody.ZIndex                 = 701
infoPanelBody.Parent                 = infoPanel

-- 1) Emote adı
local infoEmoteName = Instance.new("TextLabel")
infoEmoteName.Size                   = UDim2.new(1, 0, 0, 22)
infoEmoteName.Position               = UDim2.new(0, 0, 0, 0)
infoEmoteName.BackgroundTransparency = 1
infoEmoteName.Text                   = "—"
infoEmoteName.TextColor3             = Color3.new(1, 1, 1)
infoEmoteName.Font                   = Enum.Font.GothamBold
infoEmoteName.TextSize               = 16
infoEmoteName.TextXAlignment         = Enum.TextXAlignment.Left
infoEmoteName.TextTruncate           = Enum.TextTruncate.AtEnd
infoEmoteName.ZIndex                 = 702
infoEmoteName.Parent                 = infoPanelBody

-- 2) Açıklama (ismin hemen altı)
local infoDescLbl = Instance.new("TextLabel")
infoDescLbl.Size                   = UDim2.new(1, 0, 0, 28)
infoDescLbl.Position               = UDim2.new(0, 0, 0, 24)
infoDescLbl.BackgroundTransparency = 1
infoDescLbl.Text                   = "—"
infoDescLbl.TextColor3             = Color3.fromRGB(140, 140, 165)
infoDescLbl.Font                   = Enum.Font.Gotham
infoDescLbl.TextSize               = 11
infoDescLbl.TextXAlignment         = Enum.TextXAlignment.Left
infoDescLbl.TextYAlignment         = Enum.TextYAlignment.Top
infoDescLbl.TextWrapped            = true
infoDescLbl.ZIndex                 = 702
infoDescLbl.Parent                 = infoPanelBody

-- Ayırıcı çizgi
local infoDivider = Instance.new("Frame")
infoDivider.Size             = UDim2.new(1, 0, 0, 1)
infoDivider.Position         = UDim2.new(0, 0, 0, 56)
infoDivider.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
infoDivider.BorderSizePixel  = 0
infoDivider.ZIndex           = 702
infoDivider.Parent           = infoPanelBody

-- 3) Creator
do
	local ic = Instance.new("ImageLabel")
	ic.Size = UDim2.new(0, 13, 0, 13); ic.Position = UDim2.new(0, 0, 0, 63)
	ic.BackgroundTransparency = 1; ic.Image = Icons.Crown; ic.ZIndex = 702
	ic.Parent = infoPanelBody
end
local infoCreatorLbl = Instance.new("TextLabel")
infoCreatorLbl.Size                   = UDim2.new(1, -18, 0, 16)
infoCreatorLbl.Position               = UDim2.new(0, 18, 0, 61)
infoCreatorLbl.BackgroundTransparency = 1
infoCreatorLbl.Text                   = "—"
infoCreatorLbl.TextColor3             = Color3.fromRGB(140, 200, 255)
infoCreatorLbl.Font                   = Enum.Font.Gotham
infoCreatorLbl.TextSize               = 12
infoCreatorLbl.TextXAlignment         = Enum.TextXAlignment.Left
infoCreatorLbl.ZIndex                 = 702
infoCreatorLbl.Parent                 = infoPanelBody

-- 4) Hız
do
	local ic = Instance.new("ImageLabel")
	ic.Size = UDim2.new(0, 13, 0, 13); ic.Position = UDim2.new(0, 0, 0, 83)
	ic.BackgroundTransparency = 1; ic.Image = Icons.Emote; ic.ZIndex = 702
	ic.Parent = infoPanelBody
end
-- infoSpeedLbl: forward declared above
infoSpeedLbl = Instance.new("TextLabel")
infoSpeedLbl.Size                   = UDim2.new(1, -18, 0, 16)
infoSpeedLbl.Position               = UDim2.new(0, 18, 0, 81)
infoSpeedLbl.BackgroundTransparency = 1
infoSpeedLbl.Text                   = L.speed .. ": 1x"
infoSpeedLbl.TextColor3             = Color3.fromRGB(160, 160, 185)
infoSpeedLbl.Font                   = Enum.Font.Gotham
infoSpeedLbl.TextSize               = 12
infoSpeedLbl.TextXAlignment         = Enum.TextXAlignment.Left
infoSpeedLbl.ZIndex                 = 702
infoSpeedLbl.Parent                 = infoPanelBody

-- RefreshHUDSpeedBtns ve infoSpeedLbl artık tanımlı — bridge'i bağla
_onSpeedChanged = function()
	RefreshHUDSpeedBtns()
	if infoSpeedLbl then
		infoSpeedLbl.Text = L.speed .. ": " .. tostring(Settings.speed) .. "x"
	end
end

-- 5) Fiyat (tam genişlik)
local infoPriceLbl = Instance.new("TextLabel")
infoPriceLbl.Size                   = UDim2.new(1, 0, 0, 16)
infoPriceLbl.Position               = UDim2.new(0, 0, 0, 101)
infoPriceLbl.BackgroundTransparency = 1
infoPriceLbl.Text                   = "—"
infoPriceLbl.TextColor3             = Color3.fromRGB(160, 160, 185)
infoPriceLbl.Font                   = Enum.Font.GothamBold
infoPriceLbl.TextSize               = 12
infoPriceLbl.TextXAlignment         = Enum.TextXAlignment.Left
infoPriceLbl.ZIndex                 = 702
infoPriceLbl.Parent                 = infoPanelBody

-- 6) Favori sayısı (tam genişlik)
local infoFavLbl = Instance.new("TextLabel")
infoFavLbl.Size                   = UDim2.new(1, 0, 0, 16)
infoFavLbl.Position               = UDim2.new(0, 0, 0, 120)
infoFavLbl.BackgroundTransparency = 1
infoFavLbl.Text                   = "—"
infoFavLbl.TextColor3             = Color3.fromRGB(160, 160, 185)
infoFavLbl.Font                   = Enum.Font.Gotham
infoFavLbl.TextSize               = 12
infoFavLbl.TextXAlignment         = Enum.TextXAlignment.Left
infoFavLbl.ZIndex                 = 702
infoFavLbl.Parent                 = infoPanelBody

-- 7) Yaratılma tarihi
do
	local ic = Instance.new("ImageLabel")
	ic.Size = UDim2.new(0, 13, 0, 13); ic.Position = UDim2.new(0, 0, 0, 141)
	ic.BackgroundTransparency = 1; ic.Image = Icons.Recent; ic.ZIndex = 702
	ic.Parent = infoPanelBody
end
local infoDateLbl = Instance.new("TextLabel")
infoDateLbl.Size                   = UDim2.new(1, -18, 0, 16)
infoDateLbl.Position               = UDim2.new(0, 18, 0, 139)
infoDateLbl.BackgroundTransparency = 1
infoDateLbl.Text                   = "—"
infoDateLbl.TextColor3             = Color3.fromRGB(130, 130, 155)
infoDateLbl.Font                   = Enum.Font.Gotham
infoDateLbl.TextSize               = 11
infoDateLbl.TextXAlignment         = Enum.TextXAlignment.Left
infoDateLbl.ZIndex                 = 702
infoDateLbl.Parent                 = infoPanelBody

-- 8) Copy ID butonu + Arkadaş Ekle Modu butonu
local friendAddModeBtn = Instance.new("TextButton")
friendAddModeBtn.Size             = UDim2.new(0.48, -2, 0, 26)
friendAddModeBtn.Position         = UDim2.new(0, 0, 0, 161)
friendAddModeBtn.BackgroundColor3 = currentTheme.critical
friendAddModeBtn.Text             = ""
friendAddModeBtn.ZIndex           = 703
friendAddModeBtn.Parent           = infoPanelBody
Instance.new("UICorner", friendAddModeBtn).CornerRadius = UDim.new(0, 8)
local _faBtnImg = Instance.new("ImageLabel")
_faBtnImg.Size = UDim2.new(0, 16, 0, 16)
_faBtnImg.AnchorPoint = Vector2.new(0.5, 0.5)
_faBtnImg.Position = UDim2.new(0.5, 0, 0.5, 0)
_faBtnImg.BackgroundTransparency = 1
_faBtnImg.Image = ResolveAssetImage("rbxassetid://119398141999369")
_faBtnImg.ImageColor3 = Color3.new(1,1,1)
_faBtnImg.ZIndex = 704
_faBtnImg.Parent = friendAddModeBtn

local copyIdBtn = Instance.new("TextButton")
copyIdBtn.Size             = UDim2.new(0.52, -2, 0, 26)
copyIdBtn.Position         = UDim2.new(0.48, 2, 0, 161)
copyIdBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
copyIdBtn.Text             = L.copyId
copyIdBtn.TextColor3       = Color3.fromRGB(180, 180, 210)
copyIdBtn.Font             = Enum.Font.GothamBold
copyIdBtn.TextSize         = 12
copyIdBtn.ZIndex           = 703
copyIdBtn.Parent           = infoPanelBody
Instance.new("UICorner", copyIdBtn).CornerRadius = UDim.new(0, 8)
local copyIdStroke = Instance.new("UIStroke")
copyIdStroke.Color       = Color3.fromRGB(70, 70, 100)
copyIdStroke.Thickness   = 1
copyIdStroke.Parent      = copyIdBtn

local infoIdLbl = nil -- eski referans (kaldırıldı)

-- Panel aç/kapa fonksiyonu
local infoPanelOpen = false
local INFO_OPEN_POS  = UDim2.new(0, 10, 1, -285)
local INFO_CLOSE_POS = UDim2.new(0, -290, 1, -285)

local _copyIdTarget = 0  -- Copy ID için mevcut emote id'si

local function _applyMetaToInfoPanel(meta)
	-- Yaratıcı
	infoCreatorLbl.Text = (meta.creatorName and meta.creatorName ~= "") and meta.creatorName or "—"
	-- Açıklama
	infoDescLbl.Text    = (meta.description and meta.description ~= "") and meta.description or L.noDesc
	-- Fiyat
	if meta.priceStatus == "Free" or meta.price == 0 then
		infoPriceLbl.Text       = L.freePrice
		infoPriceLbl.TextColor3 = Color3.fromRGB(100, 220, 130)
	elseif meta.price and meta.price > 0 then
		infoPriceLbl.Text       = tostring(meta.price) .. " R$"
		infoPriceLbl.TextColor3 = Color3.fromRGB(255, 200, 80)
	else
		infoPriceLbl.Text       = (meta.priceStatus and meta.priceStatus ~= "") and meta.priceStatus or "—"
		infoPriceLbl.TextColor3 = Color3.fromRGB(160, 160, 185)
	end
	-- Favori sayısı
	infoFavLbl.Text = meta.favoriteCount
		and ("♥ " .. tostring(meta.favoriteCount))
		or "—"
	-- Tarih
	if meta.createdUtc and meta.createdUtc ~= "" then
		infoDateLbl.Text = meta.createdUtc:sub(1, 10)
	else
		infoDateLbl.Text = "—"
	end
	-- HUD creator
	hudCreator.Text = (meta.creatorName and meta.creatorName ~= "") and meta.creatorName or "Vexro Emotes"
end

local function _fetchAndCacheMeta(numId, targetId)
	-- MarketplaceService ile metadata çek (native Roblox, HTTP'ye gerek yok)
	local ok, info = pcall(function()
		return game:GetService("MarketplaceService"):GetProductInfo(numId)
	end)
	if not ok or not info then return end

	local price      = info.PriceInRobux
	local isFree     = info.IsPublicDomain or (price and price == 0)
	local isNotSale  = info.IsForSale == false and not isFree

	local meta = {
		creatorName   = tostring((info.Creator and info.Creator.Name) or ""),
		description   = tostring(info.Description or ""),
		price         = isFree and 0 or price,
		priceStatus   = isFree and "Free" or (isNotSale and "Not for sale" or ""),
		favoriteCount = nil,
		createdUtc    = "",
	}

	_emoteMetaCache[numId] = meta

	-- emotes tablosunu da güncelle (gelecekteki arama için)
	local eData = EmotesById[numId]
	if eData then
		eData.creatorName   = meta.creatorName
		eData.description   = meta.description
		eData.price         = meta.price
		eData.priceStatus   = meta.priceStatus
		eData.favoriteCount = meta.favoriteCount
		eData.createdUtc    = meta.createdUtc
	end

	-- Panel hâlâ aynı emote için açıksa UI'yi güncelle
	if infoPanelOpen and _copyIdTarget == numId then
		_applyMetaToInfoPanel(meta)
	end
end

local function OpenInfoPanel(emoteId, emoteName)
	infoEmoteName.Text  = emoteName or "—"
	infoSpeedLbl.Text   = L.speed .. ": " .. tostring(Settings.speed) .. "x"
	infoPanelStroke.Color           = currentTheme.accent
	infoPanelTitle.BackgroundColor3 = currentTheme.accent
	_copyIdTarget = tonumber(emoteId) or 0

	local numId = tonumber(emoteId)

	-- Önce önbellekten veya Emotes tablosundan bak
	local meta = _emoteMetaCache[numId]
	if not meta then
		local eData = EmotesById[numId]
		if eData and eData.creatorName ~= "" then
			-- Emotes tablosunda zaten tam veri var
			meta = eData
		end
	end

	if meta then
		_applyMetaToInfoPanel(meta)
	else
		-- Placeholder göster, arka planda çek
		infoCreatorLbl.Text = "…"
		infoDescLbl.Text    = "…"
		infoPriceLbl.Text   = "…"
		infoPriceLbl.TextColor3 = Color3.fromRGB(160, 160, 185)
		infoFavLbl.Text     = "…"
		infoDateLbl.Text    = "…"
		hudCreator.Text     = "Vexro Emotes"
		if numId and numId > 0 then
			task.spawn(_fetchAndCacheMeta, numId, numId)
		end
	end

	-- Copy ID buton tıklama
	copyIdBtn.Text = L.copyId .. ": " .. tostring(numId)

	infoPanel.Position = INFO_CLOSE_POS
	infoPanel.Visible  = true
	infoPanelOpen      = true
	TweenService:Create(infoPanel,
		TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{Position = INFO_OPEN_POS}
	):Play()
	TweenService:Create(hudInfoBtn, TweenInfo.new(0.15),
		{BackgroundTransparency = 0.05}):Play()
end

copyIdBtn.MouseButton1Click:Connect(function()
	pcall(function()
		if setclipboard then
			setclipboard(tostring(_copyIdTarget))
		end
	end)
	local orig = copyIdBtn.Text
	copyIdBtn.Text            = L.copied
	copyIdBtn.TextColor3      = Color3.fromRGB(100, 220, 130)
	task.delay(1.5, function()
		copyIdBtn.Text       = orig
		copyIdBtn.TextColor3 = Color3.fromRGB(180, 180, 210)
	end)
end)

local function CloseInfoPanel()
	infoPanelOpen = false
	-- Panelin şu anki konumundan sola kayarak kapan (sürüklendiyse oradan çıkar)
	local curX = infoPanel.AbsolutePosition.X
	local curY = infoPanel.AbsolutePosition.Y
	local exitPos = UDim2.new(0, curX - 300, 0, curY)
	TweenService:Create(infoPanel,
		TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{Position = exitPos}
	):Play()
	TweenService:Create(hudInfoBtn, TweenInfo.new(0.15),
		{BackgroundTransparency = 0.40}):Play()
	task.delay(0.22, function()
		if not infoPanelOpen then infoPanel.Visible = false end
	end)
end

-- "i" butonuna tıklayınca panel aç/kapat
hudInfoBtn.MouseButton1Click:Connect(function()
	if infoPanelOpen then
		CloseInfoPanel()
	else
		OpenInfoPanel(_currentInfoId or 0, _currentInfoName or "Emote")
	end
end)
infoPanelClose.MouseButton1Click:Connect(CloseInfoPanel)

-- ▸ InfoPanel sürükle-bırak — başlık çubuğundan tutarak taşı
local _ipDragActive     = false
local _ipDragMouseStart = Vector2.zero
local _ipDragPanelStart = Vector2.zero

infoPanelTitle.InputBegan:Connect(function(inp)
	if inp.UserInputType ~= Enum.UserInputType.MouseButton1
	and inp.UserInputType ~= Enum.UserInputType.Touch then return end
	_ipDragActive     = true
	_ipDragMouseStart = Vector2.new(inp.Position.X, inp.Position.Y)
	_ipDragPanelStart = Vector2.new(
		infoPanel.AbsolutePosition.X,
		infoPanel.AbsolutePosition.Y
	)
end)

UserInputService.InputChanged:Connect(function(inp)
	if not _ipDragActive then return end
	if inp.UserInputType ~= Enum.UserInputType.MouseMovement
	and inp.UserInputType ~= Enum.UserInputType.Touch then return end
	local delta = Vector2.new(inp.Position.X, inp.Position.Y) - _ipDragMouseStart
	infoPanel.Position = UDim2.new(0, _ipDragPanelStart.X + delta.X,
	                               0, _ipDragPanelStart.Y + delta.Y)
end)

UserInputService.InputEnded:Connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1
	or inp.UserInputType == Enum.UserInputType.Touch then
		_ipDragActive = false
	end
end)

-- ▸ Slider knob sürükleme
local hudKnobDragging = false

hudKnob.InputBegan:Connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1
	or inp.UserInputType == Enum.UserInputType.Touch then
		hudKnobDragging = true
	end
end)

-- Slider arka planına tıkla → o noktaya atla
hudSliderBg.InputBegan:Connect(function(inp)
	if inp.UserInputType ~= Enum.UserInputType.MouseButton1
	and inp.UserInputType ~= Enum.UserInputType.Touch then return end
	if currentAnimTrack and currentAnimTrack.Length and currentAnimTrack.Length > 0 then
		local alpha = math.clamp(
			(inp.Position.X - hudSliderBg.AbsolutePosition.X) / hudSliderBg.AbsoluteSize.X,
			0, 1)
		pcall(function() currentAnimTrack.TimePosition = alpha * currentAnimTrack.Length end)
	end
end)

UserInputService.InputEnded:Connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1
	or inp.UserInputType == Enum.UserInputType.Touch then
		hudKnobDragging = false
	end
end)

-- Sürükleme → TimePosition güncelle
UserInputService.InputChanged:Connect(function(inp)
	if not hudKnobDragging then return end
	if inp.UserInputType ~= Enum.UserInputType.MouseMovement
	and inp.UserInputType ~= Enum.UserInputType.Touch then return end
	if currentAnimTrack and currentAnimTrack.Length and currentAnimTrack.Length > 0 then
		local alpha = math.clamp(
			(inp.Position.X - hudSliderBg.AbsolutePosition.X) / hudSliderBg.AbsoluteSize.X,
			0, 1)
		pcall(function() currentAnimTrack.TimePosition = alpha * currentAnimTrack.Length end)
	end
end)

-- ▸ RenderStepped: slider'ı her kare canlı güncelle
local function StartHUDTracking()
	-- Önceki bağlantıyı kes → FPS kaybını önle
	if hudTrackerConn then
		hudTrackerConn:Disconnect()
		hudTrackerConn = nil
	end

	hudTrackerConn = RunService.RenderStepped:Connect(function()
		if not currentAnimTrack or not currentAnimTrack.IsPlaying then return end
		local len = currentAnimTrack.Length
		if not len or len <= 0 then return end

		-- TimePosition / Length = ilerleme oranı (0..1)
		local alpha = math.clamp(currentAnimTrack.TimePosition / len, 0, 1)

		-- Slider fill ve knob'u güncelle (tween gerekmez, her frame smooth)
		hudFill.Size     = UDim2.new(alpha, 0, 1, 0)
		hudKnob.Position = UDim2.new(alpha, 0, 0.5, 0)

		-- Tema renkleriyle senkron tut
		hudFill.BackgroundColor3    = currentTheme.accent
		hudStroke.Color             = currentTheme.stroke
		hudInfoBtn.BackgroundColor3 = currentTheme.accent
		infoPanelStroke.Color       = currentTheme.accent
	end)
end

local function StopHUDTracking()
	-- Disconnect -> RenderStepped baglantisini kes (FPS korunur)
	if hudTrackerConn then
		hudTrackerConn:Disconnect()
		hudTrackerConn = nil
	end
end

-- ShowEmoteHUD: HUD'u asagidan kaydirarak goster
ShowEmoteHUD = function(emoteId, emoteName)
	if not Settings.showHUD then return end
	-- Bekleyen gizleme işlemini iptal et (hızlı geçiş hatası düzeltmesi)
	_hudHideToken = _hudHideToken + 1

	_currentInfoId   = emoteId
	_currentInfoName = emoteName

	RefreshHUDFavBtn()
	hudName.Text    = emoteName or "Emote"
	hudCreator.Text = "Vexro Emotes"

	-- Duraklat butonunu sıfırla
	_isPaused = false
	RefreshHudPauseBtn()

	if infoPanelOpen then
		OpenInfoPanel(emoteId, emoteName)
	end

	HUD.Position               = UDim2.new(0.5, 0, 1, -88)
	HUD.BackgroundTransparency = 1
	HUD.Visible                = true

	TweenService:Create(HUD,
		TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{Position = UDim2.new(0.5, 0, 1, -120), BackgroundTransparency = 0.30}
	):Play()

	RefreshHUDSpeedBtns()
	StartHUDTracking()
end

-- HideEmoteHUD: HUD'u asagiya kaydirarak gizle
HideEmoteHUD = function()
	_isPaused = false
	RefreshHudPauseBtn()
	-- stopBtn görselini sıfırla (doğrudan, döngü yaratmamak için)
	if _stopBtnSquare then _stopBtnSquare.Image = ResolveAssetImage("rbxassetid://113416463749658") end
	StopHUDTracking()
	TweenService:Create(HUD,
		TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{Position = UDim2.new(0.5, 0, 1, -88), BackgroundTransparency = 1}
	):Play()
	-- Token tabanlı iptal: sadece güncel token eşleşiyorsa gizle
	local token = _hudHideToken
	task.delay(0.22, function()
		if HUD and _hudHideToken == token then
			HUD.Visible = false
		end
	end)
	if infoPanelOpen then CloseInfoPanel() end
end

-- ----------------------------------------------------------------
-- BOLUM 4 - HUD & BLENDING ENTEGRASYONU
-- ----------------------------------------------------------------

local _origPlayEmote = PlayEmote
PlayEmote = function(id, name, silent)
	_origPlayEmote(id, name, silent)
	-- Anlık token'ı yakala: bu emote için geçerli token
	local myToken = _hudHideToken + 1
	_hudHideToken = myToken
	task.defer(function()
		-- Başka bir emote daha geçildiyse bu defer'ı atla
		if _hudHideToken ~= myToken then return end
		if currentAnimTrack then
			ShowEmoteHUD(id, name)
			local tracked = currentAnimTrack
			tracked.Stopped:Connect(function()
				if (currentAnimTrack == tracked or not currentAnimTrack)
				and not isComboActive then
					HideEmoteHUD()
				end
			end)
		end
	end)
end

local _origStopEmote = StopEmote
StopEmote = function(showNotif)
	_origStopEmote(showNotif)
	isComboActive = false
	ComboQueue    = {}
	HideEmoteHUD()
end

-- ----------------------------------------------------------------
-- BOLUM 5 - COMBO SIRASI
-- ----------------------------------------------------------------

-- comboQueue_UI forward declared above; reset here
comboQueue_UI = {}

local comboRow = MakeSettingRow("", L.comboTitle, 9, 196)
comboRow.Size             = UDim2.new(1, 0, 0, 196)
comboRow.ClipsDescendants = true

local comboTitleLbl = comboRow:FindFirstChildWhichIsA("TextLabel")
if comboTitleLbl then
	comboTitleLbl.Size     = UDim2.new(1, -12, 0, 20)
	comboTitleLbl.Position = UDim2.new(0, 10, 0, 5)
	comboTitleLbl.TextSize = 13
end

local slotHolder = Instance.new("Frame")
slotHolder.Size             = UDim2.new(1, -12, 0, 36)
slotHolder.Position         = UDim2.new(0, 6, 0, 28)
slotHolder.BackgroundTransparency = 1
slotHolder.ZIndex           = 9
slotHolder.Parent           = comboRow
local slotLayout = Instance.new("UIListLayout")
slotLayout.FillDirection    = Enum.FillDirection.Horizontal
slotLayout.Padding          = UDim.new(0, 5)
slotLayout.Parent           = slotHolder

-- comboSlots forward declared above; populate here
comboSlots = {}
for si = 1, 3 do
	local s = Instance.new("TextButton")
	s.Size             = UDim2.new(0.316, 0, 1, 0)
	s.BackgroundColor3 = Color3.fromRGB(30, 30, 46)
	s.Text             = L.slotLabel .. " " .. si
	s.TextColor3       = Color3.fromRGB(120, 120, 148)
	s.Font             = Enum.Font.Gotham
	s.TextSize         = 11
	s.ZIndex           = 9
	s.Parent           = slotHolder
	Instance.new("UICorner", s).CornerRadius = UDim.new(0, 8)
	comboSlots[si] = s
	s.MouseButton1Click:Connect(function()
		if comboQueue_UI[si] then
			table.remove(comboQueue_UI, si)
			for j = 1, 3 do
				local e = comboQueue_UI[j]
				comboSlots[j].Text = e and e.name:sub(1,9) or ("Slot " .. j)
				TweenService:Create(comboSlots[j], TweenInfo.new(0.15), {
					BackgroundColor3 = e and currentTheme.accent or Color3.fromRGB(30,30,46)
				}):Play()
			end
		end
	end)
end

local comboBtnHolder = Instance.new("Frame")
comboBtnHolder.Size             = UDim2.new(1, -12, 0, 30)
comboBtnHolder.Position         = UDim2.new(0, 6, 0, 70)
comboBtnHolder.BackgroundTransparency = 1
comboBtnHolder.ZIndex           = 9
comboBtnHolder.Parent           = comboRow
local comboBtnLayout = Instance.new("UIListLayout")
comboBtnLayout.FillDirection    = Enum.FillDirection.Horizontal
comboBtnLayout.Padding          = UDim.new(0, 5)
comboBtnLayout.Parent           = comboBtnHolder

local addComboBtn = Instance.new("TextButton")
addComboBtn.Size             = UDim2.new(0.5, -2, 1, 0)
addComboBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 170)
addComboBtn.Text             = L.addEmote
addComboBtn.TextColor3       = Color3.new(1, 1, 1)
addComboBtn.Font             = Enum.Font.GothamBold
addComboBtn.TextSize         = 12
addComboBtn.ZIndex           = 9
addComboBtn.Parent           = comboBtnHolder
Instance.new("UICorner", addComboBtn).CornerRadius = UDim.new(0, 8)

local playComboBtn = Instance.new("TextButton")
playComboBtn.Size             = UDim2.new(0.5, -2, 1, 0)
playComboBtn.BackgroundColor3 = Color3.fromRGB(60, 140, 80)
playComboBtn.Text             = L.playCombo
playComboBtn.TextColor3       = Color3.new(1, 1, 1)
playComboBtn.Font             = Enum.Font.GothamBold
playComboBtn.TextSize         = 12
playComboBtn.ZIndex           = 9
playComboBtn.Parent           = comboBtnHolder
Instance.new("UICorner", playComboBtn).CornerRadius = UDim.new(0, 8)

-- ▸ Loop toggle butonu
local loopComboBtn = Instance.new("TextButton")
loopComboBtn.Size             = UDim2.new(1, -12, 0, 26)
loopComboBtn.Position         = UDim2.new(0, 6, 0, 106)
loopComboBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 46)
loopComboBtn.Text             = L.loopText .. ": " .. L.off
loopComboBtn.TextColor3       = Color3.fromRGB(120, 120, 148)
loopComboBtn.Font             = Enum.Font.GothamBold
loopComboBtn.TextSize         = 12
loopComboBtn.ZIndex           = 9
loopComboBtn.Parent           = comboRow
Instance.new("UICorner", loopComboBtn).CornerRadius = UDim.new(0, 8)
local loopStroke = Instance.new("UIStroke")
loopStroke.Color        = Color3.fromRGB(60, 60, 90)
loopStroke.Thickness    = 1
loopStroke.Transparency = 0.5
loopStroke.Parent       = loopComboBtn
-- Sol taraftaki loop ikonu (Icons.Refresh asset'i)
local loopIcon = Instance.new("ImageLabel")
loopIcon.Size                   = UDim2.new(0, 14, 0, 14)
loopIcon.Position               = UDim2.new(0, 8, 0.5, -7)
loopIcon.BackgroundTransparency = 1
loopIcon.Image                  = ResolveAssetImage(Icons.Refresh)
loopIcon.ImageColor3            = Color3.fromRGB(120, 120, 148)
loopIcon.ZIndex                 = 10
loopIcon.Parent                 = loopComboBtn
-- İkona yer açmak için text'i sağa kaydır
loopComboBtn.TextXAlignment = Enum.TextXAlignment.Center

loopComboBtn.MouseButton1Click:Connect(function()
	_comboLoopEnabled = not _comboLoopEnabled
	if _comboLoopEnabled then
		loopComboBtn.Text             = L.loopText .. ": " .. L.on
		loopComboBtn.TextColor3       = Color3.new(1, 1, 1)
		loopIcon.ImageColor3          = Color3.new(1, 1, 1)
		TweenService:Create(loopComboBtn, TweenInfo.new(0.2), {
			BackgroundColor3 = currentTheme.accent
		}):Play()
		loopStroke.Color = currentTheme.accent
	else
		loopComboBtn.Text             = L.loopText .. ": " .. L.off
		loopComboBtn.TextColor3       = Color3.fromRGB(120, 120, 148)
		loopIcon.ImageColor3          = Color3.fromRGB(120, 120, 148)
		TweenService:Create(loopComboBtn, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(30, 30, 46)
		}):Play()
		loopStroke.Color = Color3.fromRGB(60, 60, 90)
	end
end)

local clearComboBtn = Instance.new("TextButton")
clearComboBtn.Size             = UDim2.new(1, -12, 0, 26)
clearComboBtn.Position         = UDim2.new(0, 6, 0, 138)
clearComboBtn.BackgroundColor3 = Color3.fromRGB(140, 40, 40)
clearComboBtn.Text             = L.clearCombo
clearComboBtn.TextColor3       = Color3.new(1, 1, 1)
clearComboBtn.Font             = Enum.Font.GothamBold
clearComboBtn.TextSize         = 12
clearComboBtn.ZIndex           = 9
clearComboBtn.Parent           = comboRow
Instance.new("UICorner", clearComboBtn).CornerRadius = UDim.new(0, 8)

addComboBtn.MouseButton1Click:Connect(function()
	if #comboQueue_UI >= 3 then return end
	if not _currentInfoId then
		-- Emote seçilmedi — butonu kısa süre kırmızı yak
		local origCol = addComboBtn.BackgroundColor3
		addComboBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
		addComboBtn.Text = L.selectFirst
		task.delay(0.7, function()
			addComboBtn.BackgroundColor3 = origCol
			addComboBtn.Text = L.addEmote
		end)
		return
	end
	table.insert(comboQueue_UI, {id = _currentInfoId, name = _currentInfoName or "Emote"})
	local idx = #comboQueue_UI
	comboSlots[idx].Text = (comboQueue_UI[idx].name):sub(1, 9)
	TweenService:Create(comboSlots[idx], TweenInfo.new(0.15), {
		BackgroundColor3 = currentTheme.accent
	}):Play()
end)

playComboBtn.MouseButton1Click:Connect(function()
	if #comboQueue_UI == 0 then return end
	local list = {}
	for _, e in ipairs(comboQueue_UI) do
		table.insert(list, {id = e.id, name = e.name})
	end
	StartCombo(list)
end)

clearComboBtn.MouseButton1Click:Connect(function()
	comboQueue_UI    = {}
	isComboActive    = false
	ComboQueue       = {}
	_comboLoopList   = {}
	-- Loop kapatılsın
	if _comboLoopEnabled then
		_comboLoopEnabled             = false
		loopComboBtn.Text             = L.loopText .. ": " .. L.off
		loopComboBtn.TextColor3       = Color3.fromRGB(120, 120, 148)
		loopComboBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 46)
		loopStroke.Color              = Color3.fromRGB(60, 60, 90)
		loopIcon.ImageColor3          = Color3.fromRGB(120, 120, 148)
	end
	for j = 1, 3 do
		comboSlots[j].Text = L.slotLabel .. " " .. j
		TweenService:Create(comboSlots[j], TweenInfo.new(0.15), {
			BackgroundColor3 = Color3.fromRGB(30, 30, 46)
		}):Play()
	end
end)

-- Tema değişince loop butonu aktifse yeni accent rengine güncelle
do
	local _prevApply = ApplyTheme
	ApplyTheme = function(name)
		_prevApply(name)
		if _comboLoopEnabled and loopComboBtn and loopComboBtn.Parent then
			pcall(function()
				loopComboBtn.BackgroundColor3 = currentTheme.accent
				loopStroke.Color             = currentTheme.accent
				loopIcon.ImageColor3         = Color3.new(1, 1, 1)
			end)
		end
	end
end

end -- _VexroExtend kapatiliyor
_VexroExtend()
