--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║                  DRAKTHON UI LIBRARY V10.0                   ║
    ║              Professional UI Library - Final Fixed            ║
    ║         ✅ All Issues Fixed + Notifications System           ║
    ╚══════════════════════════════════════════════════════════════╝
]]

local DrakthonLib = {}

-- ═══════════════════════════════════════════════════════════════
-- THEMES
-- ═══════════════════════════════════════════════════════════════
local Themes = {
    Default = {
        Background = Color3.fromRGB(20, 20, 25),
        Secondary = Color3.fromRGB(25, 25, 30),
        Tertiary = Color3.fromRGB(30, 30, 35),
        Accent = Color3.fromRGB(88, 101, 242),
        AccentHover = Color3.fromRGB(108, 121, 255),
        AccentPressed = Color3.fromRGB(68, 81, 222),
        TextPrimary = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(180, 180, 190),
        TextMuted = Color3.fromRGB(140, 140, 150),
        ElementBackground = Color3.fromRGB(35, 35, 40),
        ElementBorder = Color3.fromRGB(45, 45, 50),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(240, 71, 71),
        ToggleOn = Color3.fromRGB(67, 181, 129),
        ToggleOff = Color3.fromRGB(50, 50, 55),
    },
    Ocean = {
        Background = Color3.fromRGB(15, 23, 42),
        Secondary = Color3.fromRGB(20, 28, 47),
        Tertiary = Color3.fromRGB(25, 33, 52),
        Accent = Color3.fromRGB(56, 189, 248),
        AccentHover = Color3.fromRGB(76, 209, 255),
        AccentPressed = Color3.fromRGB(36, 169, 228),
        TextPrimary = Color3.fromRGB(248, 250, 252),
        TextSecondary = Color3.fromRGB(203, 213, 225),
        TextMuted = Color3.fromRGB(148, 163, 184),
        ElementBackground = Color3.fromRGB(30, 41, 59),
        ElementBorder = Color3.fromRGB(51, 65, 85),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(234, 179, 8),
        Error = Color3.fromRGB(239, 68, 68),
        ToggleOn = Color3.fromRGB(34, 197, 94),
        ToggleOff = Color3.fromRGB(51, 65, 85),
    },
    Purple = {
        Background = Color3.fromRGB(24, 15, 35),
        Secondary = Color3.fromRGB(29, 20, 40),
        Tertiary = Color3.fromRGB(34, 25, 45),
        Accent = Color3.fromRGB(168, 85, 247),
        AccentHover = Color3.fromRGB(188, 105, 255),
        AccentPressed = Color3.fromRGB(148, 65, 227),
        TextPrimary = Color3.fromRGB(250, 245, 255),
        TextSecondary = Color3.fromRGB(216, 180, 254),
        TextMuted = Color3.fromRGB(192, 132, 252),
        ElementBackground = Color3.fromRGB(44, 30, 60),
        ElementBorder = Color3.fromRGB(59, 45, 75),
        Success = Color3.fromRGB(134, 239, 172),
        Warning = Color3.fromRGB(253, 224, 71),
        Error = Color3.fromRGB(252, 165, 165),
        ToggleOn = Color3.fromRGB(134, 239, 172),
        ToggleOff = Color3.fromRGB(59, 45, 75),
    },
    Crimson = {
        Background = Color3.fromRGB(30, 15, 15),
        Secondary = Color3.fromRGB(35, 20, 20),
        Tertiary = Color3.fromRGB(40, 25, 25),
        Accent = Color3.fromRGB(239, 68, 68),
        AccentHover = Color3.fromRGB(255, 88, 88),
        AccentPressed = Color3.fromRGB(219, 48, 48),
        TextPrimary = Color3.fromRGB(254, 242, 242),
        TextSecondary = Color3.fromRGB(252, 165, 165),
        TextMuted = Color3.fromRGB(239, 68, 68),
        ElementBackground = Color3.fromRGB(50, 30, 30),
        ElementBorder = Color3.fromRGB(69, 26, 26),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(251, 191, 36),
        Error = Color3.fromRGB(220, 38, 38),
        ToggleOn = Color3.fromRGB(34, 197, 94),
        ToggleOff = Color3.fromRGB(69, 26, 26),
    },
}

-- ═══════════════════════════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════════════════════════
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ═══════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

local function CreateInstance(className, properties)
    local instance = Instance.new(className)
    for property, value in pairs(properties) do
        if property ~= "Parent" then
            pcall(function()
                instance[property] = value
            end)
        end
    end
    if properties.Parent then
        instance.Parent = properties.Parent
    end
    return instance
end

local function Tween(object, properties, duration, easingStyle, easingDirection)
    easingStyle = easingStyle or Enum.EasingStyle.Quad
    easingDirection = easingDirection or Enum.EasingDirection.Out
    duration = duration or 0.3
    
    local tweenInfo = TweenInfo.new(duration, easingStyle, easingDirection)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

local function MakeDraggable(frame, dragHandle)
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        if dragging then
            local delta = input.Position - dragStart
            local newPosition = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
            frame.Position = newPosition
        end
    end
    
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

local function AddHoverEffect(button, normalColor, hoverColor, pressedColor)
    if not normalColor or not hoverColor then return end
    
    button.MouseEnter:Connect(function()
        Tween(button, {BackgroundColor3 = hoverColor}, 0.2)
    end)
    
    button.MouseLeave:Connect(function()
        Tween(button, {BackgroundColor3 = normalColor}, 0.2)
    end)
    
    if pressedColor then
        button.MouseButton1Down:Connect(function()
            Tween(button, {BackgroundColor3 = pressedColor}, 0.1)
        end)
        
        button.MouseButton1Up:Connect(function()
            Tween(button, {BackgroundColor3 = hoverColor}, 0.1)
        end)
    end
end

local function CheckDuplicate(antiDupId)
    if not antiDupId or antiDupId == "" then
        return false
    end
    
    for _, gui in ipairs(PlayerGui:GetChildren()) do
        if gui:GetAttribute("DrakthonID") == antiDupId then
            return true
        end
    end
    
    return false
end

-- ═══════════════════════════════════════════════════════════════
-- NOTIFICATION SYSTEM
-- ═══════════════════════════════════════════════════════════════
local function SendNotification(title, text, duration, notifType)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title or "Notification",
            Text = text or "",
            Duration = duration or 5,
            Icon = notifType == "success" and "rbxassetid://7733964640" or 
                   notifType == "error" and "rbxassetid://7733993211" or 
                   notifType == "warning" and "rbxassetid://7733955511" or 
                   "rbxassetid://7733658504"
        })
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- MAIN WINDOW FUNCTION
-- ═══════════════════════════════════════════════════════════════

function DrakthonLib:MakeWindow(options)
    options = options or {}
    
    local antiDupId = options.AntiDuplicate or ""
    if CheckDuplicate(antiDupId) then
        return nil
    end
    
    local windowName = options.Name or "Drakthon Library"
    local themeName = options.Theme or "Default"
    local windowSize = options.Size or UDim2.new(0, 550, 0, 350)
    
    local LoaderConfig = {
        Enabled = options.LoaderEnabled ~= false,
        MainImage = options.LoaderImage or "rbxassetid://11422155687",
        MinimizeIcon = options.LoaderMinimizeIcon or "rbxassetid://10734950309",
        Position = options.LoaderPosition or UDim2.new(0, 20, 1, -90),
        Size = options.LoaderSize or UDim2.new(0, 70, 0, 70),
    }
    
    local Theme = Themes[themeName] or Themes.Default
    
    -- Screen GUI
    local screenGui = CreateInstance("ScreenGui", {
        Name = "DrakthonLib_" .. tick(),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = PlayerGui
    })
    
    if antiDupId ~= "" then
        screenGui:SetAttribute("DrakthonID", antiDupId)
    end
    
    -- Minimize Icon (Simple - No Stroke)
    local minimizeIcon = CreateInstance("ImageButton", {
        Name = "MinimizeIcon",
        Size = LoaderConfig.Size,
        Position = LoaderConfig.Position,
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = Theme.Secondary,
        Image = LoaderConfig.MinimizeIcon,
        ScaleType = Enum.ScaleType.Fit,
        Visible = false,
        ZIndex = 100,
        Parent = screenGui
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = minimizeIcon
    })
    
    CreateInstance("UIPadding", {
        PaddingAll = UDim.new(0, 8),
        Parent = minimizeIcon
    })
    
    MakeDraggable(minimizeIcon, minimizeIcon)
    
    -- Main Window
    local mainFrame = CreateInstance("Frame", {
        Name = "MainWindow",
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Visible = true,
        ZIndex = 2,
        Parent = screenGui
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = mainFrame
    })
    
    CreateInstance("UIStroke", {
        Color = Theme.ElementBorder,
        Thickness = 1.5,
        Transparency = 0.5,
        Parent = mainFrame
    })
    
    -- Title Bar
    local titleBar = CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = mainFrame
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = titleBar
    })
    
    CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 15),
        Position = UDim2.new(0, 0, 1, -15),
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = titleBar
    })
    
    local titleLabel = CreateInstance("TextLabel", {
        Size = UDim2.new(1, -120, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = "🌙 " .. windowName,
        TextColor3 = Theme.TextPrimary,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 4,
        Parent = titleBar
    })
    
    -- Minimize Button
    local minimizeBtn = CreateInstance("TextButton", {
        Size = UDim2.new(0, 35, 0, 26),
        Position = UDim2.new(1, -85, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.ElementBackground,
        Text = "—",
        TextColor3 = Theme.TextPrimary,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        ZIndex = 4,
        Parent = titleBar
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = minimizeBtn
    })
    
    -- Close Button (Fixed Icon)
    local closeBtn = CreateInstance("ImageButton", {
        Size = UDim2.new(0, 35, 0, 26),
        Position = UDim2.new(1, -42, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.Error,
        Image = "rbxassetid://10152135063",
        ImageColor3 = Theme.TextPrimary,
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 4,
        Parent = titleBar
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = closeBtn
    })
    
    CreateInstance("UIPadding", {
        PaddingAll = UDim.new(0, 6),
        Parent = closeBtn
    })
    
    -- Confirmation Modal
    local confirmOverlay = CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 150,
        Parent = mainFrame
    })
    
    local confirmModal = CreateInstance("Frame", {
        Size = UDim2.new(0, 320, 0, 160),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.Tertiary,
        BorderSizePixel = 0,
        ZIndex = 200,
        Parent = confirmOverlay
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = confirmModal
    })
    
    CreateInstance("UIStroke", {
        Color = Theme.Error,
        Thickness = 2,
        Parent = confirmModal
    })
    
    CreateInstance("TextLabel", {
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 12),
        BackgroundTransparency = 1,
        Text = "⚠️ Warning",
        TextColor3 = Theme.Warning,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 201,
        Parent = confirmModal
    })
    
    CreateInstance("TextLabel", {
        Size = UDim2.new(1, -30, 0, 45),
        Position = UDim2.new(0, 15, 0, 48),
        BackgroundTransparency = 1,
        Text = "Are you sure you want to close?",
        TextColor3 = Theme.TextSecondary,
        TextSize = 13,
        Font = Enum.Font.Gotham,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Top,
        ZIndex = 201,
        Parent = confirmModal
    })
    
    local confirmYesBtn = CreateInstance("TextButton", {
        Size = UDim2.new(0, 130, 0, 36),
        Position = UDim2.new(0.5, -138, 1, -45),
        BackgroundColor3 = Theme.Error,
        Text = "✓ Yes",
        TextColor3 = Theme.TextPrimary,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        ZIndex = 201,
        Parent = confirmModal
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = confirmYesBtn
    })
    
    local confirmNoBtn = CreateInstance("TextButton", {
        Size = UDim2.new(0, 130, 0, 36),
        Position = UDim2.new(0.5, 8, 1, -45),
        BackgroundColor3 = Theme.ElementBackground,
        Text = "✕ No",
        TextColor3 = Theme.TextPrimary,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        ZIndex = 201,
        Parent = confirmModal
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = confirmNoBtn
    })
    
    -- Sidebar
    local sidebar = CreateInstance("Frame", {
        Size = UDim2.new(0, 165, 1, -40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = mainFrame
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = sidebar
    })
    
    CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 10),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = sidebar
    })
    
    CreateInstance("Frame", {
        Size = UDim2.new(0, 10, 1, 0),
        Position = UDim2.new(1, -10, 0, 0),
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = sidebar
    })
    
    local tabsContainer = CreateInstance("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.ElementBorder,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ZIndex = 4,
        Parent = sidebar
    })
    
    local tabsLayout = CreateInstance("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6),
        Parent = tabsContainer
    })
    
    CreateInstance("UIPadding", {
        PaddingAll = UDim.new(0, 10),
        Parent = tabsContainer
    })
    
    tabsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabsContainer.CanvasSize = UDim2.new(0, 0, 0, tabsLayout.AbsoluteContentSize.Y + 20)
    end)
    
    -- Content Area
    local contentArea = CreateInstance("Frame", {
        Size = UDim2.new(1, -165, 1, -40),
        Position = UDim2.new(0, 165, 0, 40),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        ZIndex = 3,
        ClipsDescendants = true,
        Parent = mainFrame
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = contentArea
    })
    
    CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 10),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = contentArea
    })
    
    CreateInstance("Frame", {
        Size = UDim2.new(0, 10, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = contentArea
    })
    
    local contentScroll = CreateInstance("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 5,
        ScrollBarImageColor3 = Theme.ElementBorder,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ClipsDescendants = true,
        ZIndex = 4,
        Parent = contentArea
    })
    
    CreateInstance("UIPadding", {
        PaddingAll = UDim.new(0, 12),
        Parent = contentScroll
    })
    
    MakeDraggable(mainFrame, titleBar)
    
    -- Window Object
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        Theme = Theme,
        ThemeName = themeName,
        Notify = SendNotification,
    }
    
    -- Button Interactions
    AddHoverEffect(minimizeBtn, Theme.ElementBackground, Theme.Tertiary)
    AddHoverEffect(closeBtn, Theme.Error, Color3.fromRGB(255, 91, 91))
    AddHoverEffect(minimizeIcon, Theme.Secondary, Theme.Tertiary)
    AddHoverEffect(confirmYesBtn, Theme.Error, Color3.fromRGB(255, 91, 91))
    AddHoverEffect(confirmNoBtn, Theme.ElementBackground, Theme.Tertiary)
    
    minimizeBtn.MouseButton1Click:Connect(function()
        Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        mainFrame.Visible = false
        minimizeIcon.Visible = true
        Tween(minimizeIcon, {Size = LoaderConfig.Size}, 0.3, Enum.EasingStyle.Back)
    end)
    
    minimizeIcon.MouseButton1Click:Connect(function()
        Tween(minimizeIcon, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        minimizeIcon.Visible = false
        mainFrame.Visible = true
        Tween(mainFrame, {Size = windowSize}, 0.4, Enum.EasingStyle.Back)
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        confirmOverlay.Visible = true
        confirmModal.Size = UDim2.new(0, 0, 0, 0)
        Tween(confirmModal, {Size = UDim2.new(0, 320, 0, 160)}, 0.4, Enum.EasingStyle.Back)
    end)
    
    confirmYesBtn.MouseButton1Click:Connect(function()
        Tween(confirmModal, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        screenGui:Destroy()
    end)
    
    confirmNoBtn.MouseButton1Click:Connect(function()
        Tween(confirmModal, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        confirmOverlay.Visible = false
    end)
    
    -- Make Tab Function
    function Window:MakeTab(options)
        options = options or {}
        local tabName = options.Name or "Tab"
        local tabIcon = options.Icon or ""
        
        local tabButton = CreateInstance("TextButton", {
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundColor3 = Theme.ElementBackground,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            ZIndex = 5,
            Parent = tabsContainer
        })
        
        CreateInstance("UICorner", {
            CornerRadius = UDim.new(0, 8),
            Parent = tabButton
        })
        
        local activeIndicator = CreateInstance("Frame", {
            Size = UDim2.new(0, 0, 0, 35),
            Position = UDim2.new(0, -5, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
            ZIndex = 6,
            Parent = tabButton
        })
        
        CreateInstance("UICorner", {
            CornerRadius = UDim.new(1, 0),
            Parent = activeIndicator
        })
        
        local iconOffset = 12
        if tabIcon ~= "" then
            CreateInstance("ImageLabel", {
                Size = UDim2.new(0, 28, 0, 28),
                Position = UDim2.new(0, 14, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                Image = tabIcon,
                ScaleType = Enum.ScaleType.Fit,
                ZIndex = 7,
                Parent = tabButton
            })
            iconOffset = 50
        end
        
        CreateInstance("TextLabel", {
            Size = UDim2.new(1, -iconOffset - 8, 1, 0),
            Position = UDim2.new(0, iconOffset, 0, 0),
            BackgroundTransparency = 1,
            Text = tabName,
            TextColor3 = Theme.TextSecondary,
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            ZIndex = 7,
            Parent = tabButton
        })
        
        local tabContainer = CreateInstance("Frame", {
            Name = tabName .. "_Container",
            Size = UDim2.new(1, -24, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Visible = false,
            ClipsDescendants = false,
            ZIndex = 5,
            Parent = contentScroll
        })
        
        local tabLayout = CreateInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10),
            Parent = tabContainer
        })
        
        local function updateCanvas()
            task.wait(0.05)
            contentScroll.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 30)
        end
        
        tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
        
        tabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                Tween(tab.Button, {BackgroundColor3 = Theme.ElementBackground}, 0.2)
                tab.Container.Visible = false
                Tween(tab.ActiveIndicator, {
                    Size = UDim2.new(0, 0, 0, 35),
                    Position = UDim2.new(0, -5, 0.5, 0)
                }, 0.3, Enum.EasingStyle.Back)
            end
            
            Tween(tabButton, {BackgroundColor3 = Theme.Tertiary}, 0.2)
            tabContainer.Visible = true
            
            Tween(activeIndicator, {
                Size = UDim2.new(0, 4, 0, 35),
                Position = UDim2.new(0, 0, 0.5, 0)
            }, 0.4, Enum.EasingStyle.Back)
            
            updateCanvas()
        end)
        
        AddHoverEffect(tabButton, Theme.ElementBackground, Theme.Tertiary)
        
        local Tab = {
            Name = tabName,
            Button = tabButton,
            Container = tabContainer,
            ActiveIndicator = activeIndicator,
            Elements = {},
            UpdateCanvas = updateCanvas
        }
        
        if #Window.Tabs == 0 then
            tabButton.BackgroundColor3 = Theme.Tertiary
            tabContainer.Visible = true
            activeIndicator.Size = UDim2.new(0, 4, 0, 35)
            activeIndicator.Position = UDim2.new(0, 0, 0.5, 0)
            updateCanvas()
        end
        
        table.insert(Window.Tabs, Tab)
        
        -- Tab Elements
        function Tab:AddParagraph(options)
            options = options or {}
            local title = options.Title or "Paragraph"
            local text = options.Text or "No text provided"
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = container})
            CreateInstance("UIStroke", {Color = Theme.ElementBorder, Thickness = 1, Transparency = 0.7, Parent = container})
            CreateInstance("UIPadding", {PaddingAll = UDim.new(0, 12), Parent = container})
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = "📝 " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 25),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = text,
                TextColor3 = Theme.TextSecondary,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                ZIndex = 7,
                Parent = container
            })
            
            table.insert(Tab.Elements, container)
            Tab.UpdateCanvas()
            return container
        end
        
        function Tab:AddButton(options)
            options = options or {}
            local title = options.Title or "Button"
            local text = options.Text or "Click Me"
            local callback = options.Callback or function() end
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 80),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = container})
            CreateInstance("UIStroke", {Color = Theme.ElementBorder, Thickness = 1, Transparency = 0.7, Parent = container})
            CreateInstance("UIPadding", {PaddingAll = UDim.new(0, 12), Parent = container})
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = "🔘 " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7,
                Parent = container
            })
            
            local btn = CreateInstance("TextButton", {
                Size = UDim2.new(1, 0, 0, 36),
                Position = UDim2.new(0, 0, 0, 32),
                BackgroundColor3 = Theme.Accent,
                Text = text,
                TextColor3 = Theme.TextPrimary,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 7), Parent = btn})
            
            btn.MouseButton1Click:Connect(function()
                Tween(btn, {Size = UDim2.new(0.98, 0, 0, 34)}, 0.1)
                wait(0.1)
                Tween(btn, {Size = UDim2.new(1, 0, 0, 36)}, 0.1)
                pcall(callback)
            end)
            
            AddHoverEffect(btn, Theme.Accent, Theme.AccentHover, Theme.AccentPressed)
            
            table.insert(Tab.Elements, container)
            Tab.UpdateCanvas()
            return container
        end
        
        function Tab:AddToggle(options)
            options = options or {}
            local title = options.Title or "Toggle"
            local text = options.Text or "Toggle Option"
            local default = options.Default or false
            local callback = options.Callback or function() end
            
            local toggled = default
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 72),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = container})
            CreateInstance("UIStroke", {Color = Theme.ElementBorder, Thickness = 1, Transparency = 0.7, Parent = container})
            CreateInstance("UIPadding", {PaddingAll = UDim.new(0, 12), Parent = container})
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = "🔄 " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(0.62, 0, 0, 30),
                Position = UDim2.new(0, 0, 0, 32),
                BackgroundTransparency = 1,
                Text = text,
                TextColor3 = Theme.TextSecondary,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                TextWrapped = true,
                ZIndex = 7,
                Parent = container
            })
            
            local toggleBtn = CreateInstance("TextButton", {
                Size = UDim2.new(0, 50, 0, 26),
                Position = UDim2.new(1, -50, 0, 38),
                BackgroundColor3 = toggled and Theme.ToggleOn or Theme.ToggleOff,
                Text = "",
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = toggleBtn})
            
            local knob = CreateInstance("Frame", {
                Size = UDim2.new(0, 20, 0, 20),
                Position = toggled and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Theme.TextPrimary,
                BorderSizePixel = 0,
                ZIndex = 8,
                Parent = toggleBtn
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = knob})
            CreateInstance("UIStroke", {Color = Theme.TextSecondary, Thickness = 1.5, Parent = knob})
            
            toggleBtn.MouseButton1Click:Connect(function()
                toggled = not toggled
                Tween(toggleBtn, {BackgroundColor3 = toggled and Theme.ToggleOn or Theme.ToggleOff}, 0.3)
                Tween(knob, {Position = toggled and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)}, 0.3, Enum.EasingStyle.Quad)
                pcall(function() callback(toggled) end)
            end)
            
            table.insert(Tab.Elements, container)
            Tab.UpdateCanvas()
            
            return {
                SetValue = function(value)
                    toggled = value
                    Tween(toggleBtn, {BackgroundColor3 = toggled and Theme.ToggleOn or Theme.ToggleOff}, 0.3)
                    Tween(knob, {Position = toggled and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)}, 0.3)
                end,
                GetValue = function()
                    return toggled
                end
            }
        end
        
        function Tab:AddSlider(options)
            options = options or {}
            local title = options.Title or "Slider"
            local min = options.Min or 0
            local max = options.Max or 100
            local default = options.Default or 50
            local callback = options.Callback or function() end
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 85),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = container})
            CreateInstance("UIStroke", {Color = Theme.ElementBorder, Thickness = 1, Transparency = 0.7, Parent = container})
            CreateInstance("UIPadding", {PaddingAll = UDim.new(0, 12), Parent = container})
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, -60, 0, 20),
                BackgroundTransparency = 1,
                Text = "🎚️ " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7,
                Parent = container
            })
            
            local valueLabel = CreateInstance("TextLabel", {
                Size = UDim2.new(0, 55, 0, 24),
                Position = UDim2.new(1, -55, 0, 0),
                BackgroundColor3 = Theme.Tertiary,
                Text = tostring(default),
                TextColor3 = Theme.TextPrimary,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 6), Parent = valueLabel})
            
            local track = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 7),
                Position = UDim2.new(0, 0, 0, 45),
                BackgroundColor3 = Theme.Tertiary,
                BorderSizePixel = 0,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = track})
            
            local fill = CreateInstance("Frame", {
                Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                BackgroundColor3 = Theme.Accent,
                BorderSizePixel = 0,
                ZIndex = 8,
                Parent = track
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = fill})
            
            local knob = CreateInstance("TextButton", {
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new((default - min) / (max - min), -9, 0.5, -9),
                BackgroundColor3 = Theme.TextPrimary,
                BorderSizePixel = 0,
                Text = "",
                ZIndex = 9,
                Parent = track
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = knob})
            CreateInstance("UIStroke", {Color = Theme.Accent, Thickness = 2, Parent = knob})
            
            local dragging = false
            
            knob.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)
            
            track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local pos = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
                    pos = math.clamp(pos, 0, 1)
                    local value = math.floor(min + (max - min) * pos)
                    fill.Size = UDim2.new(pos, 0, 1, 0)
                    knob.Position = UDim2.new(pos, -9, 0.5, -9)
                    valueLabel.Text = tostring(value)
                    pcall(function() callback(value) end)
                end
            end)
            
            AddHoverEffect(knob, Theme.TextPrimary, Theme.TextSecondary)
            
            table.insert(Tab.Elements, container)
            Tab.UpdateCanvas()
            return container
        end
        
        function Tab:AddTextBox(options)
            options = options or {}
            local title = options.Title or "TextBox"
            local placeholder = options.Placeholder or "Type here..."
            local default = options.Default or ""
            local callback = options.Callback or function() end
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 80),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = container})
            CreateInstance("UIStroke", {Color = Theme.ElementBorder, Thickness = 1, Transparency = 0.7, Parent = container})
            CreateInstance("UIPadding", {PaddingAll = UDim.new(0, 12), Parent = container})
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = "✏️ " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7,
                Parent = container
            })
            
            local textBox = CreateInstance("TextBox", {
                Size = UDim2.new(1, 0, 0, 36),
                Position = UDim2.new(0, 0, 0, 32),
                BackgroundColor3 = Theme.Tertiary,
                PlaceholderText = placeholder,
                PlaceholderColor3 = Theme.TextMuted,
                Text = default,
                TextColor3 = Theme.TextPrimary,
                TextSize = 13,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 7), Parent = textBox})
            CreateInstance("UIPadding", {PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), Parent = textBox})
            
            local stroke = CreateInstance("UIStroke", {Color = Theme.ElementBorder, Thickness = 1.5, Transparency = 0.5, Parent = textBox})
            
            textBox.Focused:Connect(function()
                Tween(stroke, {Color = Theme.Accent, Transparency = 0}, 0.2)
            end)
            
            textBox.FocusLost:Connect(function(enter)
                Tween(stroke, {Color = Theme.ElementBorder, Transparency = 0.5}, 0.2)
                if enter then pcall(function() callback(textBox.Text) end) end
            end)
            
            table.insert(Tab.Elements, container)
            Tab.UpdateCanvas()
            return textBox
        end
        
        function Tab:AddDropdown(options)
            options = options or {}
            local title = options.Title or "Dropdown"
            local text = options.Text or "Select Option"
            local items = options.Items or {"Option 1", "Option 2", "Option 3"}
            local callback = options.Callback or function() end
            
            local selectedItem = text
            local isOpen = false
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 80),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                ClipsDescendants = false,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = container})
            CreateInstance("UIStroke", {Color = Theme.ElementBorder, Thickness = 1, Transparency = 0.7, Parent = container})
            CreateInstance("UIPadding", {PaddingAll = UDim.new(0, 12), Parent = container})
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = "📋 " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7,
                Parent = container
            })
            
            local dropdownButton = CreateInstance("TextButton", {
                Size = UDim2.new(1, 0, 0, 36),
                Position = UDim2.new(0, 0, 0, 32),
                BackgroundColor3 = Theme.Tertiary,
                BorderSizePixel = 0,
                Text = "",
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 7), Parent = dropdownButton})
            
            local dropdownLabel = CreateInstance("TextLabel", {
                Size = UDim2.new(1, -35, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Text = selectedItem,
                TextColor3 = Theme.TextPrimary,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                ZIndex = 8,
                Parent = dropdownButton
            })
            
            local arrowIcon = CreateInstance("TextLabel", {
                Size = UDim2.new(0, 25, 1, 0),
                Position = UDim2.new(1, -25, 0, 0),
                BackgroundTransparency = 1,
                Text = "▼",
                TextColor3 = Theme.TextSecondary,
                TextSize = 11,
                ZIndex = 8,
                Parent = dropdownButton
            })
            
            local dropdownList = CreateInstance("ScrollingFrame", {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 73),
                BackgroundColor3 = Theme.Tertiary,
                BorderSizePixel = 0,
                ScrollBarThickness = 4,
                ScrollBarImageColor3 = Theme.ElementBorder,
                Visible = false,
                ZIndex = 100,
                ClipsDescendants = true,
                Parent = container
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 7), Parent = dropdownList})
            CreateInstance("UIStroke", {Color = Theme.Accent, Thickness = 1.5, Parent = dropdownList})
            
            local listLayout = CreateInstance("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 2),
                Parent = dropdownList
            })
            
            CreateInstance("UIPadding", {PaddingAll = UDim.new(0, 4), Parent = dropdownList})
            
            listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                dropdownList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 8)
            end)
            
            for _, item in ipairs(items) do
                local itemButton = CreateInstance("TextButton", {
                    Size = UDim2.new(1, -8, 0, 32),
                    BackgroundColor3 = Theme.ElementBackground,
                    BorderSizePixel = 0,
                    Text = "",
                    ZIndex = 101,
                    Parent = dropdownList
                })
                
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 6), Parent = itemButton})
                
                CreateInstance("TextLabel", {
                    Size = UDim2.new(1, -10, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = item,
                    TextColor3 = Theme.TextPrimary,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = 102,
                    Parent = itemButton
                })
                
                itemButton.MouseButton1Click:Connect(function()
                    selectedItem = item
                    dropdownLabel.Text = selectedItem
                    
                    isOpen = false
                    Tween(container, {Size = UDim2.new(1, 0, 0, 80)}, 0.3)
                    Tween(dropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
                    Tween(arrowIcon, {Rotation = 0}, 0.3)
                    wait(0.3)
                    dropdownList.Visible = false
                    Tab.UpdateCanvas()
                    
                    pcall(function() callback(item) end)
                end)
                
                AddHoverEffect(itemButton, Theme.ElementBackground, Theme.ElementBorder)
            end
            
            dropdownButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                
                if isOpen then
                    dropdownList.Visible = true
                    local maxHeight = math.min(#items * 34, 140)
                    Tween(container, {Size = UDim2.new(1, 0, 0, 80 + maxHeight + 8)}, 0.3, Enum.EasingStyle.Back)
                    Tween(dropdownList, {Size = UDim2.new(1, 0, 0, maxHeight)}, 0.3, Enum.EasingStyle.Back)
                    Tween(arrowIcon, {Rotation = 180}, 0.3)
                    task.wait(0.3)
                    Tab.UpdateCanvas()
                else
                    Tween(container, {Size = UDim2.new(1, 0, 0, 80)}, 0.3)
                    Tween(dropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
                    Tween(arrowIcon, {Rotation = 0}, 0.3)
                    wait(0.3)
                    dropdownList.Visible = false
                    Tab.UpdateCanvas()
                end
            end)
            
            AddHoverEffect(dropdownButton, Theme.Tertiary, Theme.ElementBorder)
            
            table.insert(Tab.Elements, container)
            Tab.UpdateCanvas()
            return container
        end
        
        return Tab
    end
    
    Tween(mainFrame, {Size = windowSize}, 0.5, Enum.EasingStyle.Back)
    
    return Window
end

return DrakthonLib
