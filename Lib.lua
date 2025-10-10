--[[
    ╔══════════════════════════════════════════════════════╗
    ║         DRAKTHON UI LIBRARY V2.1                     ║
    ║         Full Responsive + Enhanced System            ║
    ╚══════════════════════════════════════════════════════╝
]]--

local Library = {}
Library.Version = "2.1.0"

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ═══════════════════════════════════════════════════════
-- 📱 نظام Responsive
-- ═══════════════════════════════════════════════════════

local ViewportSize = workspace.CurrentCamera.ViewportSize

local function GetResponsiveSize(sizeType)
    local baseWidth = ViewportSize.X
    local baseHeight = ViewportSize.Y
    
    local sizes = {
        Small = {
            Width = math.clamp(baseWidth * 0.4, 400, 550),
            Height = math.clamp(baseHeight * 0.5, 350, 450)
        },
        Medium = {
            Width = math.clamp(baseWidth * 0.5, 500, 700),
            Height = math.clamp(baseHeight * 0.6, 400, 600)
        },
        Large = {
            Width = math.clamp(baseWidth * 0.6, 650, 850),
            Height = math.clamp(baseHeight * 0.7, 500, 750)
        },
        Auto = {
            Width = math.clamp(baseWidth * 0.45, 500, 700),
            Height = math.clamp(baseHeight * 0.65, 450, 650)
        }
    }
    
    return sizes[sizeType] or sizes.Auto
end

local function CreateScreenGui()
    local success, ScreenGui = pcall(function()
        return game:GetService("CoreGui"):FindFirstChild("DrakthonUI") or Instance.new("ScreenGui", game:GetService("CoreGui"))
    end)
    
    if not success then
        ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    end
    
    ScreenGui.Name = "DrakthonUI"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    
    return ScreenGui
end

-- ═══════════════════════════════════════════════════════
-- 🎨 الثيمات
-- ═══════════════════════════════════════════════════════

Library.Themes = {
    Default = {
        Background = Color3.fromRGB(15, 15, 20),
        Secondary = Color3.fromRGB(25, 25, 30),
        Tertiary = Color3.fromRGB(35, 35, 40),
        Accent = Color3.fromRGB(138, 43, 226),
        AccentHover = Color3.fromRGB(158, 63, 246),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(180, 180, 180),
        Border = Color3.fromRGB(50, 50, 60),
        Success = Color3.fromRGB(46, 204, 113),
        Warning = Color3.fromRGB(241, 196, 15),
        Error = Color3.fromRGB(231, 76, 60),
        Info = Color3.fromRGB(52, 152, 219),
    },
    Dark = {
        Background = Color3.fromRGB(10, 10, 15),
        Secondary = Color3.fromRGB(20, 20, 25),
        Tertiary = Color3.fromRGB(30, 30, 35),
        Accent = Color3.fromRGB(0, 122, 204),
        AccentHover = Color3.fromRGB(20, 142, 224),
        Text = Color3.fromRGB(240, 240, 240),
        SubText = Color3.fromRGB(160, 160, 160),
        Border = Color3.fromRGB(40, 40, 50),
        Success = Color3.fromRGB(39, 174, 96),
        Warning = Color3.fromRGB(230, 126, 34),
        Error = Color3.fromRGB(192, 57, 43),
        Info = Color3.fromRGB(41, 128, 185),
    },
    Ocean = {
        Background = Color3.fromRGB(10, 25, 40),
        Secondary = Color3.fromRGB(15, 35, 55),
        Tertiary = Color3.fromRGB(20, 45, 70),
        Accent = Color3.fromRGB(52, 152, 219),
        AccentHover = Color3.fromRGB(72, 172, 239),
        Text = Color3.fromRGB(236, 240, 241),
        SubText = Color3.fromRGB(149, 165, 166),
        Border = Color3.fromRGB(41, 128, 185),
        Success = Color3.fromRGB(26, 188, 156),
        Warning = Color3.fromRGB(243, 156, 18),
        Error = Color3.fromRGB(231, 76, 60),
        Info = Color3.fromRGB(52, 152, 219),
    },
    Midnight = {
        Background = Color3.fromRGB(18, 18, 24),
        Secondary = Color3.fromRGB(28, 28, 36),
        Tertiary = Color3.fromRGB(38, 38, 48),
        Accent = Color3.fromRGB(255, 71, 87),
        AccentHover = Color3.fromRGB(255, 91, 107),
        Text = Color3.fromRGB(248, 248, 255),
        SubText = Color3.fromRGB(170, 170, 180),
        Border = Color3.fromRGB(58, 58, 68),
        Success = Color3.fromRGB(72, 219, 251),
        Warning = Color3.fromRGB(254, 202, 87),
        Error = Color3.fromRGB(255, 71, 87),
        Info = Color3.fromRGB(158, 148, 255),
    },
    Forest = {
        Background = Color3.fromRGB(20, 25, 20),
        Secondary = Color3.fromRGB(30, 38, 30),
        Tertiary = Color3.fromRGB(40, 50, 40),
        Accent = Color3.fromRGB(76, 209, 55),
        AccentHover = Color3.fromRGB(96, 229, 75),
        Text = Color3.fromRGB(245, 245, 245),
        SubText = Color3.fromRGB(165, 175, 165),
        Border = Color3.fromRGB(60, 75, 60),
        Success = Color3.fromRGB(46, 213, 115),
        Warning = Color3.fromRGB(255, 168, 1),
        Error = Color3.fromRGB(255, 56, 56),
        Info = Color3.fromRGB(0, 184, 148),
    }
}

Library.CurrentTheme = Library.Themes.Default

-- ═══════════════════════════════════════════════════════
-- ⚡ دوال الأنيميشن
-- ═══════════════════════════════════════════════════════

local AnimationStyles = {
    Smooth = {Style = Enum.EasingStyle.Quad, Direction = Enum.EasingDirection.Out},
    Bounce = {Style = Enum.EasingStyle.Bounce, Direction = Enum.EasingDirection.Out},
    Elastic = {Style = Enum.EasingStyle.Elastic, Direction = Enum.EasingDirection.Out},
    Back = {Style = Enum.EasingStyle.Back, Direction = Enum.EasingDirection.Out},
    Linear = {Style = Enum.EasingStyle.Linear, Direction = Enum.EasingDirection.Out},
}

local function Tween(object, properties, duration, style)
    style = style or AnimationStyles.Smooth
    local tweenInfo = TweenInfo.new(duration or 0.3, style.Style, style.Direction)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

local function CreateRipple(parent, x, y)
    local Ripple = Instance.new("ImageLabel")
    Ripple.Parent = parent
    Ripple.BackgroundTransparency = 1
    Ripple.BorderSizePixel = 0
    Ripple.Position = UDim2.new(0, x, 0, y)
    Ripple.Size = UDim2.new(0, 0, 0, 0)
    Ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    Ripple.Image = "rbxassetid://266543268"
    Ripple.ImageColor3 = Library.CurrentTheme.Accent
    Ripple.ImageTransparency = 0.5
    Ripple.ZIndex = 10
    
    local size = math.max(parent.AbsoluteSize.X, parent.AbsoluteSize.Y) * 2
    
    Tween(Ripple, {
        Size = UDim2.new(0, size, 0, size),
        ImageTransparency = 1
    }, 0.6, AnimationStyles.Smooth)
    
    task.delay(0.6, function()
        Ripple:Destroy()
    end)
end

-- ═══════════════════════════════════════════════════════
-- 🔔 نظام الإشعارات المحسّن
-- ═══════════════════════════════════════════════════════

Library.Notifications = {}
Library.NotificationQueue = {}
Library.ActiveNotifications = 0
Library.MaxNotifications = 4

local NotificationIcons = {
    Success = "✓",
    Error = "✕",
    Warning = "⚠",
    Info = "ℹ",
    Default = "🔔"
}

function Library:Notify(options)
    options = options or {}
    local Title = options.Title or "Notification"
    local Description = options.Description or ""
    local Duration = options.Duration or 4
    local Type = options.Type or "Default"
    local Callback = options.Callback or function() end
    
    if Library.ActiveNotifications >= Library.MaxNotifications then
        table.insert(Library.NotificationQueue, options)
        return
    end
    
    Library.ActiveNotifications = Library.ActiveNotifications + 1
    
    local NotifGui = CreateScreenGui()
    NotifGui.Name = "NotificationGui_" .. HttpService:GenerateGUID(false)
    
    local yPosition = 10 + ((Library.ActiveNotifications - 1) * 95)
    
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Name = "NotifFrame"
    NotifFrame.Parent = NotifGui
    NotifFrame.BackgroundColor3 = Library.CurrentTheme.Secondary
    NotifFrame.BorderSizePixel = 0
    NotifFrame.Position = UDim2.new(1, 10, 0, yPosition)
    NotifFrame.Size = UDim2.new(0, 0, 0, 85)
    NotifFrame.ClipsDescendants = false
    NotifFrame.AnchorPoint = Vector2.new(0, 0)
    
    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 12)
    NotifCorner.Parent = NotifFrame
    
    local NotifShadow = Instance.new("ImageLabel")
    NotifShadow.Name = "Shadow"
    NotifShadow.Parent = NotifFrame
    NotifShadow.BackgroundTransparency = 1
    NotifShadow.Position = UDim2.new(0, -15, 0, -15)
    NotifShadow.Size = UDim2.new(1, 30, 1, 30)
    NotifShadow.ZIndex = 0
    NotifShadow.Image = "rbxassetid://6015897843"
    NotifShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    NotifShadow.ImageTransparency = 0.5
    NotifShadow.ScaleType = Enum.ScaleType.Slice
    NotifShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    
    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Parent = NotifFrame
    NotifStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    NotifStroke.Color = Type == "Success" and Library.CurrentTheme.Success or 
                        Type == "Warning" and Library.CurrentTheme.Warning or
                        Type == "Error" and Library.CurrentTheme.Error or
                        Type == "Info" and Library.CurrentTheme.Info or
                        Library.CurrentTheme.Accent
    NotifStroke.Thickness = 2
    NotifStroke.Transparency = 0.3
    
    local AccentBar = Instance.new("Frame")
    AccentBar.Name = "AccentBar"
    AccentBar.Parent = NotifFrame
    AccentBar.BackgroundColor3 = NotifStroke.Color
    AccentBar.BorderSizePixel = 0
    AccentBar.Size = UDim2.new(0, 5, 1, 0)
    
    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(0, 12)
    BarCorner.Parent = AccentBar
    
    local IconFrame = Instance.new("Frame")
    IconFrame.Name = "IconFrame"
    IconFrame.Parent = NotifFrame
    IconFrame.BackgroundColor3 = NotifStroke.Color
    IconFrame.BorderSizePixel = 0
    IconFrame.Position = UDim2.new(0, 15, 0, 12)
    IconFrame.Size = UDim2.new(0, 40, 0, 40)
    
    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(0, 10)
    IconCorner.Parent = IconFrame
    
    local Icon = Instance.new("TextLabel")
    Icon.Name = "Icon"
    Icon.Parent = IconFrame
    Icon.BackgroundTransparency = 1
    Icon.Size = UDim2.new(1, 0, 1, 0)
    Icon.Font = Enum.Font.GothamBold
    Icon.Text = NotificationIcons[Type] or NotificationIcons.Default
    Icon.TextColor3 = Library.CurrentTheme.Text
    Icon.TextSize = 20
    
    local NotifTitle = Instance.new("TextLabel")
    NotifTitle.Name = "Title"
    NotifTitle.Parent = NotifFrame
    NotifTitle.BackgroundTransparency = 1
    NotifTitle.Position = UDim2.new(0, 65, 0, 12)
    NotifTitle.Size = UDim2.new(1, -110, 0, 20)
    NotifTitle.Font = Enum.Font.GothamBold
    NotifTitle.Text = Title
    NotifTitle.TextColor3 = Library.CurrentTheme.Text
    NotifTitle.TextSize = 15
    NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
    NotifTitle.TextTruncate = Enum.TextTruncate.AtEnd
    
    local NotifDesc = Instance.new("TextLabel")
    NotifDesc.Name = "Description"
    NotifDesc.Parent = NotifFrame
    NotifDesc.BackgroundTransparency = 1
    NotifDesc.Position = UDim2.new(0, 65, 0, 35)
    NotifDesc.Size = UDim2.new(1, -110, 0, 38)
    NotifDesc.Font = Enum.Font.Gotham
    NotifDesc.Text = Description
    NotifDesc.TextColor3 = Library.CurrentTheme.SubText
    NotifDesc.TextSize = 13
    NotifDesc.TextXAlignment = Enum.TextXAlignment.Left
    NotifDesc.TextYAlignment = Enum.TextYAlignment.Top
    NotifDesc.TextWrapped = true
    
    local ProgressBar = Instance.new("Frame")
    ProgressBar.Name = "ProgressBar"
    ProgressBar.Parent = NotifFrame
    ProgressBar.BackgroundColor3 = Library.CurrentTheme.Background
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Position = UDim2.new(0, 0, 1, -4)
    ProgressBar.Size = UDim2.new(1, 0, 0, 4)
    
    local Progress = Instance.new("Frame")
    Progress.Name = "Progress"
    Progress.Parent = ProgressBar
    Progress.BackgroundColor3 = NotifStroke.Color
    Progress.BorderSizePixel = 0
    Progress.Size = UDim2.new(1, 0, 1, 0)
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = NotifFrame
    CloseButton.BackgroundColor3 = Library.CurrentTheme.Tertiary
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(1, -35, 0, 8)
    CloseButton.Size = UDim2.new(0, 28, 0, 28)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Library.CurrentTheme.SubText
    CloseButton.TextSize = 18
    CloseButton.AutoButtonColor = false
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = CloseButton
    
    CloseButton.MouseEnter:Connect(function()
        Tween(CloseButton, {BackgroundColor3 = Library.CurrentTheme.Error}, 0.2)
        Tween(CloseButton, {TextColor3 = Library.CurrentTheme.Text}, 0.2)
    end)
    
    CloseButton.MouseLeave:Connect(function()
        Tween(CloseButton, {BackgroundColor3 = Library.CurrentTheme.Tertiary}, 0.2)
        Tween(CloseButton, {TextColor3 = Library.CurrentTheme.SubText}, 0.2)
    end)
    
    local function CloseNotification()
        Library.ActiveNotifications = Library.ActiveNotifications - 1
        
        Tween(NotifFrame, {
            Position = UDim2.new(1, 10, 0, yPosition),
            Size = UDim2.new(0, 0, 0, 85)
        }, 0.4, AnimationStyles.Back)
        
        task.wait(0.4)
        NotifGui:Destroy()
        
        if #Library.NotificationQueue > 0 then
            local nextNotif = table.remove(Library.NotificationQueue, 1)
            task.wait(0.1)
            Library:Notify(nextNotif)
        end
        
        Callback()
    end
    
    CloseButton.MouseButton1Click:Connect(CloseNotification)
    
    task.spawn(function()
        Tween(NotifFrame, {
            Position = UDim2.new(1, -340, 0, yPosition),
            Size = UDim2.new(0, 330, 0, 85)
        }, 0.5, AnimationStyles.Back)
        
        task.wait(0.3)
        local originalSize = IconFrame.Size
        IconFrame.Size = UDim2.new(0, 0, 0, 0)
        Tween(IconFrame, {Size = originalSize}, 0.4, AnimationStyles.Elastic)
    end)
    
    task.spawn(function()
        Tween(Progress, {Size = UDim2.new(0, 0, 1, 0)}, Duration, AnimationStyles.Linear)
    end)
    
    task.delay(Duration, function()
        if NotifGui and NotifGui.Parent then
            CloseNotification()
        end
    end)
    
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://6895079853"
        sound.Volume = 0.3
        sound.Parent = game:GetService("SoundService")
        sound:Play()
        game:GetService("Debris"):AddItem(sound, 2)
    end)
end

-- ═══════════════════════════════════════════════════════
-- 💾 نظام حفظ الإعدادات
-- ═══════════════════════════════════════════════════════

Library.ConfigSystem = {}

function Library.ConfigSystem:Save(configName, data)
    local success, result = pcall(function()
        writefile(configName .. ".json", HttpService:JSONEncode(data))
    end)
    
    if success then
        Library:Notify({
            Title = "تم الحفظ بنجاح",
            Description = "تم حفظ الإعدادات: " .. configName,
            Type = "Success",
            Duration = 3
        })
    else
        Library:Notify({
            Title = "فشل الحفظ",
            Description = "حدث خطأ أثناء حفظ الإعدادات",
            Type = "Error",
            Duration = 3
        })
    end
end

function Library.ConfigSystem:Load(configName)
    local success, result = pcall(function()
        return HttpService:JSONDecode(readfile(configName .. ".json"))
    end)
    
    if success then
        Library:Notify({
            Title = "تم التحميل بنجاح",
            Description = "تم تحميل الإعدادات: " .. configName,
            Type = "Success",
            Duration = 3
        })
        return result
    else
        Library:Notify({
            Title = "فشل التحميل",
            Description = "لم يتم العثور على ملف الإعدادات",
            Type = "Warning",
            Duration = 3
        })
        return nil
    end
end

-- ═══════════════════════════════════════════════════════
-- 🪟 إنشاء الـ Window الرئيسي
-- ═══════════════════════════════════════════════════════

function Library:CreateWindow(options)
    options = options or {}
    local WindowTitle = options.Title or "Drakthon UI"
    local WindowSubtitle = options.Subtitle or "v" .. Library.Version
    local Theme = options.Theme or "Default"
    local SizeType = options.SizeType or "Auto"
    local Keybind = options.Keybind or Enum.KeyCode.RightControl
    
    if Library.Themes[Theme] then
        Library.CurrentTheme = Library.Themes[Theme]
    end
    
    local ResponsiveSize = GetResponsiveSize(SizeType)
    local WindowSize = UDim2.new(0, ResponsiveSize.Width, 0, ResponsiveSize.Height)
    
    local ScreenGui = CreateScreenGui()
    
    local MainContainer = Instance.new("Frame")
    MainContainer.Name = "MainContainer"
    MainContainer.Parent = ScreenGui
    MainContainer.BackgroundTransparency = 1
    MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainContainer.Size = WindowSize
    MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    MainContainer.ClipsDescendants = false
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = MainContainer
    MainFrame.BackgroundColor3 = Library.CurrentTheme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Size = UDim2.new(1, 0, 1, 0)
    MainFrame.ClipsDescendants = true
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame
    
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = MainContainer
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0, -20, 0, -20)
    Shadow.Size = UDim2.new(1, 40, 1, 40)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://6015897843"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.4
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    
    local BorderGradient = Instance.new("UIStroke")
    BorderGradient.Parent = MainFrame
    BorderGradient.Color = Library.CurrentTheme.Accent
    BorderGradient.Thickness = 1.5
    BorderGradient.Transparency = 0.7
    
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Parent = MainFrame
    Header.BackgroundColor3 = Library.CurrentTheme.Secondary
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(1, 0, 0, 50)
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Parent = Header
    
    local HeaderGradient = Instance.new("UIGradient")
    HeaderGradient.Parent = Header
    HeaderGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Library.CurrentTheme.Secondary),
        ColorSequenceKeypoint.new(1, Library.CurrentTheme.Tertiary)
    }
    HeaderGradient.Rotation = 90
    
    local Logo = Instance.new("ImageLabel")
    Logo.Name = "Logo"
    Logo.Parent = Header
    Logo.BackgroundTransparency = 1
    Logo.Position = UDim2.new(0, 12, 0.5, 0)
    Logo.Size = UDim2.new(0, 30, 0, 30)
    Logo.AnchorPoint = Vector2.new(0, 0.5)
    Logo.Image = "rbxassetid://7733992358"
    Logo.ImageColor3 = Library.CurrentTheme.Accent
    
    local LogoCorner = Instance.new("UICorner")
    LogoCorner.CornerRadius = UDim.new(1, 0)
    LogoCorner.Parent = Logo
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 50, 0, 8)
    Title.Size = UDim2.new(0.5, -50, 0, 18)
    Title.Font = Enum.Font.GothamBold
    Title.Text = WindowTitle
    Title.TextColor3 = Library.CurrentTheme.Text
    Title.TextSize = 15
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextTruncate = Enum.TextTruncate.AtEnd
    
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Name = "Subtitle"
    Subtitle.Parent = Header
    Subtitle.BackgroundTransparency = 1
    Subtitle.Position = UDim2.new(0, 50, 0, 26)
    Subtitle.Size = UDim2.new(0.5, -50, 0, 16)
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.Text = WindowSubtitle
    Subtitle.TextColor3 = Library.CurrentTheme.SubText
    Subtitle.TextSize = 12
    Subtitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local ControlsFrame = Instance.new("Frame")
    ControlsFrame.Name = "Controls"
    ControlsFrame.Parent = Header
    ControlsFrame.BackgroundTransparency = 1
    ControlsFrame.Position = UDim2.new(1, -100, 0.5, 0)
    ControlsFrame.Size = UDim2.new(0, 95, 0, 28)
    ControlsFrame.AnchorPoint = Vector2.new(0, 0.5)
    
    local ControlsList = Instance.new("UIListLayout")
    ControlsList.Parent = ControlsFrame
    ControlsList.FillDirection = Enum.FillDirection.Horizontal
    ControlsList.HorizontalAlignment = Enum.HorizontalAlignment.Right
    ControlsList.Padding = UDim.new(0, 6)
    
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "Minimize"
    MinimizeButton.Parent = ControlsFrame
    MinimizeButton.BackgroundColor3 = Library.CurrentTheme.Tertiary
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Size = UDim2.new(0, 28, 0, 28)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = Library.CurrentTheme.Text
    MinimizeButton.TextSize = 18
    MinimizeButton.AutoButtonColor = false
    
    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 7)
    MinimizeCorner.Parent = MinimizeButton
    
    local minimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Tween(MainContainer, {Size = UDim2.new(0, ResponsiveSize.Width, 0, 50)}, 0.3, AnimationStyles.Back)
            MinimizeButton.Text = "+"
        else
            Tween(MainContainer, {Size = WindowSize}, 0.3, AnimationStyles.Back)
            MinimizeButton.Text = "−"
        end
    end)
    
    MinimizeButton.MouseEnter:Connect(function()
        Tween(MinimizeButton, {BackgroundColor3 = Library.CurrentTheme.Accent}, 0.2)
    end)
    
    MinimizeButton.MouseLeave:Connect(function()
        Tween(MinimizeButton, {BackgroundColor3 = Library.CurrentTheme.Tertiary}, 0.2)
    end)
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "Close"
    CloseButton.Parent = ControlsFrame
    CloseButton.BackgroundColor3 = Library.CurrentTheme.Error
    CloseButton.BorderSizePixel = 0
    CloseButton.Size = UDim2.new(0, 28, 0, 28)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Library.CurrentTheme.Text
    CloseButton.TextSize = 20
    CloseButton.AutoButtonColor = false
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 7)
    CloseCorner.Parent = CloseButton
    
    CloseButton.MouseEnter:Connect(function()
        Tween(CloseButton, {BackgroundColor3 = Color3.fromRGB(255, 96, 80)}, 0.2)
    end)
    
    CloseButton.MouseLeave:Connect(function()
        Tween(CloseButton, {BackgroundColor3 = Library.CurrentTheme.Error}, 0.2)
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        Tween(MainContainer, {Size = UDim2.new(0, 0, 0, 0)}, 0.4, AnimationStyles.Back)
        task.wait(0.4)
        ScreenGui:Destroy()
    end)
    
    local UIVisible = true
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Keybind then
            UIVisible = not UIVisible
            Tween(MainContainer, {
                Size = UIVisible and WindowSize or UDim2.new(0, 0, 0, 0)
            }, 0.3, AnimationStyles.Back)
        end
    end)
    
    local dragging, dragInput, dragStart, startPos
    
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainContainer.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    Header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainContainer.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = Library.CurrentTheme.Secondary
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 0, 0, 50)
    TabContainer.Size = UDim2.new(0, math.clamp(ResponsiveSize.Width * 0.25, 120, 165), 1, -50)
    
    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.Parent = TabContainer
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingBottom = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 8)
    TabPadding.PaddingRight = UDim.new(0, 8)
    
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, TabContainer.Size.X.Offset, 0, 50)
    ContentContainer.Size = UDim2.new(1, -TabContainer.Size.X.Offset, 1, -50)
    
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        SavedData = {},
        Size = ResponsiveSize
    }
    
    -- ═══════════════════════════════════════════════════════
    -- 📑 إنشاء Tab
    -- ═══════════════════════════════════════════════════════
    
    function Window:CreateTab(options)
        options = options or {}
        local TabName = options.Name or "Tab"
        local TabIcon = options.Icon or "rbxassetid://7734053426"
        local TabVisible = options.Visible ~= false
        
        local TabButton = Instance.new("TextButton")
        TabButton.Name = TabName
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = Library.CurrentTheme.Tertiary
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, 0, 0, 40)
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.Text = ""
        TabButton.TextColor3 = Library.CurrentTheme.SubText
        TabButton.TextSize = 14
        TabButton.AutoButtonColor = false
        TabButton.Visible = TabVisible
        
        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 10)
        TabButtonCorner.Parent = TabButton
        
        local TabIconImage = Instance.new("ImageLabel")
        TabIconImage.Name = "Icon"
        TabIconImage.Parent = TabButton
        TabIconImage.BackgroundTransparency = 1
        TabIconImage.Position = UDim2.new(0, 10, 0.5, 0)
        TabIconImage.Size = UDim2.new(0, 20, 0, 20)
        TabIconImage.AnchorPoint = Vector2.new(0, 0.5)
        TabIconImage.Image = TabIcon
        TabIconImage.ImageColor3 = Library.CurrentTheme.SubText
        
        local TabText = Instance.new("TextLabel")
        TabText.Name = "TabText"
        TabText.Parent = TabButton
        TabText.BackgroundTransparency = 1
        TabText.Position = UDim2.new(0, 38, 0, 0)
        TabText.Size = UDim2.new(1, -46, 1, 0)
        TabText.Font = Enum.Font.GothamSemibold
        TabText.Text = TabName
        TabText.TextColor3 = Library.CurrentTheme.SubText
        TabText.TextSize = 13
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTruncate = Enum.TextTruncate.AtEnd
        
        local Indicator = Instance.new("Frame")
        Indicator.Name = "Indicator"
        Indicator.Parent = TabButton
        Indicator.BackgroundColor3 = Library.CurrentTheme.Accent
        Indicator.BorderSizePixel = 0
        Indicator.Position = UDim2.new(0, 0, 0, 0)
        Indicator.Size = UDim2.new(0, 0, 1, 0)
        
        local IndicatorCorner = Instance.new("UICorner")
        IndicatorCorner.CornerRadius = UDim.new(0, 10)
        IndicatorCorner.Parent = Indicator
        
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = TabName .. "Content"
        TabContent.Parent = ContentContainer
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Library.CurrentTheme.Accent
        TabContent.Visible = false
        TabContent.ClipsDescendants = true
        
        local ContentList = Instance.new("UIListLayout")
        ContentList.Parent = TabContent
        ContentList.SortOrder = Enum.SortOrder.LayoutOrder
        ContentList.Padding = UDim.new(0, 10)
        
        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.Parent = TabContent
        ContentPadding.PaddingTop = UDim.new(0, 15)
        ContentPadding.PaddingBottom = UDim.new(0, 15)
        ContentPadding.PaddingLeft = UDim.new(0, 15)
        ContentPadding.PaddingRight = UDim.new(0, 15)
        
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 30)
        end)
        
        TabButton.MouseButton1Click:Connect(function()
            -- تم حذف CreateRipple من هنا
            
            for _, tab in pairs(Window.Tabs) do
                tab:Deactivate()
            end
            
            TabContent.Visible = true
            Window.CurrentTab = TabName
            
            Tween(TabButton, {BackgroundColor3 = Library.CurrentTheme.Accent}, 0.2)
            Tween(TabText, {TextColor3 = Library.CurrentTheme.Text}, 0.2)
            Tween(TabIconImage, {ImageColor3 = Library.CurrentTheme.Text}, 0.2)
            Tween(Indicator, {Size = UDim2.new(0, 4, 1, 0)}, 0.3, AnimationStyles.Back)
        end)
        
        TabButton.MouseEnter:Connect(function()
            if Window.CurrentTab ~= TabName then
                Tween(TabButton, {BackgroundColor3 = Library.CurrentTheme.Secondary}, 0.2)
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if Window.CurrentTab ~= TabName then
                Tween(TabButton, {BackgroundColor3 = Library.CurrentTheme.Tertiary}, 0.2)
            end
        end)
        
        local Tab = {
            Name = TabName,
            Button = TabButton,
            Content = TabContent,
            Elements = {}
        }
        
        function Tab:Deactivate()
            TabContent.Visible = false
            Tween(TabButton, {BackgroundColor3 = Library.CurrentTheme.Tertiary}, 0.2)
            Tween(TabText, {TextColor3 = Library.CurrentTheme.SubText}, 0.2)
            Tween(TabIconImage, {ImageColor3 = Library.CurrentTheme.SubText}, 0.2)
            Tween(Indicator, {Size = UDim2.new(0, 0, 1, 0)}, 0.3)
        end
        
        -- ═══════════════════════════════════════════════════════
        -- 📋 إنشاء Section
        -- ═══════════════════════════════════════════════════════
        
        function Tab:CreateSection(sectionName)
            local Section = Instance.new("Frame")
            Section.Name = sectionName
            Section.Parent = TabContent
            Section.BackgroundColor3 = Library.CurrentTheme.Secondary
            Section.BorderSizePixel = 0
            Section.Size = UDim2.new(1, 0, 0, 40)
            Section.AutomaticSize = Enum.AutomaticSize.Y
            
            local SectionCorner = Instance.new("UICorner")
            SectionCorner.CornerRadius = UDim.new(0, 10)
            SectionCorner.Parent = Section
            
            local SectionStroke = Instance.new("UIStroke")
            SectionStroke.Parent = Section
            SectionStroke.Color = Library.CurrentTheme.Border
            SectionStroke.Thickness = 1
            SectionStroke.Transparency = 0.8
            
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Name = "Title"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0, 15, 0, 0)
            SectionTitle.Size = UDim2.new(1, -30, 0, 40)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = sectionName
            SectionTitle.TextColor3 = Library.CurrentTheme.Text
            SectionTitle.TextSize = 14
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local SectionContent = Instance.new("Frame")
            SectionContent.Name = "Content"
            SectionContent.Parent = Section
            SectionContent.BackgroundTransparency = 1
            SectionContent.Position = UDim2.new(0, 0, 0, 40)
            SectionContent.Size = UDim2.new(1, 0, 1, -40)
            SectionContent.AutomaticSize = Enum.AutomaticSize.Y
            
            local SectionList = Instance.new("UIListLayout")
            SectionList.Parent = SectionContent
            SectionList.SortOrder = Enum.SortOrder.LayoutOrder
            SectionList.Padding = UDim.new(0, 8)
            
            local SectionPadding = Instance.new("UIPadding")
            SectionPadding.Parent = SectionContent
            SectionPadding.PaddingTop = UDim.new(0, 10)
            SectionPadding.PaddingBottom = UDim.new(0, 15)
            SectionPadding.PaddingLeft = UDim.new(0, 15)
            SectionPadding.PaddingRight = UDim.new(0, 15)
            
            local SectionObj = {
                Section = Section,
                Content = SectionContent
            }
            
            -- ═══════════════════════════════════════════════════════
            -- 🏷️ Label
            -- ═══════════════════════════════════════════════════════
            
            function SectionObj:AddLabel(text)
                local Label = Instance.new("TextLabel")
                Label.Name = "Label"
                Label.Parent = SectionContent
                Label.BackgroundTransparency = 1
                Label.Size = UDim2.new(1, 0, 0, 25)
                Label.Font = Enum.Font.Gotham
                Label.Text = text
                Label.TextColor3 = Library.CurrentTheme.SubText
                Label.TextSize = 13
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextWrapped = true
                Label.AutomaticSize = Enum.AutomaticSize.Y
                
                return {
                    SetText = function(self, newText)
                        Label.Text = newText
                    end
                }
            end
            
            -- ═══════════════════════════════════════════════════════
            -- 📄 Paragraph
            -- ═══════════════════════════════════════════════════════
            
            function SectionObj:AddParagraph(title, content)
                local Paragraph = Instance.new("Frame")
                Paragraph.Name = "Paragraph"
                Paragraph.Parent = SectionContent
                Paragraph.BackgroundColor3 = Library.CurrentTheme.Tertiary
                Paragraph.BorderSizePixel = 0
                Paragraph.Size = UDim2.new(1, 0, 0, 60)
                Paragraph.AutomaticSize = Enum.AutomaticSize.Y
                
                local ParagraphCorner = Instance.new("UICorner")
                ParagraphCorner.CornerRadius = UDim.new(0, 8)
                ParagraphCorner.Parent = Paragraph
                
                local ParagraphTitle = Instance.new("TextLabel")
                ParagraphTitle.Name = "Title"
                ParagraphTitle.Parent = Paragraph
                ParagraphTitle.BackgroundTransparency = 1
                ParagraphTitle.Position = UDim2.new(0, 12, 0, 8)
                ParagraphTitle.Size = UDim2.new(1, -24, 0, 18)
                ParagraphTitle.Font = Enum.Font.GothamBold
                ParagraphTitle.Text = title
                ParagraphTitle.TextColor3 = Library.CurrentTheme.Text
                ParagraphTitle.TextSize = 14
                ParagraphTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                local ParagraphContent = Instance.new("TextLabel")
                ParagraphContent.Name = "Content"
                ParagraphContent.Parent = Paragraph
                ParagraphContent.BackgroundTransparency = 1
                ParagraphContent.Position = UDim2.new(0, 12, 0, 28)
                ParagraphContent.Size = UDim2.new(1, -24, 1, -36)
                ParagraphContent.Font = Enum.Font.Gotham
                ParagraphContent.Text = content
                ParagraphContent.TextColor3 = Library.CurrentTheme.SubText
                ParagraphContent.TextSize = 13
                ParagraphContent.TextXAlignment = Enum.TextXAlignment.Left
                ParagraphContent.TextYAlignment = Enum.TextYAlignment.Top
                ParagraphContent.TextWrapped = true
                ParagraphContent.AutomaticSize = Enum.AutomaticSize.Y
                
                local ParagraphPadding = Instance.new("UIPadding")
                ParagraphPadding.Parent = Paragraph
                ParagraphPadding.PaddingBottom = UDim.new(0, 8)
                
                return {
                    SetTitle = function(self, newTitle)
                        ParagraphTitle.Text = newTitle
                    end,
                    SetContent = function(self, newContent)
                        ParagraphContent.Text = newContent
                    end
                }
            end
            
            -- ═══════════════════════════════════════════════════════
            -- 🔘 Button
            -- ═══════════════════════════════════════════════════════
            
            function SectionObj:AddButton(options)
                options = options or {}
                local ButtonName = options.Name or "Button"
                local Callback = options.Callback or function() end
                
                local Button = Instance.new("TextButton")
                Button.Name = ButtonName
                Button.Parent = SectionContent
                Button.BackgroundColor3 = Library.CurrentTheme.Tertiary
                Button.BorderSizePixel = 0
                Button.Size = UDim2.new(1, 0, 0, 38)
                Button.Font = Enum.Font.GothamSemibold
                Button.Text = ButtonName
                Button.TextColor3 = Library.CurrentTheme.Text
                Button.TextSize = 14
                Button.AutoButtonColor = false
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 8)
                ButtonCorner.Parent = Button
                
                local ButtonStroke = Instance.new("UIStroke")
                ButtonStroke.Parent = Button
                ButtonStroke.Color = Library.CurrentTheme.Accent
                ButtonStroke.Thickness = 0
                ButtonStroke.Transparency = 0.5
                
                Button.MouseEnter:Connect(function()
                    Tween(Button, {BackgroundColor3 = Library.CurrentTheme.Accent}, 0.2)
                    Tween(ButtonStroke, {Thickness = 2}, 0.2)
                end)
                
                Button.MouseLeave:Connect(function()
                    Tween(Button, {BackgroundColor3 = Library.CurrentTheme.Tertiary}, 0.2)
                    Tween(ButtonStroke, {Thickness = 0}, 0.2)
                end)
                
                Button.MouseButton1Click:Connect(function()
                    CreateRipple(Button, Mouse.X - Button.AbsolutePosition.X, Mouse.Y - Button.AbsolutePosition.Y)
                    Tween(Button, {Size = UDim2.new(1, 0, 0, 35)}, 0.1)
                    task.wait(0.1)
                    Tween(Button, {Size = UDim2.new(1, 0, 0, 38)}, 0.1)
                    Callback()
                end)
                
                return {
                    SetName = function(self, newName)
                        Button.Text = newName
                    end
                }
            end
            
            -- ═══════════════════════════════════════════════════════
            -- ⚡ Toggle
            -- ═══════════════════════════════════════════════════════
            
            function SectionObj:AddToggle(options)
                options = options or {}
                local ToggleName = options.Name or "Toggle"
                local DefaultValue = options.Default or false
                local Callback = options.Callback or function() end
                
                local Toggle = Instance.new("Frame")
                Toggle.Name = ToggleName
                Toggle.Parent = SectionContent
                Toggle.BackgroundColor3 = Library.CurrentTheme.Tertiary
                Toggle.BorderSizePixel = 0
                Toggle.Size = UDim2.new(1, 0, 0, 38)
                
                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 8)
                ToggleCorner.Parent = Toggle
                
                local ToggleLabel = Instance.new("TextLabel")
                ToggleLabel.Name = "Label"
                ToggleLabel.Parent = Toggle
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Position = UDim2.new(0, 12, 0, 0)
                ToggleLabel.Size = UDim2.new(1, -65, 1, 0)
                ToggleLabel.Font = Enum.Font.GothamSemibold
                ToggleLabel.Text = ToggleName
                ToggleLabel.TextColor3 = Library.CurrentTheme.Text
                ToggleLabel.TextSize = 13
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabel.TextTruncate = Enum.TextTruncate.AtEnd
                
                local ToggleButton = Instance.new("TextButton")
                ToggleButton.Name = "Button"
                ToggleButton.Parent = Toggle
                ToggleButton.BackgroundColor3 = DefaultValue and Library.CurrentTheme.Accent or Library.CurrentTheme.Background
                ToggleButton.BorderSizePixel = 0
                ToggleButton.Position = UDim2.new(1, -48, 0.5, 0)
                ToggleButton.Size = UDim2.new(0, 40, 0, 20)
                ToggleButton.AnchorPoint = Vector2.new(0, 0.5)
                ToggleButton.Text = ""
                ToggleButton.AutoButtonColor = false
                
                local ToggleButtonCorner = Instance.new("UICorner")
                ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
                ToggleButtonCorner.Parent = ToggleButton
                
                local ToggleCircle = Instance.new("Frame")
                ToggleCircle.Name = "Circle"
                ToggleCircle.Parent = ToggleButton
                ToggleCircle.BackgroundColor3 = Library.CurrentTheme.Text
                ToggleCircle.BorderSizePixel = 0
                ToggleCircle.Position = DefaultValue and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
                ToggleCircle.AnchorPoint = Vector2.new(0, 0.5)
                
                local CircleCorner = Instance.new("UICorner")
                CircleCorner.CornerRadius = UDim.new(1, 0)
                CircleCorner.Parent = ToggleCircle
                
                local toggled = DefaultValue
                
                local function UpdateToggle(state)
                    toggled = state
                    Tween(ToggleButton, {
                        BackgroundColor3 = toggled and Library.CurrentTheme.Accent or Library.CurrentTheme.Background
                    }, 0.3)
                    Tween(ToggleCircle, {
                        Position = toggled and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                    }, 0.3, AnimationStyles.Back)
                    Callback(toggled)
                end
                
                ToggleButton.MouseButton1Click:Connect(function()
                    UpdateToggle(not toggled)
                end)
                
                return {
                    SetValue = function(self, value)
                        UpdateToggle(value)
                    end,
                    GetValue = function(self)
                        return toggled
                    end
                }
            end
            
            -- ═══════════════════════════════════════════════════════
            -- 🎚️ Slider
            -- ═══════════════════════════════════════════════════════
            
            function SectionObj:AddSlider(options)
                options = options or {}
                local SliderName = options.Name or "Slider"
                local Min = options.Min or 0
                local Max = options.Max or 100
                local Default = options.Default or 50
                local Increment = options.Increment or 1
                local Callback = options.Callback or function() end
                
                local Slider = Instance.new("Frame")
                Slider.Name = SliderName
                Slider.Parent = SectionContent
                Slider.BackgroundColor3 = Library.CurrentTheme.Tertiary
                Slider.BorderSizePixel = 0
                Slider.Size = UDim2.new(1, 0, 0, 50)
                
                local SliderCorner = Instance.new("UICorner")
                SliderCorner.CornerRadius = UDim.new(0, 8)
                SliderCorner.Parent = Slider
                
                local SliderLabel = Instance.new("TextLabel")
                SliderLabel.Name = "Label"
                SliderLabel.Parent = Slider
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Position = UDim2.new(0, 12, 0, 8)
                SliderLabel.Size = UDim2.new(0.65, 0, 0, 18)
                SliderLabel.Font = Enum.Font.GothamSemibold
                SliderLabel.Text = SliderName
                SliderLabel.TextColor3 = Library.CurrentTheme.Text
                SliderLabel.TextSize = 13
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                SliderLabel.TextTruncate = Enum.TextTruncate.AtEnd
                
                local SliderValue = Instance.new("TextLabel")
                SliderValue.Name = "Value"
                SliderValue.Parent = Slider
                SliderValue.BackgroundColor3 = Library.CurrentTheme.Background
                SliderValue.BorderSizePixel = 0
                SliderValue.Position = UDim2.new(1, -55, 0, 8)
                SliderValue.Size = UDim2.new(0, 48, 0, 18)
                SliderValue.Font = Enum.Font.GothamBold
                SliderValue.Text = tostring(Default)
                SliderValue.TextColor3 = Library.CurrentTheme.Accent
                SliderValue.TextSize = 12
                
                local ValueCorner = Instance.new("UICorner")
                ValueCorner.CornerRadius = UDim.new(0, 5)
                ValueCorner.Parent = SliderValue
                
                local SliderBar = Instance.new("Frame")
                SliderBar.Name = "Bar"
                SliderBar.Parent = Slider
                SliderBar.BackgroundColor3 = Library.CurrentTheme.Background
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0, 12, 1, -16)
                SliderBar.Size = UDim2.new(1, -24, 0, 7)
                
                local BarCorner = Instance.new("UICorner")
                BarCorner.CornerRadius = UDim.new(1, 0)
                BarCorner.Parent = SliderBar
                
                local SliderFill = Instance.new("Frame")
                SliderFill.Name = "Fill"
                SliderFill.Parent = SliderBar
                SliderFill.BackgroundColor3 = Library.CurrentTheme.Accent
                SliderFill.BorderSizePixel = 0
                SliderFill.Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0)
                
                local FillCorner = Instance.new("UICorner")
                FillCorner.CornerRadius = UDim.new(1, 0)
                FillCorner.Parent = SliderFill
                
                local FillGradient = Instance.new("UIGradient")
                FillGradient.Parent = SliderFill
                FillGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Library.CurrentTheme.Accent),
                    ColorSequenceKeypoint.new(1, Library.CurrentTheme.AccentHover)
                }
                
                local SliderDot = Instance.new("Frame")
                SliderDot.Name = "Dot"
                SliderDot.Parent = SliderBar
                SliderDot.BackgroundColor3 = Library.CurrentTheme.Text
                SliderDot.BorderSizePixel = 0
                SliderDot.Position = UDim2.new((Default - Min) / (Max - Min), 0, 0.5, 0)
                SliderDot.Size = UDim2.new(0, 14, 0, 14)
                SliderDot.AnchorPoint = Vector2.new(0.5, 0.5)
                
                local DotCorner = Instance.new("UICorner")
                DotCorner.CornerRadius = UDim.new(1, 0)
                DotCorner.Parent = SliderDot
                
                local dragging = false
                
                local function UpdateSlider(input)
                    local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    local value = math.floor(Min + (Max - Min) * pos)
                    value = math.floor(value / Increment) * Increment
                    value = math.clamp(value, Min, Max)
                    
                    SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                    SliderDot.Position = UDim2.new(pos, 0, 0.5, 0)
                    SliderValue.Text = tostring(value)
                    
                    Callback(value)
                end
                
                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        UpdateSlider(input)
                        Tween(SliderDot, {Size = UDim2.new(0, 18, 0, 18)}, 0.2, AnimationStyles.Back)
                    end
                end)
                
                SliderBar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                        Tween(SliderDot, {Size = UDim2.new(0, 14, 0, 14)}, 0.2)
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        UpdateSlider(input)
                    end
                end)
                
                return {
                    SetValue = function(self, value)
                        local pos = (value - Min) / (Max - Min)
                        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                        SliderDot.Position = UDim2.new(pos, 0, 0.5, 0)
                        SliderValue.Text = tostring(value)
                        Callback(value)
                    end,
                    GetValue = function(self)
                        return tonumber(SliderValue.Text)
                    end
                }
            end
            
            -- ═══════════════════════════════════════════════════════
            -- 📋 Dropdown
            -- ═══════════════════════════════════════════════════════
            
            function SectionObj:AddDropdown(options)
                options = options or {}
                local DropdownName = options.Name or "Dropdown"
                local Items = options.Items or {"Option 1", "Option 2"}
                local Default = options.Default or Items[1]
                local Callback = options.Callback or function() end
                
                local Dropdown = Instance.new("Frame")
                Dropdown.Name = DropdownName
                Dropdown.Parent = SectionContent
                Dropdown.BackgroundColor3 = Library.CurrentTheme.Tertiary
                Dropdown.BorderSizePixel = 0
                Dropdown.Size = UDim2.new(1, 0, 0, 38)
                Dropdown.ClipsDescendants = true
                
                local DropdownCorner = Instance.new("UICorner")
                DropdownCorner.CornerRadius = UDim.new(0, 8)
                DropdownCorner.Parent = Dropdown
                
                local DropdownLabel = Instance.new("TextLabel")
                DropdownLabel.Name = "Label"
                DropdownLabel.Parent = Dropdown
                DropdownLabel.BackgroundTransparency = 1
                DropdownLabel.Position = UDim2.new(0, 12, 0, 0)
                DropdownLabel.Size = UDim2.new(0.45, 0, 0, 38)
                DropdownLabel.Font = Enum.Font.GothamSemibold
                DropdownLabel.Text = DropdownName
                DropdownLabel.TextColor3 = Library.CurrentTheme.Text
                DropdownLabel.TextSize = 13
                DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                DropdownLabel.TextTruncate = Enum.TextTruncate.AtEnd
                
                local DropdownButton = Instance.new("TextButton")
                DropdownButton.Name = "Button"
                DropdownButton.Parent = Dropdown
                DropdownButton.BackgroundColor3 = Library.CurrentTheme.Background
                DropdownButton.BorderSizePixel = 0
                DropdownButton.Position = UDim2.new(0.5, 5, 0, 7)
                DropdownButton.Size = UDim2.new(0.5, -17, 0, 24)
                DropdownButton.Font = Enum.Font.Gotham
                DropdownButton.Text = "  " .. Default
                DropdownButton.TextColor3 = Library.CurrentTheme.Accent
                DropdownButton.TextSize = 12
                DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
                DropdownButton.AutoButtonColor = false
                DropdownButton.TextTruncate = Enum.TextTruncate.AtEnd
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 6)
                ButtonCorner.Parent = DropdownButton
                
                local Arrow = Instance.new("TextLabel")
                Arrow.Parent = DropdownButton
                Arrow.BackgroundTransparency = 1
                Arrow.Position = UDim2.new(1, -20, 0, 0)
                Arrow.Size = UDim2.new(0, 18, 1, 0)
                Arrow.Font = Enum.Font.GothamBold
                Arrow.Text = "▼"
                Arrow.TextColor3 = Library.CurrentTheme.SubText
                Arrow.TextSize = 9
                
                local ItemList = Instance.new("ScrollingFrame")
                ItemList.Name = "ItemList"
                ItemList.Parent = Dropdown
                ItemList.BackgroundTransparency = 1
                ItemList.BorderSizePixel = 0
                ItemList.Position = UDim2.new(0, 8, 0, 43)
                ItemList.Size = UDim2.new(1, -16, 0, 0)
                ItemList.CanvasSize = UDim2.new(0, 0, 0, 0)
                ItemList.ScrollBarThickness = 3
                ItemList.ScrollBarImageColor3 = Library.CurrentTheme.Accent
                
                local ListLayout = Instance.new("UIListLayout")
                ListLayout.Parent = ItemList
                ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                ListLayout.Padding = UDim.new(0, 4)
                
                ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    ItemList.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
                end)
                
                local expanded = false
                local currentValue = Default
                
                for _, itemName in ipairs(Items) do
                    local Item = Instance.new("TextButton")
                    Item.Name = itemName
                    Item.Parent = ItemList
                    Item.BackgroundColor3 = Library.CurrentTheme.Background
                    Item.BorderSizePixel = 0
                    Item.Size = UDim2.new(1, 0, 0, 26)
                    Item.Font = Enum.Font.Gotham
                    Item.Text = "  " .. itemName
                    Item.TextColor3 = Library.CurrentTheme.Text
                    Item.TextSize = 12
                    Item.TextXAlignment = Enum.TextXAlignment.Left
                    Item.AutoButtonColor = false
                    Item.TextTruncate = Enum.TextTruncate.AtEnd
                    
                    local ItemCorner = Instance.new("UICorner")
                    ItemCorner.CornerRadius = UDim.new(0, 6)
                    ItemCorner.Parent = Item
                    
                    Item.MouseEnter:Connect(function()
                        Tween(Item, {BackgroundColor3 = Library.CurrentTheme.Accent}, 0.2)
                    end)
                    
                    Item.MouseLeave:Connect(function()
                        Tween(Item, {BackgroundColor3 = Library.CurrentTheme.Background}, 0.2)
                    end)
                    
                    Item.MouseButton1Click:Connect(function()
                        currentValue = itemName
                        DropdownButton.Text = "  " .. itemName
                        Callback(itemName)
                        
                        expanded = false
                        Tween(Dropdown, {Size = UDim2.new(1, 0, 0, 38)}, 0.3, AnimationStyles.Back)
                        Tween(Arrow, {Rotation = 0}, 0.3)
                    end)
                end
                
                DropdownButton.MouseButton1Click:Connect(function()
                    expanded = not expanded
                    if expanded then
                        local itemCount = math.min(#Items, 5)
                        Tween(Dropdown, {Size = UDim2.new(1, 0, 0, 48 + (itemCount * 30))}, 0.3, AnimationStyles.Back)
                        Tween(Arrow, {Rotation = 180}, 0.3)
                        ItemList.Size = UDim2.new(1, -16, 0, itemCount * 30)
                    else
                        Tween(Dropdown, {Size = UDim2.new(1, 0, 0, 38)}, 0.3, AnimationStyles.Back)
                        Tween(Arrow, {Rotation = 0}, 0.3)
                    end
                end)
                
                return {
                    SetValue = function(self, value)
                        if table.find(Items, value) then
                            currentValue = value
                            DropdownButton.Text = "  " .. value
                            Callback(value)
                        end
                    end,
                    GetValue = function(self)
                        return currentValue
                    end
                }
            end
            
            -- ═══════════════════════════════════════════════════════
            -- ⌨️ Textbox
            -- ═══════════════════════════════════════════════════════
            
            function SectionObj:AddTextbox(options)
                options = options or {}
                local TextboxName = options.Name or "Textbox"
                local DefaultText = options.Default or ""
                local Placeholder = options.Placeholder or "Enter text..."
                local Callback = options.Callback or function() end
                
                local Textbox = Instance.new("Frame")
                Textbox.Name = TextboxName
                Textbox.Parent = SectionContent
                Textbox.BackgroundColor3 = Library.CurrentTheme.Tertiary
                Textbox.BorderSizePixel = 0
                Textbox.Size = UDim2.new(1, 0, 0, 38)
                
                local TextboxCorner = Instance.new("UICorner")
                TextboxCorner.CornerRadius = UDim.new(0, 8)
                TextboxCorner.Parent = Textbox
                
                local TextboxLabel = Instance.new("TextLabel")
                TextboxLabel.Name = "Label"
                TextboxLabel.Parent = Textbox
                TextboxLabel.BackgroundTransparency = 1
                TextboxLabel.Position = UDim2.new(0, 12, 0, 0)
                TextboxLabel.Size = UDim2.new(0.35, 0, 1, 0)
                TextboxLabel.Font = Enum.Font.GothamSemibold
                TextboxLabel.Text = TextboxName
                TextboxLabel.TextColor3 = Library.CurrentTheme.Text
                TextboxLabel.TextSize = 13
                TextboxLabel.TextXAlignment = Enum.TextXAlignment.Left
                TextboxLabel.TextTruncate = Enum.TextTruncate.AtEnd
                
                local TextboxInput = Instance.new("TextBox")
                TextboxInput.Name = "Input"
                TextboxInput.Parent = Textbox
                TextboxInput.BackgroundColor3 = Library.CurrentTheme.Background
                TextboxInput.BorderSizePixel = 0
                TextboxInput.Position = UDim2.new(0.4, 0, 0, 7)
                TextboxInput.Size = UDim2.new(0.58, 0, 0, 24)
                TextboxInput.Font = Enum.Font.Gotham
                TextboxInput.PlaceholderText = Placeholder
                TextboxInput.PlaceholderColor3 = Library.CurrentTheme.SubText
                TextboxInput.Text = DefaultText
                TextboxInput.TextColor3 = Library.CurrentTheme.Accent
                TextboxInput.TextSize = 12
                TextboxInput.ClearTextOnFocus = false
                TextboxInput.TextTruncate = Enum.TextTruncate.AtEnd
                
                local InputCorner = Instance.new("UICorner")
                InputCorner.CornerRadius = UDim.new(0, 6)
                InputCorner.Parent = TextboxInput
                
                local InputPadding = Instance.new("UIPadding")
                InputPadding.Parent = TextboxInput
                InputPadding.PaddingLeft = UDim.new(0, 8)
                InputPadding.PaddingRight = UDim.new(0, 8)
                
                TextboxInput.FocusLost:Connect(function(enter)
                    if enter then
                        Callback(TextboxInput.Text)
                    end
                end)
                
                TextboxInput.Focused:Connect(function()
                    Tween(TextboxInput, {BackgroundColor3 = Library.CurrentTheme.Secondary}, 0.2)
                end)
                
                TextboxInput.FocusLost:Connect(function()
                    Tween(TextboxInput, {BackgroundColor3 = Library.CurrentTheme.Background}, 0.2)
                end)
                
                return {
                    SetValue = function(self, value)
                        TextboxInput.Text = value
                        Callback(value)
                    end,
                    GetValue = function(self)
                        return TextboxInput.Text
                    end
                }
            end
            
            -- ═══════════════════════════════════════════════════════
            -- ⌨️ Keybind
            -- ═══════════════════════════════════════════════════════
            
            function SectionObj:AddKeybind(options)
                options = options or {}
                local KeybindName = options.Name or "Keybind"
                local DefaultKey = options.Default or Enum.KeyCode.E
                local Callback = options.Callback or function() end
                
                local Keybind = Instance.new("Frame")
                Keybind.Name = KeybindName
                Keybind.Parent = SectionContent
                Keybind.BackgroundColor3 = Library.CurrentTheme.Tertiary
                Keybind.BorderSizePixel = 0
                Keybind.Size = UDim2.new(1, 0, 0, 38)
                
                local KeybindCorner = Instance.new("UICorner")
                KeybindCorner.CornerRadius = UDim.new(0, 8)
                KeybindCorner.Parent = Keybind
                
                local KeybindLabel = Instance.new("TextLabel")
                KeybindLabel.Name = "Label"
                KeybindLabel.Parent = Keybind
                KeybindLabel.BackgroundTransparency = 1
                KeybindLabel.Position = UDim2.new(0, 12, 0, 0)
                KeybindLabel.Size = UDim2.new(0.55, 0, 1, 0)
                KeybindLabel.Font = Enum.Font.GothamSemibold
                KeybindLabel.Text = KeybindName
                KeybindLabel.TextColor3 = Library.CurrentTheme.Text
                KeybindLabel.TextSize = 13
                KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
                KeybindLabel.TextTruncate = Enum.TextTruncate.AtEnd
                
                local KeybindButton = Instance.new("TextButton")
                KeybindButton.Name = "Button"
                KeybindButton.Parent = Keybind
                KeybindButton.BackgroundColor3 = Library.CurrentTheme.Background
                KeybindButton.BorderSizePixel = 0
                KeybindButton.Position = UDim2.new(1, -75, 0, 7)
                KeybindButton.Size = UDim2.new(0, 68, 0, 24)
                KeybindButton.Font = Enum.Font.GothamBold
                KeybindButton.Text = DefaultKey.Name
                KeybindButton.TextColor3 = Library.CurrentTheme.Accent
                KeybindButton.TextSize = 11
                KeybindButton.AutoButtonColor = false
                KeybindButton.TextTruncate = Enum.TextTruncate.AtEnd
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 6)
                ButtonCorner.Parent = KeybindButton
                
                local currentKey = DefaultKey
                local binding = false
                
                KeybindButton.MouseButton1Click:Connect(function()
                    binding = true
                    KeybindButton.Text = "..."
                    Tween(KeybindButton, {BackgroundColor3 = Library.CurrentTheme.Accent}, 0.2)
                end)
                
                UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if binding then
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            currentKey = input.KeyCode
                            KeybindButton.Text = currentKey.Name
                            binding = false
                            Tween(KeybindButton, {BackgroundColor3 = Library.CurrentTheme.Background}, 0.2)
                        end
                    elseif not gameProcessed and input.KeyCode == currentKey then
                        Callback(currentKey)
                    end
                end)
                
                return {
                    SetKey = function(self, key)
                        currentKey = key
                        KeybindButton.Text = key.Name
                    end,
                    GetKey = function(self)
                        return currentKey
                    end
                }
            end
            
            -- ═══════════════════════════════════════════════════════
            -- 🎨 Color Picker
            -- ═══════════════════════════════════════════════════════
            
            function SectionObj:AddColorPicker(options)
                options = options or {}
                local PickerName = options.Name or "Color Picker"
                local DefaultColor = options.Default or Color3.fromRGB(255, 255, 255)
                local Callback = options.Callback or function() end
                
                local ColorPicker = Instance.new("Frame")
                ColorPicker.Name = PickerName
                ColorPicker.Parent = SectionContent
                ColorPicker.BackgroundColor3 = Library.CurrentTheme.Tertiary
                ColorPicker.BorderSizePixel = 0
                ColorPicker.Size = UDim2.new(1, 0, 0, 38)
                ColorPicker.ClipsDescendants = true
                
                local PickerCorner = Instance.new("UICorner")
                PickerCorner.CornerRadius = UDim.new(0, 8)
                PickerCorner.Parent = ColorPicker
                
                local PickerLabel = Instance.new("TextLabel")
                PickerLabel.Name = "Label"
                PickerLabel.Parent = ColorPicker
                PickerLabel.BackgroundTransparency = 1
                PickerLabel.Position = UDim2.new(0, 12, 0, 0)
                PickerLabel.Size = UDim2.new(0.7, 0, 0, 38)
                PickerLabel.Font = Enum.Font.GothamSemibold
                PickerLabel.Text = PickerName
                PickerLabel.TextColor3 = Library.CurrentTheme.Text
                PickerLabel.TextSize = 13
                PickerLabel.TextXAlignment = Enum.TextXAlignment.Left
                PickerLabel.TextTruncate = Enum.TextTruncate.AtEnd
                
                local ColorDisplay = Instance.new("TextButton")
                ColorDisplay.Name = "Display"
                ColorDisplay.Parent = ColorPicker
                ColorDisplay.BackgroundColor3 = DefaultColor
                ColorDisplay.BorderSizePixel = 0
                ColorDisplay.Position = UDim2.new(1, -48, 0, 9)
                ColorDisplay.Size = UDim2.new(0, 38, 0, 20)
                ColorDisplay.Text = ""
                ColorDisplay.AutoButtonColor = false
                
                local DisplayCorner = Instance.new("UICorner")
                DisplayCorner.CornerRadius = UDim.new(0, 6)
                DisplayCorner.Parent = ColorDisplay
                
                local DisplayStroke = Instance.new("UIStroke")
                DisplayStroke.Parent = ColorDisplay
                DisplayStroke.Color = Library.CurrentTheme.Border
                DisplayStroke.Thickness = 2
                
                local Palette = Instance.new("Frame")
                Palette.Name = "Palette"
                Palette.Parent = ColorPicker
                Palette.BackgroundColor3 = Library.CurrentTheme.Background
                Palette.BorderSizePixel = 0
                Palette.Position = UDim2.new(0, 8, 0, 43)
                Palette.Size = UDim2.new(1, -16, 0, 140)
                Palette.Visible = false
                
                local PaletteCorner = Instance.new("UICorner")
                PaletteCorner.CornerRadius = UDim.new(0, 8)
                PaletteCorner.Parent = Palette
                
                local ColorCanvas = Instance.new("ImageButton")
                ColorCanvas.Name = "Canvas"
                ColorCanvas.Parent = Palette
                ColorCanvas.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorCanvas.BorderSizePixel = 0
                ColorCanvas.Position = UDim2.new(0, 8, 0, 8)
                ColorCanvas.Size = UDim2.new(1, -80, 1, -16)
                ColorCanvas.Image = "rbxassetid://4155801252"
                ColorCanvas.AutoButtonColor = false
                
                local CanvasCorner = Instance.new("UICorner")
                CanvasCorner.CornerRadius = UDim.new(0, 6)
                CanvasCorner.Parent = ColorCanvas
                
                local HueSlider = Instance.new("ImageButton")
                HueSlider.Name = "Hue"
                HueSlider.Parent = Palette
                HueSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                HueSlider.BorderSizePixel = 0
                HueSlider.Position = UDim2.new(1, -62, 0, 8)
                HueSlider.Size = UDim2.new(0, 26, 1, -16)
                HueSlider.Image = "rbxassetid://3641079629"
                HueSlider.AutoButtonColor = false
                
                local HueCorner = Instance.new("UICorner")
                HueCorner.CornerRadius = UDim.new(0, 6)
                HueCorner.Parent = HueSlider
                
                local Confirm = Instance.new("TextButton")
                Confirm.Name = "Confirm"
                Confirm.Parent = Palette
                Confirm.BackgroundColor3 = Library.CurrentTheme.Accent
                Confirm.BorderSizePixel = 0
                Confirm.Position = UDim2.new(1, -28, 0, 8)
                Confirm.Size = UDim2.new(0, 20, 0, 20)
                Confirm.Font = Enum.Font.GothamBold
                Confirm.Text = "✓"
                Confirm.TextColor3 = Library.CurrentTheme.Text
                Confirm.TextSize = 13
                Confirm.AutoButtonColor = false
                
                local ConfirmCorner = Instance.new("UICorner")
                ConfirmCorner.CornerRadius = UDim.new(0, 5)
                ConfirmCorner.Parent = Confirm
                
                local expanded = false
                local currentHue = 0
                local currentSat = 1
                local currentVal = 1
                
                ColorDisplay.MouseButton1Click:Connect(function()
                    expanded = not expanded
                    Palette.Visible = expanded
                    if expanded then
                        Tween(ColorPicker, {Size = UDim2.new(1, 0, 0, 190)}, 0.3, AnimationStyles.Back)
                    else
                        Tween(ColorPicker, {Size = UDim2.new(1, 0, 0, 38)}, 0.3, AnimationStyles.Back)
                    end
                end)
                
                Confirm.MouseButton1Click:Connect(function()
                    expanded = false
                    Palette.Visible = false
                    Tween(ColorPicker, {Size = UDim2.new(1, 0, 0, 38)}, 0.3, AnimationStyles.Back)
                end)
                
                local function UpdateColor()
                    local color = Color3.fromHSV(currentHue, currentSat, currentVal)
                    ColorDisplay.BackgroundColor3 = color
                    ColorCanvas.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)
                    Callback(color)
                end
                
                local hueDragging = false
                local canvasDragging = false
                
                HueSlider.MouseButton1Down:Connect(function()
                    hueDragging = true
                end)
                
                ColorCanvas.MouseButton1Down:Connect(function()
                    canvasDragging = true
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        hueDragging = false
                        canvasDragging = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        if hueDragging then
                            local pos = math.clamp((input.Position.Y - HueSlider.AbsolutePosition.Y) / HueSlider.AbsoluteSize.Y, 0, 1)
                            currentHue = 1 - pos
                            UpdateColor()
                        end
                        
                        if canvasDragging then
                            local posX = math.clamp((input.Position.X - ColorCanvas.AbsolutePosition.X) / ColorCanvas.AbsoluteSize.X, 0, 1)
                            local posY = math.clamp((input.Position.Y - ColorCanvas.AbsolutePosition.Y) / ColorCanvas.AbsoluteSize.Y, 0, 1)
                            currentSat = posX
                            currentVal = 1 - posY
                            UpdateColor()
                        end
                    end
                end)
                
                local h, s, v = DefaultColor:ToHSV()
                currentHue = h
                currentSat = s
                currentVal = v
                UpdateColor()
                
                return {
                    SetColor = function(self, color)
                        local h, s, v = color:ToHSV()
                        currentHue = h
                        currentSat = s
                        currentVal = v
                        UpdateColor()
                    end,
                    GetColor = function(self)
                        return Color3.fromHSV(currentHue, currentSat, currentVal)
                    end
                }
            end
            
            return SectionObj
        end
        
        if #Window.Tabs == 0 then
            TabContent.Visible = true
            Window.CurrentTab = TabName
            TabButton.BackgroundColor3 = Library.CurrentTheme.Accent
            TabText.TextColor3 = Library.CurrentTheme.Text
            TabIconImage.ImageColor3 = Library.CurrentTheme.Text
            Indicator.Size = UDim2.new(0, 4, 1, 0)
        end
        
        table.insert(Window.Tabs, Tab)
        return Tab
    end
    
    -- ═══════════════════════════════════════════════════════
    -- 💧 Watermark
    -- ═══════════════════════════════════════════════════════
    
    function Window:CreateWatermark(text)
        local Watermark = Instance.new("TextLabel")
        Watermark.Name = "Watermark"
        Watermark.Parent = ScreenGui
        Watermark.BackgroundColor3 = Library.CurrentTheme.Secondary
        Watermark.BorderSizePixel = 0
        Watermark.Position = UDim2.new(0, 10, 0, 10)
        Watermark.Size = UDim2.new(0, 200, 0, 28)
        Watermark.Font = Enum.Font.GothamBold
        Watermark.Text = text or "Drakthon UI"
        Watermark.TextColor3 = Library.CurrentTheme.Text
        Watermark.TextSize = 13
        
        local WatermarkCorner = Instance.new("UICorner")
        WatermarkCorner.CornerRadius = UDim.new(0, 8)
        WatermarkCorner.Parent = Watermark
        
        local WatermarkStroke = Instance.new("UIStroke")
        WatermarkStroke.Parent = Watermark
        WatermarkStroke.Color = Library.CurrentTheme.Accent
        WatermarkStroke.Thickness = 1
        WatermarkStroke.Transparency = 0.7
        
        return {
            SetText = function(self, newText)
                Watermark.Text = newText
            end,
            Destroy = function(self)
                Watermark:Destroy()
            end
        }
    end
    
    MainContainer.Size = UDim2.new(0, 0, 0, 0)
    Tween(MainContainer, {Size = WindowSize}, 0.6, AnimationStyles.Back)
    
    task.wait(0.7)
    Library:Notify({
        Title = "مرحباً بك!",
        Description = WindowTitle .. " جاهز للاستخدام 🚀",
        Type = "Success",
        Duration = 4
    })
    
    return Window
end

return Library
