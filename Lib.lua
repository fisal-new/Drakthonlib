--[[
    ════════════════════════════════════════════════════════
                    UI LIBRARY - COMPLETE
                      Version 9.0.0
    ════════════════════════════════════════════════════════
    
    Features:
    ✓ 15 Themes
    ✓ Responsive Design
    ✓ All UI Elements
    ✓ Config System
    ✓ Mobile & PC Support
    ✓ Easy to Use
    
    ════════════════════════════════════════════════════════
]]

local Library = {}
Library.Version = "9.0.0"
Library.Flags = {}
Library.Options = {}
Library.ThemeObjects = {}

-- ════════════════════════════════════════════════════════
-- CONFIG
-- ════════════════════════════════════════════════════════

Library.Config = {
    UI = {
        Animations = true,
        AnimationSpeed = 0.2,
        Font = Enum.Font.Gotham,
        TextSize = 13,
    },
    
    Theme = {
        Background = Color3.fromRGB(15, 15, 20),
        SecondaryBG = Color3.fromRGB(25, 25, 30),
        TertiaryBG = Color3.fromRGB(30, 30, 38),
        Accent = Color3.fromRGB(138, 43, 226),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(180, 180, 190),
        Border = Color3.fromRGB(45, 45, 55),
        Shadow = Color3.fromRGB(0, 0, 0),
    },
    
    ConfigFolder = "UIConfigs",
}

-- ════════════════════════════════════════════════════════
-- SERVICES
-- ════════════════════════════════════════════════════════

local Services = setmetatable({}, {
    __index = function(t, k)
        local s = game:GetService(k)
        rawset(t, k, s)
        return s
    end
})

local Player = Services.Players.LocalPlayer
local IsMobile = Services.UserInputService.TouchEnabled and not Services.UserInputService.KeyboardEnabled

-- ════════════════════════════════════════════════════════
-- THEMES (15 THEMES)
-- ════════════════════════════════════════════════════════

Library.Themes = {
    Default = {
        Accent = Color3.fromRGB(138, 43, 226),
        Background = Color3.fromRGB(15, 15, 20),
        SecondaryBG = Color3.fromRGB(25, 25, 30),
        TertiaryBG = Color3.fromRGB(30, 30, 38),
    },
    Midnight = {
        Accent = Color3.fromRGB(30, 136, 229),
        Background = Color3.fromRGB(10, 10, 15),
        SecondaryBG = Color3.fromRGB(15, 15, 22),
        TertiaryBG = Color3.fromRGB(20, 20, 28),
    },
    Ocean = {
        Accent = Color3.fromRGB(52, 152, 219),
        Background = Color3.fromRGB(10, 20, 30),
        SecondaryBG = Color3.fromRGB(15, 28, 40),
        TertiaryBG = Color3.fromRGB(20, 35, 48),
    },
    Sunset = {
        Accent = Color3.fromRGB(255, 107, 107),
        Background = Color3.fromRGB(25, 15, 20),
        SecondaryBG = Color3.fromRGB(32, 20, 28),
        TertiaryBG = Color3.fromRGB(38, 25, 32),
    },
    Forest = {
        Accent = Color3.fromRGB(46, 204, 113),
        Background = Color3.fromRGB(15, 25, 15),
        SecondaryBG = Color3.fromRGB(20, 32, 20),
        TertiaryBG = Color3.fromRGB(25, 38, 25),
    },
    Rose = {
        Accent = Color3.fromRGB(255, 105, 180),
        Background = Color3.fromRGB(25, 15, 20),
        SecondaryBG = Color3.fromRGB(32, 20, 28),
        TertiaryBG = Color3.fromRGB(38, 25, 32),
    },
    Mint = {
        Accent = Color3.fromRGB(26, 188, 156),
        Background = Color3.fromRGB(15, 25, 23),
        SecondaryBG = Color3.fromRGB(20, 32, 30),
        TertiaryBG = Color3.fromRGB(25, 38, 35),
    },
    Cherry = {
        Accent = Color3.fromRGB(220, 20, 60),
        Background = Color3.fromRGB(20, 12, 15),
        SecondaryBG = Color3.fromRGB(28, 18, 22),
        TertiaryBG = Color3.fromRGB(35, 22, 28),
    },
    Gold = {
        Accent = Color3.fromRGB(255, 215, 0),
        Background = Color3.fromRGB(20, 18, 10),
        SecondaryBG = Color3.fromRGB(28, 25, 15),
        TertiaryBG = Color3.fromRGB(35, 30, 18),
    },
    Cyber = {
        Accent = Color3.fromRGB(0, 255, 255),
        Background = Color3.fromRGB(10, 10, 15),
        SecondaryBG = Color3.fromRGB(15, 15, 22),
        TertiaryBG = Color3.fromRGB(18, 18, 28),
    },
    Toxic = {
        Accent = Color3.fromRGB(0, 255, 0),
        Background = Color3.fromRGB(8, 15, 8),
        SecondaryBG = Color3.fromRGB(12, 22, 12),
        TertiaryBG = Color3.fromRGB(15, 28, 15),
    },
    Royal = {
        Accent = Color3.fromRGB(147, 51, 234),
        Background = Color3.fromRGB(18, 10, 25),
        SecondaryBG = Color3.fromRGB(25, 15, 35),
        TertiaryBG = Color3.fromRGB(30, 18, 42),
    },
    Blood = {
        Accent = Color3.fromRGB(139, 0, 0),
        Background = Color3.fromRGB(18, 8, 8),
        SecondaryBG = Color3.fromRGB(25, 12, 12),
        TertiaryBG = Color3.fromRGB(32, 15, 15),
    },
    Ice = {
        Accent = Color3.fromRGB(135, 206, 250),
        Background = Color3.fromRGB(12, 15, 20),
        SecondaryBG = Color3.fromRGB(18, 22, 28),
        TertiaryBG = Color3.fromRGB(22, 28, 35),
    },
    Dark = {
        Accent = Color3.fromRGB(100, 100, 110),
        Background = Color3.fromRGB(8, 8, 10),
        SecondaryBG = Color3.fromRGB(12, 12, 15),
        TertiaryBG = Color3.fromRGB(15, 15, 18),
    },
}

function Library:SetTheme(themeName)
    local theme = self.Themes[themeName]
    if not theme then return false end
    
    self.Config.Theme.Accent = theme.Accent
    self.Config.Theme.Background = theme.Background
    self.Config.Theme.SecondaryBG = theme.SecondaryBG
    self.Config.Theme.TertiaryBG = theme.TertiaryBG
    
    for _, obj in pairs(self.ThemeObjects) do
        if obj and obj.Parent then
            local t = obj:GetAttribute("ThemeType")
            if t == "Accent" then obj.BackgroundColor3 = theme.Accent
            elseif t == "Background" then obj.BackgroundColor3 = theme.Background
            elseif t == "SecondaryBG" then obj.BackgroundColor3 = theme.SecondaryBG
            elseif t == "TertiaryBG" then obj.BackgroundColor3 = theme.TertiaryBG
            elseif t == "AccentText" then obj.TextColor3 = theme.Accent
            elseif t == "AccentImage" then obj.ImageColor3 = theme.Accent
            elseif t == "AccentStroke" then obj.Color = theme.Accent
            end
        end
    end
    
    return true
end

function Library:RegisterTheme(obj, type)
    obj:SetAttribute("ThemeType", type)
    table.insert(self.ThemeObjects, obj)
end

function Library:GetThemeNames()
    local names = {}
    for name in pairs(self.Themes) do
        table.insert(names, name)
    end
    table.sort(names)
    return names
end

-- ════════════════════════════════════════════════════════
-- UTILITIES
-- ════════════════════════════════════════════════════════

local Utility = {}

function Utility:Tween(obj, props, time, style, dir)
    if not obj or not obj.Parent then return end
    
    if not Library.Config.UI.Animations then
        for k, v in pairs(props) do obj[k] = v end
        return
    end
    
    local tween = Services.TweenService:Create(
        obj,
        TweenInfo.new(time or 0.2, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out),
        props
    )
    tween:Play()
    return tween
end

function Utility:MakeDraggable(gui, handle)
    handle = handle or gui
    local dragging, dragInput, dragStart, startPos
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    Services.UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

function Utility:Create(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        if k ~= "Parent" then
            obj[k] = v
        end
    end
    obj.Parent = props.Parent
    return obj
end

function Utility:Corner(parent, radius)
    return Utility:Create("UICorner", {CornerRadius = UDim.new(0, radius or 8), Parent = parent})
end

function Utility:Stroke(parent, color, thickness, transparency)
    return Utility:Create("UIStroke", {
        Color = color or Library.Config.Theme.Border,
        Thickness = thickness or 1,
        Transparency = transparency or 0.5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent
    })
end

function Utility:Shadow(parent, size)
    return Utility:Create("ImageLabel", {
        Name = "Shadow",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, -(size or 15), 0, -(size or 15)),
        Size = UDim2.new(1, (size or 15) * 2, 1, (size or 15) * 2),
        ZIndex = (parent.ZIndex or 1) - 1,
        Image = "rbxassetid://6015897843",
        ImageColor3 = Library.Config.Theme.Shadow,
        ImageTransparency = 0.4,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(49, 49, 450, 450),
        Parent = parent
    })
end

function Utility:Ripple(button)
    button.ClipsDescendants = true
    button.MouseButton1Click:Connect(function()
        local ripple = Utility:Create("ImageLabel", {
            BackgroundTransparency = 1,
            Image = "rbxassetid://3570695787",
            ImageColor3 = Library.Config.Theme.Accent,
            ImageTransparency = 0.5,
            ZIndex = button.ZIndex + 1,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(0, 0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Parent = button
        })
        
        local mouse = Services.UserInputService:GetMouseLocation()
        local pos = mouse - button.AbsolutePosition
        ripple.Position = UDim2.new(0, pos.X, 0, pos.Y)
        
        local size = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2
        Utility:Tween(ripple, {Size = UDim2.new(0, size, 0, size), ImageTransparency = 1}, 0.5)
        task.delay(0.5, function() ripple:Destroy() end)
    end)
end

-- ════════════════════════════════════════════════════════
-- CONFIG SYSTEM
-- ════════════════════════════════════════════════════════

function Library:SaveConfig(name)
    name = name or "Config"
    pcall(function()
        if not isfolder(self.Config.ConfigFolder) then
            makefolder(self.Config.ConfigFolder)
        end
        writefile(self.Config.ConfigFolder .. "/" .. name .. ".json", Services.HttpService:JSONEncode({
            Version = self.Version,
            Flags = self.Flags,
            Time = os.date("%Y-%m-%d %H:%M:%S"),
        }))
    end)
end

function Library:LoadConfig(name)
    name = name or "Config"
    local success, data = pcall(function()
        return Services.HttpService:JSONDecode(readfile(self.Config.ConfigFolder .. "/" .. name .. ".json"))
    end)
    
    if success and data then
        for flag, value in pairs(data.Flags or {}) do
            if self.Options[flag] then
                pcall(function() self.Options[flag]:Set(value) end)
            end
        end
        self.Flags = data.Flags or {}
        return true
    end
    return false
end

function Library:GetConfigs()
    local configs = {}
    pcall(function()
        if not isfolder(self.Config.ConfigFolder) then
            makefolder(self.Config.ConfigFolder)
        end
        for _, file in ipairs(listfiles(self.Config.ConfigFolder)) do
            if file:match("%.json$") then
                local name = file:match("([^/\```+)%.json$")
                if name then table.insert(configs, name) end
            end
        end
    end)
    return configs
end

function Library:DeleteConfig(name)
    return pcall(function()
        delfile(self.Config.ConfigFolder .. "/" .. name .. ".json")
    end)
end

-- ════════════════════════════════════════════════════════
-- CREATE WINDOW
-- ════════════════════════════════════════════════════════

function Library:CreateWindow(config)
    config = config or {}
    
    -- Settings
    local title = config.Title or "UI Library"
    local subtitle = config.Subtitle or "v" .. self.Version
    local keybind = config.Keybind or Enum.KeyCode.RightControl
    local icon = config.Icon or "rbxassetid://11963374911"
    local showMax = config.ShowMaximize ~= false
    
    -- Size
    local vp = workspace.CurrentCamera.ViewportSize
    local w = IsMobile and math.clamp(vp.X * 0.95, 340, 500) or math.clamp(vp.X * 0.5, 600, 800)
    local h = IsMobile and math.clamp(vp.Y * 0.88, 480, 750) or math.clamp(vp.Y * 0.7, 500, 700)
    
    -- GUI
    local gui = Utility:Create("ScreenGui", {
        Name = "UILib",
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        DisplayOrder = 100,
        IgnoreGuiInset = true,
        Parent = gethui and gethui() or Services.CoreGui
    })
    
    -- Minimize Box
    local miniBox = Utility:Create("Frame", {
        Name = "MiniBox",
        BackgroundColor3 = Library.Config.Theme.SecondaryBG,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Visible = false,
        Parent = gui
    })
    
    Library:RegisterTheme(miniBox, "SecondaryBG")
    Utility:Corner(miniBox, 16)
    Utility:Shadow(miniBox, 20)
    local miniStroke = Utility:Stroke(miniBox, Library.Config.Theme.Accent, 2, 0.3)
    Library:RegisterTheme(miniStroke, "AccentStroke")
    Utility:MakeDraggable(miniBox)
    
    local miniIcon = Utility:Create("ImageLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 50, 0, 50),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Image = icon,
        ImageColor3 = Library.Config.Theme.Accent,
        Parent = miniBox
    })
    
    Library:RegisterTheme(miniIcon, "AccentImage")
    
    -- Double Click to Restore
    local clicks = 0
    local lastClick = 0
    miniBox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local now = tick()
            if now - lastClick < 0.3 then
                clicks = clicks + 1
            else
                clicks = 1
            end
            lastClick = now
            
            if clicks == 2 then
                clicks = 0
                Utility:Tween(miniBox, {Size = UDim2.new(0, 0, 0, 0)}, 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
                task.wait(0.25)
                miniBox.Visible = false
                main.Visible = true
                Utility:Tween(main, {Size = UDim2.new(0, w, 0, h)}, 0.4, Enum.EasingStyle.Quart)
            end
        end
    end)
    
    -- Main Frame
    local main = Utility:Create("Frame", {
        Name = "Main",
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Parent = gui
    })
    
    local frame = Utility:Create("Frame", {
        BackgroundColor3 = Library.Config.Theme.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        ClipsDescendants = true,
        Parent = main
    })
    
    Library:RegisterTheme(frame, "Background")
    Utility:Corner(frame, 14)
    Utility:Shadow(main, 25)
    local frameStroke = Utility:Stroke(frame, Library.Config.Theme.Accent, 2, 0.4)
    Library:RegisterTheme(frameStroke, "AccentStroke")
    
    -- Header
    local header = Utility:Create("Frame", {
        BackgroundColor3 = Library.Config.Theme.SecondaryBG,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 52),
        Parent = frame
    })
    
    Library:RegisterTheme(header, "SecondaryBG")
    Utility:Corner(header, 14)
    
    local headerLine = Utility:Create("Frame", {
        BackgroundColor3 = Library.Config.Theme.Accent,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -3),
        Size = UDim2.new(1, 0, 0, 3),
        Parent = header
    })
    
    Library:RegisterTheme(headerLine, "Accent")
    
    Utility:Create("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 18, 0, 8),
        Size = UDim2.new(0.5, 0, 0, 22),
        Font = Enum.Font.GothamBold,
        Text = title,
        TextColor3 = Library.Config.Theme.Text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = header
    })
    
    Utility:Create("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 18, 0, 30),
        Size = UDim2.new(0.5, 0, 0, 16),
        Font = Enum.Font.Gotham,
        Text = subtitle,
        TextColor3 = Library.Config.Theme.TextDark,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = header
    })
    
    -- Buttons
    local btnSize = 32
    local btnGap = 8
    local btnX = 12
    
    -- Maximize Button
    local isMax = false
    local normalW, normalH = w, h
    
    if showMax then
        local maxBtn = Utility:Create("TextButton", {
            BackgroundColor3 = Library.Config.Theme.TertiaryBG,
            BorderSizePixel = 0,
            Position = UDim2.new(1, -(btnSize * 3 + btnGap * 2 + btnX), 0.5, 0),
            Size = UDim2.new(0, btnSize, 0, btnSize),
            AnchorPoint = Vector2.new(0, 0.5),
            Font = Enum.Font.GothamBold,
            Text = "□",
            TextColor3 = Library.Config.Theme.Text,
            TextSize = 18,
            AutoButtonColor = false,
            Parent = header
        })
        
        Library:RegisterTheme(maxBtn, "TertiaryBG")
        Utility:Corner(maxBtn, 8)
        
        maxBtn.MouseButton1Click:Connect(function()
            isMax = not isMax
            if isMax then
                normalW, normalH = main.Size.X.Offset, main.Size.Y.Offset
                local maxW, maxH = vp.X - 40, vp.Y - 40
                Utility:Tween(main, {Size = UDim2.new(0, maxW, 0, maxH)}, 0.3)
                maxBtn.Text = "❐"
            else
                Utility:Tween(main, {Size = UDim2.new(0, normalW, 0, normalH)}, 0.3)
                maxBtn.Text = "□"
            end
        end)
        
        maxBtn.MouseEnter:Connect(function()
            Utility:Tween(maxBtn, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2)
        end)
        
        maxBtn.MouseLeave:Connect(function()
            Utility:Tween(maxBtn, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.2)
        end)
    end
    
    -- Minimize Button
    local minBtn = Utility:Create("TextButton", {
        BackgroundColor3 = Library.Config.Theme.TertiaryBG,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -(btnSize * 2 + btnGap + btnX), 0.5, 0),
        Size = UDim2.new(0, btnSize, 0, btnSize),
        AnchorPoint = Vector2.new(0, 0.5),
        Font = Enum.Font.GothamBold,
        Text = "─",
        TextColor3 = Library.Config.Theme.Text,
        TextSize = 16,
        AutoButtonColor = false,
        Parent = header
    })
    
    Library:RegisterTheme(minBtn, "TertiaryBG")
    Utility:Corner(minBtn, 8)
    
    minBtn.MouseButton1Click:Connect(function()
        Utility:Tween(main, {Size = UDim2.new(0, 0, 0, 0)}, 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        task.wait(0.25)
        main.Visible = false
        miniBox.Visible = true
        Utility:Tween(miniBox, {Size = UDim2.new(0, 90, 0, 90)}, 0.35, Enum.EasingStyle.Quart)
    end)
    
    minBtn.MouseEnter:Connect(function()
        Utility:Tween(minBtn, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2)
    end)
    
    minBtn.MouseLeave:Connect(function()
        Utility:Tween(minBtn, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.2)
    end)
    
    -- Close Button
    local closeBtn = Utility:Create("TextButton", {
        BackgroundColor3 = Color3.fromRGB(231, 76, 60),
        BorderSizePixel = 0,
        Position = UDim2.new(1, -(btnSize + btnX), 0.5, 0),
        Size = UDim2.new(0, btnSize, 0, btnSize),
        AnchorPoint = Vector2.new(0, 0.5),
        Font = Enum.Font.GothamBold,
        Text = "×",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 20,
        AutoButtonColor = false,
        Parent = header
    })
    
    Utility:Corner(closeBtn, 8)
    
    closeBtn.MouseButton1Click:Connect(function()
        Utility:Tween(main, {Size = UDim2.new(0, 0, 0, 0)}, 0.25)
        task.wait(0.3)
        gui:Destroy()
    end)
    
    closeBtn.MouseEnter:Connect(function()
        Utility:Tween(closeBtn, {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}, 0.2)
    end)
    
    closeBtn.MouseLeave:Connect(function()
        Utility:Tween(closeBtn, {BackgroundColor3 = Color3.fromRGB(231, 76, 60)}, 0.2)
    end)
    
    Utility:MakeDraggable(main, header)
    
    -- Tab Container
    local tabW = IsMobile and 70 or 180
    
    local tabContainer = Utility:Create("ScrollingFrame", {
        BackgroundColor3 = Library.Config.Theme.SecondaryBG,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 52),
        Size = UDim2.new(0, tabW, 1, -52),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 5,
        ScrollBarImageColor3 = Library.Config.Theme.Accent,
        Parent = frame
    })
    
    Library:RegisterTheme(tabContainer, "SecondaryBG")
    
    local tabList = Utility:Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        Parent = tabContainer
    })
    
    Utility:Create("UIPadding", {
        PaddingTop = UDim.new(0, 12),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 12),
        Parent = tabContainer
    })
    
    tabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContainer.CanvasSize = UDim2.new(0, 0, 0, tabList.AbsoluteContentSize.Y + 24)
    end)
    
    -- Content Container
    local contentContainer = Utility:Create("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, tabW, 0, 52),
        Size = UDim2.new(1, -tabW, 1, -52),
        Parent = frame
    })
    
    -- Window Object
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        Flags = Library.Flags,
        Options = Library.Options,
    }
    
    function Window:SetIcon(img)
        miniIcon.Image = img
    end
    
    -- CREATE TAB
    function Window:CreateTab(cfg)
        if type(cfg) == "string" then cfg = {Name = cfg} end
        
        local tabName = cfg.Name or "Tab"
        local tabIcon = cfg.Icon or "•"
        
        -- Tab Button
        local tabBtn = Utility:Create("TextButton", {
            BackgroundColor3 = Library.Config.Theme.TertiaryBG,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, IsMobile and 60 or 50),
            Text = "",
            AutoButtonColor = false,
            Parent = tabContainer
        })
        
        Library:RegisterTheme(tabBtn, "TertiaryBG")
        Utility:Corner(tabBtn, 12)
        Utility:Ripple(tabBtn)
        
        local icon = Utility:Create("TextLabel", {
            BackgroundTransparency = 1,
            Position = IsMobile and UDim2.new(0.5, 0, 0, 10) or UDim2.new(0, 15, 0.5, 0),
            Size = IsMobile and UDim2.new(0, 30, 0, 25) or UDim2.new(0, 30, 0, 30),
            AnchorPoint = IsMobile and Vector2.new(0.5, 0) or Vector2.new(0, 0.5),
            Font = Enum.Font.GothamBold,
            Text = tabIcon,
            TextColor3 = Library.Config.Theme.TextDark,
            TextSize = 20,
            Parent = tabBtn
        })
        
        local text = Utility:Create("TextLabel", {
            BackgroundTransparency = 1,
            Position = IsMobile and UDim2.new(0.5, 0, 0, 38) or UDim2.new(0, 50, 0.5, 0),
            Size = IsMobile and UDim2.new(1, -10, 0, 18) or UDim2.new(1, -60, 0, 24),
            AnchorPoint = IsMobile and Vector2.new(0.5, 0) or Vector2.new(0, 0.5),
            Font = Enum.Font.GothamBold,
            Text = tabName,
            TextColor3 = Library.Config.Theme.TextDark,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            Parent = tabBtn
        })
        
        local indicator = Utility:Create("Frame", {
            BackgroundColor3 = Library.Config.Theme.Accent,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 0, 1, 0),
            Parent = tabBtn
        })
        
        Library:RegisterTheme(indicator, "Accent")
        Utility:Corner(indicator, 12)
        
        -- Tab Content
        local tabContent = Utility:Create("ScrollingFrame", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 6,
            ScrollBarImageColor3 = Library.Config.Theme.Accent,
            Visible = false,
            Parent = contentContainer
        })
        
        local contentList = Utility:Create("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12),
            Parent = tabContent
        })
        
        Utility:Create("UIPadding", {
            PaddingTop = UDim.new(0, 15),
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 15),
            PaddingBottom = UDim.new(0, 15),
            Parent = tabContent
        })
        
        contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabContent.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 30)
        end)
        
        -- Tab Click
        tabBtn.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab:Deactivate()
            end
            
            tabContent.Visible = true
            Window.CurrentTab = tabName
            
            Utility:Tween(tabBtn, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2)
            Utility:Tween(icon, {TextColor3 = Library.Config.Theme.Text}, 0.2)
            Utility:Tween(text, {TextColor3 = Library.Config.Theme.Text}, 0.2)
            Utility:Tween(indicator, {Size = UDim2.new(0, 5, 1, 0)}, 0.3, Enum.EasingStyle.Back)
        end)
        
        tabBtn.MouseEnter:Connect(function()
            if Window.CurrentTab ~= tabName then
                Utility:Tween(tabBtn, {BackgroundColor3 = Library.Config.Theme.SecondaryBG}, 0.15)
            end
        end)
        
        tabBtn.MouseLeave:Connect(function()
            if Window.CurrentTab ~= tabName then
                Utility:Tween(tabBtn, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.15)
            end
        end)
        
        local Tab = {
            Name = tabName,
            Content = tabContent,
        }
        
        function Tab:Deactivate()
            tabContent.Visible = false
            Utility:Tween(tabBtn, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.2)
            Utility:Tween(icon, {TextColor3 = Library.Config.Theme.TextDark}, 0.2)
            Utility:Tween(text, {TextColor3 = Library.Config.Theme.TextDark}, 0.2)
            Utility:Tween(indicator, {Size = UDim2.new(0, 0, 1, 0)}, 0.2)
        end
        
        -- ADD SECTION
        function Tab:AddSection(name)
            local section = Utility:Create("Frame", {
                BackgroundColor3 = Library.Config.Theme.SecondaryBG,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 45),
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = tabContent
            })
            
            Library:RegisterTheme(section, "SecondaryBG")
            Utility:Corner(section, 12)
            
            local header = Utility:Create("Frame", {
                BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 45),
                Parent = section
            })
            
            Library:RegisterTheme(header, "TertiaryBG")
            Utility:Corner(header, 12)
            
            local line = Utility:Create("Frame", {
                BackgroundColor3 = Library.Config.Theme.Accent,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 43),
                Size = UDim2.new(1, 0, 0, 2),
                Parent = header
            })
            
            Library:RegisterTheme(line, "Accent")
            
            Utility:Create("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 15, 0, 0),
                Size = UDim2.new(1, -30, 0, 45),
                Font = Enum.Font.GothamBold,
                Text = name,
                TextColor3 = Library.Config.Theme.Text,
                TextSize = 15,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = header
            })
            
            local content = Utility:Create("Frame", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0, 45),
                Size = UDim2.new(1, 0, 1, -45),
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = section
            })
            
            local list = Utility:Create("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10),
                Parent = content
            })
            
            Utility:Create("UIPadding", {
                PaddingTop = UDim.new(0, 12),
                PaddingLeft = UDim.new(0, 15),
                PaddingRight = UDim.new(0, 15),
                PaddingBottom = UDim.new(0, 15),
                Parent = content
            })
            
            local Section = {}
            
            -- BUTTON
            function Section:AddButton(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Button"
                local callback = cfg.Callback or function() end
                
                local btn = Utility:Create("TextButton", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 38),
                    Text = "",
                    AutoButtonColor = false,
                    Parent = content
                })
                
                Library:RegisterTheme(btn, "TertiaryBG")
                Utility:Corner(btn, 10)
                Utility:Ripple(btn)
                
                Utility:Create("TextLabel", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -20, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = btn
                })
                
                btn.MouseEnter:Connect(function()
                    Utility:Tween(btn, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2)
                end)
                
                btn.MouseLeave:Connect(function()
                    Utility:Tween(btn, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.2)
                end)
                
                btn.MouseButton1Click:Connect(callback)
            end
            
            -- TOGGLE
            function Section:AddToggle(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Toggle"
                local default = cfg.Default or false
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                
                local toggle = Utility:Create("Frame", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 38),
                    Parent = content
                })
                
                Library:RegisterTheme(toggle, "TertiaryBG")
                Utility:Corner(toggle, 10)
                
                Utility:Create("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 15, 0, 0),
                    Size = UDim2.new(1, -70, 1, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = toggle
                })
                
                local switch = Utility:Create("TextButton", {
                    BackgroundColor3 = default and Library.Config.Theme.Accent or Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -50, 0.5, 0),
                    Size = UDim2.new(0, 44, 0, 24),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Text = "",
                    AutoButtonColor = false,
                    Parent = toggle
                })
                
                if default then Library:RegisterTheme(switch, "Accent") end
                Utility:Corner(switch, 20)
                
                local circle = Utility:Create("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Text,
                    BorderSizePixel = 0,
                    Position = default and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 4, 0.5, 0),
                    Size = UDim2.new(0, 16, 0, 16),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Parent = switch
                })
                
                Utility:Corner(circle, 20)
                
                local toggled = default
                
                if flag then
                    Library.Flags[flag] = toggled
                    Library.Options[flag] = {
                        Set = function(v)
                            toggled = v
                            Utility:Tween(switch, {BackgroundColor3 = toggled and Library.Config.Theme.Accent or Library.Config.Theme.Background}, 0.2)
                            Utility:Tween(circle, {Position = toggled and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 4, 0.5, 0)}, 0.3, Enum.EasingStyle.Back)
                            callback(toggled)
                        end,
                        Get = function() return toggled end
                    }
                end
                
                switch.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    if flag then Library.Flags[flag] = toggled end
                    
                    Utility:Tween(switch, {BackgroundColor3 = toggled and Library.Config.Theme.Accent or Library.Config.Theme.Background}, 0.2)
                    Utility:Tween(circle, {Position = toggled and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 4, 0.5, 0)}, 0.3, Enum.EasingStyle.Back)
                    callback(toggled)
                end)
                
                return Library.Options[flag] or {Set = function(v) end, Get = function() return toggled end}
            end
            
            -- SLIDER
            function Section:AddSlider(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Slider"
                local min = cfg.Min or 0
                local max = cfg.Max or 100
                local default = cfg.Default or 50
                local inc = cfg.Increment or 1
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                local suffix = cfg.Suffix or ""
                
                local slider = Utility:Create("Frame", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 58),
                    Parent = content
                })
                
                Library:RegisterTheme(slider, "TertiaryBG")
                Utility:Corner(slider, 10)
                
                Utility:Create("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 15, 0, 10),
                    Size = UDim2.new(0.6, 0, 0, 20),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = slider
                })
                
                local valueText = Utility:Create("TextLabel", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -60, 0, 10),
                    Size = UDim2.new(0, 50, 0, 20),
                    Font = Enum.Font.GothamBold,
                    Text = tostring(default) .. suffix,
                    TextColor3 = Library.Config.Theme.Accent,
                    TextSize = 13,
                    Parent = slider
                })
                
                Library:RegisterTheme(valueText, "AccentText")
                Utility:Corner(valueText, 6)
                
                local bar = Utility:Create("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 15, 1, -18),
                    Size = UDim2.new(1, -30, 0, 8),
                    Parent = slider
                })
                
                Utility:Corner(bar, 10)
                
                local fill = Utility:Create("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Accent,
                    BorderSizePixel = 0,
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    Parent = bar
                })
                
                Library:RegisterTheme(fill, "Accent")
                Utility:Corner(fill, 10)
                
                local dot = Utility:Create("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Text,
                    BorderSizePixel = 0,
                    Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0),
                    Size = UDim2.new(0, 16, 0, 16),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Parent = bar
                })
                
                Utility:Corner(dot, 20)
                
                local dragging = false
                
                if flag then
                    Library.Flags[flag] = default
                    Library.Options[flag] = {
                        Set = function(v)
                            local pos = (v - min) / (max - min)
                            fill.Size = UDim2.new(pos, 0, 1, 0)
                            dot.Position = UDim2.new(pos, 0, 0.5, 0)
                            valueText.Text = tostring(v) .. suffix
                            if flag then Library.Flags[flag] = v end
                            callback(v)
                        end,
                        Get = function() return tonumber(valueText.Text:gsub(suffix, "")) end
                    }
                end
                
                local function update(input)
                    local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                    local val = math.floor(min + (max - min) * pos)
                    val = math.floor(val / inc + 0.5) * inc
                    val = math.clamp(val, min, max)
                    
                    fill.Size = UDim2.new(pos, 0, 1, 0)
                    dot.Position = UDim2.new(pos, 0, 0.5, 0)
                    valueText.Text = tostring(val) .. suffix
                    
                    if flag then Library.Flags[flag] = val end
                    callback(val)
                end
                
                bar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        update(input)
                        Utility:Tween(dot, {Size = UDim2.new(0, 20, 0, 20)}, 0.2, Enum.EasingStyle.Back)
                    end
                end)
                
                bar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                        Utility:Tween(dot, {Size = UDim2.new(0, 16, 0, 16)}, 0.2)
                    end
                end)
                
                Services.UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        update(input)
                    end
                end)
                
                return Library.Options[flag] or {Set = function(v) end, Get = function() return default end}
            end
            
            -- DROPDOWN
            function Section:AddDropdown(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Dropdown"
                local items = cfg.Items or {"Item1", "Item2"}
                local default = cfg.Default or items[1]
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                local search = cfg.Search or false
                
                local dropdown = Utility:Create("Frame", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 38),
                    ClipsDescendants = true,
                    Parent = content
                })
                
                Library:RegisterTheme(dropdown, "TertiaryBG")
                Utility:Corner(dropdown, 10)
                
                Utility:Create("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 15, 0, 0),
                    Size = UDim2.new(0.4, 0, 0, 38),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = dropdown
                })
                
                local btn = Utility:Create("TextButton", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.45, 0, 0, 9),
                    Size = UDim2.new(0.5, -15, 0, 20),
                    Font = Enum.Font.Gotham,
                    Text = "  " .. default,
                    TextColor3 = Library.Config.Theme.Accent,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutoButtonColor = false,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Parent = dropdown
                })
                
                Library:RegisterTheme(btn, "AccentText")
                Utility:Corner(btn, 8)
                
                local arrow = Utility:Create("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -22, 0, 0),
                    Size = UDim2.new(0, 20, 1, 0),
                    Font = Enum.Font.GothamBold,
                    Text = "▼",
                    TextColor3 = Library.Config.Theme.TextDark,
                    TextSize = 10,
                    Parent = btn
                })
                
                local listContainer = Utility:Create("Frame", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 10, 0, 42),
                    Size = UDim2.new(1, -20, 0, 0),
                    Parent = dropdown
                })
                
                local searchBox
                if search then
                    searchBox = Utility:Create("TextBox", {
                        BackgroundColor3 = Library.Config.Theme.Background,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 28),
                        Font = Enum.Font.Gotham,
                        PlaceholderText = "🔍 Search...",
                        PlaceholderColor3 = Library.Config.Theme.TextDark,
                        Text = "",
                        TextColor3 = Library.Config.Theme.Text,
                        TextSize = 13,
                        ClearTextOnFocus = false,
                        Parent = listContainer
                    })
                    
                    Utility:Corner(searchBox, 7)
                    Utility:Create("UIPadding", {PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), Parent = searchBox})
                end
                
                local list = Utility:Create("ScrollingFrame", {
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, search and 33 or 0),
                    Size = UDim2.new(1, 0, 0, 0),
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    ScrollBarThickness = 4,
                    ScrollBarImageColor3 = Library.Config.Theme.Accent,
                    Parent = listContainer
                })
                
                local listLayout = Utility:Create("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 5),
                    Parent = list
                })
                
                listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    list.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
                end)
                
                local expanded = false
                local current = default
                
                if flag then
                    Library.Flags[flag] = current
                    Library.Options[flag] = {
                        Set = function(v)
                            current = v
                            btn.Text = "  " .. v
                        end,
                        Get = function() return current end,
                        Refresh = function(newItems, newDefault)
                            items = newItems
                            list:ClearAllChildren()
                            listLayout.Parent = list
                            for _, item in ipairs(newItems) do
                                createItem(item)
                            end
                            if newDefault and table.find(newItems, newDefault) then
                                current = newDefault
                                btn.Text = "  " .. newDefault
                                if flag then Library.Flags[flag] = newDefault end
                            end
                        end
                    }
                end
                
                local function createItem(itemName)
                    local item = Utility:Create("TextButton", {
                        Name = itemName,
                        BackgroundColor3 = Library.Config.Theme.Background,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 28),
                        Font = Enum.Font.Gotham,
                        Text = "  " .. itemName,
                        TextColor3 = Library.Config.Theme.Text,
                        TextSize = 13,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutoButtonColor = false,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Parent = list
                    })
                    
                    Utility:Corner(item, 7)
                    
                    item.MouseEnter:Connect(function()
                        Utility:Tween(item, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2)
                    end)
                    
                    item.MouseLeave:Connect(function()
                        Utility:Tween(item, {BackgroundColor3 = Library.Config.Theme.Background}, 0.2)
                    end)
                    
                    item.MouseButton1Click:Connect(function()
                        current = itemName
                        btn.Text = "  " .. itemName
                        if flag then Library.Flags[flag] = itemName end
                        callback(itemName)
                        
                        expanded = false
                        Utility:Tween(dropdown, {Size = UDim2.new(1, 0, 0, 38)}, 0.3, Enum.EasingStyle.Back)
                        Utility:Tween(arrow, {Rotation = 0}, 0.3)
                    end)
                end
                
                for _, item in ipairs(items) do
                    createItem(item)
                end
                
                if search and searchBox then
                    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
                        local txt = searchBox.Text:lower()
                        for _, item in ipairs(list:GetChildren()) do
                            if item:IsA("TextButton") then
                                item.Visible = txt == "" or item.Name:lower():find(txt)
                            end
                        end
                    end)
                end
                
                btn.MouseButton1Click:Connect(function()
                    expanded = not expanded
                    
                    if expanded then
                        local count = 0
                        for _, item in ipairs(list:GetChildren()) do
                            if item:IsA("TextButton") and item.Visible then count = count + 1 end
                        end
                        
                        local maxItems = math.min(count, 5)
                        local searchH = search and 33 or 0
                        local totalH = 38 + 14 + searchH + (maxItems * 33)
                        
                        Utility:Tween(dropdown, {Size = UDim2.new(1, 0, 0, totalH)}, 0.3, Enum.EasingStyle.Back)
                        Utility:Tween(arrow, {Rotation = 180}, 0.3)
                        list.Size = UDim2.new(1, 0, 0, maxItems * 33)
                    else
                        Utility:Tween(dropdown, {Size = UDim2.new(1, 0, 0, 38)}, 0.3, Enum.EasingStyle.Back)
                        Utility:Tween(arrow, {Rotation = 0}, 0.3)
                    end
                end)
                
                return Library.Options[flag] or {Set = function(v) end, Get = function() return current end, Refresh = function() end}
            end
            
            -- TEXTBOX
            function Section:AddTextbox(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Textbox"
                local default = cfg.Default or ""
                local placeholder = cfg.Placeholder or "Enter..."
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                
                local box = Utility:Create("Frame", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 38),
                    Parent = content
                })
                
                Library:RegisterTheme(box, "TertiaryBG")
                Utility:Corner(box, 10)
                
                Utility:Create("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 15, 0, 0),
                    Size = UDim2.new(0.35, 0, 1, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = box
                })
                
                local input = Utility:Create("TextBox", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.4, 0, 0.5, 0),
                    Size = UDim2.new(0.58, 0, 0, 22),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Font = Enum.Font.Gotham,
                    PlaceholderText = placeholder,
                    PlaceholderColor3 = Library.Config.Theme.TextDark,
                    Text = default,
                    TextColor3 = Library.Config.Theme.Accent,
                    TextSize = 13,
                    ClearTextOnFocus = false,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Parent = box
                })
                
                Library:RegisterTheme(input, "AccentText")
                Utility:Corner(input, 7)
                Utility:Create("UIPadding", {PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), Parent = input})
                
                if flag then
                    Library.Flags[flag] = default
                    Library.Options[flag] = {
                        Set = function(v) input.Text = v end,
                        Get = function() return input.Text end
                    }
                end
                
                input.FocusLost:Connect(function(enter)
                    if enter then
                        if flag then Library.Flags[flag] = input.Text end
                        callback(input.Text)
                    end
                end)
                
                return Library.Options[flag] or {Set = function(v) end, Get = function() return input.Text end}
            end
            
            -- COLORPICKER
            function Section:AddColorPicker(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Color"
                local default = cfg.Default or Color3.fromRGB(255, 255, 255)
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                
                local picker = Utility:Create("Frame", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 38),
                    ClipsDescendants = true,
                    Parent = content
                })
                
                Library:RegisterTheme(picker, "TertiaryBG")
                Utility:Corner(picker, 10)
                
                Utility:Create("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 15, 0, 0),
                    Size = UDim2.new(0.7, 0, 0, 38),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = picker
                })
                
                local display = Utility:Create("TextButton", {
                    BackgroundColor3 = default,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -58, 0.5, 0),
                    Size = UDim2.new(0, 48, 0, 22),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Text = "",
                    AutoButtonColor = false,
                    Parent = picker
                })
                
                Utility:Corner(display, 7)
                Utility:Stroke(display, Library.Config.Theme.Border, 2)
                
                local palette = Utility:Create("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 10, 0, 42),
                    Size = UDim2.new(1, -20, 0, 165),
                    Visible = false,
                    Parent = picker
                })
                
                Utility:Corner(palette, 10)
                
                local canvas = Utility:Create("ImageButton", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 10, 0, 10),
                    Size = UDim2.new(1, -90, 1, -20),
                    Image = "rbxassetid://4155801252",
                    AutoButtonColor = false,
                    Parent = palette
                })
                
                Utility:Corner(canvas, 8)
                
                local hue = Utility:Create("ImageButton", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -72, 0, 10),
                    Size = UDim2.new(0, 32, 1, -20),
                    Image = "rbxassetid://3641079629",
                    AutoButtonColor = false,
                    Parent = palette
                })
                
                Utility:Corner(hue, 8)
                
                local confirm = Utility:Create("TextButton", {
                    BackgroundColor3 = Library.Config.Theme.Accent,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -32, 0, 10),
                    Size = UDim2.new(0, 22, 0, 22),
                    Font = Enum.Font.GothamBold,
                    Text = "✓",
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    AutoButtonColor = false,
                    Parent = palette
                })
                
                Library:RegisterTheme(confirm, "Accent")
                Utility:Corner(confirm, 6)
                
                local expanded = false
                local h, s, v = default:ToHSV()
                
                if flag then
                    Library.Flags[flag] = default
                    Library.Options[flag] = {
                        Set = function(color)
                            local hh, ss, vv = color:ToHSV()
                            h, s, v = hh, ss, vv
                            local c = Color3.fromHSV(h, s, v)
                            display.BackgroundColor3 = c
                            canvas.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                            if flag then Library.Flags[flag] = c end
                            callback(c)
                        end,
                        Get = function() return Color3.fromHSV(h, s, v) end
                    }
                end
                
                local hueDragging, canvasDragging = false, false
                
                hue.MouseButton1Down:Connect(function() hueDragging = true end)
                canvas.MouseButton1Down:Connect(function() canvasDragging = true end)
                
                Services.UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        hueDragging = false
                        canvasDragging = false
                    end
                end)
                
                Services.UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                        if hueDragging then
                            local pos = math.clamp((input.Position.Y - hue.AbsolutePosition.Y) / hue.AbsoluteSize.Y, 0, 1)
                            h = 1 - pos
                            local c = Color3.fromHSV(h, s, v)
                            display.BackgroundColor3 = c
                            canvas.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                            if flag then Library.Flags[flag] = c end
                            callback(c)
                        end
                        
                        if canvasDragging then
                            local posX = math.clamp((input.Position.X - canvas.AbsolutePosition.X) / canvas.AbsoluteSize.X, 0, 1)
                            local posY = math.clamp((input.Position.Y - canvas.AbsolutePosition.Y) / canvas.AbsoluteSize.Y, 0, 1)
                            s = posX
                            v = 1 - posY
                            local c = Color3.fromHSV(h, s, v)
                            display.BackgroundColor3 = c
                            if flag then Library.Flags[flag] = c end
                            callback(c)
                        end
                    end
                end)
                
                display.MouseButton1Click:Connect(function()
                    expanded = not expanded
                    palette.Visible = expanded
                    Utility:Tween(picker, {Size = UDim2.new(1, 0, 0, expanded and 215 or 38)}, 0.3, Enum.EasingStyle.Back)
                end)
                
                confirm.MouseButton1Click:Connect(function()
                    expanded = false
                    palette.Visible = false
                    Utility:Tween(picker, {Size = UDim2.new(1, 0, 0, 38)}, 0.3, Enum.EasingStyle.Back)
                end)
                
                return Library.Options[flag] or {Set = function(c) end, Get = function() return Color3.fromHSV(h, s, v) end}
            end
            
            -- KEYBIND
            function Section:AddKeybind(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Keybind"
                local default = cfg.Default or Enum.KeyCode.E
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                local mode = cfg.Mode or "Toggle"
                
                local keybind = Utility:Create("Frame", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 38),
                    Parent = content
                })
                
                Library:RegisterTheme(keybind, "TertiaryBG")
                Utility:Corner(keybind, 10)
                
                Utility:Create("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 15, 0, 0),
                    Size = UDim2.new(0.6, 0, 0, 38),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = keybind
                })
                
                local keyBtn = Utility:Create("TextButton", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -72, 0.5, 0),
                    Size = UDim2.new(0, 62, 0, 22),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Font = Enum.Font.Gotham,
                    Text = default.Name,
                    TextColor3 = Library.Config.Theme.Accent,
                    TextSize = 12,
                    AutoButtonColor = false,
                    Parent = keybind
                })
                
                Library:RegisterTheme(keyBtn, "AccentText")
                Utility:Corner(keyBtn, 7)
                
                local current = default
                local listening = false
                local toggled = false
                
                if flag then
                    Library.Flags[flag] = current
                    Library.Options[flag] = {
                        Set = function(key)
                            current = key
                            keyBtn.Text = key.Name
                        end,
                        Get = function() return current end
                    }
                end
                
                keyBtn.MouseButton1Click:Connect(function()
                    listening = true
                    keyBtn.Text = "..."
                    Utility:Tween(keyBtn, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2)
                end)
                
                Services.UserInputService.InputBegan:Connect(function(input, gp)
                    if gp then return end
                    
                    if listening then
                        if input.KeyCode ~= Enum.KeyCode.Unknown then
                            current = input.KeyCode
                            keyBtn.Text = input.KeyCode.Name
                            listening = false
                            if flag then Library.Flags[flag] = current end
                            Utility:Tween(keyBtn, {BackgroundColor3 = Library.Config.Theme.Background}, 0.2)
                        end
                    elseif input.KeyCode == current then
                        if mode == "Toggle" then
                            toggled = not toggled
                            callback(toggled)
                        elseif mode == "Hold" then
                            callback(true)
                        end
                    end
                end)
                
                if mode == "Hold" then
                    Services.UserInputService.InputEnded:Connect(function(input, gp)
                        if gp then return end
                        if input.KeyCode == current then
                            callback(false)
                        end
                    end)
                end
                
                return Library.Options[flag] or {Set = function(k) end, Get = function() return current end}
            end
            
            -- LABEL
            function Section:AddLabel(text)
                local label = Utility:Create("TextLabel", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 22),
                    Font = Enum.Font.Gotham,
                    Text = text or "Label",
                    TextColor3 = Library.Config.Theme.TextDark,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Parent = content
                })
                
                return {Set = function(t) label.Text = t end}
            end
            
            -- PARAGRAPH
            function Section:AddParagraph(title, text)
                local para = Utility:Create("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 65),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Parent = content
                })
                
                Utility:Corner(para, 10)
                
                local paraTitle = Utility:Create("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 15, 0, 10),
                    Size = UDim2.new(1, -30, 0, 20),
                    Font = Enum.Font.GothamBold,
                    Text = title or "Title",
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = para
                })
                
                local paraContent = Utility:Create("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 15, 0, 32),
                    Size = UDim2.new(1, -30, 1, -42),
                    Font = Enum.Font.Gotham,
                    Text = text or "Content",
                    TextColor3 = Library.Config.Theme.TextDark,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Parent = para
                })
                
                Utility:Create("UIPadding", {PaddingBottom = UDim.new(0, 12), Parent = para})
                
                return {
                    SetTitle = function(t) paraTitle.Text = t end,
                    SetContent = function(c) paraContent.Text = c end
                }
            end
            
            -- DIVIDER
            function Section:AddDivider(text)
                local div = Utility:Create("Frame", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, text and 30 or 10),
                    Parent = content
                })
                
                local line = Utility:Create("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Border,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0.5, 0),
                    Size = UDim2.new(1, 0, 0, 2),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Parent = div
                })
                
                if text then
                    Utility:Create("TextLabel", {
                        BackgroundColor3 = Library.Config.Theme.SecondaryBG,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(0, 0, 0, 20),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Font = Enum.Font.GothamBold,
                        Text = " " .. text .. " ",
                        TextColor3 = Library.Config.Theme.TextDark,
                        TextSize = 12,
                        AutomaticSize = Enum.AutomaticSize.X,
                        Parent = div
                    })
                end
            end
            
            return Section
        end
        
        if #Window.Tabs == 0 then
            tabContent.Visible = true
            Window.CurrentTab = tabName
            tabBtn.BackgroundColor3 = Library.Config.Theme.Accent
            icon.TextColor3 = Library.Config.Theme.Text
            text.TextColor3 = Library.Config.Theme.Text
            indicator.Size = UDim2.new(0, 5, 1, 0)
        end
        
        table.insert(Window.Tabs, Tab)
        return Tab
    end
    
    -- Keybind Toggle
    if keybind then
        local visible = true
        Services.UserInputService.InputBegan:Connect(function(input, gp)
            if not gp and input.KeyCode == keybind then
                visible = not visible
                
                if miniBox.Visible then
                    miniBox.Visible = false
                    Utility:Tween(miniBox, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
                    main.Visible = true
                    Utility:Tween(main, {Size = visible and UDim2.new(0, w, 0, h) or UDim2.new(0, 0, 0, 0)}, 0.3)
                else
                    Utility:Tween(main, {Size = visible and UDim2.new(0, w, 0, h) or UDim2.new(0, 0, 0, 0)}, 0.3)
                end
            end
        end)
    end
    
    -- Responsive
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        local vp = workspace.CurrentCamera.ViewportSize
        local newW = IsMobile and math.clamp(vp.X * 0.95, 340, 500) or math.clamp(vp.X * 0.5, 600, 800)
        local newH = IsMobile and math.clamp(vp.Y * 0.88, 480, 750) or math.clamp(vp.Y * 0.7, 500, 700)
        
        if main.Visible and main.Size ~= UDim2.new(0, 0, 0, 0) and not isMax then
            main.Size = UDim2.new(0, newW, 0, newH)
        end
        
        w, h = newW, newH
    end)
    
    Utility:Tween(main, {Size = UDim2.new(0, w, 0, h)}, 0.5, Enum.EasingStyle.Quart)
    
    return Window
end

return Library
