--[[
    ╔══════════════════════════════════════════════════╗
    ║         ULTIMATE UI LIBRARY V2.0                 ║
    ║         أقوى مكتبة UI في Roblox                 ║
    ╚══════════════════════════════════════════════════╝
]]--

local Library = {}
Library.Version = "2.0.0"

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- إنشاء ScreenGui محمي
local function CreateScreenGui()
    local success, ScreenGui = pcall(function()
        return game:GetService("CoreGui"):FindFirstChild("UltimateUI") or Instance.new("ScreenGui", game:GetService("CoreGui"))
    end)
    
    if not success then
        ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    end
    
    ScreenGui.Name = "UltimateUI"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    return ScreenGui
end

-- الثيمات المتعددة
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
    }
}

Library.CurrentTheme = Library.Themes.Default

-- دوال الأنيميشن المتقدمة
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

-- دالة Ripple Effect (تأثير الموجة)
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

-- إنشاء Notification System
Library.Notifications = {}

function Library:Notify(options)
    options = options or {}
    local Title = options.Title or "Notification"
    local Description = options.Description or "No description provided"
    local Duration = options.Duration or 3
    local Type = options.Type or "Default" -- Success, Warning, Error, Default
    
    local NotifGui = CreateScreenGui()
    
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Parent = NotifGui
    NotifFrame.BackgroundColor3 = Library.CurrentTheme.Secondary
    NotifFrame.BorderSizePixel = 0
    NotifFrame.Position = UDim2.new(1, -320, 1, 10)
    NotifFrame.Size = UDim2.new(0, 300, 0, 80)
    NotifFrame.ClipsDescendants = true
    
    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 10)
    NotifCorner.Parent = NotifFrame
    
    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Parent = NotifFrame
    NotifStroke.Color = Type == "Success" and Library.CurrentTheme.Success or 
                        Type == "Warning" and Library.CurrentTheme.Warning or
                        Type == "Error" and Library.CurrentTheme.Error or
                        Library.CurrentTheme.Accent
    NotifStroke.Thickness = 2
    NotifStroke.Transparency = 0.5
    
    local AccentBar = Instance.new("Frame")
    AccentBar.Parent = NotifFrame
    AccentBar.BackgroundColor3 = NotifStroke.Color
    AccentBar.BorderSizePixel = 0
    AccentBar.Size = UDim2.new(0, 4, 1, 0)
    
    local NotifTitle = Instance.new("TextLabel")
    NotifTitle.Parent = NotifFrame
    NotifTitle.BackgroundTransparency = 1
    NotifTitle.Position = UDim2.new(0, 15, 0, 10)
    NotifTitle.Size = UDim2.new(1, -30, 0, 20)
    NotifTitle.Font = Enum.Font.GothamBold
    NotifTitle.Text = Title
    NotifTitle.TextColor3 = Library.CurrentTheme.Text
    NotifTitle.TextSize = 15
    NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local NotifDesc = Instance.new("TextLabel")
    NotifDesc.Parent = NotifFrame
    NotifDesc.BackgroundTransparency = 1
    NotifDesc.Position = UDim2.new(0, 15, 0, 35)
    NotifDesc.Size = UDim2.new(1, -30, 0, 35)
    NotifDesc.Font = Enum.Font.Gotham
    NotifDesc.Text = Description
    NotifDesc.TextColor3 = Library.CurrentTheme.SubText
    NotifDesc.TextSize = 13
    NotifDesc.TextXAlignment = Enum.TextXAlignment.Left
    NotifDesc.TextYAlignment = Enum.TextYAlignment.Top
    NotifDesc.TextWrapped = true
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = NotifFrame
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -30, 0, 5)
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Library.CurrentTheme.SubText
    CloseButton.TextSize = 20
    
    -- أنيميشن الظهور
    Tween(NotifFrame, {Position = UDim2.new(1, -320, 1, -100)}, 0.5, AnimationStyles.Back)
    
    -- أنيميشن الاختفاء
    task.delay(Duration, function()
        Tween(NotifFrame, {Position = UDim2.new(1, -320, 1, 10)}, 0.5, AnimationStyles.Back)
        task.wait(0.5)
        NotifGui:Destroy()
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        Tween(NotifFrame, {Position = UDim2.new(1, -320, 1, 10)}, 0.5, AnimationStyles.Back)
        task.wait(0.5)
        NotifGui:Destroy()
    end)
end

-- نظام حفظ الإعدادات
Library.ConfigSystem = {}

function Library.ConfigSystem:Save(configName, data)
    local success, result = pcall(function()
        writefile(configName .. ".json", HttpService:JSONEncode(data))
    end)
    
    if success then
        Library:Notify({
            Title = "Config Saved",
            Description = "Configuration saved successfully!",
            Type = "Success",
            Duration = 2
        })
    else
        Library:Notify({
            Title = "Save Failed",
            Description = "Failed to save configuration",
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
            Title = "Config Loaded",
            Description = "Configuration loaded successfully!",
            Type = "Success",
            Duration = 2
        })
        return result
    else
        Library:Notify({
            Title = "Load Failed",
            Description = "No configuration file found",
            Type = "Warning",
            Duration = 3
        })
        return nil
    end
end

-- إنشاء الـ Window الرئيسي
function Library:CreateWindow(options)
    options = options or {}
    local WindowTitle = options.Title or "UI Library"
    local WindowSubtitle = options.Subtitle or "v" .. Library.Version
    local Theme = options.Theme or "Default"
    local ConfigFolder = options.ConfigFolder or "UltimateUI_Configs"
    local Keybind = options.Keybind or Enum.KeyCode.RightControl
    local Size = options.Size or UDim2.new(0, 650, 0, 550)
    
    -- تطبيق الثيم
    if Library.Themes[Theme] then
        Library.CurrentTheme = Library.Themes[Theme]
    end
    
    local ScreenGui = CreateScreenGui()
    
    -- Container رئيسي
    local MainContainer = Instance.new("Frame")
    MainContainer.Name = "MainContainer"
    MainContainer.Parent = ScreenGui
    MainContainer.BackgroundTransparency = 1
    MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainContainer.Size = Size
    MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    MainContainer.ClipsDescendants = false
    
    -- الإطار الرئيسي
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
    
    -- Shadow Effect (تأثير الظل)
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = MainContainer
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0, -20, 0, -20)
    Shadow.Size = UDim2.new(1, 40, 1, 40)
    Shadow.ZIndex = -1
    Shadow.Image = "rbxassetid://6015897843"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.4
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    
    -- Border Gradient
    local BorderGradient = Instance.new("UIStroke")
    BorderGradient.Parent = MainFrame
    BorderGradient.Color = Library.CurrentTheme.Accent
    BorderGradient.Thickness = 1.5
    BorderGradient.Transparency = 0.7
    
    -- الـ Header (الهيدر الفخم)
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Parent = MainFrame
    Header.BackgroundColor3 = Library.CurrentTheme.Secondary
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(1, 0, 0, 55)
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Parent = Header
    
    -- تأثير Gradient على الهيدر
    local HeaderGradient = Instance.new("UIGradient")
    HeaderGradient.Parent = Header
    HeaderGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Library.CurrentTheme.Secondary),
        ColorSequenceKeypoint.new(1, Library.CurrentTheme.Tertiary)
    }
    HeaderGradient.Rotation = 90
    
    -- Logo/Icon
    local Logo = Instance.new("ImageLabel")
    Logo.Name = "Logo"
    Logo.Parent = Header
    Logo.BackgroundTransparency = 1
    Logo.Position = UDim2.new(0, 15, 0.5, 0)
    Logo.Size = UDim2.new(0, 35, 0, 35)
    Logo.AnchorPoint = Vector2.new(0, 0.5)
    Logo.Image = "rbxassetid://7733992358" -- يمكن تغيير الأيقونة
    Logo.ImageColor3 = Library.CurrentTheme.Accent
    
    local LogoCorner = Instance.new("UICorner")
    LogoCorner.CornerRadius = UDim.new(1, 0)
    LogoCorner.Parent = Logo
    
    -- العنوان الرئيسي
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 60, 0, 8)
    Title.Size = UDim2.new(0.5, -60, 0, 22)
    Title.Font = Enum.Font.GothamBold
    Title.Text = WindowTitle
    Title.TextColor3 = Library.CurrentTheme.Text
    Title.TextSize = 17
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- العنوان الفرعي
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Name = "Subtitle"
    Subtitle.Parent = Header
    Subtitle.BackgroundTransparency = 1
    Subtitle.Position = UDim2.new(0, 60, 0, 28)
    Subtitle.Size = UDim2.new(0.5, -60, 0, 18)
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.Text = WindowSubtitle
    Subtitle.TextColor3 = Library.CurrentTheme.SubText
    Subtitle.TextSize = 13
    Subtitle.TextXAlignment = Enum.TextXAlignment.Left
    
    -- أزرار التحكم (تصغير، إغلاق)
    local ControlsFrame = Instance.new("Frame")
    ControlsFrame.Name = "Controls"
    ControlsFrame.Parent = Header
    ControlsFrame.BackgroundTransparency = 1
    ControlsFrame.Position = UDim2.new(1, -120, 0.5, 0)
    ControlsFrame.Size = UDim2.new(0, 110, 0, 30)
    ControlsFrame.AnchorPoint = Vector2.new(0, 0.5)
    
    local ControlsList = Instance.new("UIListLayout")
    ControlsList.Parent = ControlsFrame
    ControlsList.FillDirection = Enum.FillDirection.Horizontal
    ControlsList.HorizontalAlignment = Enum.HorizontalAlignment.Right
    ControlsList.Padding = UDim.new(0, 8)
    
    -- زر التصغير
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "Minimize"
    MinimizeButton.Parent = ControlsFrame
    MinimizeButton.BackgroundColor3 = Library.CurrentTheme.Tertiary
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = Library.CurrentTheme.Text
    MinimizeButton.TextSize = 20
    
    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 8)
    MinimizeCorner.Parent = MinimizeButton
    
    local minimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Tween(MainContainer, {Size = UDim2.new(0, 650, 0, 55)}, 0.3, AnimationStyles.Back)
            MinimizeButton.Text = "+"
        else
            Tween(MainContainer, {Size = Size}, 0.3, AnimationStyles.Back)
            MinimizeButton.Text = "−"
        end
    end)
    
    -- زر الإغلاق
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "Close"
    CloseButton.Parent = ControlsFrame
    CloseButton.BackgroundColor3 = Library.CurrentTheme.Error
    CloseButton.BorderSizePixel = 0
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Library.CurrentTheme.Text
    CloseButton.TextSize = 22
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
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
    
    -- Keybind لإخفاء/إظهار الواجهة
    local UIVisible = true
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Keybind then
            UIVisible = not UIVisible
            Tween(MainContainer, {
                Size = UIVisible and Size or UDim2.new(0, 0, 0, 0)
            }, 0.3, AnimationStyles.Back)
        end
    end)
    
    -- نظام السحب (Dragging)
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
    
    -- نظام الـ Tabs (القوائم الجانبية)
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = Library.CurrentTheme.Secondary
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 0, 0, 55)
    TabContainer.Size = UDim2.new(0, 165, 1, -55)
    
    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 6)
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.Parent = TabContainer
    TabPadding.PaddingTop = UDim.new(0, 12)
    TabPadding.PaddingBottom = UDim.new(0, 12)
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.PaddingRight = UDim.new(0, 10)
    
    -- شريط البحث في التابات
    local SearchBox = Instance.new("TextBox")
    SearchBox.Name = "SearchBox"
    SearchBox.Parent = TabContainer
    SearchBox.BackgroundColor3 = Library.CurrentTheme.Tertiary
    SearchBox.BorderSizePixel = 0
    SearchBox.Size = UDim2.new(1, 0, 0, 35)
    SearchBox.Font = Enum.Font.Gotham
    SearchBox.PlaceholderText = "🔍 Search..."
    SearchBox.PlaceholderColor3 = Library.CurrentTheme.SubText
    SearchBox.Text = ""
    SearchBox.TextColor3 = Library.CurrentTheme.Text
    SearchBox.TextSize = 13
    SearchBox.ClearTextOnFocus = false
    
    local SearchCorner = Instance.new("UICorner")
    SearchCorner.CornerRadius = UDim.new(0, 8)
    SearchCorner.Parent = SearchBox
    
    -- الخط الفاصل
    local Divider = Instance.new("Frame")
    Divider.Name = "Divider"
    Divider.Parent = TabContainer
    Divider.BackgroundColor3 = Library.CurrentTheme.Border
    Divider.BorderSizePixel = 0
    Divider.Size = UDim2.new(1, 0, 0, 1)
    
    -- منطقة عرض المحتوى
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, 165, 0, 55)
    ContentContainer.Size = UDim2.new(1, -165, 1, -55)
    
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        SavedData = {}
    }
    
    -- إنشاء Tab
    function Window:CreateTab(options)
        options = options or {}
        local TabName = options.Name or "Tab"
        local TabIcon = options.Icon or "rbxassetid://7734053426"
        local TabVisible = options.Visible ~= false
        
        -- زر الـ Tab
        local TabButton = Instance.new("TextButton")
        TabButton.Name = TabName
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = Library.CurrentTheme.Tertiary
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, 0, 0, 42)
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.Text = ""
        TabButton.TextColor3 = Library.CurrentTheme.SubText
        TabButton.TextSize = 14
        TabButton.AutoButtonColor = false
        TabButton.Visible = TabVisible
        
        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 10)
        TabButtonCorner.Parent = TabButton
        
        -- أيقونة التاب
        local TabIconImage = Instance.new("ImageLabel")
        TabIconImage.Name = "Icon"
        TabIconImage.Parent = TabButton
        TabIconImage.BackgroundTransparency = 1
        TabIconImage.Position = UDim2.new(0, 12, 0.5, 0)
        TabIconImage.Size = UDim2.new(0, 22, 0, 22)
        TabIconImage.AnchorPoint = Vector2.new(0, 0.5)
        TabIconImage.Image = TabIcon
        TabIconImage.ImageColor3 = Library.CurrentTheme.SubText
        
        -- نص التاب
        local TabText = Instance.new("TextLabel")
        TabText.Name = "TabText"
        TabText.Parent = TabButton
        TabText.BackgroundTransparency = 1
        TabText.Position = UDim2.new(0, 42, 0, 0)
        TabText.Size = UDim2.new(1, -50, 1, 0)
        TabText.Font = Enum.Font.GothamSemibold
        TabText.Text = TabName
        TabText.TextColor3 = Library.CurrentTheme.SubText
        TabText.TextSize = 14
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Indicator (خط التحديد)
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
        
        -- محتوى التاب
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
        ContentPadding.PaddingLeft = UDim.new(0, 20)
        ContentPadding.PaddingRight = UDim.new(0, 20)
        
        -- تحديث حجم الـ Canvas
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 30)
        end)
        
        -- تفعيل التاب عند الضغط
        TabButton.MouseButton1Click:Connect(function()
            CreateRipple(TabButton, Mouse.X - TabButton.AbsolutePosition.X, Mouse.Y - TabButton.AbsolutePosition.Y)
            
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
        
        -- تأثير Hover
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
        
        -- إنشاء Section (قسم)
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
            SectionTitle.TextSize = 15
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
            
            -- Label (نص عادي)
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
            
            -- Paragraph (فقرة نصية)
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
            
            -- Button (زر)
            function SectionObj:AddButton(options)
                options = options or {}
                local ButtonName = options.Name or "Button"
                local Callback = options.Callback or function() end
                
                local Button = Instance.new("TextButton")
                Button.Name = ButtonName
                Button.Parent = SectionContent
                Button.BackgroundColor3 = Library.CurrentTheme.Tertiary
                Button.BorderSizePixel = 0
                Button.Size = UDim2.new(1, 0, 0, 40)
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
                    Tween(Button, {Size = UDim2.new(1, 0, 0, 37)}, 0.1)
                    task.wait(0.1)
                    Tween(Button, {Size = UDim2.new(1, 0, 0, 40)}, 0.1)
                    Callback()
                end)
                
                return {
                    SetName = function(self, newName)
                        Button.Text = newName
                    end
                }
            end
            
            -- Toggle (مفتاح تشغيل/إيقاف)
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
                Toggle.Size = UDim2.new(1, 0, 0, 40)
                
                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 8)
                ToggleCorner.Parent = Toggle
                
                local ToggleLabel = Instance.new("TextLabel")
                ToggleLabel.Name = "Label"
                ToggleLabel.Parent = Toggle
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
                ToggleLabel.Size = UDim2.new(1, -70, 1, 0)
                ToggleLabel.Font = Enum.Font.GothamSemibold
                ToggleLabel.Text = ToggleName
                ToggleLabel.TextColor3 = Library.CurrentTheme.Text
                ToggleLabel.TextSize = 14
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local ToggleButton = Instance.new("TextButton")
                ToggleButton.Name = "Button"
                ToggleButton.Parent = Toggle
                ToggleButton.BackgroundColor3 = DefaultValue and Library.CurrentTheme.Accent or Library.CurrentTheme.Background
                ToggleButton.BorderSizePixel = 0
                ToggleButton.Position = UDim2.new(1, -50, 0.5, 0)
                ToggleButton.Size = UDim2.new(0, 42, 0, 22)
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
                ToggleCircle.Position = DefaultValue and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                ToggleCircle.Size = UDim2.new(0, 18, 0, 18)
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
                        Position = toggled and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
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
            
            -- Slider (شريط التمرير)
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
                Slider.Size = UDim2.new(1, 0, 0, 55)
                
                local SliderCorner = Instance.new("UICorner")
                SliderCorner.CornerRadius = UDim.new(0, 8)
                SliderCorner.Parent = Slider
                
                local SliderLabel = Instance.new("TextLabel")
                SliderLabel.Name = "Label"
                SliderLabel.Parent = Slider
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Position = UDim2.new(0, 15, 0, 8)
                SliderLabel.Size = UDim2.new(0.7, 0, 0, 20)
                SliderLabel.Font = Enum.Font.GothamSemibold
                SliderLabel.Text = SliderName
                SliderLabel.TextColor3 = Library.CurrentTheme.Text
                SliderLabel.TextSize = 14
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local SliderValue = Instance.new("TextLabel")
                SliderValue.Name = "Value"
                SliderValue.Parent = Slider
                SliderValue.BackgroundColor3 = Library.CurrentTheme.Background
                SliderValue.BorderSizePixel = 0
                SliderValue.Position = UDim2.new(1, -60, 0, 8)
                SliderValue.Size = UDim2.new(0, 50, 0, 20)
                SliderValue.Font = Enum.Font.GothamBold
                SliderValue.Text = tostring(Default)
                SliderValue.TextColor3 = Library.CurrentTheme.Accent
                SliderValue.TextSize = 13
                
                local ValueCorner = Instance.new("UICorner")
                ValueCorner.CornerRadius = UDim.new(0, 6)
                ValueCorner.Parent = SliderValue
                
                local SliderBar = Instance.new("Frame")
                SliderBar.Name = "Bar"
                SliderBar.Parent = Slider
                SliderBar.BackgroundColor3 = Library.CurrentTheme.Background
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0, 15, 1, -18)
                SliderBar.Size = UDim2.new(1, -30, 0, 8)
                
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
                
                -- Gradient للـ Fill
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
                SliderDot.Size = UDim2.new(0, 16, 0, 16)
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
                        Tween(SliderDot, {Size = UDim2.new(0, 20, 0, 20)}, 0.2, AnimationStyles.Back)
                    end
                end)
                
                SliderBar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                        Tween(SliderDot, {Size = UDim2.new(0, 16, 0, 16)}, 0.2)
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
                    end
                }
            end
            
            -- Dropdown (القائمة المنسدلة)
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
                Dropdown.Size = UDim2.new(1, 0, 0, 40)
                Dropdown.ClipsDescendants = true
                
                local DropdownCorner = Instance.new("UICorner")
                DropdownCorner.CornerRadius = UDim.new(0, 8)
                DropdownCorner.Parent = Dropdown
                
                local DropdownLabel = Instance.new("TextLabel")
                DropdownLabel.Name = "Label"
                DropdownLabel.Parent = Dropdown
                DropdownLabel.BackgroundTransparency = 1
                DropdownLabel.Position = UDim2.new(0, 15, 0, 0)
                DropdownLabel.Size = UDim2.new(0.6, 0, 0, 40)
                DropdownLabel.Font = Enum.Font.GothamSemibold
                DropdownLabel.Text = DropdownName
                DropdownLabel.TextColor3 = Library.CurrentTheme.Text
                DropdownLabel.TextSize = 14
                DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local DropdownButton = Instance.new("TextButton")
                DropdownButton.Name = "Button"
                DropdownButton.Parent = Dropdown
                DropdownButton.BackgroundColor3 = Library.CurrentTheme.Background
                DropdownButton.BorderSizePixel = 0
                DropdownButton.Position = UDim2.new(1, -150, 0, 8)
                DropdownButton.Size = UDim2.new(0, 140, 0, 24)
                DropdownButton.Font = Enum.Font.Gotham
                DropdownButton.Text = "  " .. Default
                DropdownButton.TextColor3 = Library.CurrentTheme.Accent
                DropdownButton.TextSize = 13
                DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
                DropdownButton.AutoButtonColor = false
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 6)
                ButtonCorner.Parent = DropdownButton
                
                local Arrow = Instance.new("TextLabel")
                Arrow.Parent = DropdownButton
                Arrow.BackgroundTransparency = 1
                Arrow.Position = UDim2.new(1, -22, 0, 0)
                Arrow.Size = UDim2.new(0, 20, 1, 0)
                Arrow.Font = Enum.Font.GothamBold
                Arrow.Text = "▼"
                Arrow.TextColor3 = Library.CurrentTheme.SubText
                Arrow.TextSize = 10
                
                local ItemList = Instance.new("ScrollingFrame")
                ItemList.Name = "ItemList"
                ItemList.Parent = Dropdown
                ItemList.BackgroundTransparency = 1
                ItemList.BorderSizePixel = 0
                ItemList.Position = UDim2.new(0, 10, 0, 45)
                ItemList.Size = UDim2.new(1, -20, 0, 0)
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
                    Item.Size = UDim2.new(1, 0, 0, 28)
                    Item.Font = Enum.Font.Gotham
                    Item.Text = "  " .. itemName
                    Item.TextColor3 = Library.CurrentTheme.Text
                    Item.TextSize = 13
                    Item.TextXAlignment = Enum.TextXAlignment.Left
                    Item.AutoButtonColor = false
                    
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
                        Tween(Dropdown, {Size = UDim2.new(1, 0, 0, 40)}, 0.3, AnimationStyles.Back)
                        Tween(Arrow, {Rotation = 0}, 0.3)
                    end)
                end
                
                DropdownButton.MouseButton1Click:Connect(function()
                    expanded = not expanded
                    if expanded then
                        local itemCount = math.min(#Items, 5)
                        Tween(Dropdown, {Size = UDim2.new(1, 0, 0, 50 + (itemCount * 32))}, 0.3, AnimationStyles.Back)
                        Tween(Arrow, {Rotation = 180}, 0.3)
                        ItemList.Size = UDim2.new(1, -20, 0, itemCount * 32)
                    else
                        Tween(Dropdown, {Size = UDim2.new(1, 0, 0, 40)}, 0.3, AnimationStyles.Back)
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
            
            -- Textbox (مربع نص)
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
                Textbox.Size = UDim2.new(1, 0, 0, 40)
                
                local TextboxCorner = Instance.new("UICorner")
                TextboxCorner.CornerRadius = UDim.new(0, 8)
                TextboxCorner.Parent = Textbox
                
                local TextboxLabel = Instance.new("TextLabel")
                TextboxLabel.Name = "Label"
                TextboxLabel.Parent = Textbox
                TextboxLabel.BackgroundTransparency = 1
                TextboxLabel.Position = UDim2.new(0, 15, 0, 0)
                TextboxLabel.Size = UDim2.new(0.4, 0, 1, 0)
                TextboxLabel.Font = Enum.Font.GothamSemibold
                TextboxLabel.Text = TextboxName
                TextboxLabel.TextColor3 = Library.CurrentTheme.Text
                TextboxLabel.TextSize = 14
                TextboxLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local TextboxInput = Instance.new("TextBox")
                TextboxInput.Name = "Input"
                TextboxInput.Parent = Textbox
                TextboxInput.BackgroundColor3 = Library.CurrentTheme.Background
                TextboxInput.BorderSizePixel = 0
                TextboxInput.Position = UDim2.new(0.45, 0, 0, 8)
                TextboxInput.Size = UDim2.new(0.5, -15, 0, 24)
                TextboxInput.Font = Enum.Font.Gotham
                TextboxInput.PlaceholderText = Placeholder
                TextboxInput.PlaceholderColor3 = Library.CurrentTheme.SubText
                TextboxInput.Text = DefaultText
                TextboxInput.TextColor3 = Library.CurrentTheme.Accent
                TextboxInput.TextSize = 13
                TextboxInput.ClearTextOnFocus = false
                
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
            
            -- Keybind (ربط المفاتيح)
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
                Keybind.Size = UDim2.new(1, 0, 0, 40)
                
                local KeybindCorner = Instance.new("UICorner")
                KeybindCorner.CornerRadius = UDim.new(0, 8)
                KeybindCorner.Parent = Keybind
                
                local KeybindLabel = Instance.new("TextLabel")
                KeybindLabel.Name = "Label"
                KeybindLabel.Parent = Keybind
                KeybindLabel.BackgroundTransparency = 1
                KeybindLabel.Position = UDim2.new(0, 15, 0, 0)
                KeybindLabel.Size = UDim2.new(0.6, 0, 1, 0)
                KeybindLabel.Font = Enum.Font.GothamSemibold
                KeybindLabel.Text = KeybindName
                KeybindLabel.TextColor3 = Library.CurrentTheme.Text
                KeybindLabel.TextSize = 14
                KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local KeybindButton = Instance.new("TextButton")
                KeybindButton.Name = "Button"
                KeybindButton.Parent = Keybind
                KeybindButton.BackgroundColor3 = Library.CurrentTheme.Background
                KeybindButton.BorderSizePixel = 0
                KeybindButton.Position = UDim2.new(1, -80, 0, 8)
                KeybindButton.Size = UDim2.new(0, 70, 0, 24)
                KeybindButton.Font = Enum.Font.GothamBold
                KeybindButton.Text = DefaultKey.Name
                KeybindButton.TextColor3 = Library.CurrentTheme.Accent
                KeybindButton.TextSize = 12
                KeybindButton.AutoButtonColor = false
                
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
            
            -- Color Picker (منتقي الألوان)
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
                ColorPicker.Size = UDim2.new(1, 0, 0, 40)
                ColorPicker.ClipsDescendants = true
                
                local PickerCorner = Instance.new("UICorner")
                PickerCorner.CornerRadius = UDim.new(0, 8)
                PickerCorner.Parent = ColorPicker
                
                local PickerLabel = Instance.new("TextLabel")
                PickerLabel.Name = "Label"
                PickerLabel.Parent = ColorPicker
                PickerLabel.BackgroundTransparency = 1
                PickerLabel.Position = UDim2.new(0, 15, 0, 0)
                PickerLabel.Size = UDim2.new(0.7, 0, 0, 40)
                PickerLabel.Font = Enum.Font.GothamSemibold
                PickerLabel.Text = PickerName
                PickerLabel.TextColor3 = Library.CurrentTheme.Text
                PickerLabel.TextSize = 14
                PickerLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local ColorDisplay = Instance.new("TextButton")
                ColorDisplay.Name = "Display"
                ColorDisplay.Parent = ColorPicker
                ColorDisplay.BackgroundColor3 = DefaultColor
                ColorDisplay.BorderSizePixel = 0
                ColorDisplay.Position = UDim2.new(1, -50, 0, 10)
                ColorDisplay.Size = UDim2.new(0, 35, 0, 20)
                ColorDisplay.Text = ""
                ColorDisplay.AutoButtonColor = false
                
                local DisplayCorner = Instance.new("UICorner")
                DisplayCorner.CornerRadius = UDim.new(0, 6)
                DisplayCorner.Parent = ColorDisplay
                
                local DisplayStroke = Instance.new("UIStroke")
                DisplayStroke.Parent = ColorDisplay
                DisplayStroke.Color = Library.CurrentTheme.Border
                DisplayStroke.Thickness = 2
                
                -- Color Picker Palette
                local Palette = Instance.new("Frame")
                Palette.Name = "Palette"
                Palette.Parent = ColorPicker
                Palette.BackgroundColor3 = Library.CurrentTheme.Background
                Palette.BorderSizePixel = 0
                Palette.Position = UDim2.new(0, 10, 0, 45)
                Palette.Size = UDim2.new(1, -20, 0, 150)
                Palette.Visible = false
                
                local PaletteCorner = Instance.new("UICorner")
                PaletteCorner.CornerRadius = UDim.new(0, 8)
                PaletteCorner.Parent = Palette
                
                local ColorCanvas = Instance.new("ImageButton")
                ColorCanvas.Name = "Canvas"
                ColorCanvas.Parent = Palette
                ColorCanvas.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorCanvas.BorderSizePixel = 0
                ColorCanvas.Position = UDim2.new(0, 10, 0, 10)
                ColorCanvas.Size = UDim2.new(1, -90, 1, -20)
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
                HueSlider.Position = UDim2.new(1, -70, 0, 10)
                HueSlider.Size = UDim2.new(0, 30, 1, -20)
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
                Confirm.Position = UDim2.new(1, -30, 0, 10)
                Confirm.Size = UDim2.new(0, 20, 0, 20)
                Confirm.Font = Enum.Font.GothamBold
                Confirm.Text = "✓"
                Confirm.TextColor3 = Library.CurrentTheme.Text
                Confirm.TextSize = 14
                Confirm.AutoButtonColor = false
                
                local ConfirmCorner = Instance.new("UICorner")
                ConfirmCorner.CornerRadius = UDim.new(0, 4)
                ConfirmCorner.Parent = Confirm
                
                local expanded = false
                local currentHue = 0
                local currentSat = 1
                local currentVal = 1
                
                ColorDisplay.MouseButton1Click:Connect(function()
                    expanded = not expanded
                    Palette.Visible = expanded
                    if expanded then
                        Tween(ColorPicker, {Size = UDim2.new(1, 0, 0, 205)}, 0.3, AnimationStyles.Back)
                    else
                        Tween(ColorPicker, {Size = UDim2.new(1, 0, 0, 40)}, 0.3, AnimationStyles.Back)
                    end
                end)
                
                Confirm.MouseButton1Click:Connect(function()
                    expanded = false
                    Palette.Visible = false
                    Tween(ColorPicker, {Size = UDim2.new(1, 0, 0, 40)}, 0.3, AnimationStyles.Back)
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
                
                -- Set initial color
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
        
        -- تفعيل أول تاب تلقائياً
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
    
    -- نظام Watermark (علامة مائية)
    function Window:CreateWatermark(text)
        local Watermark = Instance.new("TextLabel")
        Watermark.Name = "Watermark"
        Watermark.Parent = ScreenGui
        Watermark.BackgroundColor3 = Library.CurrentTheme.Secondary
        Watermark.BorderSizePixel = 0
        Watermark.Position = UDim2.new(0, 10, 0, 10)
        Watermark.Size = UDim2.new(0, 200, 0, 30)
        Watermark.Font = Enum.Font.GothamBold
        Watermark.Text = text or "UI Library"
        Watermark.TextColor3 = Library.CurrentTheme.Text
        Watermark.TextSize = 14
        
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
    
    -- أنيميشن الظهور
    MainContainer.Size = UDim2.new(0, 0, 0, 0)
    Tween(MainContainer, {Size = Size}, 0.5, AnimationStyles.Back)
    
    -- Notification عند بدء التشغيل
    Library:Notify({
        Title = "تم التحميل بنجاح!",
        Description = WindowTitle .. " جاهز للاستخدام",
        Type = "Success",
        Duration = 3
    })
    
    return Window
end

return Library
