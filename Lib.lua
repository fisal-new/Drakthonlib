--[[
    ════════════════════════════════════════════════════════
           UI LIBRARY - ULTIMATE COMPLETE VERSION
                     Version 11.0.0
    ════════════════════════════════════════════════════════
    
    ✓ Fully Responsive (PC, Mobile, Tablet)
    ✓ All UI Elements Complete
    ✓ Smooth Animations
    ✓ Beautiful Design
    ✓ Easy to Use
    ✓ 15 Themes
    ✓ Config System
    
    ════════════════════════════════════════════════════════
]]

local Library = {}
Library.Version = "11.0.0"
Library.Flags = {}
Library.Options = {}
Library.ThemeObjects = {}

-- ════════════════════════════════════════════════════════
-- CONFIGURATION
-- ════════════════════════════════════════════════════════

Library.Config = {
    UI = {
        Animations = true,
        AnimationSpeed = 0.25,
        Font = Enum.Font.Gotham,
        TextSize = 14,
    },
    
    Theme = {
        Background = Color3.fromRGB(15, 15, 20),
        SecondaryBG = Color3.fromRGB(25, 25, 30),
        TertiaryBG = Color3.fromRGB(30, 30, 38),
        Accent = Color3.fromRGB(138, 43, 226),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(180, 180, 190),
        Border = Color3.fromRGB(45, 45, 55),
        Success = Color3.fromRGB(46, 204, 113),
        Warning = Color3.fromRGB(241, 196, 15),
        Error = Color3.fromRGB(231, 76, 60),
        Info = Color3.fromRGB(52, 152, 219),
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

-- ════════════════════════════════════════════════════════
-- THEMES (15 THEMES)
-- ════════════════════════════════════════════════════════

Library.Themes = {
    Default = {Accent = Color3.fromRGB(138, 43, 226), Background = Color3.fromRGB(15, 15, 20), SecondaryBG = Color3.fromRGB(25, 25, 30), TertiaryBG = Color3.fromRGB(30, 30, 38)},
    Midnight = {Accent = Color3.fromRGB(30, 136, 229), Background = Color3.fromRGB(10, 10, 15), SecondaryBG = Color3.fromRGB(15, 15, 22), TertiaryBG = Color3.fromRGB(20, 20, 28)},
    Ocean = {Accent = Color3.fromRGB(52, 152, 219), Background = Color3.fromRGB(10, 20, 30), SecondaryBG = Color3.fromRGB(15, 28, 40), TertiaryBG = Color3.fromRGB(20, 35, 48)},
    Sunset = {Accent = Color3.fromRGB(255, 107, 107), Background = Color3.fromRGB(25, 15, 20), SecondaryBG = Color3.fromRGB(32, 20, 28), TertiaryBG = Color3.fromRGB(38, 25, 32)},
    Forest = {Accent = Color3.fromRGB(46, 204, 113), Background = Color3.fromRGB(15, 25, 15), SecondaryBG = Color3.fromRGB(20, 32, 20), TertiaryBG = Color3.fromRGB(25, 38, 25)},
    Rose = {Accent = Color3.fromRGB(255, 105, 180), Background = Color3.fromRGB(25, 15, 20), SecondaryBG = Color3.fromRGB(32, 20, 28), TertiaryBG = Color3.fromRGB(38, 25, 32)},
    Mint = {Accent = Color3.fromRGB(26, 188, 156), Background = Color3.fromRGB(15, 25, 23), SecondaryBG = Color3.fromRGB(20, 32, 30), TertiaryBG = Color3.fromRGB(25, 38, 35)},
    Cherry = {Accent = Color3.fromRGB(220, 20, 60), Background = Color3.fromRGB(20, 12, 15), SecondaryBG = Color3.fromRGB(28, 18, 22), TertiaryBG = Color3.fromRGB(35, 22, 28)},
    Gold = {Accent = Color3.fromRGB(255, 215, 0), Background = Color3.fromRGB(20, 18, 10), SecondaryBG = Color3.fromRGB(28, 25, 15), TertiaryBG = Color3.fromRGB(35, 30, 18)},
    Cyber = {Accent = Color3.fromRGB(0, 255, 255), Background = Color3.fromRGB(10, 10, 15), SecondaryBG = Color3.fromRGB(15, 15, 22), TertiaryBG = Color3.fromRGB(18, 18, 28)},
    Toxic = {Accent = Color3.fromRGB(0, 255, 0), Background = Color3.fromRGB(8, 15, 8), SecondaryBG = Color3.fromRGB(12, 22, 12), TertiaryBG = Color3.fromRGB(15, 28, 15)},
    Royal = {Accent = Color3.fromRGB(147, 51, 234), Background = Color3.fromRGB(18, 10, 25), SecondaryBG = Color3.fromRGB(25, 15, 35), TertiaryBG = Color3.fromRGB(30, 18, 42)},
    Blood = {Accent = Color3.fromRGB(139, 0, 0), Background = Color3.fromRGB(18, 8, 8), SecondaryBG = Color3.fromRGB(25, 12, 12), TertiaryBG = Color3.fromRGB(32, 15, 15)},
    Ice = {Accent = Color3.fromRGB(135, 206, 250), Background = Color3.fromRGB(12, 15, 20), SecondaryBG = Color3.fromRGB(18, 22, 28), TertiaryBG = Color3.fromRGB(22, 28, 35)},
    Dark = {Accent = Color3.fromRGB(100, 100, 110), Background = Color3.fromRGB(8, 8, 10), SecondaryBG = Color3.fromRGB(12, 12, 15), TertiaryBG = Color3.fromRGB(15, 15, 18)},
}

function Library:SetTheme(name)
    local theme = self.Themes[name]
    if not theme then return false end
    
    self.Config.Theme.Accent = theme.Accent
    self.Config.Theme.Background = theme.Background
    self.Config.Theme.SecondaryBG = theme.SecondaryBG
    self.Config.Theme.TertiaryBG = theme.TertiaryBG
    
    for _, obj in pairs(self.ThemeObjects) do
        if obj and obj.Parent then
            local t = obj:GetAttribute("T")
            if t == "A" then obj.BackgroundColor3 = theme.Accent
            elseif t == "B" then obj.BackgroundColor3 = theme.Background
            elseif t == "S" then obj.BackgroundColor3 = theme.SecondaryBG
            elseif t == "T" then obj.BackgroundColor3 = theme.TertiaryBG
            elseif t == "AT" then obj.TextColor3 = theme.Accent
            elseif t == "AI" then obj.ImageColor3 = theme.Accent
            elseif t == "AS" then obj.Color = theme.Accent
            end
        end
    end
    return true
end

function Library:Reg(obj, type)
    obj:SetAttribute("T", type)
    table.insert(self.ThemeObjects, obj)
end

function Library:GetThemeNames()
    local n = {}
    for name in pairs(self.Themes) do table.insert(n, name) end
    table.sort(n)
    return n
end

-- ════════════════════════════════════════════════════════
-- UTILITIES
-- ════════════════════════════════════════════════════════

local U = {}

function U:Tween(obj, props, time, style, dir)
    if not obj or not obj.Parent then return end
    if not Library.Config.UI.Animations then
        for k, v in pairs(props) do obj[k] = v end
        return
    end
    
    local tween = Services.TweenService:Create(obj, TweenInfo.new(time or 0.25, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out), props)
    tween:Play()
    return tween
end

function U:Drag(gui, handle)
    handle = handle or gui
    local drag, input, start, pos
    
    handle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            drag = true
            start = inp.Position
            pos = gui.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then drag = false end
            end)
        end
    end)
    
    handle.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            input = inp
        end
    end)
    
    Services.UserInputService.InputChanged:Connect(function(inp)
        if inp == input and drag then
            local delta = inp.Position - start
            gui.Position = UDim2.new(pos.X.Scale, pos.X.Offset + delta.X, pos.Y.Scale, pos.Y.Offset + delta.Y)
        end
    end)
end

function U:New(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        if k ~= "Parent" then obj[k] = v end
    end
    obj.Parent = props.Parent
    return obj
end

function U:Corner(p, r) return U:New("UICorner", {CornerRadius = UDim.new(0, r or 8), Parent = p}) end
function U:Stroke(p, c, t, tr) return U:New("UIStroke", {Color = c or Library.Config.Theme.Border, Thickness = t or 1, Transparency = tr or 0.5, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = p}) end

function U:Shadow(p, s)
    return U:New("ImageLabel", {
        Name = "Shadow",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, -(s or 15), 0, -(s or 15)),
        Size = UDim2.new(1, (s or 15) * 2, 1, (s or 15) * 2),
        ZIndex = (p.ZIndex or 1) - 1,
        Image = "rbxassetid://6015897843",
        ImageColor3 = Library.Config.Theme.Border,
        ImageTransparency = 0.6,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(49, 49, 450, 450),
        Parent = p
    })
end

function U:Ripple(btn)
    btn.ClipsDescendants = true
    btn.MouseButton1Click:Connect(function()
        local r = U:New("ImageLabel", {
            BackgroundTransparency = 1,
            Image = "rbxassetid://3570695787",
            ImageColor3 = Library.Config.Theme.Accent,
            ImageTransparency = 0.5,
            ZIndex = btn.ZIndex + 1,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(0, 0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Parent = btn
        })
        
        local m = Services.UserInputService:GetMouseLocation()
        local p = m - btn.AbsolutePosition
        r.Position = UDim2.new(0, p.X, 0, p.Y)
        
        local sz = math.max(btn.AbsoluteSize.X, btn.AbsoluteSize.Y) * 2.5
        U:Tween(r, {Size = UDim2.new(0, sz, 0, sz), ImageTransparency = 1}, 0.6)
        task.delay(0.6, function() r:Destroy() end)
    end)
end

-- ════════════════════════════════════════════════════════
-- CONFIG SYSTEM
-- ════════════════════════════════════════════════════════

function Library:SaveConfig(name)
    name = name or "Config"
    pcall(function()
        if not isfolder(self.Config.ConfigFolder) then makefolder(self.Config.ConfigFolder) end
        writefile(self.Config.ConfigFolder .. "/" .. name .. ".json", Services.HttpService:JSONEncode({
            Version = self.Version,
            Flags = self.Flags,
            Time = os.date("%Y-%m-%d %H:%M:%S"),
        }))
    end)
end

function Library:LoadConfig(name)
    name = name or "Config"
    local s, d = pcall(function()
        return Services.HttpService:JSONDecode(readfile(self.Config.ConfigFolder .. "/" .. name .. ".json"))
    end)
    
    if s and d then
        for flag, val in pairs(d.Flags or {}) do
            if self.Options[flag] then pcall(function() self.Options[flag]:Set(val) end) end
        end
        self.Flags = d.Flags or {}
        return true
    end
    return false
end

function Library:GetConfigs()
    local c = {}
    pcall(function()
        if not isfolder(self.Config.ConfigFolder) then makefolder(self.Config.ConfigFolder) end
        for _, file in ipairs(listfiles(self.Config.ConfigFolder)) do
            if file:match("%.json$") then
                local n = file:match("([^/\```+)%.json$")
                if n then table.insert(c, n) end
            end
        end
    end)
    return c
end

function Library:DeleteConfig(name)
    return pcall(function() delfile(self.Config.ConfigFolder .. "/" .. name .. ".json") end)
end

-- ════════════════════════════════════════════════════════
-- CREATE WINDOW
-- ════════════════════════════════════════════════════════

function Library:CreateWindow(cfg)
    cfg = cfg or {}
    
    local title = cfg.Title or "UI Library"
    local subtitle = cfg.Subtitle or "v" .. self.Version
    local keybind = cfg.Keybind or Enum.KeyCode.RightControl
    local icon = cfg.Icon or "rbxassetid://11963374911"
    local showMax = cfg.ShowMaximize ~= false
    
    local gui = U:New("ScreenGui", {
        Name = "UILib",
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        DisplayOrder = 100,
        IgnoreGuiInset = true,
        Parent = gethui and gethui() or Services.CoreGui
    })
    
    -- ════════════════════════════════════════════════════════
    -- MINIMIZE BOX
    -- ════════════════════════════════════════════════════════
    
    local miniBox = U:New("Frame", {
        Name = "MiniBox",
        BackgroundColor3 = Library.Config.Theme.SecondaryBG,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Visible = false,
        Parent = gui
    })
    
    Library:Reg(miniBox, "S")
    U:Corner(miniBox, 16)
    U:Shadow(miniBox, 20)
    local miniStroke = U:Stroke(miniBox, Library.Config.Theme.Accent, 2, 0.3)
    Library:Reg(miniStroke, "AS")
    U:Drag(miniBox)
    
    local miniIcon = U:New("ImageLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0.6, 0, 0.6, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Image = icon,
        ImageColor3 = Library.Config.Theme.Accent,
        Parent = miniBox
    })
    
    Library:Reg(miniIcon, "AI")
    
    local MiniBox = {}
    function MiniBox:SetIcon(img) miniIcon.Image = img end
    function MiniBox:SetColor(color) miniBox.BackgroundColor3 = color end
    function MiniBox:SetSize(size) U:Tween(miniBox, {Size = UDim2.new(0, size, 0, size)}, 0.3, Enum.EasingStyle.Back) end
    function MiniBox:SetIconSize(scale) miniIcon.Size = UDim2.new(scale, 0, scale, 0) end
    
    local clicks, lastClick = 0, 0
    miniBox.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            local now = tick()
            clicks = (now - lastClick < 0.3) and clicks + 1 or 1
            lastClick = now
            
            if clicks == 2 then
                clicks = 0
                U:Tween(miniBox, {Size = UDim2.new(0, 0, 0, 0)}, 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
                task.wait(0.25)
                miniBox.Visible = false
                main.Visible = true
                U:Tween(main, {Size = UDim2.new(0.35, 0, 0.5, 0)}, 0.4, Enum.EasingStyle.Quart)
            end
        end
    end)
    
    -- ════════════════════════════════════════════════════════
    -- MAIN WINDOW
    -- ════════════════════════════════════════════════════════
    
    local main = U:New("Frame", {
        Name = "Main",
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Parent = gui
    })
    
    local uiScale = U:New("UIScale", {Scale = 1, Parent = main})
    
    local cam = workspace.CurrentCamera
    local function updateScale()
        uiScale.Scale = math.clamp(cam.ViewportSize.X / 1920, 0.5, 1.5)
    end
    updateScale()
    cam:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
    
    local frame = U:New("Frame", {
        BackgroundColor3 = Library.Config.Theme.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        ClipsDescendants = true,
        Parent = main
    })
    
    Library:Reg(frame, "B")
    U:Corner(frame, 14)
    U:Shadow(main, 25)
    local frameStroke = U:Stroke(frame, Library.Config.Theme.Accent, 2, 0.4)
    Library:Reg(frameStroke, "AS")
    
    U:New("UIAspectRatioConstraint", {AspectRatio = 1.6, Parent = main})
    
    -- ════════════════════════════════════════════════════════
    -- HEADER
    -- ════════════════════════════════════════════════════════
    
    local header = U:New("Frame", {
        BackgroundColor3 = Library.Config.Theme.SecondaryBG,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0.1, 0),
        Parent = frame
    })
    
    Library:Reg(header, "S")
    U:Corner(header, 14)
    
    local headerLine = U:New("Frame", {
        BackgroundColor3 = Library.Config.Theme.Accent,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -3),
        Size = UDim2.new(1, 0, 0, 3),
        Parent = header
    })
    
    Library:Reg(headerLine, "A")
    
    U:New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0.03, 0, 0.15, 0),
        Size = UDim2.new(0.5, 0, 0.4, 0),
        Font = Enum.Font.GothamBold,
        Text = title,
        TextColor3 = Library.Config.Theme.Text,
        TextScaled = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = header
    })
    
    U:New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0.03, 0, 0.6, 0),
        Size = UDim2.new(0.5, 0, 0.3, 0),
        Font = Enum.Font.Gotham,
        Text = subtitle,
        TextColor3 = Library.Config.Theme.TextDark,
        TextScaled = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = header
    })
    
    -- ════════════════════════════════════════════════════════
    -- HEADER BUTTONS
    -- ════════════════════════════════════════════════════════
    
    local btnSize = 0.06
    local btnGap = 0.015
    local isMax = false
    
    if showMax then
        local maxBtn = U:New("TextButton", {
            BackgroundColor3 = Library.Config.Theme.TertiaryBG,
            BorderSizePixel = 0,
            Position = UDim2.new(1 - (btnSize * 3 + btnGap * 2 + 0.02), 0, 0.5, 0),
            Size = UDim2.new(btnSize, 0, 0.6, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Font = Enum.Font.GothamBold,
            Text = "□",
            TextColor3 = Library.Config.Theme.Text,
            TextScaled = true,
            AutoButtonColor = false,
            Parent = header
        })
        
        Library:Reg(maxBtn, "T")
        U:Corner(maxBtn, 8)
        
        maxBtn.MouseButton1Click:Connect(function()
            isMax = not isMax
            U:Tween(main, {Size = isMax and UDim2.new(0.9, 0, 0.9, 0) or UDim2.new(0.35, 0, 0.5, 0)}, 0.3)
            maxBtn.Text = isMax and "❐" or "□"
        end)
        
        maxBtn.MouseEnter:Connect(function() U:Tween(maxBtn, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2) end)
        maxBtn.MouseLeave:Connect(function() U:Tween(maxBtn, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.2) end)
    end
    
    local minBtn = U:New("TextButton", {
        BackgroundColor3 = Library.Config.Theme.TertiaryBG,
        BorderSizePixel = 0,
        Position = UDim2.new(1 - (btnSize * 2 + btnGap + 0.02), 0, 0.5, 0),
        Size = UDim2.new(btnSize, 0, 0.6, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Font = Enum.Font.GothamBold,
        Text = "─",
        TextColor3 = Library.Config.Theme.Text,
        TextScaled = true,
        AutoButtonColor = false,
        Parent = header
    })
    
    Library:Reg(minBtn, "T")
    U:Corner(minBtn, 8)
    
    minBtn.MouseButton1Click:Connect(function()
        U:Tween(main, {Size = UDim2.new(0, 0, 0, 0)}, 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        task.wait(0.25)
        main.Visible = false
        miniBox.Visible = true
        U:Tween(miniBox, {Size = UDim2.new(0, 90, 0, 90)}, 0.35, Enum.EasingStyle.Back)
    end)
    
    minBtn.MouseEnter:Connect(function() U:Tween(minBtn, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2) end)
    minBtn.MouseLeave:Connect(function() U:Tween(minBtn, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.2) end)
    
    local closeBtn = U:New("TextButton", {
        BackgroundColor3 = Color3.fromRGB(231, 76, 60),
        BorderSizePixel = 0,
        Position = UDim2.new(1 - (btnSize + 0.02), 0, 0.5, 0),
        Size = UDim2.new(btnSize, 0, 0.6, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Font = Enum.Font.GothamBold,
        Text = "×",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        AutoButtonColor = false,
        Parent = header
    })
    
    U:Corner(closeBtn, 8)
    
    closeBtn.MouseButton1Click:Connect(function()
        U:Tween(main, {Size = UDim2.new(0, 0, 0, 0)}, 0.25)
        task.wait(0.3)
        gui:Destroy()
    end)
    
    closeBtn.MouseEnter:Connect(function() U:Tween(closeBtn, {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}, 0.2) end)
    closeBtn.MouseLeave:Connect(function() U:Tween(closeBtn, {BackgroundColor3 = Color3.fromRGB(231, 76, 60)}, 0.2) end)
    
    U:Drag(main, header)
    
    -- ════════════════════════════════════════════════════════
    -- TAB CONTAINER
    -- ════════════════════════════════════════════════════════
    
    local tabW = 0.25
    
    local tabContainer = U:New("ScrollingFrame", {
        BackgroundColor3 = Library.Config.Theme.SecondaryBG,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0.1, 0),
        Size = UDim2.new(tabW, 0, 0.9, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Library.Config.Theme.Accent,
        Parent = frame
    })
    
    Library:Reg(tabContainer, "S")
    
    local tabList = U:New("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0.02, 0),
        Parent = tabContainer
    })
    
    U:New("UIPadding", {
        PaddingTop = UDim.new(0.02, 0),
        PaddingLeft = UDim.new(0.05, 0),
        PaddingRight = UDim.new(0.05, 0),
        PaddingBottom = UDim.new(0.02, 0),
        Parent = tabContainer
    })
    
    tabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContainer.CanvasSize = UDim2.new(0, 0, 0, tabList.AbsoluteContentSize.Y + 20)
    end)
    
    local tabIndicator = U:New("Frame", {
        BackgroundColor3 = Library.Config.Theme.Accent,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 0),
        ZIndex = 0,
        Parent = tabContainer
    })
    
    Library:Reg(tabIndicator, "A")
    U:Corner(tabIndicator, 12)
    
    local contentContainer = U:New("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(tabW, 0, 0.1, 0),
        Size = UDim2.new(1 - tabW, 0, 0.9, 0),
        Parent = frame
    })
    
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        Flags = Library.Flags,
        Options = Library.Options,
        MiniBox = MiniBox,
    }
    
    function Window:SetIcon(img) miniIcon.Image = img end
    
    -- ════════════════════════════════════════════════════════
    -- CREATE TAB
    -- ════════════════════════════════════════════════════════
    
    function Window:CreateTab(cfg)
        if type(cfg) == "string" then cfg = {Name = cfg} end
        
        local tabName = cfg.Name or "Tab"
        local tabIcon = cfg.Icon or "•"
        
        local tabBtn = U:New("TextButton", {
            BackgroundColor3 = Library.Config.Theme.TertiaryBG,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0.1, 0),
            Text = "",
            AutoButtonColor = false,
            ZIndex = 1,
            Parent = tabContainer
        })
        
        Library:Reg(tabBtn, "T")
        U:Corner(tabBtn, 12)
        U:Ripple(tabBtn)
        
        local icon = U:New("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0.15, 0, 0.5, 0),
            Size = UDim2.new(0.25, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Font = Enum.Font.GothamBold,
            Text = tabIcon,
            TextColor3 = Library.Config.Theme.TextDark,
            TextScaled = true,
            Parent = tabBtn
        })
        
        local text = U:New("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0.45, 0, 0.5, 0),
            Size = UDim2.new(0.5, 0, 0.4, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Font = Enum.Font.GothamBold,
            Text = tabName,
            TextColor3 = Library.Config.Theme.TextDark,
            TextScaled = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = tabBtn
        })
        
        local tabContent = U:New("ScrollingFrame", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 5,
            ScrollBarImageColor3 = Library.Config.Theme.Accent,
            Visible = false,
            Parent = contentContainer
        })
        
        local contentList = U:New("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0.025, 0),
            Parent = tabContent
        })
        
        U:New("UIPadding", {
            PaddingTop = UDim.new(0.02, 0),
            PaddingLeft = UDim.new(0.03, 0),
            PaddingRight = UDim.new(0.03, 0),
            PaddingBottom = UDim.new(0.02, 0),
            Parent = tabContent
        })
        
        contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabContent.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 30)
        end)
        
        tabBtn.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab:Deactivate()
            end
            
            tabContent.Visible = true
            Window.CurrentTab = tabName
            
            local targetPos = tabBtn.Position
            local targetSize = tabBtn.Size
            
            U:Tween(tabIndicator, {Position = targetPos, Size = targetSize}, 0.4, Enum.EasingStyle.Quint)
            
            U:Tween(tabBtn, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.25)
            U:Tween(icon, {TextColor3 = Library.Config.Theme.Text}, 0.25)
            U:Tween(text, {TextColor3 = Library.Config.Theme.Text}, 0.25)
        end)
        
        tabBtn.MouseEnter:Connect(function()
            if Window.CurrentTab ~= tabName then
                U:Tween(tabBtn, {BackgroundColor3 = Library.Config.Theme.SecondaryBG}, 0.15)
            end
        end)
        
        tabBtn.MouseLeave:Connect(function()
            if Window.CurrentTab ~= tabName then
                U:Tween(tabBtn, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.15)
            end
        end)
        
        local Tab = {Name = tabName, Content = tabContent}
        
        function Tab:Deactivate()
            tabContent.Visible = false
            U:Tween(tabBtn, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.2)
            U:Tween(icon, {TextColor3 = Library.Config.Theme.TextDark}, 0.2)
            U:Tween(text, {TextColor3 = Library.Config.Theme.TextDark}, 0.2)
        end
        
        -- ════════════════════════════════════════════════════════
        -- ADD SECTION
        -- ════════════════════════════════════════════════════════
        
        function Tab:AddSection(name)
            local section = U:New("Frame", {
                BackgroundColor3 = Library.Config.Theme.SecondaryBG,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 50),
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = tabContent
            })
            
            Library:Reg(section, "S")
            U:Corner(section, 12)
            
            local header = U:New("Frame", {
                BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 45),
                Parent = section
            })
            
            Library:Reg(header, "T")
            U:Corner(header, 12)
            
            local line = U:New("Frame", {
                BackgroundColor3 = Library.Config.Theme.Accent,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 43),
                Size = UDim2.new(1, 0, 0, 2),
                Parent = header
            })
            
            Library:Reg(line, "A")
            
            U:New("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0.04, 0, 0, 0),
                Size = UDim2.new(0.9, 0, 1, 0),
                Font = Enum.Font.GothamBold,
                Text = name,
                TextColor3 = Library.Config.Theme.Text,
                TextScaled = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = header
            })
            
            local content = U:New("Frame", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0, 45),
                Size = UDim2.new(1, 0, 1, -45),
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = section
            })
            
            local list = U:New("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0.025, 0),
                Parent = content
            })
            
            U:New("UIPadding", {
                PaddingTop = UDim.new(0.03, 0),
                PaddingLeft = UDim.new(0.04, 0),
                PaddingRight = UDim.new(0.04, 0),
                PaddingBottom = UDim.new(0.03, 0),
                Parent = content
            })
            
            local Section = {}
            
            -- ════════════════════════════════════════════════════════
            -- BUTTON
            -- ════════════════════════════════════════════════════════
            
            function Section:AddButton(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Button"
                local callback = cfg.Callback or function() end
                
                local btn = U:New("TextButton", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 40),
                    Text = "",
                    AutoButtonColor = false,
                    Parent = content
                })
                
                Library:Reg(btn, "T")
                U:Corner(btn, 10)
                U:Ripple(btn)
                
                U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0.95, 0, 1, 0),
                    Position = UDim2.new(0.025, 0, 0, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextScaled = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = btn
                })
                
                btn.MouseEnter:Connect(function() U:Tween(btn, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2) end)
                btn.MouseLeave:Connect(function() U:Tween(btn, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.2) end)
                btn.MouseButton1Click:Connect(callback)
            end
            
            -- ════════════════════════════════════════════════════════
            -- TOGGLE
            -- ════════════════════════════════════════════════════════
            
            function Section:AddToggle(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Toggle"
                local default = cfg.Default or false
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                
                local toggle = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 40),
                    Parent = content
                })
                
                Library:Reg(toggle, "T")
                U:Corner(toggle, 10)
                
                U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.04, 0, 0, 0),
                    Size = UDim2.new(0.7, 0, 1, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextScaled = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = toggle
                })
                
                local switch = U:New("TextButton", {
                    BackgroundColor3 = default and Library.Config.Theme.Accent or Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.85, 0, 0.5, 0),
                    Size = UDim2.new(0.12, 0, 0.6, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Text = "",
                    AutoButtonColor = false,
                    Parent = toggle
                })
                
                if default then Library:Reg(switch, "A") end
                U:Corner(switch, 20)
                
                local circle = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Text,
                    BorderSizePixel = 0,
                    Position = default and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 4, 0.5, 0),
                    Size = UDim2.new(0, 16, 0, 16),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Parent = switch
                })
                
                U:Corner(circle, 20)
                
                local toggled = default
                
                if flag then
                    Library.Flags[flag] = toggled
                    Library.Options[flag] = {
                        Set = function(v)
                            toggled = v
                            U:Tween(switch, {BackgroundColor3 = toggled and Library.Config.Theme.Accent or Library.Config.Theme.Background}, 0.2)
                            U:Tween(circle, {Position = toggled and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 4, 0.5, 0)}, 0.3, Enum.EasingStyle.Back)
                            callback(toggled)
                        end,
                        Get = function() return toggled end
                    }
                end
                
                switch.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    if flag then Library.Flags[flag] = toggled end
                    
                    U:Tween(switch, {BackgroundColor3 = toggled and Library.Config.Theme.Accent or Library.Config.Theme.Background}, 0.2)
                    U:Tween(circle, {Position = toggled and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 4, 0.5, 0)}, 0.3, Enum.EasingStyle.Back)
                    callback(toggled)
                end)
                
                return Library.Options[flag] or {Set = function(v) end, Get = function() return toggled end}
            end
            
            -- ════════════════════════════════════════════════════════
            -- SLIDER
            -- ════════════════════════════════════════════════════════
            
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
                
                local slider = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 60),
                    Parent = content
                })
                
                Library:Reg(slider, "T")
                U:Corner(slider, 10)
                
                U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.04, 0, 0.15, 0),
                    Size = UDim2.new(0.6, 0, 0.3, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextScaled = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = slider
                })
                
                local valueText = U:New("TextLabel", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.85, 0, 0.15, 0),
                    Size = UDim2.new(0.12, 0, 0.3, 0),
                    Font = Enum.Font.GothamBold,
                    Text = tostring(default) .. suffix,
                    TextColor3 = Library.Config.Theme.Accent,
                    TextScaled = true,
                    Parent = slider
                })
                
                Library:Reg(valueText, "AT")
                U:Corner(valueText, 6)
                
                local bar = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.04, 0, 0.65, 0),
                    Size = UDim2.new(0.92, 0, 0.15, 0),
                    Parent = slider
                })
                
                U:Corner(bar, 10)
                
                local fill = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Accent,
                    BorderSizePixel = 0,
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    Parent = bar
                })
                
                Library:Reg(fill, "A")
                U:Corner(fill, 10)
                
                local dot = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Text,
                    BorderSizePixel = 0,
                    Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0),
                    Size = UDim2.new(0, 16, 0, 16),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Parent = bar
                })
                
                U:Corner(dot, 20)
                
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
                        U:Tween(dot, {Size = UDim2.new(0, 20, 0, 20)}, 0.2, Enum.EasingStyle.Back)
                    end
                end)
                
                bar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                        U:Tween(dot, {Size = UDim2.new(0, 16, 0, 16)}, 0.2)
                    end
                end)
                
                Services.UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        update(input)
                    end
                end)
                
                return Library.Options[flag] or {Set = function(v) end, Get = function() return default end}
            end
            
            -- ════════════════════════════════════════════════════════
            -- DROPDOWN
            -- ════════════════════════════════════════════════════════
            
            function Section:AddDropdown(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Dropdown"
                local items = cfg.Items or {"Item1", "Item2"}
                local default = cfg.Default or items[1]
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                local search = cfg.Search or false
                
                local dropdown = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 40),
                    ClipsDescendants = true,
                    Parent = content
                })
                
                Library:Reg(dropdown, "T")
                U:Corner(dropdown, 10)
                
                U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.04, 0, 0, 0),
                    Size = UDim2.new(0.4, 0, 1, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextScaled = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = dropdown
                })
                
                local btn = U:New("TextButton", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.48, 0, 0.25, 0),
                    Size = UDim2.new(0.48, 0, 0.5, 0),
                    Font = Enum.Font.Gotham,
                    Text = "  " .. default,
                    TextColor3 = Library.Config.Theme.Accent,
                    TextScaled = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutoButtonColor = false,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Parent = dropdown
                })
                
                Library:Reg(btn, "AT")
                U:Corner(btn, 8)
                
                local arrow = U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -20, 0, 0),
                    Size = UDim2.new(0, 18, 1, 0),
                    Font = Enum.Font.GothamBold,
                    Text = "▼",
                    TextColor3 = Library.Config.Theme.TextDark,
                    TextScaled = true,
                    Parent = btn
                })
                
                local listContainer = U:New("Frame", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.04, 0, 0, 45),
                    Size = UDim2.new(0.92, 0, 0, 0),
                    Parent = dropdown
                })
                
                local searchBox
                if search then
                    searchBox = U:New("TextBox", {
                        BackgroundColor3 = Library.Config.Theme.Background,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 30),
                        Font = Enum.Font.Gotham,
                        PlaceholderText = "🔍 Search...",
                        PlaceholderColor3 = Library.Config.Theme.TextDark,
                        Text = "",
                        TextColor3 = Library.Config.Theme.Text,
                        TextSize = 13,
                        ClearTextOnFocus = false,
                        Parent = listContainer
                    })
                    
                    U:Corner(searchBox, 7)
                    U:New("UIPadding", {PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), Parent = searchBox})
                end
                
                local list = U:New("ScrollingFrame", {
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, search and 35 or 0),
                    Size = UDim2.new(1, 0, 0, 0),
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    ScrollBarThickness = 4,
                    ScrollBarImageColor3 = Library.Config.Theme.Accent,
                    Parent = listContainer
                })
                
                local listLayout = U:New("UIListLayout", {
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
                    local item = U:New("TextButton", {
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
                    
                    U:Corner(item, 7)
                    
                    item.MouseEnter:Connect(function()
                        U:Tween(item, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2)
                    end)
                    
                    item.MouseLeave:Connect(function()
                        U:Tween(item, {BackgroundColor3 = Library.Config.Theme.Background}, 0.2)
                    end)
                    
                    item.MouseButton1Click:Connect(function()
                        current = itemName
                        btn.Text = "  " .. itemName
                        if flag then Library.Flags[flag] = itemName end
                        callback(itemName)
                        
                        expanded = false
                        U:Tween(dropdown, {Size = UDim2.new(1, 0, 0, 40)}, 0.3, Enum.EasingStyle.Back)
                        U:Tween(arrow, {Rotation = 0}, 0.3)
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
                        local searchH = search and 35 or 0
                        local totalH = 40 + 10 + searchH + (maxItems * 33)
                        
                        U:Tween(dropdown, {Size = UDim2.new(1, 0, 0, totalH)}, 0.3, Enum.EasingStyle.Back)
                        U:Tween(arrow, {Rotation = 180}, 0.3)
                        list.Size = UDim2.new(1, 0, 0, maxItems * 33)
                    else
                        U:Tween(dropdown, {Size = UDim2.new(1, 0, 0, 40)}, 0.3, Enum.EasingStyle.Back)
                        U:Tween(arrow, {Rotation = 0}, 0.3)
                    end
                end)
                
                return Library.Options[flag] or {Set = function(v) end, Get = function() return current end, Refresh = function() end}
            end
            
            -- ════════════════════════════════════════════════════════
            -- COLORPICKER
            -- ════════════════════════════════════════════════════════
            
            function Section:AddColorPicker(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Color"
                local default = cfg.Default or Color3.fromRGB(255, 255, 255)
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                
                local picker = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 40),
                    ClipsDescendants = true,
                    Parent = content
                })
                
                Library:Reg(picker, "T")
                U:Corner(picker, 10)
                
                U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.04, 0, 0, 0),
                    Size = UDim2.new(0.7, 0, 1, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextScaled = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = picker
                })
                
                local display = U:New("TextButton", {
                    BackgroundColor3 = default,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.82, 0, 0.25, 0),
                    Size = UDim2.new(0.14, 0, 0.5, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Parent = picker
                })
                
                U:Corner(display, 7)
                U:Stroke(display, Library.Config.Theme.Border, 2)
                
                local palette = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.04, 0, 0, 45),
                    Size = UDim2.new(0.92, 0, 0, 170),
                    Visible = false,
                    Parent = picker
                })
                
                U:Corner(palette, 10)
                
                local canvas = U:New("ImageButton", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.05, 0, 0.05, 0),
                    Size = UDim2.new(0.7, 0, 0.9, 0),
                    Image = "rbxassetid://4155801252",
                    AutoButtonColor = false,
                    Parent = palette
                })
                
                U:Corner(canvas, 8)
                
                local hue = U:New("ImageButton", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.78, 0, 0.05, 0),
                    Size = UDim2.new(0.1, 0, 0.9, 0),
                    Image = "rbxassetid://3641079629",
                    AutoButtonColor = false,
                    Parent = palette
                })
                
                U:Corner(hue, 8)
                
                local confirm = U:New("TextButton", {
                    BackgroundColor3 = Library.Config.Theme.Accent,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.9, 0, 0.05, 0),
                    Size = UDim2.new(0.08, 0, 0.2, 0),
                    Font = Enum.Font.GothamBold,
                    Text = "✓",
                    TextColor3 = Library.Config.Theme.Text,
                    TextScaled = true,
                    AutoButtonColor = false,
                    Parent = palette
                })
                
                Library:Reg(confirm, "A")
                U:Corner(confirm, 6)
                
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
                    U:Tween(picker, {Size = UDim2.new(1, 0, 0, expanded and 220 or 40)}, 0.3, Enum.EasingStyle.Back)
                end)
                
                confirm.MouseButton1Click:Connect(function()
                    expanded = false
                    palette.Visible = false
                    U:Tween(picker, {Size = UDim2.new(1, 0, 0, 40)}, 0.3, Enum.EasingStyle.Back)
                end)
                
                return Library.Options[flag] or {Set = function(c) end, Get = function() return Color3.fromHSV(h, s, v) end}
            end
            
            -- ════════════════════════════════════════════════════════
            -- TEXTBOX
            -- ════════════════════════════════════════════════════════
            
            function Section:AddTextbox(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Textbox"
                local default = cfg.Default or ""
                local placeholder = cfg.Placeholder or "Enter..."
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                
                local box = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 40),
                    Parent = content
                })
                
                Library:Reg(box, "T")
                U:Corner(box, 10)
                
                U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.04, 0, 0, 0),
                    Size = UDim2.new(0.38, 0, 1, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextScaled = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = box
                })
                
                local input = U:New("TextBox", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.46, 0, 0.25, 0),
                    Size = UDim2.new(0.5, 0, 0.5, 0),
                    Font = Enum.Font.Gotham,
                    PlaceholderText = placeholder,
                    PlaceholderColor3 = Library.Config.Theme.TextDark,
                    Text = default,
                    TextColor3 = Library.Config.Theme.Accent,
                    TextScaled = true,
                    ClearTextOnFocus = false,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Parent = box
                })
                
                Library:Reg(input, "AT")
                U:Corner(input, 7)
                U:New("UIPadding", {PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), Parent = input})
                
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
            
            -- ════════════════════════════════════════════════════════
            -- KEYBIND
            -- ════════════════════════════════════════════════════════
            
            function Section:AddKeybind(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Keybind"
                local default = cfg.Default or Enum.KeyCode.E
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                local mode = cfg.Mode or "Toggle"
                
                local keybind = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 40),
                    Parent = content
                })
                
                Library:Reg(keybind, "T")
                U:Corner(keybind, 10)
                
                U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.04, 0, 0, 0),
                    Size = UDim2.new(0.6, 0, 1, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextScaled = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = keybind
                })
                
                local keyBtn = U:New("TextButton", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.73, 0, 0.25, 0),
                    Size = UDim2.new(0.23, 0, 0.5, 0),
                    Font = Enum.Font.Gotham,
                    Text = default.Name,
                    TextColor3 = Library.Config.Theme.Accent,
                    TextScaled = true,
                    AutoButtonColor = false,
                    Parent = keybind
                })
                
                Library:Reg(keyBtn, "AT")
                U:Corner(keyBtn, 7)
                
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
                    U:Tween(keyBtn, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2)
                end)
                
                Services.UserInputService.InputBegan:Connect(function(input, gp)
                    if gp then return end
                    
                    if listening then
                        if input.KeyCode ~= Enum.KeyCode.Unknown then
                            current = input.KeyCode
                            keyBtn.Text = input.KeyCode.Name
                            listening = false
                            if flag then Library.Flags[flag] = current end
                            U:Tween(keyBtn, {BackgroundColor3 = Library.Config.Theme.Background}, 0.2)
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
            
            -- ════════════════════════════════════════════════════════
            -- LABEL
            -- ════════════════════════════════════════════════════════
            
            function Section:AddLabel(text)
                local label = U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 24),
                    Font = Enum.Font.Gotham,
                    Text = text or "Label",
                    TextColor3 = Library.Config.Theme.TextDark,
                    TextScaled = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Parent = content
                })
                
                return {Set = function(t) label.Text = t end}
            end
            
            -- ════════════════════════════════════════════════════════
            -- PARAGRAPH
            -- ════════════════════════════════════════════════════════
            
            function Section:AddParagraph(title, text)
                local para = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 70),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Parent = content
                })
                
                U:Corner(para, 10)
                
                local paraTitle = U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.04, 0, 0, 8),
                    Size = UDim2.new(0.92, 0, 0, 22),
                    Font = Enum.Font.GothamBold,
                    Text = title or "Title",
                    TextColor3 = Library.Config.Theme.Text,
                    TextScaled = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = para
                })
                
                local paraContent = U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.04, 0, 0, 32),
                    Size = UDim2.new(0.92, 0, 1, -42),
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
                
                U:New("UIPadding", {PaddingBottom = UDim.new(0, 12), Parent = para})
                
                return {
                    SetTitle = function(t) paraTitle.Text = t end,
                    SetContent = function(c) paraContent.Text = c end
                }
            end
            
            -- ════════════════════════════════════════════════════════
            -- DIVIDER
            -- ════════════════════════════════════════════════════════
            
            function Section:AddDivider(text)
                local div = U:New("Frame", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, text and 32 or 12),
                    Parent = content
                })
                
                local line = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Border,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0.5, 0),
                    Size = UDim2.new(1, 0, 0, 2),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Parent = div
                })
                
                if text then
                    U:New("TextLabel", {
                        BackgroundColor3 = Library.Config.Theme.SecondaryBG,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(0, 0, 0, 22),
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
            
            tabIndicator.Position = tabBtn.Position
            tabIndicator.Size = tabBtn.Size
        end
        
        table.insert(Window.Tabs, Tab)
        return Tab
    end
    
    if keybind then
        local visible = true
        Services.UserInputService.InputBegan:Connect(function(input, gp)
            if not gp and input.KeyCode == keybind then
                visible = not visible
                
                if miniBox.Visible then
                    miniBox.Visible = false
                    U:Tween(miniBox, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
                    main.Visible = true
                    U:Tween(main, {Size = visible and UDim2.new(0.35, 0, 0.5, 0) or UDim2.new(0, 0, 0, 0)}, 0.3)
                else
                    U:Tween(main, {Size = visible and UDim2.new(0.35, 0, 0.5, 0) or UDim2.new(0, 0, 0, 0)}, 0.3)
                end
            end
        end)
    end
    
    U:Tween(main, {Size = UDim2.new(0.35, 0, 0.5, 0)}, 0.5, Enum.EasingStyle.Quart)
    
    return Window
end

return Library
