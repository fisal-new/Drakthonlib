--[[
    ╔═══════════════════════════════════════════════════╗
    ║           DrakthonLib v3.0 - FIXED                ║
    ║         إصلاح كامل لمشكلة ظهور العناصر           ║
    ╚═══════════════════════════════════════════════════╝
]]

if not game:IsLoaded() then game.Loaded:Wait() end

local DrakthonLib = {
    Themes = {},
    CurrentTheme = "Purple",
    Settings = {
        SoundEnabled = true,
        AnimationSpeed = 0.3
    }
}

-- ════════════════════════════════════════════════════
--                    خدمات Roblox
-- ════════════════════════════════════════════════════
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")

-- ════════════════════════════════════════════════════
--                  نظام الثيمات (Themes)
-- ════════════════════════════════════════════════════
DrakthonLib.Themes = {
    Purple = {
        Primary = Color3.fromRGB(147, 51, 234),
        Secondary = Color3.fromRGB(126, 34, 206),
        Accent = Color3.fromRGB(168, 85, 247),
        Background = Color3.fromRGB(17, 17, 27),
        Surface = Color3.fromRGB(30, 30, 46),
        Text = Color3.fromRGB(255, 255, 255),
        TextDim = Color3.fromRGB(161, 161, 170),
        Success = Color3.fromRGB(34, 197, 94),
        Error = Color3.fromRGB(239, 68, 68),
        Warning = Color3.fromRGB(251, 191, 36)
    },
    
    Cyan = {
        Primary = Color3.fromRGB(6, 182, 212),
        Secondary = Color3.fromRGB(8, 145, 178),
        Accent = Color3.fromRGB(34, 211, 238),
        Background = Color3.fromRGB(15, 23, 42),
        Surface = Color3.fromRGB(30, 41, 59),
        Text = Color3.fromRGB(255, 255, 255),
        TextDim = Color3.fromRGB(148, 163, 184),
        Success = Color3.fromRGB(16, 185, 129),
        Error = Color3.fromRGB(244, 63, 94),
        Warning = Color3.fromRGB(245, 158, 11)
    },
    
    Emerald = {
        Primary = Color3.fromRGB(16, 185, 129),
        Secondary = Color3.fromRGB(5, 150, 105),
        Accent = Color3.fromRGB(52, 211, 153),
        Background = Color3.fromRGB(17, 24, 39),
        Surface = Color3.fromRGB(31, 41, 55),
        Text = Color3.fromRGB(255, 255, 255),
        TextDim = Color3.fromRGB(156, 163, 175),
        Success = Color3.fromRGB(34, 197, 94),
        Error = Color3.fromRGB(248, 113, 113),
        Warning = Color3.fromRGB(251, 146, 60)
    },
    
    Rose = {
        Primary = Color3.fromRGB(244, 63, 94),
        Secondary = Color3.fromRGB(225, 29, 72),
        Accent = Color3.fromRGB(251, 113, 133),
        Background = Color3.fromRGB(24, 24, 27),
        Surface = Color3.fromRGB(39, 39, 42),
        Text = Color3.fromRGB(255, 255, 255),
        TextDim = Color3.fromRGB(161, 161, 170),
        Success = Color3.fromRGB(74, 222, 128),
        Error = Color3.fromRGB(239, 68, 68),
        Warning = Color3.fromRGB(252, 211, 77)
    },
    
    Ocean = {
        Primary = Color3.fromRGB(59, 130, 246),
        Secondary = Color3.fromRGB(37, 99, 235),
        Accent = Color3.fromRGB(96, 165, 250),
        Background = Color3.fromRGB(15, 23, 42),
        Surface = Color3.fromRGB(30, 41, 59),
        Text = Color3.fromRGB(255, 255, 255),
        TextDim = Color3.fromRGB(148, 163, 184),
        Success = Color3.fromRGB(34, 197, 94),
        Error = Color3.fromRGB(239, 68, 68),
        Warning = Color3.fromRGB(234, 179, 8)
    }
}

-- ════════════════════════════════════════════════════
--                    الأصوات
-- ════════════════════════════════════════════════════
local Sounds = {
    Click = "rbxassetid://6895079853",
    Hover = "rbxassetid://6895079853",
    Toggle = "rbxassetid://6895079853",
    Notification = "rbxassetid://9086208694",
    Success = "rbxassetid://6026984224",
    Error = "rbxassetid://6026984224",
    Open = "rbxassetid://6895079853",
    Close = "rbxassetid://6895079853"
}

-- ════════════════════════════════════════════════════
--                    الأيقونات
-- ════════════════════════════════════════════════════
local Icons = {
    Home = "rbxassetid://11963373994",
    Settings = "rbxassetid://11963373355",
    User = "rbxassetid://11963373588",
    Globe = "rbxassetid://11963373429",
    Box = "rbxassetid://11963373004",
    Search = "rbxassetid://11963373287",
    Check = "rbxassetid://11963373004",
    X = "rbxassetid://11963373767",
    ChevronRight = "rbxassetid://11963373149",
    Info = "rbxassetid://11963373429",
    AlertTriangle = "rbxassetid://11963373004",
    Minimize = "rbxassetid://11963373176",
    Maximize = "rbxassetid://11963373149"
}

-- ════════════════════════════════════════════════════
--                  دوال مساعدة
-- ════════════════════════════════════════════════════
local function RandomString(length)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = ""
    for i = 1, length or 16 do
        local rand = math.random(1, #chars)
        result = result .. chars:sub(rand, rand)
    end
    return result
end

local function PlaySound(soundId, volume)
    if not DrakthonLib.Settings.SoundEnabled then return end
    
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = soundId
        sound.Volume = volume or 0.5
        sound.Parent = SoundService
        sound:Play()
        task.delay(2, function() sound:Destroy() end)
    end)
end

local function Tween(object, properties, duration, style, direction)
    duration = duration or DrakthonLib.Settings.AnimationSpeed
    style = style or Enum.EasingStyle.Quart
    direction = direction or Enum.EasingDirection.Out
    
    local tween = TweenService:Create(object, TweenInfo.new(duration, style, direction), properties)
    tween:Play()
    return tween
end

local function GetTheme()
    return DrakthonLib.Themes[DrakthonLib.CurrentTheme]
end

-- ════════════════════════════════════════════════════
--              إنشاء النافذة الرئيسية
-- ════════════════════════════════════════════════════
function DrakthonLib:CreateWindow(config)
    config = config or {}
    local windowName = config.Name or "DrakthonLib"
    local windowVersion = config.Version or "v3.0"
    local windowIcon = config.Icon or Icons.Box
    local theme = config.Theme or "Purple"
    
    DrakthonLib.CurrentTheme = theme
    local Theme = GetTheme()
    
    local AllPages = {}
    local CurrentPage = nil
    local MinimizeState = false
    local FirstTabActivated = false
    
    -- الحاويات الرئيسية
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    
    ScreenGui.Name = RandomString(12)
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 999999999
    ScreenGui.IgnoreGuiInset = true
    
    -- منع التفاعل مع الخلفية
    local Blocker = Instance.new("Frame")
    Blocker.Name = "Blocker"
    Blocker.Parent = ScreenGui
    Blocker.BackgroundTransparency = 1
    Blocker.Size = UDim2.new(1, 0, 1, 0)
    Blocker.ZIndex = 1
    Blocker.Active = true
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.ClipsDescendants = true
    MainFrame.BorderSizePixel = 0
    MainFrame.ZIndex = 2
    
    UICorner.CornerRadius = UDim.new(0, 16)
    UICorner.Parent = MainFrame
    
    -- ════════════════════════════════════════════════════
    --                  شريط العنوان
    -- ════════════════════════════════════════════════════
    local TitleBar = Instance.new("Frame")
    local TitleBarGradient = Instance.new("UIGradient")
    local TitleIcon = Instance.new("ImageLabel")
    local TitleLabel = Instance.new("TextLabel")
    local ControlsFrame = Instance.new("Frame")
    local MinimizeBtn = Instance.new("ImageButton")
    local CloseBtn = Instance.new("ImageButton")
    local TitleDivider = Instance.new("Frame")
    
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Theme.Surface
    TitleBar.BackgroundTransparency = 0.3
    TitleBar.Size = UDim2.new(1, 0, 0, 50)
    TitleBar.BorderSizePixel = 0
    TitleBar.ZIndex = 10
    
    TitleBarGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Theme.Primary),
        ColorSequenceKeypoint.new(1, Theme.Secondary)
    }
    TitleBarGradient.Rotation = 90
    TitleBarGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.8),
        NumberSequenceKeypoint.new(1, 0.95)
    }
    TitleBarGradient.Parent = TitleBar
    
    TitleIcon.Name = "Icon"
    TitleIcon.Parent = TitleBar
    TitleIcon.BackgroundTransparency = 1
    TitleIcon.Position = UDim2.new(0, 15, 0.5, -12)
    TitleIcon.Size = UDim2.new(0, 24, 0, 24)
    TitleIcon.Image = windowIcon
    TitleIcon.ImageColor3 = Theme.Primary
    TitleIcon.ZIndex = 11
    
    TitleLabel.Name = "Title"
    TitleLabel.Parent = TitleBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 50, 0, 0)
    TitleLabel.Size = UDim2.new(1, -150, 1, 0)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = windowName .. " • " .. windowVersion
    TitleLabel.TextColor3 = Theme.Text
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.ZIndex = 11
    
    ControlsFrame.Name = "Controls"
    ControlsFrame.Parent = TitleBar
    ControlsFrame.BackgroundTransparency = 1
    ControlsFrame.Position = UDim2.new(1, -90, 0.5, -15)
    ControlsFrame.Size = UDim2.new(0, 80, 0, 30)
    ControlsFrame.ZIndex = 11
    
    MinimizeBtn.Name = "Minimize"
    MinimizeBtn.Parent = ControlsFrame
    MinimizeBtn.BackgroundColor3 = Theme.Surface
    MinimizeBtn.BackgroundTransparency = 0.5
    MinimizeBtn.Position = UDim2.new(0, 0, 0, 0)
    MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    MinimizeBtn.Image = Icons.Minimize
    MinimizeBtn.ImageColor3 = Theme.Warning
    MinimizeBtn.BorderSizePixel = 0
    MinimizeBtn.ZIndex = 12
    
    local MinimizeBtnCorner = Instance.new("UICorner")
    MinimizeBtnCorner.CornerRadius = UDim.new(0, 8)
    MinimizeBtnCorner.Parent = MinimizeBtn
    
    CloseBtn.Name = "Close"
    CloseBtn.Parent = ControlsFrame
    CloseBtn.BackgroundColor3 = Theme.Surface
    CloseBtn.BackgroundTransparency = 0.5
    CloseBtn.Position = UDim2.new(0, 40, 0, 0)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Image = Icons.X
    CloseBtn.ImageColor3 = Theme.Error
    CloseBtn.BorderSizePixel = 0
    CloseBtn.ZIndex = 12
    
    local CloseBtnCorner = Instance.new("UICorner")
    CloseBtnCorner.CornerRadius = UDim.new(0, 8)
    CloseBtnCorner.Parent = CloseBtn
    
    TitleDivider.Name = "Divider"
    TitleDivider.Parent = TitleBar
    TitleDivider.BackgroundColor3 = Theme.Primary
    TitleDivider.BackgroundTransparency = 0.7
    TitleDivider.Position = UDim2.new(0, 0, 1, -1)
    TitleDivider.Size = UDim2.new(1, 0, 0, 2)
    TitleDivider.BorderSizePixel = 0
    TitleDivider.ZIndex = 10
    
    local DividerGradient = Instance.new("UIGradient")
    DividerGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(1, 1)
    }
    DividerGradient.Parent = TitleDivider
    
    -- تأثيرات الأزرار
    local function ButtonEffect(button)
        button.MouseEnter:Connect(function()
            PlaySound(Sounds.Hover, 0.3)
            Tween(button, {BackgroundTransparency = 0.2}, 0.2)
        end)
        
        button.MouseLeave:Connect(function()
            Tween(button, {BackgroundTransparency = 0.5}, 0.2)
        end)
        
        button.MouseButton1Down:Connect(function()
            Tween(button, {Size = UDim2.new(0, 28, 0, 28)}, 0.1)
        end)
        
        button.MouseButton1Up:Connect(function()
            Tween(button, {Size = UDim2.new(0, 30, 0, 30)}, 0.1)
        end)
    end
    
    ButtonEffect(MinimizeBtn)
    ButtonEffect(CloseBtn)
    
    -- ════════════════════════════════════════════════════
    --              المربع المصغّر
    -- ════════════════════════════════════════════════════
    local MinimizeBox = Instance.new("ImageButton")
    local MinimizeBoxCorner = Instance.new("UICorner")
    local MinimizeBoxIcon = Instance.new("ImageLabel")
    local MinimizeBoxGradient = Instance.new("UIGradient")
    
    MinimizeBox.Name = "MinimizeBox"
    MinimizeBox.Parent = ScreenGui
    MinimizeBox.BackgroundColor3 = Theme.Primary
    MinimizeBox.Position = UDim2.new(0, 20, 0, 20)
    MinimizeBox.Size = UDim2.new(0, 50, 0, 50)
    MinimizeBox.Visible = false
    MinimizeBox.AutoButtonColor = false
    MinimizeBox.BorderSizePixel = 0
    MinimizeBox.ZIndex = 20
    
    MinimizeBoxCorner.CornerRadius = UDim.new(0, 12)
    MinimizeBoxCorner.Parent = MinimizeBox
    
    MinimizeBoxIcon.Name = "Icon"
    MinimizeBoxIcon.Parent = MinimizeBox
    MinimizeBoxIcon.BackgroundTransparency = 1
    MinimizeBoxIcon.Position = UDim2.new(0.5, -15, 0.5, -15)
    MinimizeBoxIcon.Size = UDim2.new(0, 30, 0, 30)
    MinimizeBoxIcon.Image = windowIcon
    MinimizeBoxIcon.ImageColor3 = Theme.Text
    MinimizeBoxIcon.ZIndex = 21
    
    MinimizeBoxGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Theme.Primary),
        ColorSequenceKeypoint.new(1, Theme.Secondary)
    }
    MinimizeBoxGradient.Rotation = 45
    MinimizeBoxGradient.Parent = MinimizeBox
    
    -- وظيفة الإغلاق
    CloseBtn.MouseButton1Click:Connect(function()
        PlaySound(Sounds.Close, 0.6)
        Tween(MainFrame, {Size = UDim2.new(0, 650, 0, 0)}, 0.3)
        task.wait(0.3)
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
        task.wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- وظيفة التصغير
    MinimizeBtn.MouseButton1Click:Connect(function()
        MinimizeState = not MinimizeState
        PlaySound(Sounds.Click, 0.5)
        
        if MinimizeState then
            local targetSize = UDim2.new(0, 650 * 0.6, 0, 450 * 0.6)
            Tween(MainFrame, {Size = targetSize}, 0.3)
            task.wait(0.3)
            Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
            task.wait(0.3)
            
            MainFrame.Visible = false
            MinimizeBox.Visible = true
            MinimizeBox.Size = UDim2.new(0, 0, 0, 0)
            Tween(MinimizeBox, {Size = UDim2.new(0, 50, 0, 50)}, 0.4, Enum.EasingStyle.Back)
        end
    end)
    
    -- فتح من المربع
    MinimizeBox.MouseButton1Click:Connect(function()
        PlaySound(Sounds.Open, 0.6)
        MinimizeState = false
        
        Tween(MinimizeBox, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
        task.wait(0.3)
        MinimizeBox.Visible = false
        
        MainFrame.Visible = true
        MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        
        Tween(MainFrame, {Size = UDim2.new(0, 650, 0, 0)}, 0.4, Enum.EasingStyle.Back)
        task.wait(0.4)
        Tween(MainFrame, {Size = UDim2.new(0, 650, 0, 450)}, 0.5, Enum.EasingStyle.Back)
    end)
    
    MinimizeBox.MouseEnter:Connect(function()
        PlaySound(Sounds.Hover, 0.3)
        Tween(MinimizeBox, {Size = UDim2.new(0, 55, 0, 55)}, 0.2)
    end)
    
    MinimizeBox.MouseLeave:Connect(function()
        Tween(MinimizeBox, {Size = UDim2.new(0, 50, 0, 50)}, 0.2)
    end)
    
    -- السحب
    local function MakeDraggable(frame)
        local dragging = false
        local dragInput, dragStart, startPos
        
        local function UpdateDrag(input)
            local delta = input.Position - dragStart
            local newPos = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
            Tween(frame, {Position = newPos}, 0.05, Enum.EasingStyle.Linear)
        end
        
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or 
               input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
                    end
                end)
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
                            input.UserInputType == Enum.UserInputType.Touch) then
                UpdateDrag(input)
            end
        end)
    end
    
    local function MakeTitleBarDraggable()
        local dragging = false
        local dragInput, dragStart, startPos
        
        local function UpdateDrag(input)
            local delta = input.Position - dragStart
            local newPos = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
            Tween(MainFrame, {Position = newPos}, 0.05, Enum.EasingStyle.Linear)
        end
        
        TitleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or 
               input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = MainFrame.Position
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
                    end
                end)
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
                            input.UserInputType == Enum.UserInputType.Touch) then
                UpdateDrag(input)
            end
        end)
    end
    
    MakeDraggable(MinimizeBox)
    MakeTitleBarDraggable()
    
    -- فتح النافذة
    PlaySound(Sounds.Open, 0.7)
    Tween(MainFrame, {Size = UDim2.new(0, 650, 0, 0)}, 0.4, Enum.EasingStyle.Back)
    task.wait(0.4)
    Tween(MainFrame, {Size = UDim2.new(0, 650, 0, 450)}, 0.5, Enum.EasingStyle.Back)
    
    -- ════════════════════════════════════════════════════
    --                  نظام التبويبات
    -- ════════════════════════════════════════════════════
    local TabsContainer = Instance.new("Frame")
    local TabsUICorner = Instance.new("UICorner")
    local TabsList = Instance.new("UIListLayout")
    local TabsPadding = Instance.new("UIPadding")
    
    TabsContainer.Name = "TabsContainer"
    TabsContainer.Parent = MainFrame
    TabsContainer.BackgroundColor3 = Theme.Surface
    TabsContainer.BackgroundTransparency = 0.3
    TabsContainer.Position = UDim2.new(0, 10, 0, 60)
    TabsContainer.Size = UDim2.new(0, 160, 1, -70)
    TabsContainer.BorderSizePixel = 0
    TabsContainer.ZIndex = 3
    
    TabsUICorner.CornerRadius = UDim.new(0, 12)
    TabsUICorner.Parent = TabsContainer
    
    TabsList.Parent = TabsContainer
    TabsList.SortOrder = Enum.SortOrder.LayoutOrder
    TabsList.Padding = UDim.new(0, 8)
    
    TabsPadding.Parent = TabsContainer
    TabsPadding.PaddingTop = UDim.new(0, 10)
    TabsPadding.PaddingBottom = UDim.new(0, 10)
    TabsPadding.PaddingLeft = UDim.new(0, 10)
    TabsPadding.PaddingRight = UDim.new(0, 10)
    
    local Tabs = {}
    
    function Tabs:CreateTab(tabConfig)
        tabConfig = tabConfig or {}
        local tabName = tabConfig.Name or "Tab"
        local tabIcon = tabConfig.Icon or Icons.Box
        
        local TabButton = Instance.new("TextButton")
        local TabBtnCorner = Instance.new("UICorner")
        local TabIcon = Instance.new("ImageLabel")
        local TabLabel = Instance.new("TextLabel")
        local TabIndicator = Instance.new("Frame")
        local IndicatorCorner = Instance.new("UICorner")
        
        TabButton.Name = tabName
        TabButton.Parent = TabsContainer
        TabButton.BackgroundColor3 = Theme.Surface
        TabButton.BackgroundTransparency = 0.5
        TabButton.Size = UDim2.new(1, 0, 0, 45)
        TabButton.AutoButtonColor = false
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = ""
        TabButton.BorderSizePixel = 0
        TabButton.ZIndex = 4
        
        TabBtnCorner.CornerRadius = UDim.new(0, 10)
        TabBtnCorner.Parent = TabButton
        
        TabIcon.Name = "Icon"
        TabIcon.Parent = TabButton
        TabIcon.BackgroundTransparency = 1
        TabIcon.Position = UDim2.new(0, 12, 0.5, -10)
        TabIcon.Size = UDim2.new(0, 20, 0, 20)
        TabIcon.Image = tabIcon
        TabIcon.ImageColor3 = Theme.TextDim
        TabIcon.ZIndex = 5
        
        TabLabel.Name = "Label"
        TabLabel.Parent = TabButton
        TabLabel.BackgroundTransparency = 1
        TabLabel.Position = UDim2.new(0, 40, 0, 0)
        TabLabel.Size = UDim2.new(1, -45, 1, 0)
        TabLabel.Font = Enum.Font.GothamMedium
        TabLabel.Text = tabName
        TabLabel.TextColor3 = Theme.TextDim
        TabLabel.TextSize = 13
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        TabLabel.ZIndex = 5
        
        TabIndicator.Name = "Indicator"
        TabIndicator.Parent = TabButton
        TabIndicator.BackgroundColor3 = Theme.Primary
        TabIndicator.Position = UDim2.new(1, -4, 0.5, -12)
        TabIndicator.Size = UDim2.new(0, 0, 0, 24)
        TabIndicator.BorderSizePixel = 0
        TabIndicator.ZIndex = 5
        
        IndicatorCorner.CornerRadius = UDim.new(1, 0)
        IndicatorCorner.Parent = TabIndicator
        
        TabButton.MouseEnter:Connect(function()
            if not CurrentPage or CurrentPage.Name ~= tabName then
                PlaySound(Sounds.Hover, 0.2)
                Tween(TabButton, {BackgroundTransparency = 0.2}, 0.2)
                Tween(TabIcon, {ImageColor3 = Theme.Primary}, 0.2)
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if not CurrentPage or CurrentPage.Name ~= tabName then
                Tween(TabButton, {BackgroundTransparency = 0.5}, 0.2)
                Tween(TabIcon, {ImageColor3 = Theme.TextDim}, 0.2)
            end
        end)
        
        -- ════════════════════════════════════════════════════
        --                  إنشاء الصفحة - إصلاح ZIndex
        -- ════════════════════════════════════════════════════
        local Page = Instance.new("ScrollingFrame")
        local PageCorner = Instance.new("UICorner")
        local PageList = Instance.new("UIListLayout")
        local PagePadding = Instance.new("UIPadding")
        
        Page.Name = tabName
        Page.Parent = MainFrame
        Page.Active = true
        Page.BackgroundColor3 = Theme.Surface
        Page.BackgroundTransparency = 0.3
        Page.BorderSizePixel = 0
        Page.Position = UDim2.new(0, 180, 0, 60)
        Page.Size = UDim2.new(1, -190, 1, -70)
        Page.ScrollBarThickness = 4
        Page.ScrollBarImageColor3 = Theme.Primary
        Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.Visible = false
        Page.ScrollingDirection = Enum.ScrollingDirection.Y
        Page.ZIndex = 4  -- ✅ ZIndex أعلى من TabsContainer
        Page.ClipsDescendants = false  -- ✅ للتأكد من ظهور المحتوى
        
        PageCorner.CornerRadius = UDim.new(0, 12)
        PageCorner.Parent = Page
        
        PageList.Parent = Page
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Padding = UDim.new(0, 10)
        
        PagePadding.Parent = Page
        PagePadding.PaddingTop = UDim.new(0, 10)
        PagePadding.PaddingBottom = UDim.new(0, 10)
        PagePadding.PaddingLeft = UDim.new(0, 10)
        PagePadding.PaddingRight = UDim2.new(0, 10)
        
        table.insert(AllPages, Page)
        
        TabButton.MouseButton1Click:Connect(function()
            PlaySound(Sounds.Click, 0.5)
            
            for _, p in pairs(AllPages) do
                p.Visible = false
            end
            
            Page.Visible = true
            CurrentPage = Page
            
            for _, btn in pairs(TabsContainer:GetChildren()) do
                if btn:IsA("TextButton") then
                    Tween(btn, {BackgroundTransparency = 0.5}, 0.2)
                    
                    local icon = btn:FindFirstChild("Icon")
                    local label = btn:FindFirstChild("Label")
                    local indicator = btn:FindFirstChild("Indicator")
                    
                    if icon then Tween(icon, {ImageColor3 = Theme.TextDim}, 0.2) end
                    if label then Tween(label, {TextColor3 = Theme.TextDim}, 0.2) end
                    if indicator then Tween(indicator, {Size = UDim2.new(0, 0, 0, 24)}, 0.3) end
                end
            end
            
            Tween(TabButton, {BackgroundTransparency = 0}, 0.2)
            Tween(TabIcon, {ImageColor3 = Theme.Primary}, 0.2)
            Tween(TabLabel, {TextColor3 = Theme.Text}, 0.2)
            Tween(TabIndicator, {Size = UDim2.new(0, 4, 0, 24)}, 0.3, Enum.EasingStyle.Back)
        end)
        
        if not FirstTabActivated then
            FirstTabActivated = true
            task.wait(0.6)
            TabButton.MouseButton1Click:Fire()
        end
        
        -- ════════════════════════════════════════════════════
        --                  عناصر الصفحة - ZIndex محسّن
        -- ════════════════════════════════════════════════════
        local Elements = {}
        
        function Elements:CreateButton(buttonConfig)
            buttonConfig = buttonConfig or {}
            local buttonName = buttonConfig.Name or "Button"
            local buttonDesc = buttonConfig.Description or "Click to execute"
            local buttonCallback = buttonConfig.Callback or function() end
            
            local ButtonFrame = Instance.new("Frame")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonGradient = Instance.new("UIGradient")
            local ButtonTitle = Instance.new("TextLabel")
            local ButtonDesc = Instance.new("TextLabel")
            local ButtonClick = Instance.new("TextButton")
            local ButtonIcon = Instance.new("ImageLabel")
            
            ButtonFrame.Name = "Button"
            ButtonFrame.Parent = Page
            ButtonFrame.BackgroundColor3 = Theme.Background
            ButtonFrame.BackgroundTransparency = 0.3
            ButtonFrame.Size = UDim2.new(1, 0, 0, 60)
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.ZIndex = 5  -- ✅ ZIndex مرتفع
            
            ButtonCorner.CornerRadius = UDim.new(0, 10)
            ButtonCorner.Parent = ButtonFrame
            
            ButtonGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Theme.Primary),
                ColorSequenceKeypoint.new(1, Theme.Secondary)
            }
            ButtonGradient.Rotation = 45
            ButtonGradient.Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 0.95),
                NumberSequenceKeypoint.new(1, 0.98)
            }
            ButtonGradient.Parent = ButtonFrame
            
            ButtonTitle.Name = "Title"
            ButtonTitle.Parent = ButtonFrame
            ButtonTitle.BackgroundTransparency = 1
            ButtonTitle.Position = UDim2.new(0, 15, 0, 8)
            ButtonTitle.Size = UDim2.new(1, -50, 0, 20)
            ButtonTitle.Font = Enum.Font.GothamBold
            ButtonTitle.Text = buttonName
            ButtonTitle.TextColor3 = Theme.Text
            ButtonTitle.TextSize = 14
            ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
            ButtonTitle.ZIndex = 6
            
            ButtonDesc.Name = "Description"
            ButtonDesc.Parent = ButtonFrame
            ButtonDesc.BackgroundTransparency = 1
            ButtonDesc.Position = UDim2.new(0, 15, 0, 30)
            ButtonDesc.Size = UDim2.new(1, -50, 0, 18)
            ButtonDesc.Font = Enum.Font.Gotham
            ButtonDesc.Text = buttonDesc
            ButtonDesc.TextColor3 = Theme.TextDim
            ButtonDesc.TextSize = 12
            ButtonDesc.TextXAlignment = Enum.TextXAlignment.Left
            ButtonDesc.ZIndex = 6
            
            ButtonIcon.Name = "Icon"
            ButtonIcon.Parent = ButtonFrame
            ButtonIcon.BackgroundTransparency = 1
            ButtonIcon.Position = UDim2.new(1, -35, 0.5, -10)
            ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
            ButtonIcon.Image = Icons.ChevronRight
            ButtonIcon.ImageColor3 = Theme.Primary
            ButtonIcon.ZIndex = 6
            
            ButtonClick.Name = "Click"
            ButtonClick.Parent = ButtonFrame
            ButtonClick.BackgroundTransparency = 1
            ButtonClick.Size = UDim2.new(1, 0, 1, 0)
            ButtonClick.Text = ""
            ButtonClick.ZIndex = 7
            
            ButtonClick.MouseEnter:Connect(function()
                PlaySound(Sounds.Hover, 0.2)
                Tween(ButtonFrame, {BackgroundTransparency = 0.1}, 0.2)
                Tween(ButtonIcon, {Position = UDim2.new(1, -30, 0.5, -10)}, 0.2)
            end)
            
            ButtonClick.MouseLeave:Connect(function()
                Tween(ButtonFrame, {BackgroundTransparency = 0.3}, 0.2)
                Tween(ButtonIcon, {Position = UDim2.new(1, -35, 0.5, -10)}, 0.2)
            end)
            
            ButtonClick.MouseButton1Click:Connect(function()
                PlaySound(Sounds.Click, 0.5)
                pcall(buttonCallback)
            end)
            
            return {
                SetTitle = function(self, text) ButtonTitle.Text = text end,
                SetDescription = function(self, text) ButtonDesc.Text = text end
            }
        end
        
        function Elements:CreateToggle(toggleConfig)
            toggleConfig = toggleConfig or {}
            local toggleName = toggleConfig.Name or "Toggle"
            local toggleDesc = toggleConfig.Description or "Enable or disable"
            local toggleDefault = toggleConfig.Default or false
            local toggleCallback = toggleConfig.Callback or function() end
            
            local toggled = toggleDefault
            
            local ToggleFrame = Instance.new("Frame")
            local ToggleCorner = Instance.new("UICorner")
            local ToggleTitle = Instance.new("TextLabel")
            local ToggleDesc = Instance.new("TextLabel")
            local ToggleButton = Instance.new("TextButton")
            local ToggleSwitch = Instance.new("Frame")
            local SwitchCorner = Instance.new("UICorner")
            local SwitchKnob = Instance.new("Frame")
            local KnobCorner = Instance.new("UICorner")
            
            ToggleFrame.Name = "Toggle"
            ToggleFrame.Parent = Page
            ToggleFrame.BackgroundColor3 = Theme.Background
            ToggleFrame.BackgroundTransparency = 0.3
            ToggleFrame.Size = UDim2.new(1, 0, 0, 60)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.ZIndex = 5
            
            ToggleCorner.CornerRadius = UDim.new(0, 10)
            ToggleCorner.Parent = ToggleFrame
            
            ToggleTitle.Name = "Title"
            ToggleTitle.Parent = ToggleFrame
            ToggleTitle.BackgroundTransparency = 1
            ToggleTitle.Position = UDim2.new(0, 15, 0, 8)
            ToggleTitle.Size = UDim2.new(1, -80, 0, 20)
            ToggleTitle.Font = Enum.Font.GothamBold
            ToggleTitle.Text = toggleName
            ToggleTitle.TextColor3 = Theme.Text
            ToggleTitle.TextSize = 14
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
            ToggleTitle.ZIndex = 6
            
            ToggleDesc.Name = "Description"
            ToggleDesc.Parent = ToggleFrame
            ToggleDesc.BackgroundTransparency = 1
            ToggleDesc.Position = UDim2.new(0, 15, 0, 30)
            ToggleDesc.Size = UDim2.new(1, -80, 0, 18)
            ToggleDesc.Font = Enum.Font.Gotham
            ToggleDesc.Text = toggleDesc
            ToggleDesc.TextColor3 = Theme.TextDim
            ToggleDesc.TextSize = 12
            ToggleDesc.TextXAlignment = Enum.TextXAlignment.Left
            ToggleDesc.ZIndex = 6
            
            ToggleSwitch.Name = "Switch"
            ToggleSwitch.Parent = ToggleFrame
            ToggleSwitch.BackgroundColor3 = toggled and Theme.Primary or Theme.Surface
            ToggleSwitch.Position = UDim2.new(1, -55, 0.5, -12)
            ToggleSwitch.Size = UDim2.new(0, 45, 0, 24)
            ToggleSwitch.BorderSizePixel = 0
            ToggleSwitch.ZIndex = 6
            
            SwitchCorner.CornerRadius = UDim.new(1, 0)
            SwitchCorner.Parent = ToggleSwitch
            
            SwitchKnob.Name = "Knob"
            SwitchKnob.Parent = ToggleSwitch
            SwitchKnob.BackgroundColor3 = Theme.Text
            SwitchKnob.Position = toggled and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
            SwitchKnob.Size = UDim2.new(0, 20, 0, 20)
            SwitchKnob.BorderSizePixel = 0
            SwitchKnob.ZIndex = 7
            
            KnobCorner.CornerRadius = UDim.new(1, 0)
            KnobCorner.Parent = SwitchKnob
            
            ToggleButton.Name = "Button"
            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundTransparency = 1
            ToggleButton.Size = UDim2.new(1, 0, 1, 0)
            ToggleButton.Text = ""
            ToggleButton.ZIndex = 8
            
            local function UpdateToggle(state)
                toggled = state
                
                if toggled then
                    PlaySound(Sounds.Toggle, 0.5)
                    Tween(ToggleSwitch, {BackgroundColor3 = Theme.Primary}, 0.3)
                    Tween(SwitchKnob, {Position = UDim2.new(1, -22, 0.5, -10)}, 0.3, Enum.EasingStyle.Back)
                else
                    PlaySound(Sounds.Click, 0.4)
                    Tween(ToggleSwitch, {BackgroundColor3 = Theme.Surface}, 0.3)
                    Tween(SwitchKnob, {Position = UDim2.new(0, 2, 0.5, -10)}, 0.3, Enum.EasingStyle.Back)
                end
                
                pcall(function() toggleCallback(toggled) end)
            end
            
            ToggleButton.MouseButton1Click:Connect(function()
                UpdateToggle(not toggled)
            end)
            
            return {
                SetState = function(self, state) UpdateToggle(state) end,
                GetState = function(self) return toggled end
            }
        end
        
        function Elements:CreateSlider(sliderConfig)
            sliderConfig = sliderConfig or {}
            local sliderName = sliderConfig.Name or "Slider"
            local sliderMin = sliderConfig.Min or 0
            local sliderMax = sliderConfig.Max or 100
            local sliderDefault = sliderConfig.Default or sliderMin
            local sliderCallback = sliderConfig.Callback or function() end
            
            local currentValue = math.clamp(sliderDefault, sliderMin, sliderMax)
            local dragging = false
            
            local SliderFrame = Instance.new("Frame")
            local SliderCorner = Instance.new("UICorner")
            local SliderTitle = Instance.new("TextLabel")
            local ValueDisplay = Instance.new("Frame")
            local ValueCorner = Instance.new("UICorner")
            local ValueText = Instance.new("TextLabel")
            local SliderTrack = Instance.new("Frame")
            local TrackCorner = Instance.new("UICorner")
            local SliderFill = Instance.new("Frame")
            local FillCorner = Instance.new("UICorner")
            local SliderKnob = Instance.new("Frame")
            local KnobCorner = Instance.new("UICorner")
            local SliderInput = Instance.new("TextButton")
            
            SliderFrame.Name = "Slider"
            SliderFrame.Parent = Page
            SliderFrame.BackgroundColor3 = Theme.Background
            SliderFrame.BackgroundTransparency = 0.3
            SliderFrame.Size = UDim2.new(1, 0, 0, 70)
            SliderFrame.BorderSizePixel = 0
            SliderFrame.ZIndex = 5
            
            SliderCorner.CornerRadius = UDim.new(0, 10)
            SliderCorner.Parent = SliderFrame
            
            SliderTitle.Name = "Title"
            SliderTitle.Parent = SliderFrame
            SliderTitle.BackgroundTransparency = 1
            SliderTitle.Position = UDim2.new(0, 15, 0, 10)
            SliderTitle.Size = UDim2.new(1, -100, 0, 20)
            SliderTitle.Font = Enum.Font.GothamBold
            SliderTitle.Text = sliderName
            SliderTitle.TextColor3 = Theme.Text
            SliderTitle.TextSize = 14
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
            SliderTitle.ZIndex = 6
            
            ValueDisplay.Name = "ValueDisplay"
            ValueDisplay.Parent = SliderFrame
            ValueDisplay.BackgroundColor3 = Theme.Primary
            ValueDisplay.BackgroundTransparency = 0.7
            ValueDisplay.Position = UDim2.new(1, -70, 0, 8)
            ValueDisplay.Size = UDim2.new(0, 55, 0, 24)
            ValueDisplay.BorderSizePixel = 0
            ValueDisplay.ZIndex = 6
            
            ValueCorner.CornerRadius = UDim.new(0, 8)
            ValueCorner.Parent = ValueDisplay
            
            ValueText.Name = "Value"
            ValueText.Parent = ValueDisplay
            ValueText.BackgroundTransparency = 1
            ValueText.Size = UDim2.new(1, 0, 1, 0)
            ValueText.Font = Enum.Font.GothamBold
            ValueText.Text = tostring(currentValue)
            ValueText.TextColor3 = Theme.Text
            ValueText.TextSize = 13
            ValueText.ZIndex = 7
            
            SliderTrack.Name = "Track"
            SliderTrack.Parent = SliderFrame
            SliderTrack.BackgroundColor3 = Theme.Surface
            SliderTrack.Position = UDim2.new(0, 15, 1, -20)
            SliderTrack.Size = UDim2.new(1, -30, 0, 6)
            SliderTrack.BorderSizePixel = 0
            SliderTrack.ZIndex = 6
            
            TrackCorner.CornerRadius = UDim.new(1, 0)
            TrackCorner.Parent = SliderTrack
            
            SliderFill.Name = "Fill"
            SliderFill.Parent = SliderTrack
            SliderFill.BackgroundColor3 = Theme.Primary
            SliderFill.Size = UDim2.new((currentValue - sliderMin) / (sliderMax - sliderMin), 0, 1, 0)
            SliderFill.BorderSizePixel = 0
            SliderFill.ZIndex = 7
            
            FillCorner.CornerRadius = UDim.new(1, 0)
            FillCorner.Parent = SliderFill
            
            SliderKnob.Name = "Knob"
            SliderKnob.Parent = SliderFill
            SliderKnob.BackgroundColor3 = Theme.Text
            SliderKnob.Position = UDim2.new(1, -10, 0.5, -10)
            SliderKnob.Size = UDim2.new(0, 20, 0, 20)
            SliderKnob.BorderSizePixel = 0
            SliderKnob.ZIndex = 8
            
            KnobCorner.CornerRadius = UDim.new(1, 0)
            KnobCorner.Parent = SliderKnob
            
            SliderInput.Name = "Input"
            SliderInput.Parent = SliderTrack
            SliderInput.BackgroundTransparency = 1
            SliderInput.Size = UDim2.new(1, 0, 1, 20)
            SliderInput.Position = UDim2.new(0, 0, 0, -10)
            SliderInput.Text = ""
            SliderInput.ZIndex = 9
            
            local function UpdateSlider(input)
                local pos = math.clamp(
                    (input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X,
                    0, 1
                )
                
                currentValue = math.floor(sliderMin + (sliderMax - sliderMin) * pos)
                Tween(SliderFill, {Size = UDim2.new(pos, 0, 1, 0)}, 0.05, Enum.EasingStyle.Linear)
                ValueText.Text = tostring(currentValue)
                pcall(function() sliderCallback(currentValue) end)
            end
            
            SliderInput.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    Tween(SliderKnob, {Size = UDim2.new(0, 24, 0, 24), Position = UDim2.new(1, -12, 0.5, -12)}, 0.2)
                    UpdateSlider(input)
                end
            end)
            
            SliderInput.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                    Tween(SliderKnob, {Size = UDim2.new(0, 20, 0, 20), Position = UDim2.new(1, -10, 0.5, -10)}, 0.2)
                end
            end)
            
            SliderInput.TouchTap:Connect(function(positions)
                UpdateSlider({Position = positions[1]})
            end)
            
            SliderInput.TouchPan:Connect(function(positions)
                UpdateSlider({Position = positions[#positions]})
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    UpdateSlider(input)
                end
            end)
            
            return {
                SetValue = function(self, value)
                    currentValue = math.clamp(value, sliderMin, sliderMax)
                    local pos = (currentValue - sliderMin) / (sliderMax - sliderMin)
                    Tween(SliderFill, {Size = UDim2.new(pos, 0, 1, 0)}, 0.3)
                    ValueText.Text = tostring(currentValue)
                    pcall(function() sliderCallback(currentValue) end)
                end,
                GetValue = function(self) return currentValue end
            }
        end
        
        function Elements:CreateLabel(labelText)
            labelText = labelText or "Label"
            
            local LabelFrame = Instance.new("Frame")
            local LabelCorner = Instance.new("UICorner")
            local LabelText = Instance.new("TextLabel")
            local LabelIcon = Instance.new("ImageLabel")
            
            LabelFrame.Name = "Label"
            LabelFrame.Parent = Page
            LabelFrame.BackgroundColor3 = Theme.Accent
            LabelFrame.BackgroundTransparency = 0.85
            LabelFrame.Size = UDim2.new(1, 0, 0, 40)
            LabelFrame.BorderSizePixel = 0
            LabelFrame.ZIndex = 5
            
            LabelCorner.CornerRadius = UDim.new(0, 10)
            LabelCorner.Parent = LabelFrame
            
            LabelIcon.Name = "Icon"
            LabelIcon.Parent = LabelFrame
            LabelIcon.BackgroundTransparency = 1
            LabelIcon.Position = UDim2.new(0, 12, 0.5, -10)
            LabelIcon.Size = UDim2.new(0, 20, 0, 20)
            LabelIcon.Image = Icons.Info
            LabelIcon.ImageColor3 = Theme.Primary
            LabelIcon.ZIndex = 6
            
            LabelText.Name = "Text"
            LabelText.Parent = LabelFrame
            LabelText.BackgroundTransparency = 1
            LabelText.Position = UDim2.new(0, 40, 0, 0)
            LabelText.Size = UDim2.new(1, -45, 1, 0)
            LabelText.Font = Enum.Font.GothamMedium
            LabelText.Text = labelText
            LabelText.TextColor3 = Theme.Text
            LabelText.TextSize = 13
            LabelText.TextXAlignment = Enum.TextXAlignment.Left
            LabelText.TextWrapped = true
            LabelText.ZIndex = 6
            
            return {
                SetText = function(self, text) LabelText.Text = text end
            }
        end
        
        return Elements
    end
    
    return Tabs
end

-- ════════════════════════════════════════════════════
--            الإشعارات
-- ════════════════════════════════════════════════════
local ActiveNotifications = {}
local MaxNotifications = 2

function DrakthonLib:CreateNotification(notifConfig)
    while #ActiveNotifications >= MaxNotifications do
        local oldest = table.remove(ActiveNotifications, 1)
        if oldest and oldest.Parent then
            Tween(oldest, {Position = UDim2.new(1.5, 0, oldest.Position.Y.Scale, 0)}, 0.3)
            task.delay(0.3, function() oldest:Destroy() end)
        end
    end
    
    notifConfig = notifConfig or {}
    local title = notifConfig.Title or "Notification"
    local message = notifConfig.Message or "Message"
    local duration = notifConfig.Duration or 3
    local callback = notifConfig.Callback or nil
    local notifType = notifConfig.Type or "Info"
    
    local Theme = GetTheme()
    
    local typeColor = Theme.Primary
    local typeIcon = Icons.Info
    
    if notifType == "Success" then
        typeColor = Theme.Success
        typeIcon = Icons.Check
    elseif notifType == "Error" then
        typeColor = Theme.Error
        typeIcon = Icons.X
    elseif notifType == "Warning" then
        typeColor = Theme.Warning
        typeIcon = Icons.AlertTriangle
    end
    
    local NotifGui = Instance.new("ScreenGui")
    local NotifFrame = Instance.new("Frame")
    local NotifCorner = Instance.new("UICorner")
    local NotifIcon = Instance.new("ImageLabel")
    local NotifTitle = Instance.new("TextLabel")
    local NotifMessage = Instance.new("TextLabel")
    local NotifProgress = Instance.new("Frame")
    local ProgressCorner = Instance.new("UICorner")
    local ProgressFill = Instance.new("Frame")
    local FillCorner = Instance.new("UICorner")
    
    NotifGui.Name = RandomString(10)
    NotifGui.Parent = CoreGui
    NotifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    NotifGui.DisplayOrder = 999999999
    
    local yPos = 0.05 + (#ActiveNotifications * 0.15)
    
    NotifFrame.Name = "Notification"
    NotifFrame.Parent = NotifGui
    NotifFrame.BackgroundColor3 = Theme.Background
    NotifFrame.Position = UDim2.new(1.5, 0, yPos, 0)
    NotifFrame.Size = UDim2.new(0, 350, 0, callback and 120 or 100)
    NotifFrame.BorderSizePixel = 0
    NotifFrame.ZIndex = 100
    
    table.insert(ActiveNotifications, NotifFrame)
    
    NotifCorner.CornerRadius = UDim.new(0, 12)
    NotifCorner.Parent = NotifFrame
    
    NotifIcon.Name = "Icon"
    NotifIcon.Parent = NotifFrame
    NotifIcon.BackgroundTransparency = 1
    NotifIcon.Position = UDim2.new(0, 15, 0, 15)
    NotifIcon.Size = UDim2.new(0, 30, 0, 30)
    NotifIcon.Image = typeIcon
    NotifIcon.ImageColor3 = typeColor
    NotifIcon.ZIndex = 101
    
    NotifTitle.Name = "Title"
    NotifTitle.Parent = NotifFrame
    NotifTitle.BackgroundTransparency = 1
    NotifTitle.Position = UDim2.new(0, 55, 0, 12)
    NotifTitle.Size = UDim2.new(1, -65, 0, 20)
    NotifTitle.Font = Enum.Font.GothamBold
    NotifTitle.Text = title
    NotifTitle.TextColor3 = Theme.Text
    NotifTitle.TextSize = 14
    NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
    NotifTitle.ZIndex = 101
    
    NotifMessage.Name = "Message"
    NotifMessage.Parent = NotifFrame
    NotifMessage.BackgroundTransparency = 1
    NotifMessage.Position = UDim2.new(0, 55, 0, 35)
    NotifMessage.Size = UDim2.new(1, -65, 0, callback and 35 or 45)
    NotifMessage.Font = Enum.Font.Gotham
    NotifMessage.Text = message
    NotifMessage.TextColor3 = Theme.TextDim
    NotifMessage.TextSize = 12
    NotifMessage.TextXAlignment = Enum.TextXAlignment.Left
    NotifMessage.TextYAlignment = Enum.TextYAlignment.Top
    NotifMessage.TextWrapped = true
    NotifMessage.ZIndex = 101
    
    NotifProgress.Name = "Progress"
    NotifProgress.Parent = NotifFrame
    NotifProgress.BackgroundColor3 = Theme.Surface
    NotifProgress.Position = UDim2.new(0, 10, 1, -8)
    NotifProgress.Size = UDim2.new(1, -20, 0, 4)
    NotifProgress.BorderSizePixel = 0
    NotifProgress.ZIndex = 100
    
    ProgressCorner.CornerRadius = UDim.new(1, 0)
    ProgressCorner.Parent = NotifProgress
    
    ProgressFill.Name = "Fill"
    ProgressFill.Parent = NotifProgress
    ProgressFill.BackgroundColor3 = typeColor
    ProgressFill.Size = UDim2.new(1, 0, 1, 0)
    ProgressFill.BorderSizePixel = 0
    ProgressFill.ZIndex = 101
    
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = ProgressFill
    
    if callback and type(callback) == "function" then
        local AcceptBtn = Instance.new("TextButton")
        local AcceptCorner = Instance.new("UICorner")
        local AcceptIcon = Instance.new("ImageLabel")
        
        AcceptBtn.Name = "Accept"
        AcceptBtn.Parent = NotifFrame
        AcceptBtn.BackgroundColor3 = Theme.Success
        AcceptBtn.BackgroundTransparency = 0.3
        AcceptBtn.Position = UDim2.new(1, -75, 0, 80)
        AcceptBtn.Size = UDim2.new(0, 30, 0, 30)
        AcceptBtn.Text = ""
        AcceptBtn.ZIndex = 102
        
        AcceptCorner.CornerRadius = UDim.new(0, 8)
        AcceptCorner.Parent = AcceptBtn
        
        AcceptIcon.Parent = AcceptBtn
        AcceptIcon.BackgroundTransparency = 1
        AcceptIcon.Position = UDim2.new(0.5, -10, 0.5, -10)
        AcceptIcon.Size = UDim2.new(0, 20, 0, 20)
        AcceptIcon.Image = Icons.Check
        AcceptIcon.ImageColor3 = Theme.Text
        AcceptIcon.ZIndex = 103
        
        local DeclineBtn = Instance.new("TextButton")
        local DeclineCorner = Instance.new("UICorner")
        local DeclineIcon = Instance.new("ImageLabel")
        
        DeclineBtn.Name = "Decline"
        DeclineBtn.Parent = NotifFrame
        DeclineBtn.BackgroundColor3 = Theme.Error
        DeclineBtn.BackgroundTransparency = 0.3
        DeclineBtn.Position = UDim2.new(1, -110, 0, 80)
        DeclineBtn.Size = UDim2.new(0, 30, 0, 30)
        DeclineBtn.Text = ""
        DeclineBtn.ZIndex = 102
        
        DeclineCorner.CornerRadius = UDim.new(0, 8)
        DeclineCorner.Parent = DeclineBtn
        
        DeclineIcon.Parent = DeclineBtn
        DeclineIcon.BackgroundTransparency = 1
        DeclineIcon.Position = UDim2.new(0.5, -10, 0.5, -10)
        DeclineIcon.Size = UDim2.new(0, 20, 0, 20)
        DeclineIcon.Image = Icons.X
        DeclineIcon.ImageColor3 = Theme.Text
        DeclineIcon.ZIndex = 103
        
        local function CloseNotif(result)
            PlaySound(result and Sounds.Success or Sounds.Error, 0.5)
            Tween(NotifFrame, {Position = UDim2.new(1.5, 0, yPos, 0)}, 0.3)
            task.delay(0.3, function()
                for i, notif in ipairs(ActiveNotifications) do
                    if notif == NotifFrame then
                        table.remove(ActiveNotifications, i)
                        break
                    end
                end
                NotifGui:Destroy()
            end)
            pcall(function() callback(result) end)
        end
        
        AcceptBtn.MouseButton1Click:Connect(function() CloseNotif(true) end)
        DeclineBtn.MouseButton1Click:Connect(function() CloseNotif(false) end)
        
        AcceptBtn.MouseEnter:Connect(function()
            Tween(AcceptBtn, {BackgroundTransparency = 0.1}, 0.2)
        end)
        AcceptBtn.MouseLeave:Connect(function()
            Tween(AcceptBtn, {BackgroundTransparency = 0.3}, 0.2)
        end)
        
        DeclineBtn.MouseEnter:Connect(function()
            Tween(DeclineBtn, {BackgroundTransparency = 0.1}, 0.2)
        end)
        DeclineBtn.MouseLeave:Connect(function()
            Tween(DeclineBtn, {BackgroundTransparency = 0.3}, 0.2)
        end)
    else
        if duration > 0 then
            Tween(ProgressFill, {Size = UDim2.new(0, 0, 1, 0)}, duration, Enum.EasingStyle.Linear)
            
            task.delay(duration, function()
                Tween(NotifFrame, {Position = UDim2.new(1.5, 0, yPos, 0)}, 0.3)
                task.delay(0.3, function()
                    for i, notif in ipairs(ActiveNotifications) do
                        if notif == NotifFrame then
                            table.remove(ActiveNotifications, i)
                            break
                        end
                    end
                    NotifGui:Destroy()
                end)
            end)
        end
    end
    
    PlaySound(Sounds.Notification, 0.6)
    Tween(NotifFrame, {Position = UDim2.new(1, -360, yPos, 0)}, 0.5, Enum.EasingStyle.Back)
end

function DrakthonLib:SetTheme(themeName)
    if not DrakthonLib.Themes[themeName] then
        warn("Theme '" .. themeName .. "' not found!")
        return
    end
    
    DrakthonLib.CurrentTheme = themeName
    
    DrakthonLib:CreateNotification({
        Title = "Theme Changed",
        Message = "Theme changed to " .. themeName,
        Duration = 3,
        Type = "Success"
    })
end

return DrakthonLib
