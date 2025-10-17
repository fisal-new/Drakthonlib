--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║                  DRAKTHON UI LIBRARY V8.0                    ║
    ║              ULTIMATE COMPLETE - EVERYTHING WORKS             ║
    ║    ✅ Full Loader + Settings + Theme Changer + Bug Fixed    ║
    ╚══════════════════════════════════════════════════════════════╝
]]

local DrakthonLib = {}

-- ═══════════════════════════════════════════════════════════════
-- THEMES - 12 COMPLETE THEMES
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
            warn("[Drakthon] Duplicate UI detected! ID: " .. antiDupId)
            return true
        end
    end
    
    return false
end

-- ═══════════════════════════════════════════════════════════════
-- MAIN WINDOW FUNCTION
-- ═══════════════════════════════════════════════════════════════

function DrakthonLib:MakeWindow(options)
    options = options or {}
    
    -- Anti-Duplicate
    local antiDupId = options.AntiDuplicate or ""
    if CheckDuplicate(antiDupId) then
        return nil
    end
    
    -- Configuration
    local windowName = options.Name or "Drakthon Library"
    local themeName = options.Theme or "Default"
    local windowSize = options.Size or UDim2.new(0, 550, 0, 350)
    
    -- Loader Settings
    local LoaderConfig = {
        Enabled = options.LoaderEnabled ~= false,
        MainImage = options.LoaderImage or "rbxassetid://11422155687",
        MinimizeIcon = options.LoaderMinimizeIcon or "rbxassetid://10734950309",
        Position = options.LoaderPosition or UDim2.new(0, 20, 1, -90),
        Size = options.LoaderSize or UDim2.new(0, 70, 0, 70),
    }
    
    -- Theme
    local Theme = Themes[themeName] or Themes.Default
    local CurrentThemeName = themeName
    
    -- ═══════════════════════════════════════════════════════════
    -- SCREEN GUI
    -- ═══════════════════════════════════════════════════════════
    local screenGui = CreateInstance("ScreenGui", {
        Name = "DrakthonLib_" .. tick(),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = PlayerGui
    })
    
    if antiDupId ~= "" then
        screenGui:SetAttribute("DrakthonID", antiDupId)
    end
    
    -- ═══════════════════════════════════════════════════════════
    -- LOADER WITH SETTINGS
    -- ═══════════════════════════════════════════════════════════
    local loaderFrame = CreateInstance("Frame", {
        Name = "LoaderFrame",
        Size = UDim2.new(0, 280, 0, 350),
        Position = LoaderConfig.Position,
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = Theme.Secondary,
        Visible = false,
        ZIndex = 100,
        Parent = screenGui
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = loaderFrame
    })
    
    CreateInstance("UIStroke", {
        Color = Theme.Accent,
        Thickness = 2,
        Parent = loaderFrame
    })
    
    -- Loader Header
    local loaderHeader = CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Theme.Tertiary,
        ZIndex = 101,
        Parent = loaderFrame
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = loaderHeader
    })
    
    CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 15),
        Position = UDim2.new(0, 0, 1, -15),
        BackgroundColor3 = Theme.Tertiary,
        ZIndex = 101,
        Parent = loaderHeader
    })
    
    CreateInstance("TextLabel", {
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = "⚙️ " .. windowName,
        TextColor3 = Theme.TextPrimary,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 102,
        Parent = loaderHeader
    })
    
    -- Close Loader Button
    local closeLoaderBtn = CreateInstance("TextButton", {
        Size = UDim2.new(0, 30, 0, 26),
        Position = UDim2.new(1, -38, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.Error,
        Text = "✕",
        TextColor3 = Theme.TextPrimary,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        ZIndex = 102,
        Parent = loaderHeader
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = closeLoaderBtn
    })
    
    -- Loader Content
    local loaderContent = CreateInstance("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, -40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.ElementBorder,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ZIndex = 101,
        Parent = loaderFrame
    })
    
    local loaderLayout = CreateInstance("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        Parent = loaderContent
    })
    
    CreateInstance("UIPadding", {
        PaddingAll = UDim.new(0, 12),
        Parent = loaderContent
    })
    
    loaderLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        loaderContent.CanvasSize = UDim2.new(0, 0, 0, loaderLayout.AbsoluteContentSize.Y + 24)
    end)
    
    -- Loader Image Display
    local loaderImageDisplay = CreateInstance("ImageLabel", {
        Size = UDim2.new(1, 0, 0, 120),
        BackgroundColor3 = Theme.ElementBackground,
        Image = LoaderConfig.MainImage,
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 102,
        LayoutOrder = 1,
        Parent = loaderContent
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = loaderImageDisplay
    })
    
    CreateInstance("UIPadding", {
        PaddingAll = UDim.new(0, 10),
        Parent = loaderImageDisplay
    })
    
    -- Theme Selector in Loader
    local themeFrame = CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 70),
        BackgroundColor3 = Theme.ElementBackground,
        LayoutOrder = 2,
        ZIndex = 102,
        Parent = loaderContent
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = themeFrame
    })
    
    CreateInstance("UIPadding", {
        PaddingAll = UDim.new(0, 10),
        Parent = themeFrame
    })
    
    CreateInstance("TextLabel", {
        Size = UDim2.new(1, 0, 0, 18),
        BackgroundTransparency = 1,
        Text = "🎨 Select Theme",
        TextColor3 = Theme.TextPrimary,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 103,
        Parent = themeFrame
    })
    
    local themeDropdown = CreateInstance("TextButton", {
        Size = UDim2.new(1, 0, 0, 32),
        Position = UDim2.new(0, 0, 0, 28),
        BackgroundColor3 = Theme.Tertiary,
        Text = "",
        ZIndex = 103,
        Parent = themeFrame
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = themeDropdown
    })
    
    local themeLabel = CreateInstance("TextLabel", {
        Size = UDim2.new(1, -30, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = CurrentThemeName,
        TextColor3 = Theme.TextPrimary,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 104,
        Parent = themeDropdown
    })
    
    local themeArrow = CreateInstance("TextLabel", {
        Size = UDim2.new(0, 20, 1, 0),
        Position = UDim2.new(1, -20, 0, 0),
        BackgroundTransparency = 1,
        Text = "▼",
        TextColor3 = Theme.TextSecondary,
        TextSize = 10,
        ZIndex = 104,
        Parent = themeDropdown
    })
    
    local themeList = CreateInstance("ScrollingFrame", {
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 1, 5),
        BackgroundColor3 = Theme.Tertiary,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.ElementBorder,
        Visible = false,
        ZIndex = 200,
        Parent = themeDropdown
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = themeList
    })
    
    CreateInstance("UIStroke", {
        Color = Theme.Accent,
        Thickness = 1.5,
        Parent = themeList
    })
    
    local themeListLayout = CreateInstance("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2),
        Parent = themeList
    })
    
    CreateInstance("UIPadding", {
        PaddingAll = UDim.new(0, 4),
        Parent = themeList
    })
    
    -- Open UI Button in Loader
    local openUIBtn = CreateInstance("TextButton", {
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundColor3 = Theme.Accent,
        Text = "🚀 Open UI",
        TextColor3 = Theme.TextPrimary,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        LayoutOrder = 3,
        ZIndex = 102,
        Parent = loaderContent
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = openUIBtn
    })
    
    MakeDraggable(loaderFrame, loaderHeader)
    
    -- Minimize Icon (Small)
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
    
    CreateInstance("UIStroke", {
        Color = Theme.Accent,
        Thickness = 2,
        Parent = minimizeIcon
    })
    
    CreateInstance("UIPadding", {
        PaddingAll = UDim.new(0, 8),
        Parent = minimizeIcon
    })
    
    MakeDraggable(minimizeIcon, minimizeIcon)
    
    -- ═══════════════════════════════════════════════════════════
    -- MAIN WINDOW
    -- ═══════════════════════════════════════════════════════════
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
        Parent = mainFrame
    })
    
    -- Title Bar
    local titleBar = CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Theme.Secondary,
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
    
    -- Close Button
    local closeBtn = CreateInstance("TextButton", {
        Size = UDim2.new(0, 35, 0, 26),
        Position = UDim2.new(1, -42, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.Error,
        Text = "✕",
        TextColor3 = Theme.TextPrimary,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        ZIndex = 4,
        Parent = titleBar
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = closeBtn
    })
    
    -- Sidebar
    local sidebar = CreateInstance("Frame", {
        Size = UDim2.new(0, 165, 1, -40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundColor3 = Theme.Secondary,
        ZIndex = 3,
        Parent = mainFrame
    })
    
    local tabsContainer = CreateInstance("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
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
        ZIndex = 3,
        ClipsDescendants = true,
        Parent = mainFrame
    })
    
    local contentScroll = CreateInstance("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
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
    
    -- ═══════════════════════════════════════════════════════════
    -- WINDOW OBJECT
    -- ═══════════════════════════════════════════════════════════
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        Theme = Theme,
        ThemeName = CurrentThemeName,
        Elements = {
            MainFrame = mainFrame,
            TitleBar = titleBar,
            TitleLabel = titleLabel,
            Sidebar = sidebar,
            ContentArea = contentArea,
            MinimizeBtn = minimizeBtn,
            CloseBtn = closeBtn,
        }
    }
    
    -- Apply Theme Function
    function Window:ApplyTheme(newTheme)
        Theme = newTheme
        
        -- Update all elements
        mainFrame.BackgroundColor3 = Theme.Background
        titleBar.BackgroundColor3 = Theme.Secondary
        titleLabel.TextColor3 = Theme.TextPrimary
        sidebar.BackgroundColor3 = Theme.Secondary
        contentArea.BackgroundColor3 = Theme.Background
        minimizeBtn.BackgroundColor3 = Theme.ElementBackground
        minimizeBtn.TextColor3 = Theme.TextPrimary
        closeBtn.BackgroundColor3 = Theme.Error
        closeBtn.TextColor3 = Theme.TextPrimary
        
        -- Update loader
        loaderFrame.BackgroundColor3 = Theme.Secondary
        loaderHeader.BackgroundColor3 = Theme.Tertiary
        minimizeIcon.BackgroundColor3 = Theme.Secondary
        openUIBtn.BackgroundColor3 = Theme.Accent
        themeFrame.BackgroundColor3 = Theme.ElementBackground
        themeDropdown.BackgroundColor3 = Theme.Tertiary
        
        -- Update strokes
        for _, obj in pairs(mainFrame:GetDescendants()) do
            if obj:IsA("UIStroke") then
                if obj.Parent == mainFrame then
                    obj.Color = Theme.ElementBorder
                elseif obj.Parent.Name:find("Loader") or obj.Parent.Parent.Name:find("Loader") then
                    obj.Color = Theme.Accent
                end
            end
        end
        
        -- Update all tabs
        for _, tab in pairs(Window.Tabs) do
            tab.Button.BackgroundColor3 = Theme.ElementBackground
            tab.ActiveIndicator.BackgroundColor3 = Theme.Accent
            
            -- Update tab elements
            for _, element in pairs(tab.Container:GetDescendants()) do
                if element:IsA("Frame") and element.Name:find("container") or element.Parent.Name:find("Container") then
                    element.BackgroundColor3 = Theme.ElementBackground
                elseif element:IsA("TextButton") and element.Parent.Parent.Name:find("Container") then
                    if element.Name:find("toggle") then
                        -- Will be handled by toggle logic
                    else
                        element.BackgroundColor3 = Theme.Accent
                        element.TextColor3 = Theme.TextPrimary
                    end
                elseif element:IsA("TextLabel") then
                    if element.Parent.Name:find("Title") or element.Parent:IsA("Frame") then
                        element.TextColor3 = Theme.TextPrimary
                    else
                        element.TextColor3 = Theme.TextSecondary
                    end
                elseif element:IsA("TextBox") then
                    element.BackgroundColor3 = Theme.Tertiary
                    element.TextColor3 = Theme.TextPrimary
                    element.PlaceholderColor3 = Theme.TextMuted
                end
            end
        end
        
        Window.Theme = Theme
    end
    
    -- Create Theme List Items
    local themeNames = {}
    for name, _ in pairs(Themes) do
        table.insert(themeNames, name)
    end
    table.sort(themeNames)
    
    for _, themeName in ipairs(themeNames) do
        local themeItem = CreateInstance("TextButton", {
            Size = UDim2.new(1, -8, 0, 30),
            BackgroundColor3 = Theme.ElementBackground,
            Text = "",
            ZIndex = 201,
            Parent = themeList
        })
        
        CreateInstance("UICorner", {
            CornerRadius = UDim.new(0, 4),
            Parent = themeItem
        })
        
        CreateInstance("TextLabel", {
            Size = UDim2.new(1, -10, 1, 0),
            Position = UDim2.new(0, 10, 0, 0),
            BackgroundTransparency = 1,
            Text = themeName,
            TextColor3 = Theme.TextPrimary,
            TextSize = 11,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 202,
            Parent = themeItem
        })
        
        themeItem.MouseButton1Click:Connect(function()
            CurrentThemeName = themeName
            themeLabel.Text = themeName
            Window.ThemeName = themeName
            Window:ApplyTheme(Themes[themeName])
            
            Tween(themeList, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
            Tween(themeArrow, {Rotation = 0}, 0.3)
            wait(0.3)
            themeList.Visible = false
        end)
        
        AddHoverEffect(themeItem, Theme.ElementBackground, Theme.Tertiary)
    end
    
    themeListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        themeList.CanvasSize = UDim2.new(0, 0, 0, themeListLayout.AbsoluteContentSize.Y + 8)
    end)
    
    local themeListOpen = false
    themeDropdown.MouseButton1Click:Connect(function()
        themeListOpen = not themeListOpen
        
        if themeListOpen then
            themeList.Visible = true
            local maxHeight = math.min(#themeNames * 32, 150)
            Tween(themeList, {Size = UDim2.new(1, 0, 0, maxHeight)}, 0.3, Enum.EasingStyle.Back)
            Tween(themeArrow, {Rotation = 180}, 0.3)
        else
            Tween(themeList, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
            Tween(themeArrow, {Rotation = 0}, 0.3)
            wait(0.3)
            themeList.Visible = false
        end
    end)
    
    -- Button Interactions
    AddHoverEffect(minimizeBtn, Theme.ElementBackground, Theme.Tertiary)
    AddHoverEffect(closeBtn, Theme.Error, Color3.fromRGB(255, 91, 91))
    AddHoverEffect(minimizeIcon, Theme.Secondary, Theme.Tertiary)
    AddHoverEffect(closeLoaderBtn, Theme.Error, Color3.fromRGB(255, 91, 91))
    AddHoverEffect(openUIBtn, Theme.Accent, Theme.AccentHover, Theme.AccentPressed)
    AddHoverEffect(themeDropdown, Theme.Tertiary, Theme.ElementBorder)
    
    minimizeBtn.MouseButton1Click:Connect(function()
        Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        mainFrame.Visible = false
        minimizeIcon.Visible = true
        Tween(minimizeIcon, {Size = LoaderConfig.Size}, 0.3, Enum.EasingStyle.Back)
    end)
    
    minimizeIcon.MouseButton1Click:Connect(function()
        loaderFrame.Visible = true
        Tween(loaderFrame, {Size = UDim2.new(0, 280, 0, 350)}, 0.3, Enum.EasingStyle.Back)
        Tween(minimizeIcon, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        minimizeIcon.Visible = false
    end)
    
    openUIBtn.MouseButton1Click:Connect(function()
        Tween(loaderFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        loaderFrame.Visible = false
        mainFrame.Visible = true
        Tween(mainFrame, {Size = windowSize}, 0.4, Enum.EasingStyle.Back)
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        screenGui:Destroy()
    end)
    
    closeLoaderBtn.MouseButton1Click:Connect(function()
        Tween(loaderFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        loaderFrame.Visible = false
        minimizeIcon.Visible = true
        Tween(minimizeIcon, {Size = LoaderConfig.Size}, 0.3, Enum.EasingStyle.Back)
    end)
    
    -- Make Tab Function
    function Window:MakeTab(options)
        options = options or {}
        local tabName = options.Name or "Tab"
        local tabIcon = options.Icon or ""
        
        local tabButton = CreateInstance("TextButton", {
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundColor3 = Theme.ElementBackground,
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
        
        -- ADD ELEMENTS TO TAB
        function Tab:AddButton(options)
            options = options or {}
            local title = options.Title or "Button"
            local text = options.Text or "Click"
            local callback = options.Callback or function() end
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 80),
                BackgroundColor3 = Theme.ElementBackground,
                LayoutOrder = #Tab.Elements + 1,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = container})
            CreateInstance("UIStroke", {Color = Theme.ElementBorder, Thickness = 1, Parent = container})
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
            local default = options.Default or false
            local callback = options.Callback or function() end
            
            local toggled = default
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 70),
                BackgroundColor3 = Theme.ElementBackground,
                LayoutOrder = #Tab.Elements + 1,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = container})
            CreateInstance("UIStroke", {Color = Theme.ElementBorder, Thickness = 1, Parent = container})
            CreateInstance("UIPadding", {PaddingAll = UDim.new(0, 12), Parent = container})
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, -60, 1, 0),
                BackgroundTransparency = 1,
                Text = "🔄 " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                ZIndex = 7,
                Parent = container
            })
            
            local toggleBtn = CreateInstance("TextButton", {
                Size = UDim2.new(0, 50, 0, 26),
                Position = UDim2.new(1, -50, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
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
                ZIndex = 8,
                Parent = toggleBtn
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = knob})
            
            toggleBtn.MouseButton1Click:Connect(function()
                toggled = not toggled
                Tween(toggleBtn, {BackgroundColor3 = toggled and Theme.ToggleOn or Theme.ToggleOff}, 0.3)
                Tween(knob, {Position = toggled and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)}, 0.3)
                pcall(function() callback(toggled) end)
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
                LayoutOrder = #Tab.Elements + 1,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = container})
            CreateInstance("UIStroke", {Color = Theme.ElementBorder, Thickness = 1, Parent = container})
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
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = track})
            
            local fill = CreateInstance("Frame", {
                Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                BackgroundColor3 = Theme.Accent,
                ZIndex = 8,
                Parent = track
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = fill})
            
            local dragging = false
            
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
                    valueLabel.Text = tostring(value)
                    pcall(function() callback(value) end)
                end
            end)
            
            table.insert(Tab.Elements, container)
            Tab.UpdateCanvas()
            return container
        end
        
        function Tab:AddTextBox(options)
            options = options or {}
            local title = options.Title or "TextBox"
            local placeholder = options.Placeholder or "Type..."
            local default = options.Default or ""
            local callback = options.Callback or function() end
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 80),
                BackgroundColor3 = Theme.ElementBackground,
                LayoutOrder = #Tab.Elements + 1,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = container})
            CreateInstance("UIStroke", {Color = Theme.ElementBorder, Thickness = 1, Parent = container})
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
            
            local stroke = CreateInstance("UIStroke", {Color = Theme.ElementBorder, Thickness = 1.5, Parent = textBox})
            
            textBox.Focused:Connect(function()
                Tween(stroke, {Color = Theme.Accent}, 0.2)
            end)
            
            textBox.FocusLost:Connect(function(enter)
                Tween(stroke, {Color = Theme.ElementBorder}, 0.2)
                if enter then pcall(function() callback(textBox.Text) end) end
            end)
            
            table.insert(Tab.Elements, container)
            Tab.UpdateCanvas()
            return textBox
        end
        
        function Tab:AddParagraph(options)
            options = options or {}
            local title = options.Title or "Info"
            local text = options.Text or "Text"
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = Theme.ElementBackground,
                LayoutOrder = #Tab.Elements + 1,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = container})
            CreateInstance("UIStroke", {Color = Theme.ElementBorder, Thickness = 1, Parent = container})
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
        
        return Tab
    end
    
    -- Open UI
    Tween(mainFrame, {Size = windowSize}, 0.5, Enum.EasingStyle.Back)
    
    return Window
end

return DrakthonLib
