-- Run Your Restaurant | Auto Collect Payment
-- UI: Rayfield Library
-- Vexro Scripts

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Vexro | Run Your Restaurant",
    Icon = 0,
    LoadingTitle = "Vexro Scripts",
    LoadingSubtitle = "Run Your Restaurant",
    Theme = "Default",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "VexroScripts",
        FileName = "RunYourRestaurant"
    },
    KeySystem = false,
})

-- Tabs
local MainTab = Window:CreateTab("Auto Farm", 4483362458)
local SettingsTab = Window:CreateTab("Settings", 4483362458)

-- Status label referansı
local StatusLabel

-- Ayarlar
local Settings = {
    AutoCollect = false,
    WalkToCustomer = true,
    CollectDelay = 0.3,
    WalkSpeed = 16,
}

-- ══════════════════════════════════════════
--  Yardımcı Fonksiyonlar
-- ══════════════════════════════════════════

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- Karakter yenilenince güncelle
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    Humanoid = newChar:WaitForChild("Humanoid")
end)

local function setStatus(text)
    if StatusLabel then
        StatusLabel:Set("Durum: " .. text)
    end
end

-- Oyuncuyu bir pozisyona yürüt (Humanoid:MoveTo ile)
local function walkTo(position, timeout)
    timeout = timeout or 5
    Humanoid:MoveTo(position)
    local startTime = tick()
    repeat
        task.wait(0.05)
    until (HumanoidRootPart.Position - position).Magnitude < 5
        or (tick() - startTime) > timeout
end

-- ══════════════════════════════════════════
--  Collect Payment Butonu Bulma & Basma
-- ══════════════════════════════════════════

-- Oyunun GUI yapısına göre "Collect Payment" butonunu bul
local function findCollectButtons()
    local buttons = {}

    -- PlayerGui altındaki tüm GUI'leri tara
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return buttons end

    for _, gui in ipairs(playerGui:GetDescendants()) do
        if (gui:IsA("TextButton") or gui:IsA("ImageButton")) then
            local name = gui.Name:lower()
            local text = (gui:IsA("TextButton") and gui.Text:lower()) or ""
            if name:find("collect") or text:find("collect")
                or name:find("payment") or text:find("payment")
                or name:find("pay") or text:find("pay") then
                if gui.Visible and gui.Active then
                    table.insert(buttons, gui)
                end
            end
        end
    end

    -- Ayrıca BillboardGui / SurfaceGui içindeki butonları ara (3D dünya)
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
            for _, child in ipairs(obj:GetDescendants()) do
                if (child:IsA("TextButton") or child:IsA("ImageButton")) then
                    local name = child.Name:lower()
                    local text = (child:IsA("TextButton") and child.Text:lower()) or ""
                    if name:find("collect") or text:find("collect")
                        or name:find("payment") or text:find("payment")
                        or name:find("pay") or text:find("pay") then
                        if child.Visible and child.Active then
                            table.insert(buttons, child)
                        end
                    end
                end
            end
        end
    end

    return buttons
end

-- Butona en yakın 3D pozisyonu bul (BillboardGui adornee'si veya parent Part)
local function getButtonWorldPosition(button)
    local bg = button:FindFirstAncestorWhichIsA("BillboardGui")
        or button:FindFirstAncestorWhichIsA("SurfaceGui")
    if bg then
        local adornee = bg.Adornee
        if adornee and adornee:IsA("BasePart") then
            return adornee.Position
        end
        -- Parent zincirinde BasePart ara
        local p = bg.Parent
        while p do
            if p:IsA("BasePart") then return p.Position end
            p = p.Parent
        end
    end
    return nil
end

-- Tek bir butona git ve bas
local function collectFromButton(button)
    if not button or not button.Visible or not button.Active then return end

    local worldPos = getButtonWorldPosition(button)

    if Settings.WalkToCustomer and worldPos then
        setStatus("Müşteriye gidiliyor...")
        walkTo(worldPos, 6)
    end

    -- Kısa bekleme sonra bas
    task.wait(Settings.CollectDelay)

    -- Butona tıklamayı simüle et
    local fireButton = function(btn)
        local ok, err = pcall(function()
            -- MouseButton1Click olayını tetikle
            btn.MouseButton1Click:Fire()
        end)
        if not ok then
            -- Alternatif: MouseButton1Down + Up
            pcall(function() btn.MouseButton1Down:Fire(0, 0, Enum.UserInputType.MouseButton1) end)
            task.wait(0.05)
            pcall(function() btn.MouseButton1Up:Fire(0, 0, Enum.UserInputType.MouseButton1) end)
        end
    end

    fireButton(button)
    setStatus("Ödeme alındı!")
end

-- ══════════════════════════════════════════
--  Ana Döngü
-- ══════════════════════════════════════════

local collectLoop = nil

local function startAutoCollect()
    if collectLoop then return end
    setStatus("Çalışıyor...")

    collectLoop = task.spawn(function()
        while Settings.AutoCollect do
            local buttons = findCollectButtons()
            if #buttons > 0 then
                setStatus(#buttons .. " ödeme bulundu!")
                for _, btn in ipairs(buttons) do
                    if not Settings.AutoCollect then break end
                    collectFromButton(btn)
                    task.wait(0.2)
                end
            else
                setStatus("Bekliyor... (müşteri yok)")
            end
            task.wait(0.5) -- Her 0.5 saniyede tara
        end
        collectLoop = nil
        setStatus("Durduruldu")
    end)
end

local function stopAutoCollect()
    Settings.AutoCollect = false
    collectLoop = nil
    setStatus("Durduruldu")
end

-- ══════════════════════════════════════════
--  Rayfield UI Elemanları
-- ══════════════════════════════════════════

-- Ana Tab
MainTab:CreateSection("Ödeme Toplama")

MainTab:CreateToggle({
    Name = "Auto Collect Payment",
    CurrentValue = false,
    Flag = "AutoCollect",
    Callback = function(value)
        Settings.AutoCollect = value
        if value then
            startAutoCollect()
        else
            stopAutoCollect()
        end
    end,
})

MainTab:CreateToggle({
    Name = "Müşteriye Yürü",
    CurrentValue = true,
    Flag = "WalkToCustomer",
    Callback = function(value)
        Settings.WalkToCustomer = value
    end,
})

MainTab:CreateSection("Durum")

StatusLabel = MainTab:CreateLabel("Durum: Bekleniyor")

MainTab:CreateButton({
    Name = "Manuel Topla (Bir Kez)",
    Callback = function()
        local buttons = findCollectButtons()
        if #buttons == 0 then
            setStatus("Buton bulunamadi!")
            Rayfield:Notify({
                Title = "Vexro",
                Content = "Collect Payment butonu bulunamadi!",
                Duration = 3,
                Image = 4483362458,
            })
        else
            for _, btn in ipairs(buttons) do
                collectFromButton(btn)
                task.wait(0.2)
            end
        end
    end,
})

-- Settings Tab
SettingsTab:CreateSection("Hız Ayarları")

SettingsTab:CreateSlider({
    Name = "Toplama Gecikmesi (saniye)",
    Range = {0, 2},
    Increment = 0.1,
    Suffix = "s",
    CurrentValue = Settings.CollectDelay,
    Flag = "CollectDelay",
    Callback = function(value)
        Settings.CollectDelay = value
    end,
})

SettingsTab:CreateSlider({
    Name = "Yürüme Hızı",
    Range = {16, 100},
    Increment = 1,
    Suffix = "",
    CurrentValue = Settings.WalkSpeed,
    Flag = "WalkSpeed",
    Callback = function(value)
        Settings.WalkSpeed = value
        if Humanoid then
            Humanoid.WalkSpeed = value
        end
    end,
})

SettingsTab:CreateSection("Hakkında")

SettingsTab:CreateLabel("Vexro Scripts | Run Your Restaurant")
SettingsTab:CreateLabel("Auto Collect Payment v1.0")

-- ══════════════════════════════════════════
--  Açılış Bildirimi
-- ══════════════════════════════════════════

Rayfield:Notify({
    Title = "Vexro Scripts",
    Content = "Run Your Restaurant scripti yüklendi!\nAuto Collect'i açmayı unutma.",
    Duration = 5,
    Image = 4483362458,
})

Rayfield:LoadConfiguration()
