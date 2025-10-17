--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║                  DRAKTHON UI LIBRARY V7.0                    ║
    ║       ULTIMATE EDITION - FULL CUSTOMIZATION + SETTINGS       ║
    ║    ✅ Complete Loader + Settings Tab + Everything Custom    ║
    ╚══════════════════════════════════════════════════════════════╝
]]

local DrakthonLib = {}

-- ═══════════════════════════════════════════════════════════════
-- PREDEFINED THEMES
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
    Emerald = {
        Background = Color3.fromRGB(6, 25, 15),
        Secondary = Color3.fromRGB(11, 30, 20),
        Tertiary = Color3.fromRGB(16, 35, 25),
        Accent = Color3.fromRGB(16, 185, 129),
        AccentHover = Color3.fromRGB(36, 205, 149),
        AccentPressed = Color3.fromRGB(5, 150, 105),
        TextPrimary = Color3.fromRGB(236, 253, 245),
        TextSecondary = Color3.fromRGB(167, 243, 208),
        TextMuted = Color3.fromRGB(110, 231, 183),
        ElementBackground = Color3.fromRGB(21, 40, 30),
        ElementBorder = Color3.fromRGB(6, 78, 59),
        Success = Color3.fromRGB(52, 211, 153),
        Warning = Color3.fromRGB(251, 191, 36),
        Error = Color3.fromRGB(248, 113, 113),
        ToggleOn = Color3.fromRGB(52, 211, 153),
        ToggleOff = Color3.fromRGB(6, 78, 59),
    },
    Sunset = {
        Background = Color3.fromRGB(30, 20, 10),
        Secondary = Color3.fromRGB(35, 25, 15),
        Tertiary = Color3.fromRGB(40, 30, 20),
        Accent = Color3.fromRGB(249, 115, 22),
        AccentHover = Color3.fromRGB(255, 135, 42),
        AccentPressed = Color3.fromRGB(234, 88, 12),
        TextPrimary = Color3.fromRGB(255, 247, 237),
        TextSecondary = Color3.fromRGB(254, 215, 170),
        TextMuted = Color3.fromRGB(253, 186, 116),
        ElementBackground = Color3.fromRGB(50, 35, 20),
        ElementBorder = Color3.fromRGB(124, 45, 18),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(234, 179, 8),
        Error = Color3.fromRGB(239, 68, 68),
        ToggleOn = Color3.fromRGB(34, 197, 94),
        ToggleOff = Color3.fromRGB(124, 45, 18),
    },
    Midnight = {
        Background = Color3.fromRGB(10, 10, 10),
        Secondary = Color3.fromRGB(15, 15, 15),
        Tertiary = Color3.fromRGB(20, 20, 20),
        Accent = Color3.fromRGB(100, 100, 100),
        AccentHover = Color3.fromRGB(120, 120, 120),
        AccentPressed = Color3.fromRGB(80, 80, 80),
        TextPrimary = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(180, 180, 180),
        TextMuted = Color3.fromRGB(120, 120, 120),
        ElementBackground = Color3.fromRGB(25, 25, 25),
        ElementBorder = Color3.fromRGB(40, 40, 40),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(234, 179, 8),
        Error = Color3.fromRGB(239, 68, 68),
        ToggleOn = Color3.fromRGB(34, 197, 94),
        ToggleOff = Color3.fromRGB(40, 40, 40),
    },
    Rose = {
        Background = Color3.fromRGB(31, 18, 23),
        Secondary = Color3.fromRGB(36, 23, 28),
        Tertiary = Color3.fromRGB(41, 28, 33),
        Accent = Color3.fromRGB(244, 114, 182),
        AccentHover = Color3.fromRGB(255, 134, 202),
        AccentPressed = Color3.fromRGB(236, 72, 153),
        TextPrimary = Color3.fromRGB(255, 241, 242),
        TextSecondary = Color3.fromRGB(251, 207, 232),
        TextMuted = Color3.fromRGB(249, 168, 212),
        ElementBackground = Color3.fromRGB(51, 33, 38),
        ElementBorder = Color3.fromRGB(80, 50, 60),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(251, 191, 36),
        Error = Color3.fromRGB(244, 63, 94),
        ToggleOn = Color3.fromRGB(34, 197, 94),
        ToggleOff = Color3.fromRGB(80, 50, 60),
    },
    Cyber = {
        Background = Color3.fromRGB(20, 20, 10),
        Secondary = Color3.fromRGB(25, 25, 15),
        Tertiary = Color3.fromRGB(30, 30, 20),
        Accent = Color3.fromRGB(234, 179, 8),
        AccentHover = Color3.fromRGB(250, 204, 21),
        AccentPressed = Color3.fromRGB(202, 138, 4),
        TextPrimary = Color3.fromRGB(254, 252, 232),
        TextSecondary = Color3.fromRGB(253, 224, 71),
        TextMuted = Color3.fromRGB(250, 204, 21),
        ElementBackground = Color3.fromRGB(35, 35, 25),
        ElementBorder = Color3.fromRGB(113, 63, 18),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(217, 119, 6),
        Error = Color3.fromRGB(239, 68, 68),
        ToggleOn = Color3.fromRGB(34, 197, 94),
        ToggleOff = Color3.fromRGB(113, 63, 18),
    },
    Arctic = {
        Background = Color3.fromRGB(240, 242, 245),
        Secondary = Color3.fromRGB(245, 247, 250),
        Tertiary = Color3.fromRGB(250, 252, 255),
        Accent = Color3.fromRGB(59, 130, 246),
        AccentHover = Color3.fromRGB(79, 150, 255),
        AccentPressed = Color3.fromRGB(37, 99, 235),
        TextPrimary = Color3.fromRGB(15, 23, 42),
        TextSecondary = Color3.fromRGB(51, 65, 85),
        TextMuted = Color3.fromRGB(100, 116, 139),
        ElementBackground = Color3.fromRGB(255, 255, 255),
        ElementBorder = Color3.fromRGB(226, 232, 240),
        Success = Color3.fromRGB(22, 163, 74),
        Warning = Color3.fromRGB(202, 138, 4),
        Error = Color3.fromRGB(220, 38, 38),
        ToggleOn = Color3.fromRGB(22, 163, 74),
        ToggleOff = Color3.fromRGB(203, 213, 225),
    },
    Neon = {
        Background = Color3.fromRGB(4, 20, 20),
        Secondary = Color3.fromRGB(9, 25, 25),
        Tertiary = Color3.fromRGB(14, 30, 30),
        Accent = Color3.fromRGB(20, 184, 166),
        AccentHover = Color3.fromRGB(45, 212, 191),
        AccentPressed = Color3.fromRGB(13, 148, 136),
        TextPrimary = Color3.fromRGB(240, 253, 250),
        TextSecondary = Color3.fromRGB(153, 246, 228),
        TextMuted = Color3.fromRGB(94, 234, 212),
        ElementBackground = Color3.fromRGB(19, 35, 35),
        ElementBorder = Color3.fromRGB(15, 118, 110),
        Success = Color3.fromRGB(52, 211, 153),
        Warning = Color3.fromRGB(251, 191, 36),
        Error = Color3.fromRGB(248, 113, 113),
        ToggleOn = Color3.fromRGB(52, 211, 153),
        ToggleOff = Color3.fromRGB(15, 118, 110),
    },
    Blood = {
        Background = Color3.fromRGB(25, 5, 5),
        Secondary = Color3.fromRGB(30, 10, 10),
        Tertiary = Color3.fromRGB(35, 15, 15),
        Accent = Color3.fromRGB(185, 28, 28),
        AccentHover = Color3.fromRGB(220, 38, 38),
        AccentPressed = Color3.fromRGB(153, 27, 27),
        TextPrimary = Color3.fromRGB(255, 245, 245),
        TextSecondary = Color3.fromRGB(254, 202, 202),
        TextMuted = Color3.fromRGB(252, 165, 165),
        ElementBackground = Color3.fromRGB(45, 20, 20),
        ElementBorder = Color3.fromRGB(127, 29, 29),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(251, 191, 36),
        Error = Color3.fromRGB(239, 68, 68),
        ToggleOn = Color3.fromRGB(34, 197, 94),
        ToggleOff = Color3.fromRGB(127, 29, 29),
    },
}

-- ═══════════════════════════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════════════════════════
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ═══════════════════════════════════════════════════════════════
-- ANTI-DUPLICATE SYSTEM
-- ═══════════════════════════════════════════════════════════════
local function CheckDuplicate(antiDupId)
    if not antiDupId or antiDupId == "" then
        return false
    end
    
    for _, gui in ipairs(PlayerGui:GetChildren()) do
        if gui:GetAttribute("DrakthonID") == antiDupId then
            warn("[Drakthon] UI with ID '" .. antiDupId .. "' already exists! Ignoring duplicate...")
            return true
        end
    end
    
    return false
end

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

-- ═══════════════════════════════════════════════════════════════
-- MAIN WINDOW FUNCTION
-- ═══════════════════════════════════════════════════════════════

function DrakthonLib:MakeWindow(options)
    options = options or {}
    
    -- Anti-Duplicate Check
    local antiDupId = options.AntiDuplicate or ""
    if CheckDuplicate(antiDupId) then
        return nil
    end
    
    -- ═══════════════════════════════════════════════════════════
    -- LOADER CONFIGURATION (COMPLETE)
    -- ═══════════════════════════════════════════════════════════
    local LoaderConfig = {
        Enabled = options.LoaderEnabled ~= false,
        MainImage = options.LoaderImage or "rbxassetid://11422155687",
        IconImage = options.LoaderIconImage or options.LoaderImage2 or "rbxassetid://679392",
        Position = options.LoaderPosition or UDim2.new(0, 20, 1, -90),
        Size = options.LoaderSize or UDim2.new(0, 70, 0, 70),
        BackgroundColor = options.LoaderBackgroundColor or nil,
        BorderColor = options.LoaderBorderColor or nil,
        BorderThickness = options.LoaderBorderThickness or 1.5,
        CornerRadius = options.LoaderCornerRadius or 12,
        Transparency = options.LoaderTransparency or 0,
        ImageTransparency = options.LoaderImageTransparency or 0,
        Draggable = options.LoaderDraggable ~= false,
        HoverEffect = options.LoaderHoverEffect ~= false,
        ClickSound = options.LoaderClickSound or nil,
        ShowOnStart = options.LoaderShowOnStart or false,
    }
    
    -- ═══════════════════════════════════════════════════════════
    -- WINDOW CONFIGURATION
    -- ═══════════════════════════════════════════════════════════
    local windowName = options.Name or "Drakthon Library"
    local themeName = options.Theme or "Default"
    local customTheme = options.CustomTheme or nil
    local windowSize = options.Size or UDim2.new(0, 550, 0, 350)
    local closeConfirmation = options.CloseConfirmation ~= false
    local closeConfirmText = options.CloseConfirmText or "Are you sure you want to close?"
    local accentColor = options.AccentColor or nil
    local titleBarHeight = options.TitleBarHeight or 40
    local sidebarWidth = options.SidebarWidth or 165
    local animationSpeed = options.AnimationSpeed or 0.3
    local fontSize = options.FontSize or 1
    local uiTransparency = options.UITransparency or 0
    
    -- Select Theme
    local Theme = customTheme or Themes[themeName] or Themes.Default
    
    -- Apply custom accent if provided
    if accentColor then
        Theme.Accent = accentColor
        Theme.AccentHover = Color3.new(
            math.min(accentColor.R + 0.1, 1),
            math.min(accentColor.G + 0.1, 1),
            math.min(accentColor.B + 0.1, 1)
        )
        Theme.AccentPressed = Color3.new(
            math.max(accentColor.R - 0.1, 0),
            math.max(accentColor.G - 0.1, 0),
            math.max(accentColor.B - 0.1, 0)
        )
    end
    
    -- ═══════════════════════════════════════════════════════════
    -- CREATE SCREEN GUI
    -- ═══════════════════════════════════════════════════════════
    local screenGui = CreateInstance("ScreenGui", {
        Name = "DrakthonLib_" .. tick(),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true,
        Parent = PlayerGui
    })
    
    if antiDupId ~= "" then
        screenGui:SetAttribute("DrakthonID", antiDupId)
    end
    
    -- ═══════════════════════════════════════════════════════════
    -- LOADER ICON (COMPLETE CUSTOMIZATION)
    -- ═══════════════════════════════════════════════════════════
    local loaderIcon = CreateInstance("Frame", {
        Name = "LoaderIcon",
        Size = LoaderConfig.Size,
        Position = LoaderConfig.Position,
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = LoaderConfig.BackgroundColor or Theme.Secondary,
        BackgroundTransparency = LoaderConfig.Transparency,
        Visible = LoaderConfig.ShowOnStart,
        ZIndex = 100,
        Parent = screenGui
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, LoaderConfig.CornerRadius),
        Parent = loaderIcon
    })
    
    CreateInstance("UIStroke", {
        Color = LoaderConfig.BorderColor or Theme.ElementBorder,
        Thickness = LoaderConfig.BorderThickness,
        Transparency = 0.3,
        Parent = loaderIcon
    })
    
    local loaderImageButton = CreateInstance("ImageButton", {
        Name = "ImageButton",
        Size = UDim2.new(1, -10, 1, -10),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = LoaderConfig.MainImage,
        ImageTransparency = LoaderConfig.ImageTransparency,
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 101,
        Parent = loaderIcon
    })
    
    if LoaderConfig.Draggable then
        MakeDraggable(loaderIcon, loaderIcon)
    end
    
    if LoaderConfig.HoverEffect then
        AddHoverEffect(loaderIcon, 
            LoaderConfig.BackgroundColor or Theme.Secondary, 
            Theme.Tertiary
        )
    end
    
    -- ═══════════════════════════════════════════════════════════
    -- MAIN WINDOW FRAME
    -- ═══════════════════════════════════════════════════════════
    local mainFrame = CreateInstance("Frame", {
        Name = "MainWindow",
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.Background,
        BackgroundTransparency = uiTransparency,
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
    
    -- ═══════════════════════════════════════════════════════════
    -- TITLE BAR
    -- ═══════════════════════════════════════════════════════════
    local titleBar = CreateInstance("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, titleBarHeight),
        BackgroundColor3 = Theme.Secondary,
        BackgroundTransparency = uiTransparency,
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
        BackgroundTransparency = uiTransparency,
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
        TextSize = 15 * fontSize,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 4,
        Parent = titleBar
    })
    
    -- Icon in Title Bar
    if LoaderConfig.IconImage and LoaderConfig.IconImage ~= "" then
        local imageId = LoaderConfig.IconImage
        if not string.find(imageId, "rbxassetid://") then
            imageId = "rbxassetid://" .. imageId
        end
        
        CreateInstance("ImageLabel", {
            Size = UDim2.new(0, 30, 0, 30),
            Position = UDim2.new(1, -150, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Image = imageId,
            ScaleType = Enum.ScaleType.Fit,
            ZIndex = 4,
            Parent = titleBar
        })
    end
    
    -- ═══════════════════════════════════════════════════════════
    -- CONTROL BUTTONS
    -- ═══════════════════════════════════════════════════════════
    local minimizeBtn = CreateInstance("TextButton", {
        Size = UDim2.new(0, 35, 0, 26),
        Position = UDim2.new(1, -85, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.ElementBackground,
        Text = "—",
        TextColor3 = Theme.TextPrimary,
        TextSize = 16 * fontSize,
        Font = Enum.Font.GothamBold,
        ZIndex = 4,
        Parent = titleBar
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = minimizeBtn
    })
    
    local closeBtn = CreateInstance("TextButton", {
        Size = UDim2.new(0, 35, 0, 26),
        Position = UDim2.new(1, -42, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.Error,
        Text = "✕",
        TextColor3 = Theme.TextPrimary,
        TextSize = 16 * fontSize,
        Font = Enum.Font.GothamBold,
        ZIndex = 4,
        Parent = titleBar
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = closeBtn
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- CONFIRMATION MODAL
    -- ═══════════════════════════════════════════════════════════
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
        TextSize = 18 * fontSize,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 201,
        Parent = confirmModal
    })
    
    CreateInstance("TextLabel", {
        Size = UDim2.new(1, -30, 0, 45),
        Position = UDim2.new(0, 15, 0, 48),
        BackgroundTransparency = 1,
        Text = closeConfirmText,
        TextColor3 = Theme.TextSecondary,
        TextSize = 13 * fontSize,
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
        TextSize = 14 * fontSize,
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
        TextSize = 14 * fontSize,
        Font = Enum.Font.GothamBold,
        ZIndex = 201,
        Parent = confirmModal
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = confirmNoBtn
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- SIDEBAR
    -- ═══════════════════════════════════════════════════════════
    local sidebar = CreateInstance("Frame", {
        Size = UDim2.new(0, sidebarWidth, 1, -titleBarHeight),
        Position = UDim2.new(0, 0, 0, titleBarHeight),
        BackgroundColor3 = Theme.Secondary,
        BackgroundTransparency = uiTransparency,
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = mainFrame
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
        PaddingTop = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 10),
        Parent = tabsContainer
    })
    
    tabsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabsContainer.CanvasSize = UDim2.new(0, 0, 0, tabsLayout.AbsoluteContentSize.Y + 20)
    end)
    
    -- ═══════════════════════════════════════════════════════════
    -- CONTENT AREA
    -- ═══════════════════════════════════════════════════════════
    local contentArea = CreateInstance("Frame", {
        Name = "ContentArea",
        Size = UDim2.new(1, -sidebarWidth, 1, -titleBarHeight),
        Position = UDim2.new(0, sidebarWidth, 0, titleBarHeight),
        BackgroundColor3 = Theme.Background,
        BackgroundTransparency = uiTransparency,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 3,
        Parent = mainFrame
    })
    
    local contentScroll = CreateInstance("ScrollingFrame", {
        Name = "ContentScroll",
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
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
        PaddingTop = UDim.new(0, 12),
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12),
        PaddingBottom = UDim.new(0, 12),
        Parent = contentScroll
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- BUTTON INTERACTIONS
    -- ═══════════════════════════════════════════════════════════
    AddHoverEffect(minimizeBtn, Theme.ElementBackground, Theme.Tertiary, Theme.ElementBorder)
    AddHoverEffect(closeBtn, Theme.Error, Color3.fromRGB(255, 91, 91), Color3.fromRGB(220, 51, 51))
    AddHoverEffect(confirmYesBtn, Theme.Error, Color3.fromRGB(255, 91, 91))
    AddHoverEffect(confirmNoBtn, Theme.ElementBackground, Theme.Tertiary)
    
    closeBtn.MouseButton1Click:Connect(function()
        if closeConfirmation then
            confirmOverlay.Visible = true
            confirmModal.Size = UDim2.new(0, 0, 0, 0)
            Tween(confirmModal, {Size = UDim2.new(0, 320, 0, 160)}, animationSpeed + 0.1, Enum.EasingStyle.Back)
        else
            screenGui:Destroy()
        end
    end)
    
    confirmYesBtn.MouseButton1Click:Connect(function()
        Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, animationSpeed + 0.1, Enum.EasingStyle.Back)
        wait(animationSpeed + 0.1)
        screenGui:Destroy()
    end)
    
    confirmNoBtn.MouseButton1Click:Connect(function()
        Tween(confirmModal, {Size = UDim2.new(0, 0, 0, 0)}, animationSpeed, Enum.EasingStyle.Back)
        wait(animationSpeed)
        confirmOverlay.Visible = false
    end)
    
    minimizeBtn.MouseButton1Click:Connect(function()
        if LoaderConfig.ClickSound then
            -- Play sound if provided
        end
        
        Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, animationSpeed, Enum.EasingStyle.Back)
        wait(animationSpeed)
        mainFrame.Visible = false
        loaderIcon.Visible = true
        Tween(loaderIcon, {Size = LoaderConfig.Size}, animationSpeed, Enum.EasingStyle.Back)
    end)
    
    loaderImageButton.MouseButton1Click:Connect(function()
        if LoaderConfig.ClickSound then
            -- Play sound if provided
        end
        
        Tween(loaderIcon, {Size = UDim2.new(0, 0, 0, 0)}, animationSpeed, Enum.EasingStyle.Back)
        wait(animationSpeed)
        loaderIcon.Visible = false
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        Tween(mainFrame, {Size = windowSize}, animationSpeed + 0.1, Enum.EasingStyle.Back)
    end)
    
    MakeDraggable(mainFrame, titleBar)
    
    -- ═══════════════════════════════════════════════════════════
    -- WINDOW OBJECT
    -- ═══════════════════════════════════════════════════════════
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        ContentScroll = contentScroll,
        Theme = Theme,
        Config = {
            AnimationSpeed = animationSpeed,
            FontSize = fontSize,
            UITransparency = uiTransparency,
            TitleBarHeight = titleBarHeight,
            SidebarWidth = sidebarWidth,
            WindowSize = windowSize,
        }
    }
    
    -- ═══════════════════════════════════════════════════════════
    -- SETTINGS TAB CREATOR (AUTOMATIC)
    -- ═══════════════════════════════════════════════════════════
    function Window:CreateSettingsTab()
        local SettingsTab = self:MakeTab({
            Name = "⚙️ Settings",
            Icon = "rbxassetid://10734950309"
        })
        
        SettingsTab:AddParagraph({
            Title = "UI Settings",
            Text = "Customize your UI appearance and behavior"
        })
        
        -- Theme Selector
        local themeNames = {}
        for name, _ in pairs(Themes) do
            table.insert(themeNames, name)
        end
        table.sort(themeNames)
        
        SettingsTab:AddDropdown({
            Title = "Theme",
            Text = themeName,
            Items = themeNames,
            Callback = function(selected)
                Theme = Themes[selected]
                themeName = selected
                
                -- Apply theme to all elements
                mainFrame.BackgroundColor3 = Theme.Background
                titleBar.BackgroundColor3 = Theme.Secondary
                sidebar.BackgroundColor3 = Theme.Secondary
                contentArea.BackgroundColor3 = Theme.Background
                titleLabel.TextColor3 = Theme.TextPrimary
                
                -- Update all tabs
                for _, tab in pairs(Window.Tabs) do
                    tab.Button.BackgroundColor3 = Theme.ElementBackground
                    tab.ActiveIndicator.BackgroundColor3 = Theme.Accent
                end
            end
        })
        
        -- UI Scale
        SettingsTab:AddSlider({
            Title = "UI Scale",
            Min = 50,
            Max = 150,
            Default = 100,
            Callback = function(value)
                local scale = value / 100
                local newWidth = windowSize.X.Offset * scale
                local newHeight = windowSize.Y.Offset * scale
                Tween(mainFrame, {Size = UDim2.new(0, newWidth, 0, newHeight)}, animationSpeed)
            end
        })
        
        -- UI Transparency
        SettingsTab:AddSlider({
            Title = "Background Transparency",
            Min = 0,
            Max = 100,
            Default = uiTransparency * 100,
            Callback = function(value)
                uiTransparency = value / 100
                Tween(mainFrame, {BackgroundTransparency = uiTransparency}, animationSpeed)
                Tween(titleBar, {BackgroundTransparency = uiTransparency}, animationSpeed)
                Tween(sidebar, {BackgroundTransparency = uiTransparency}, animationSpeed)
                Tween(contentArea, {BackgroundTransparency = uiTransparency}, animationSpeed)
            end
        })
        
        -- Font Size
        SettingsTab:AddSlider({
            Title = "Font Size",
            Min = 50,
            Max = 150,
            Default = fontSize * 100,
            Callback = function(value)
                fontSize = value / 100
                titleLabel.TextSize = 15 * fontSize
                
                -- Update all text elements
                for _, descendant in pairs(mainFrame:GetDescendants()) do
                    if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
                        local baseSize = descendant:GetAttribute("BaseTextSize") or descendant.TextSize
                        descendant:SetAttribute("BaseTextSize", baseSize / fontSize)
                        descendant.TextSize = baseSize
                    end
                end
            end
        })
        
        -- Animation Speed
        SettingsTab:AddSlider({
            Title = "Animation Speed",
            Min = 10,
            Max = 100,
            Default = animationSpeed * 100,
            Callback = function(value)
                animationSpeed = value / 100
                Window.Config.AnimationSpeed = animationSpeed
            end
        })
        
        -- Sidebar Width
        SettingsTab:AddSlider({
            Title = "Sidebar Width",
            Min = 100,
            Max = 250,
            Default = sidebarWidth,
            Callback = function(value)
                sidebarWidth = value
                Tween(sidebar, {Size = UDim2.new(0, sidebarWidth, 1, -titleBarHeight)}, animationSpeed)
                Tween(contentArea, {
                    Size = UDim2.new(1, -sidebarWidth, 1, -titleBarHeight),
                    Position = UDim2.new(0, sidebarWidth, 0, titleBarHeight)
                }, animationSpeed)
            end
        })
        
        -- Title Bar Height
        SettingsTab:AddSlider({
            Title = "Title Bar Height",
            Min = 30,
            Max = 60,
            Default = titleBarHeight,
            Callback = function(value)
                titleBarHeight = value
                Tween(titleBar, {Size = UDim2.new(1, 0, 0, titleBarHeight)}, animationSpeed)
                Tween(sidebar, {
                    Size = UDim2.new(0, sidebarWidth, 1, -titleBarHeight),
                    Position = UDim2.new(0, 0, 0, titleBarHeight)
                }, animationSpeed)
                Tween(contentArea, {
                    Size = UDim2.new(1, -sidebarWidth, 1, -titleBarHeight),
                    Position = UDim2.new(0, sidebarWidth, 0, titleBarHeight)
                }, animationSpeed)
            end
        })
        
        -- Toggle Close Confirmation
        SettingsTab:AddToggle({
            Title = "Close Confirmation",
            Text = "Show warning when closing",
            Default = closeConfirmation,
            Callback = function(value)
                closeConfirmation = value
            end
        })
        
        -- Loader Settings
        SettingsTab:AddParagraph({
            Title = "Loader Settings",
            Text = "Customize loader appearance"
        })
        
        SettingsTab:AddToggle({
            Title = "Loader Draggable",
            Text = "Allow dragging loader icon",
            Default = LoaderConfig.Draggable,
            Callback = function(value)
                LoaderConfig.Draggable = value
            end
        })
        
        SettingsTab:AddToggle({
            Title = "Loader Hover Effect",
            Text = "Show hover effect on loader",
            Default = LoaderConfig.HoverEffect,
            Callback = function(value)
                LoaderConfig.HoverEffect = value
            end
        })
        
        SettingsTab:AddSlider({
            Title = "Loader Transparency",
            Min = 0,
            Max = 100,
            Default = LoaderConfig.Transparency * 100,
            Callback = function(value)
                LoaderConfig.Transparency = value / 100
                Tween(loaderIcon, {BackgroundTransparency = LoaderConfig.Transparency}, animationSpeed)
            end
        })
        
        -- Reset Button
        SettingsTab:AddButton({
            Title = "Reset to Default",
            Text = "Reset All Settings",
            Callback = function()
                -- Reset all settings
                Theme = Themes.Default
                fontSize = 1
                uiTransparency = 0
                animationSpeed = 0.3
                sidebarWidth = 165
                titleBarHeight = 40
                
                -- Apply defaults
                mainFrame.BackgroundColor3 = Theme.Background
                titleBar.BackgroundColor3 = Theme.Secondary
                sidebar.BackgroundColor3 = Theme.Secondary
                contentArea.BackgroundColor3 = Theme.Background
                
                Tween(mainFrame, {
                    Size = windowSize,
                    BackgroundTransparency = 0
                }, animationSpeed)
            end
        })
        
        -- Export Config
        SettingsTab:AddButton({
            Title = "Export Config",
            Text = "Copy to Clipboard",
            Callback = function()
                local config = {
                    Theme = themeName,
                    FontSize = fontSize,
                    UITransparency = uiTransparency,
                    AnimationSpeed = animationSpeed,
                    SidebarWidth = sidebarWidth,
                    TitleBarHeight = titleBarHeight,
                }
                
                local configString = HttpService:JSONEncode(config)
                setclipboard(configString)
                print("[Drakthon] Config exported to clipboard!")
            end
        })
        
        return SettingsTab
    end
    
    -- ═══════════════════════════════════════════════════════════
    -- MAKE TAB FUNCTION
    -- ═══════════════════════════════════════════════════════════
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
            ClipsDescendants = false,
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
            TextSize = 13 * fontSize,
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
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Visible = false,
            BorderSizePixel = 0,
            ClipsDescendants = false,
            ZIndex = 5,
            Parent = contentScroll
        })
        
        local tabLayout = CreateInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10),
            Parent = tabContainer
        })
        
        local function updateCanvasSize()
            task.wait(0.05)
            local contentSize = tabLayout.AbsoluteContentSize.Y
            contentScroll.CanvasSize = UDim2.new(0, 0, 0, contentSize + 30)
        end
        
        tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)
        
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
            
            Window.CurrentTab = tabName
            updateCanvasSize()
        end)
        
        AddHoverEffect(tabButton, Theme.ElementBackground, Theme.Tertiary)
        
        local Tab = {
            Name = tabName,
            Button = tabButton,
            Container = tabContainer,
            ActiveIndicator = activeIndicator,
            Elements = {},
            UpdateCanvas = updateCanvasSize
        }
        
        if #Window.Tabs == 0 then
            tabButton.BackgroundColor3 = Theme.Tertiary
            tabContainer.Visible = true
            activeIndicator.Size = UDim2.new(0, 4, 0, 35)
            activeIndicator.Position = UDim2.new(0, 0, 0.5, 0)
            Window.CurrentTab = tabName
            updateCanvasSize()
        end
        
        table.insert(Window.Tabs, Tab)
        
        -- [CONTINUE IN NEXT PART - Tab Elements Functions]
        
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
                Visible = true,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = container
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.ElementBorder,
                Thickness = 1,
                Transparency = 0.7,
                Parent = container
            })
            
            CreateInstance("UIPadding", {
                PaddingAll = UDim.new(0, 12),
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = "📝 " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14 * fontSize,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = true,
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
                TextSize = 12 * fontSize,
                Font = Enum.Font.Gotham,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                Visible = true,
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
                Visible = true,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = container
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.ElementBorder,
                Thickness = 1,
                Transparency = 0.7,
                Parent = container
            })
            
            CreateInstance("UIPadding", {
                PaddingAll = UDim.new(0, 12),
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = "🔘 " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14 * fontSize,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            local button = CreateInstance("TextButton", {
                Size = UDim2.new(1, 0, 0, 36),
                Position = UDim2.new(0, 0, 0, 32),
                BackgroundColor3 = Theme.Accent,
                Text = text,
                TextColor3 = Theme.TextPrimary,
                TextSize = 13 * fontSize,
                Font = Enum.Font.GothamBold,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 7),
                Parent = button
            })
            
            button.MouseButton1Click:Connect(function()
                Tween(button, {Size = UDim2.new(0.98, 0, 0, 34)}, 0.1)
                wait(0.1)
                Tween(button, {Size = UDim2.new(1, 0, 0, 36)}, 0.1)
                
                spawn(function()
                    pcall(callback)
                end)
            end)
            
            AddHoverEffect(button, Theme.Accent, Theme.AccentHover, Theme.AccentPressed)
            
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
                Visible = true,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = container
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.ElementBorder,
                Thickness = 1,
                Transparency = 0.7,
                Parent = container
            })
            
            CreateInstance("UIPadding", {
                PaddingAll = UDim.new(0, 12),
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = "🔄 " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14 * fontSize,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(0.62, 0, 0, 30),
                Position = UDim2.new(0, 0, 0, 32),
                BackgroundTransparency = 1,
                Text = text,
                TextColor3 = Theme.TextSecondary,
                TextSize = 12 * fontSize,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                TextWrapped = true,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            local toggleTrack = CreateInstance("TextButton", {
                Size = UDim2.new(0, 50, 0, 26),
                Position = UDim2.new(1, -50, 0, 38),
                BackgroundColor3 = toggled and Theme.ToggleOn or Theme.ToggleOff,
                Text = "",
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = toggleTrack
            })
            
            local toggleKnob = CreateInstance("Frame", {
                Size = UDim2.new(0, 20, 0, 20),
                Position = toggled and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Theme.TextPrimary,
                ZIndex = 8,
                Parent = toggleTrack
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = toggleKnob
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.TextSecondary,
                Thickness = 1.5,
                Parent = toggleKnob
            })
            
            toggleTrack.MouseButton1Click:Connect(function()
                toggled = not toggled
                
                if toggled then
                    Tween(toggleTrack, {BackgroundColor3 = Theme.ToggleOn}, 0.3)
                    Tween(toggleKnob, {Position = UDim2.new(1, -23, 0.5, 0)}, 0.3, Enum.EasingStyle.Quad)
                else
                    Tween(toggleTrack, {BackgroundColor3 = Theme.ToggleOff}, 0.3)
                    Tween(toggleKnob, {Position = UDim2.new(0, 3, 0.5, 0)}, 0.3, Enum.EasingStyle.Quad)
                end
                
                spawn(function()
                    pcall(function()
                        callback(toggled)
                    end)
                end)
            end)
            
            table.insert(Tab.Elements, container)
            Tab.UpdateCanvas()
            return container
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
                Visible = true,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = container
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.ElementBorder,
                Thickness = 1,
                Transparency = 0.7,
                Parent = container
            })
            
            CreateInstance("UIPadding", {
                PaddingAll = UDim.new(0, 12),
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, -60, 0, 20),
                BackgroundTransparency = 1,
                Text = "🎚️ " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14 * fontSize,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            local valueLabel = CreateInstance("TextLabel", {
                Size = UDim2.new(0, 55, 0, 24),
                Position = UDim2.new(1, -55, 0, 0),
                BackgroundColor3 = Theme.Tertiary,
                Text = tostring(default),
                TextColor3 = Theme.TextPrimary,
                TextSize = 13 * fontSize,
                Font = Enum.Font.GothamBold,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 6),
                Parent = valueLabel
            })
            
            local sliderTrack = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 7),
                Position = UDim2.new(0, 0, 0, 45),
                BackgroundColor3 = Theme.Tertiary,
                BorderSizePixel = 0,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = sliderTrack
            })
            
            local sliderFill = CreateInstance("Frame", {
                Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                BackgroundColor3 = Theme.Accent,
                BorderSizePixel = 0,
                ZIndex = 8,
                Parent = sliderTrack
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = sliderFill
            })
            
            local sliderKnob = CreateInstance("TextButton", {
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new((default - min) / (max - min), -9, 0.5, -9),
                BackgroundColor3 = Theme.TextPrimary,
                BorderSizePixel = 0,
                Text = "",
                Visible = true,
                ZIndex = 9,
                Parent = sliderTrack
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = sliderKnob
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.Accent,
                Thickness = 2,
                Parent = sliderKnob
            })
            
            local dragging = false
            
            sliderKnob.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)
            
            sliderTrack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
                   input.UserInputType == Enum.UserInputType.Touch) then
                    local mousePos = input.Position.X
                    local trackPos = sliderTrack.AbsolutePosition.X
                    local trackSize = sliderTrack.AbsoluteSize.X
                    local relative = math.clamp((mousePos - trackPos) / trackSize, 0, 1)
                    local value = math.floor(min + (max - min) * relative)
                    
                    sliderFill.Size = UDim2.new(relative, 0, 1, 0)
                    sliderKnob.Position = UDim2.new(relative, -9, 0.5, -9)
                    valueLabel.Text = tostring(value)
                    
                    spawn(function()
                        pcall(function()
                            callback(value)
                        end)
                    end)
                end
            end)
            
            AddHoverEffect(sliderKnob, Theme.TextPrimary, Theme.TextSecondary)
            
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
                Visible = true,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = container
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.ElementBorder,
                Thickness = 1,
                Transparency = 0.7,
                Parent = container
            })
            
            CreateInstance("UIPadding", {
                PaddingAll = UDim.new(0, 12),
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = "✏️ " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14 * fontSize,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = true,
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
                TextSize = 13 * fontSize,
                Font = Enum.Font.Gotham,
                ClearTextOnFocus = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 7),
                Parent = textBox
            })
            
            CreateInstance("UIPadding", {
                PaddingLeft = UDim.new(0, 10),
                PaddingRight = UDim.new(0, 10),
                Parent = textBox
            })
            
            local textBoxStroke = CreateInstance("UIStroke", {
                Color = Theme.ElementBorder,
                Thickness = 1.5,
                Transparency = 0.5,
                Parent = textBox
            })
            
            textBox.Focused:Connect(function()
                Tween(textBoxStroke, {Color = Theme.Accent, Transparency = 0}, 0.2)
            end)
            
            textBox.FocusLost:Connect(function(enterPressed)
                Tween(textBoxStroke, {Color = Theme.ElementBorder, Transparency = 0.5}, 0.2)
                
                if enterPressed then
                    spawn(function()
                        pcall(function()
                            callback(textBox.Text)
                        end)
                    end)
                end
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
                Visible = true,
                ClipsDescendants = false,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = container
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.ElementBorder,
                Thickness = 1,
                Transparency = 0.7,
                Parent = container
            })
            
            CreateInstance("UIPadding", {
                PaddingAll = UDim.new(0, 12),
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = "📋 " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14 * fontSize,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            local dropdownButton = CreateInstance("TextButton", {
                Size = UDim2.new(1, 0, 0, 36),
                Position = UDim2.new(0, 0, 0, 32),
                BackgroundColor3 = Theme.Tertiary,
                Text = "",
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 7),
                Parent = dropdownButton
            })
            
            local dropdownLabel = CreateInstance("TextLabel", {
                Size = UDim2.new(1, -35, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Text = selectedItem,
                TextColor3 = Theme.TextPrimary,
                TextSize = 12 * fontSize,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Visible = true,
                ZIndex = 8,
                Parent = dropdownButton
            })
            
            local arrowIcon = CreateInstance("TextLabel", {
                Size = UDim2.new(0, 25, 1, 0),
                Position = UDim2.new(1, -25, 0, 0),
                BackgroundTransparency = 1,
                Text = "▼",
                TextColor3 = Theme.TextSecondary,
                TextSize = 11 * fontSize,
                Font = Enum.Font.Gotham,
                Visible = true,
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
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 7),
                Parent = dropdownList
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.Accent,
                Thickness = 1.5,
                Parent = dropdownList
            })
            
            local listLayout = CreateInstance("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 2),
                Parent = dropdownList
            })
            
            CreateInstance("UIPadding", {
                PaddingAll = UDim.new(0, 4),
                Parent = dropdownList
            })
            
            listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                dropdownList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 8)
            end)
            
            for i, item in ipairs(items) do
                local itemButton = CreateInstance("TextButton", {
                    Size = UDim2.new(1, -8, 0, 32),
                    BackgroundColor3 = Theme.ElementBackground,
                    Text = "",
                    ZIndex = 101,
                    Parent = dropdownList
                })
                
                CreateInstance("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = itemButton
                })
                
                CreateInstance("TextLabel", {
                    Size = UDim2.new(1, -10, 1, 0),
                    Position = UDim2.new(0, 8, 0, 0),
                    BackgroundTransparency = 1,
                    Text = item,
                    TextColor3 = Theme.TextPrimary,
                    TextSize = 11 * fontSize,
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
                    
                    Tween(container, {Size = UDim2.new(1, 0, 0, 80)}, animationSpeed)
                    Tween(dropdownList, {Size = UDim2.new(1, 0, 0, 0)}, animationSpeed)
                    Tween(arrowIcon, {Rotation = 0}, animationSpeed)
                    
                    wait(animationSpeed)
                    dropdownList.Visible = false
                    Tab.UpdateCanvas()
                    
                    spawn(function()
                        pcall(function()
                            callback(item)
                        end)
                    end)
                end)
                
                AddHoverEffect(itemButton, Theme.ElementBackground, Theme.ElementBorder)
            end
            
            dropdownButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                
                if isOpen then
                    dropdownList.Visible = true
                    local maxHeight = math.min(#items * 34, 140)
                    
                    Tween(container, {Size = UDim2.new(1, 0, 0, 80 + maxHeight + 8)}, animationSpeed, Enum.EasingStyle.Back)
                    Tween(dropdownList, {Size = UDim2.new(1, 0, 0, maxHeight)}, animationSpeed, Enum.EasingStyle.Back)
                    Tween(arrowIcon, {Rotation = 180}, animationSpeed)
                    
                    task.wait(animationSpeed)
                    Tab.UpdateCanvas()
                else
                    Tween(container, {Size = UDim2.new(1, 0, 0, 80)}, animationSpeed)
                    Tween(dropdownList, {Size = UDim2.new(1, 0, 0, 0)}, animationSpeed)
                    Tween(arrowIcon, {Rotation = 0}, animationSpeed)
                    
                    wait(animationSpeed)
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
    
    -- Open window automatically
    Tween(mainFrame, {Size = windowSize}, 0.5, Enum.EasingStyle.Back)
    
    return Window
end

return DrakthonLib
