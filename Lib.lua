--[[
    ════════════════════════════════════════════════════════
           UI LIBRARY - ULTIMATE COMPLETE VERSION
                     Version 12.1.0 ENHANCED
    ════════════════════════════════════════════════════════
    
    ✓ حجم واجهة محسّن (أكبر وأوضح)
    ✓ Dropdown محسّن بدون بحث - أكثر سلاسة
    ✓ Color Picker مُصلح بالكامل
    ✓ دعم كامل للجوال
    ✓ Minimize Box محسّن ومُصلح
    ✓ Animated Tab Indicator
    ✓ منع فتح العناصر عند السحب
    ✓ 15 ثيم جاهز
    ✓ أنيميشن سلس للغاية
    
    ════════════════════════════════════════════════════════
]]

local Library = {}
Library.Version = "12.1.0"
Library.Flags = {}
Library.Options = {}
Library.ThemeObjects = {}

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
local Mouse = Player:GetMouse()

-- ════════════════════════════════════════════════════════
-- CONFIGURATION
-- ════════════════════════════════════════════════════════

Library.Config = {
    UI = {
        Animations = true,
        AnimationSpeed = 0.25,
        Font = Enum.Font.Gotham,
        TextSize = 14,
        DefaultSize = UDim2.new(0, 650, 0, 500),
        MinSize = UDim2.new(0, 500, 0, 350),
        MaxSize = UDim2.new(0, 1400, 0, 800),
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
    
    ConfigFolder = "UILibConfigs",
}

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
    local dragging = false
    local dragInput, mousePos, framePos
    local dragStart, startPos
    local dragThreshold = 5
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragStart = input.Position
            startPos = gui.Position
            dragging = false
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    connection:Disconnect()
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
        if input == dragInput and dragStart then
            local delta = input.Position - dragStart
            
            if not dragging and delta.Magnitude > dragThreshold then
                dragging = true
                mousePos = dragStart
                framePos = startPos
            end
            
            if dragging then
                local newPos = UDim2.new(
                    framePos.X.Scale,
                    framePos.X.Offset + delta.X,
                    framePos.Y.Scale,
                    framePos.Y.Offset + delta.Y
                )
                gui.Position = newPos
            end
        end
    end)
    
    return function()
        return dragging
    end
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
        
        local m = Vector2.new(Mouse.X, Mouse.Y)
        local p = m - btn.AbsolutePosition
        r.Position = UDim2.new(0, p.X, 0, p.Y)
        
        local sz = math.max(btn.AbsoluteSize.X, btn.AbsoluteSize.Y) * 2.5
        U:Tween(r, {Size = UDim2.new(0, sz, 0, sz), ImageTransparency = 1}, 0.6)
        task.delay(0.6, function() if r then r:Destroy() end end)
    end)
end

-- ════════════════════════════════════════════════════════
-- CONFIG SYSTEM
-- ════════════════════════════════════════════════════════

function Library:SaveConfig(name)
    name = name or "default"
    local success, err = pcall(function()
        if not isfolder(self.Config.ConfigFolder) then 
            makefolder(self.Config.ConfigFolder) 
        end
        
        local data = {
            Version = self.Version,
            Flags = {},
            Theme = nil,
            Time = os.date("%Y-%m-%d %H:%M:%S"),
        }
        
        for flag, value in pairs(self.Flags) do
            if type(value) == "Color3" then
                data.Flags[flag] = {value.R, value.G, value.B}
            elseif type(value) == "EnumItem" then
                data.Flags[flag] = tostring(value)
            else
                data.Flags[flag] = value
            end
        end
        
        local encoded = Services.HttpService:JSONEncode(data)
        writefile(self.Config.ConfigFolder .. "/" .. name .. ".json", encoded)
    end)
    
    return success, err
end

function Library:LoadConfig(name)
    name = name or "default"
    local success, result = pcall(function()
        local content = readfile(self.Config.ConfigFolder .. "/" .. name .. ".json")
        local data = Services.HttpService:JSONDecode(content)
        
        if data and data.Flags then
            for flag, value in pairs(data.Flags) do
                if self.Options[flag] then
                    pcall(function()
                        if type(value) == "table" and #value == 3 then
                            value = Color3.new(value[1], value[2], value[3])
                        end
                        if type(value) == "string" and value:match("Enum%.KeyCode%.") then
                            local keyName = value:match("Enum%.KeyCode%.(.+)")
                            value = Enum.KeyCode[keyName]
                        end
                        
                        self.Options[flag]:Set(value)
                    end)
                end
            end
            return true
        end
        return false
    end)
    
    return success and result
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
                if name then 
                    table.insert(configs, name) 
                end
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

function Library:CreateWindow(cfg)
    cfg = cfg or {}
    
    local title = cfg.Title or "UI Library v12.1"
    local subtitle = cfg.Subtitle or "Enhanced Edition"
    local keybind = cfg.Keybind or Enum.KeyCode.RightControl
    local icon = cfg.Icon or "rbxassetid://11963374911"
    local size = cfg.Size or Library.Config.UI.DefaultSize
    
    local gui = U:New("ScreenGui", {
        Name = "UILibrary_" .. tostring(math.random(1000, 9999)),
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        DisplayOrder = 100,
        IgnoreGuiInset = true,
        Parent = gethui and gethui() or Services.CoreGui
    })
    
    -- ════════════════════════════════════════════════════════
    -- MINIMIZE BOX (مُصلح بالكامل)
    -- ════════════════════════════════════════════════════════
    
    local miniBox = U:New("Frame", {
        Name = "MiniBox",
        BackgroundColor3 = Library.Config.Theme.SecondaryBG,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Visible = false,
        ZIndex = 100,
        Active = true, -- مهم للتفاعل
        Parent = gui
    })
    
    Library:Reg(miniBox, "S")
    U:Corner(miniBox, 20)
    U:Shadow(miniBox, 20)
    local miniStroke = U:Stroke(miniBox, Library.Config.Theme.Accent, 3, 0)
    Library:Reg(miniStroke, "AS")
    
    -- سحب MiniBox بتوين سلس
    local miniDragging = false
    local miniDragStart, miniStartPos
    
    miniBox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            miniDragStart = input.Position
            miniStartPos = miniBox.Position
            miniDragging = false
        end
    end)
    
    miniBox.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if miniDragStart then
                local delta = input.Position - miniDragStart
                if not miniDragging and delta.Magnitude > 5 then
                    miniDragging = true
                end
                
                if miniDragging then
                    miniBox.Position = UDim2.new(
                        miniStartPos.X.Scale,
                        miniStartPos.X.Offset + delta.X,
                        miniStartPos.Y.Scale,
                        miniStartPos.Y.Offset + delta.Y
                    )
                end
            end
        end
    end)
    
    local miniIcon = U:New("ImageLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0.55, 0, 0.55, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Image = icon,
        ImageColor3 = Library.Config.Theme.Accent,
        ScaleType = Enum.ScaleType.Fit,
        Parent = miniBox
    })
    
    Library:Reg(miniIcon, "AI")
    
    -- تأثير النبض
    local pulseRunning = false
    local function pulse()
        if miniBox.Visible and not pulseRunning then
            pulseRunning = true
            while miniBox.Visible do
                U:Tween(miniIcon, {Size = UDim2.new(0.65, 0, 0.65, 0)}, 0.5, Enum.EasingStyle.Sine)
                task.wait(0.5)
                if not miniBox.Visible then break end
                U:Tween(miniIcon, {Size = UDim2.new(0.55, 0, 0.55, 0)}, 0.5, Enum.EasingStyle.Sine)
                task.wait(0.5)
            end
            pulseRunning = false
        end
    end
    
    miniBox:GetPropertyChangedSignal("Visible"):Connect(function()
        if miniBox.Visible then
            task.spawn(pulse)
        end
    end)
    
    -- Double-click لفتح النافذة (مُصلح)
    local clicks, lastClick = 0, 0
    miniBox.InputEnded:Connect(function(inp)
        if (inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch) and not miniDragging then
            local now = tick()
            if now - lastClick < 0.4 then
                clicks = clicks + 1
            else
                clicks = 1
            end
            lastClick = now
            
            if clicks >= 2 then
                clicks = 0
                -- فتح النافذة الرئيسية بتوين سلس
                local miniPos = miniBox.AbsolutePosition
                U:Tween(miniBox, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                task.wait(0.35)
                miniBox.Visible = false
                miniDragging = false
                miniDragStart = nil
                
                main.Visible = true
                main.Position = UDim2.new(0, miniPos.X + 40, 0, miniPos.Y + 40)
                U:Tween(main, {
                    Size = size,
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                }, 0.5, Enum.EasingStyle.Back)
            end
        end
        miniDragging = false
        miniDragStart = nil
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
    
    local frame = U:New("Frame", {
        BackgroundColor3 = Library.Config.Theme.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        ClipsDescendants = true,
        Parent = main
    })
    
    Library:Reg(frame, "B")
    U:Corner(frame, 12)
    U:Shadow(main, 30)
    local frameStroke = U:Stroke(frame, Library.Config.Theme.Accent, 2, 0.3)
    Library:Reg(frameStroke, "AS")
    
    -- ════════════════════════════════════════════════════════
    -- HEADER
    -- ════════════════════════════════════════════════════════
    
    local header = U:New("Frame", {
        BackgroundColor3 = Library.Config.Theme.SecondaryBG,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 50),
        Parent = frame
    })
    
    Library:Reg(header, "S")
    U:Corner(header, 12)
    
    local headerLine = U:New("Frame", {
        BackgroundColor3 = Library.Config.Theme.Accent,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -2),
        Size = UDim2.new(1, 0, 0, 2),
        Parent = header
    })
    
    Library:Reg(headerLine, "A")
    
    local titleLabel = U:New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 60, 0, 8),
        Size = UDim2.new(0, 200, 0, 18),
        Font = Enum.Font.GothamBold,
        Text = title,
        TextColor3 = Library.Config.Theme.Text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = header
    })
    
    local subtitleLabel = U:New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 60, 0, 28),
        Size = UDim2.new(0, 200, 0, 14),
        Font = Enum.Font.Gotham,
        Text = subtitle,
        TextColor3 = Library.Config.Theme.TextDark,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = header
    })
    
    local headerIcon = U:New("ImageLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0.5, 0),
        Size = UDim2.new(0, 36, 0, 36),
        AnchorPoint = Vector2.new(0, 0.5),
        Image = icon,
        ImageColor3 = Library.Config.Theme.Accent,
        ScaleType = Enum.ScaleType.Fit,
        Parent = header
    })
    
    Library:Reg(headerIcon, "AI")
    
    -- ════════════════════════════════════════════════════════
    -- HEADER BUTTONS (بدون زر الإعدادات)
    -- ════════════════════════════════════════════════════════
    
    local btnContainer = U:New("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -80, 0.5, 0),
        Size = UDim2.new(0, 70, 0, 30),
        AnchorPoint = Vector2.new(0, 0.5),
        Parent = header
    })
    
    U:New("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        Parent = btnContainer
    })
    
    -- Minimize Button
    local minBtn = U:New("TextButton", {
        BackgroundColor3 = Library.Config.Theme.TertiaryBG,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 30, 0, 30),
        Font = Enum.Font.GothamBold,
        Text = "─",
        TextColor3 = Library.Config.Theme.Text,
        TextSize = 14,
        AutoButtonColor = false,
        LayoutOrder = 1,
        Parent = btnContainer
    })
    
    Library:Reg(minBtn, "T")
    U:Corner(minBtn, 8)
    
    minBtn.MouseButton1Click:Connect(function()
        -- تصغير إلى MiniBox بتوين سلس
        local mainPos = main.AbsolutePosition
        local mainSize = main.AbsoluteSize
        
        U:Tween(main, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.35)
        main.Visible = false
        
        miniBox.Position = UDim2.new(0, mainPos.X + mainSize.X/2, 0, mainPos.Y + mainSize.Y/2)
        miniBox.Visible = true
        U:Tween(miniBox, {Size = UDim2.new(0, 80, 0, 80)}, 0.4, Enum.EasingStyle.Back)
    end)
    
    minBtn.MouseEnter:Connect(function() U:Tween(minBtn, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2) end)
    minBtn.MouseLeave:Connect(function() U:Tween(minBtn, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.2) end)
    
    -- Close Button
    local closeBtn = U:New("TextButton", {
        BackgroundColor3 = Library.Config.Theme.Error,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 30, 0, 30),
        Font = Enum.Font.GothamBold,
        Text = "×",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 18,
        AutoButtonColor = false,
        LayoutOrder = 2,
        Parent = btnContainer
    })
    
    U:Corner(closeBtn, 8)
    
    closeBtn.MouseButton1Click:Connect(function()
        U:Tween(main, {Size = UDim2.new(0, 0, 0, 0)}, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.3)
        gui:Destroy()
    end)
    
    closeBtn.MouseEnter:Connect(function() U:Tween(closeBtn, {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}, 0.2) end)
    closeBtn.MouseLeave:Connect(function() U:Tween(closeBtn, {BackgroundColor3 = Library.Config.Theme.Error}, 0.2) end)
    
    local isDragging = U:Drag(main, header)
    
    -- ════════════════════════════════════════════════════════
    -- TAB CONTAINER مع Animated Indicator
    -- ════════════════════════════════════════════════════════
    
    local tabContainer = U:New("ScrollingFrame", {
        BackgroundColor3 = Library.Config.Theme.SecondaryBG,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 50),
        Size = UDim2.new(0, 180, 1, -50),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 5,
        ScrollBarImageColor3 = Library.Config.Theme.Accent,
        Parent = frame
    })
    
    Library:Reg(tabContainer, "S")
    
    local tabList = U:New("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        Parent = tabContainer
    })
    
    U:New("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        Parent = tabContainer
    })
    
    tabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContainer.CanvasSize = UDim2.new(0, 0, 0, tabList.AbsoluteContentSize.Y + 20)
    end)
    
    -- ════════════════════════════════════════════════════════
    -- ANIMATED TAB INDICATOR ✨
    -- ════════════════════════════════════════════════════════
    
    local tabIndicator = U:New("Frame", {
        BackgroundColor3 = Library.Config.Theme.Accent,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 10, 0, 10),
        Size = UDim2.new(1, -20, 0, 45),
        ZIndex = 0,
        Visible = false,
        Parent = tabContainer
    })
    
    Library:Reg(tabIndicator, "A")
    U:Corner(tabIndicator, 10)
    
    local contentContainer = U:New("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 180, 0, 50),
        Size = UDim2.new(1, -180, 1, -50),
        Parent = frame
    })
    
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        Flags = Library.Flags,
        Options = Library.Options,
    }
    
    -- ════════════════════════════════════════════════════════
    -- CREATE TAB
    -- ════════════════════════════════════════════════════════
    
    function Window:CreateTab(cfg)
        if type(cfg) == "string" then cfg = {Name = cfg, Icon = "📑"} end
        
        local tabName = cfg.Name or "Tab"
        local tabIcon = cfg.Icon or "📑"
        
        local tabBtn = U:New("TextButton", {
            BackgroundColor3 = Library.Config.Theme.TertiaryBG,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 45),
            Text = "",
            AutoButtonColor = false,
            ZIndex = 1,
            Parent = tabContainer
        })
        
        Library:Reg(tabBtn, "T")
        U:Corner(tabBtn, 10)
        U:Ripple(tabBtn)
        
        local icon = U:New("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0.5, 0),
            Size = UDim2.new(0, 24, 0, 24),
            AnchorPoint = Vector2.new(0, 0.5),
            Font = Enum.Font.GothamBold,
            Text = tabIcon,
            TextColor3 = Library.Config.Theme.TextDark,
            TextSize = 16,
            ZIndex = 2,
            Parent = tabBtn
        })
        
        local text = U:New("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 45, 0.5, 0),
            Size = UDim2.new(1, -55, 0, 20),
            AnchorPoint = Vector2.new(0, 0.5),
            Font = Enum.Font.GothamBold,
            Text = tabName,
            TextColor3 = Library.Config.Theme.TextDark,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            ZIndex = 2,
            Parent = tabBtn
        })
        
        local tabContent = U:New("ScrollingFrame", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 6,
            ScrollBarImageColor3 = Library.Config.Theme.Accent,
            Visible = false,
            Parent = contentContainer
        })
        
        local contentList = U:New("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12),
            Parent = tabContent
        })
        
        U:New("UIPadding", {
            PaddingTop = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12),
            Parent = tabContent
        })
        
        contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabContent.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 24)
        end)
        
        tabBtn.MouseButton1Click:Connect(function()
            if isDragging() then return end
            
            for _, tab in pairs(Window.Tabs) do
                tab:Deactivate()
            end
            
            tabContent.Visible = true
            Window.CurrentTab = tabName
            
            -- تحريك المؤشر بسلاسة
            tabIndicator.Visible = true
            U:Tween(tabIndicator, {
                Position = UDim2.new(0, tabBtn.Position.X.Offset, 0, tabBtn.AbsolutePosition.Y - tabContainer.AbsolutePosition.Y + tabContainer.CanvasPosition.Y)
            }, 0.35, Enum.EasingStyle.Quart)
            
            U:Tween(icon, {TextColor3 = Library.Config.Theme.Text}, 0.2)
            U:Tween(text, {TextColor3 = Library.Config.Theme.Text}, 0.2)
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
        
        local Tab = {Name = tabName, Content = tabContent, Button = tabBtn}
        
        function Tab:Deactivate()
            tabContent.Visible = false
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
            U:Corner(section, 10)
            
            local header = U:New("Frame", {
                BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 42),
                Parent = section
            })
            
            Library:Reg(header, "T")
            U:Corner(header, 10)
            
            local line = U:New("Frame", {
                BackgroundColor3 = Library.Config.Theme.Accent,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 1, -2),
                Size = UDim2.new(1, 0, 0, 2),
                Parent = header
            })
            
            Library:Reg(line, "A")
            
            U:New("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 15, 0, 0),
                Size = UDim2.new(1, -30, 1, 0),
                Font = Enum.Font.GothamBold,
                Text = name,
                TextColor3 = Library.Config.Theme.Text,
                TextSize = 15,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = header
            })
            
            local content = U:New("Frame", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0, 42),
                Size = UDim2.new(1, 0, 1, -42),
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = section
            })
            
            local list = U:New("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10),
                Parent = content
            })
            
            U:New("UIPadding", {
                PaddingTop = UDim.new(0, 12),
                PaddingLeft = UDim.new(0, 12),
                PaddingRight = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 12),
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
                    Size = UDim2.new(1, 0, 0, 42),
                    Text = "",
                    AutoButtonColor = false,
                    Parent = content
                })
                
                Library:Reg(btn, "T")
                U:Corner(btn, 8)
                U:Ripple(btn)
                
                U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -24, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = btn
                })
                
                btn.MouseEnter:Connect(function() U:Tween(btn, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2) end)
                btn.MouseLeave:Connect(function() U:Tween(btn, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.2) end)
                btn.MouseButton1Click:Connect(function()
                    if not isDragging() then callback() end
                end)
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
                    Size = UDim2.new(1, 0, 0, 42),
                    Parent = content
                })
                
                Library:Reg(toggle, "T")
                U:Corner(toggle, 8)
                
                U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(0.7, 0, 1, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = toggle
                })
                
                local switch = U:New("TextButton", {
                    BackgroundColor3 = default and Library.Config.Theme.Accent or Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -60, 0.5, 0),
                    Size = UDim2.new(0, 50, 0, 26),
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
                    Position = default and UDim2.new(1, -22, 0.5, 0) or UDim2.new(0, 4, 0.5, 0),
                    Size = UDim2.new(0, 18, 0, 18),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Parent = switch
                })
                
                U:Corner(circle, 20)
                
                local toggled = default
                
                if flag then
                    Library.Flags[flag] = toggled
                    Library.Options[flag] = {
                        Set = function(self, v)
                            toggled = v
                            U:Tween(switch, {BackgroundColor3 = toggled and Library.Config.Theme.Accent or Library.Config.Theme.Background}, 0.2)
                            U:Tween(circle, {Position = toggled and UDim2.new(1, -22, 0.5, 0) or UDim2.new(0, 4, 0.5, 0)}, 0.3, Enum.EasingStyle.Back)
                            callback(toggled)
                        end,
                        Get = function(self) return toggled end
                    }
                end
                
                switch.MouseButton1Click:Connect(function()
                    if isDragging() then return end
                    
                    toggled = not toggled
                    if flag then Library.Flags[flag] = toggled end
                    
                    U:Tween(switch, {BackgroundColor3 = toggled and Library.Config.Theme.Accent or Library.Config.Theme.Background}, 0.2)
                    U:Tween(circle, {Position = toggled and UDim2.new(1, -22, 0.5, 0) or UDim2.new(0, 4, 0.5, 0)}, 0.3, Enum.EasingStyle.Back)
                    callback(toggled)
                end)
                
                return Library.Options[flag] or {Set = function(self, v) end, Get = function() return toggled end}
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
                    Size = UDim2.new(1, 0, 0, 65),
                    Parent = content
                })
                
                Library:Reg(slider, "T")
                U:Corner(slider, 8)
                
                U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 12, 0, 8),
                    Size = UDim2.new(0.6, 0, 0, 18),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = slider
                })
                
                local valueText = U:New("TextLabel", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -70, 0, 8),
                    Size = UDim2.new(0, 58, 0, 18),
                    Font = Enum.Font.GothamBold,
                    Text = tostring(default) .. suffix,
                    TextColor3 = Library.Config.Theme.Accent,
                    TextSize = 13,
                    Parent = slider
                })
                
                Library:Reg(valueText, "AT")
                U:Corner(valueText, 6)
                
                local bar = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 12, 0, 38),
                    Size = UDim2.new(1, -24, 0, 16),
                    Parent = slider
                })
                
                U:Corner(bar, 8)
                
                local fill = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Accent,
                    BorderSizePixel = 0,
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    Parent = bar
                })
                
                Library:Reg(fill, "A")
                U:Corner(fill, 8)
                
                local dot = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Text,
                    BorderSizePixel = 0,
                    Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0),
                    Size = UDim2.new(0, 20, 0, 20),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    ZIndex = 2,
                    Parent = bar
                })
                
                U:Corner(dot, 20)
                U:Stroke(dot, Library.Config.Theme.Accent, 3, 0)
                
                local dragging = false
                local currentValue = default
                
                if flag then
                    Library.Flags[flag] = default
                    Library.Options[flag] = {
                        Set = function(self, v)
                            currentValue = math.clamp(v, min, max)
                            local pos = (currentValue - min) / (max - min)
                            fill.Size = UDim2.new(pos, 0, 1, 0)
                            dot.Position = UDim2.new(pos, 0, 0.5, 0)
                            valueText.Text = tostring(currentValue) .. suffix
                            if flag then Library.Flags[flag] = currentValue end
                            callback(currentValue)
                        end,
                        Get = function(self) return currentValue end
                    }
                end
                
                local function update(input)
                    local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                    local val = min + (max - min) * pos
                    val = math.floor(val / inc + 0.5) * inc
                    val = math.clamp(val, min, max)
                    currentValue = val
                    
                    fill.Size = UDim2.new(pos, 0, 1, 0)
                    dot.Position = UDim2.new(pos, 0, 0.5, 0)
                    valueText.Text = tostring(val) .. suffix
                    
                    if flag then Library.Flags[flag] = val end
                    callback(val)
                end
                
                bar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        if not isDragging() then
                            dragging = true
                            update(input)
                            U:Tween(dot, {Size = UDim2.new(0, 24, 0, 24)}, 0.2, Enum.EasingStyle.Back)
                        end
                    end
                end)
                
                bar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                        U:Tween(dot, {Size = UDim2.new(0, 20, 0, 20)}, 0.2)
                    end
                end)
                
                Services.UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        update(input)
                    end
                end)
                
                return Library.Options[flag] or {Set = function(self, v) end, Get = function() return currentValue end}
            end
            
            -- ════════════════════════════════════════════════════════
            -- DROPDOWN (محسّن بدون بحث - سلس جداً)
            -- ════════════════════════════════════════════════════════
            
            function Section:AddDropdown(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Dropdown"
                local items = cfg.Items or {"Item1", "Item2", "Item3"}
                local default = cfg.Default or items[1]
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                
                local dropdown = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 42),
                    ClipsDescendants = true,
                    ZIndex = 5,
                    Parent = content
                })
                
                Library:Reg(dropdown, "T")
                U:Corner(dropdown, 8)
                
                U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(0.35, 0, 1, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = dropdown
                })
                
                local btn = U:New("TextButton", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.4, 0, 0.2, 0),
                    Size = UDim2.new(0.58, 0, 0.6, 0),
                    Font = Enum.Font.Gotham,
                    Text = "  " .. default,
                    TextColor3 = Library.Config.Theme.Accent,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutoButtonColor = false,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = 6,
                    Parent = dropdown
                })
                
                Library:Reg(btn, "AT")
                U:Corner(btn, 6)
                
                local arrow = U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -22, 0.5, 0),
                    Size = UDim2.new(0, 16, 0, 16),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Font = Enum.Font.GothamBold,
                    Text = "▼",
                    TextColor3 = Library.Config.Theme.TextDark,
                    TextSize = 10,
                    ZIndex = 7,
                    Parent = btn
                })
                
                local list = U:New("ScrollingFrame", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 12, 0, 47),
                    Size = UDim2.new(1, -24, 0, 0),
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    ScrollBarThickness = 4,
                    ScrollBarImageColor3 = Library.Config.Theme.Accent,
                    Visible = false,
                    ZIndex = 10,
                    Parent = dropdown
                })
                
                U:Corner(list, 6)
                
                local listLayout = U:New("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 4),
                    Parent = list
                })
                
                U:New("UIPadding", {
                    PaddingTop = UDim.new(0, 6),
                    PaddingLeft = UDim.new(0, 6),
                    PaddingRight = UDim.new(0, 6),
                    PaddingBottom = UDim.new(0, 6),
                    Parent = list
                })
                
                listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    list.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 12)
                end)
                
                local expanded = false
                local current = default
                
                if flag then
                    Library.Flags[flag] = current
                    Library.Options[flag] = {
                        Set = function(self, v)
                            if table.find(items, v) then
                                current = v
                                btn.Text = "  " .. v
                                if flag then Library.Flags[flag] = v end
                                callback(v)
                            end
                        end,
                        Get = function(self) return current end,
                        Refresh = function(self, newItems, newDefault)
                            items = newItems
                            list:ClearAllChildren()
                            listLayout.Parent = list
                            
                            U:New("UIPadding", {
                                PaddingTop = UDim.new(0, 6),
                                PaddingLeft = UDim.new(0, 6),
                                PaddingRight = UDim.new(0, 6),
                                PaddingBottom = UDim.new(0, 6),
                                Parent = list
                            })
                            
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
                        BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, -12, 0, 30),
                        Font = Enum.Font.Gotham,
                        Text = "  " .. itemName,
                        TextColor3 = Library.Config.Theme.Text,
                        TextSize = 13,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutoButtonColor = false,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        ZIndex = 11,
                        Parent = list
                    })
                    
                    Library:Reg(item, "T")
                    U:Corner(item, 6)
                    
                    item.MouseEnter:Connect(function()
                        U:Tween(item, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.15)
                    end)
                    
                    item.MouseLeave:Connect(function()
                        U:Tween(item, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.15)
                    end)
                    
                    item.MouseButton1Click:Connect(function()
                        if isDragging() then return end
                        
                        current = itemName
                        btn.Text = "  " .. itemName
                        if flag then Library.Flags[flag] = itemName end
                        callback(itemName)
                        
                        -- إغلاق القائمة بسلاسة
                        expanded = false
                        list.Visible = false
                        U:Tween(dropdown, {Size = UDim2.new(1, 0, 0, 42)}, 0.3, Enum.EasingStyle.Quart)
                        U:Tween(arrow, {Rotation = 0}, 0.3, Enum.EasingStyle.Quart)
                        task.wait(0.35)
                        dropdown.ZIndex = 5
                    end)
                end
                
                for _, item in ipairs(items) do
                    createItem(item)
                end
                
                btn.MouseButton1Click:Connect(function()
                    if isDragging() then return end
                    
                    expanded = not expanded
                    
                    if expanded then
                        local maxItems = math.min(#items, 5)
                        local listHeight = math.min(maxItems * 34, 170)
                        local totalHeight = 42 + 10 + listHeight
                        
                        list.Size = UDim2.new(1, -24, 0, listHeight)
                        list.Visible = true
                        dropdown.ZIndex = 50
                        
                        U:Tween(dropdown, {Size = UDim2.new(1, 0, 0, totalHeight)}, 0.35, Enum.EasingStyle.Quart)
                        U:Tween(arrow, {Rotation = 180}, 0.3, Enum.EasingStyle.Quart)
                    else
                        list.Visible = false
                        U:Tween(dropdown, {Size = UDim2.new(1, 0, 0, 42)}, 0.3, Enum.EasingStyle.Quart)
                        U:Tween(arrow, {Rotation = 0}, 0.3, Enum.EasingStyle.Quart)
                        task.wait(0.35)
                        dropdown.ZIndex = 5
                    end
                end)
                
                -- إغلاق عند النقر خارج القائمة
                Services.UserInputService.InputBegan:Connect(function(input)
                    if expanded and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                        local mousePos = Vector2.new(input.Position.X, input.Position.Y)
                        local dropdownPos = dropdown.AbsolutePosition
                        local dropdownSize = dropdown.AbsoluteSize
                        
                        if mousePos.X < dropdownPos.X or mousePos.X > dropdownPos.X + dropdownSize.X or
                           mousePos.Y < dropdownPos.Y or mousePos.Y > dropdownPos.Y + dropdownSize.Y then
                            expanded = false
                            list.Visible = false
                            U:Tween(dropdown, {Size = UDim2.new(1, 0, 0, 42)}, 0.3, Enum.EasingStyle.Quart)
                            U:Tween(arrow, {Rotation = 0}, 0.3, Enum.EasingStyle.Quart)
                            task.wait(0.35)
                            dropdown.ZIndex = 5
                        end
                    end
                end)
                
                return Library.Options[flag] or {Set = function(self, v) end, Get = function() return current end, Refresh = function(self) end}
            end
            
            -- ════════════════════════════════════════════════════════
            -- COLORPICKER
            -- ════════════════════════════════════════════════════════
            
            function Section:AddColorPicker(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Color"
                local default = cfg.Default or Color3.fromRGB(255, 0, 0)
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                
                local picker = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 42),
                    ClipsDescendants = true,
                    ZIndex = 5,
                    Parent = content
                })
                
                Library:Reg(picker, "T")
                U:Corner(picker, 8)
                
                U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(0.7, 0, 1, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 6,
                    Parent = picker
                })
                
                local display = U:New("TextButton", {
                    BackgroundColor3 = default,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -50, 0.5, 0),
                    Size = UDim2.new(0, 38, 0, 26),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 7,
                    Parent = picker
                })
                
                U:Corner(display, 6)
                U:Stroke(display, Library.Config.Theme.Border, 2, 0.5)
                
                local palette = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 12, 0, 47),
                    Size = UDim2.new(1, -24, 0, 190),
                    Visible = false,
                    ZIndex = 50,
                    Parent = picker
                })
                
                U:Corner(palette, 8)
                U:Stroke(palette, Library.Config.Theme.Accent, 1, 0.5)
                
                local canvas = U:New("ImageButton", {
                    BackgroundColor3 = Color3.fromRGB(255, 0, 0),
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 10, 0, 10),
                    Size = UDim2.new(1, -75, 1, -50),
                    Image = "rbxassetid://4155801252",
                    ImageColor3 = Color3.fromRGB(255, 255, 255),
                    AutoButtonColor = false,
                    ZIndex = 51,
                    Parent = palette
                })
                
                U:Corner(canvas, 6)
                
                local canvasCursor = U:New("Frame", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, 0, 0, 0),
                    Size = UDim2.new(0, 10, 0, 10),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    ZIndex = 52,
                    Parent = canvas
                })
                
                U:Corner(canvasCursor, 20)
                U:Stroke(canvasCursor, Color3.fromRGB(0, 0, 0), 2, 0)
                
                local hueBar = U:New("ImageButton", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -55, 0, 10),
                    Size = UDim2.new(0, 20, 1, -50),
                    Image = "rbxassetid://3641079629",
                    ImageColor3 = Color3.fromRGB(255, 255, 255),
                    Rotation = 0,
                    AutoButtonColor = false,
                    ZIndex = 51,
                    Parent = palette
                })
                
                U:Corner(hueBar, 6)
                
                local hueCursor = U:New("Frame", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.5, 0, 0, 0),
                    Size = UDim2.new(1, 4, 0, 4),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    ZIndex = 52,
                    Parent = hueBar
                })
                
                U:Corner(hueCursor, 20)
                U:Stroke(hueCursor, Color3.fromRGB(0, 0, 0), 2, 0)
                
                local rgbContainer = U:New("Frame", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 10, 1, -35),
                    Size = UDim2.new(1, -20, 0, 30),
                    ZIndex = 51,
                    Parent = palette
                })
                
                U:New("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 8),
                    Parent = rgbContainer
                })
                
                local function createRGBInput(label, defaultVal)
                    local container = U:New("Frame", {
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0.22, 0, 1, 0),
                        ZIndex = 51,
                        Parent = rgbContainer
                    })
                    
                    U:New("TextLabel", {
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0.3, 0, 1, 0),
                        Font = Enum.Font.GothamBold,
                        Text = label,
                        TextColor3 = Library.Config.Theme.TextDark,
                        TextSize = 12,
                        ZIndex = 52,
                        Parent = container
                    })
                    
                    local input = U:New("TextBox", {
                        BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.35, 0, 0, 0),
                        Size = UDim2.new(0.65, 0, 1, 0),
                        Font = Enum.Font.Gotham,
                        Text = tostring(defaultVal),
                        TextColor3 = Library.Config.Theme.Text,
                        TextSize = 12,
                        ClearTextOnFocus = false,
                        ZIndex = 52,
                        Parent = container
                    })
                    
                    Library:Reg(input, "T")
                    U:Corner(input, 4)
                    
                    return input
                end
                
                local h, s, v = default:ToHSV()
                local r, g, b = math.floor(default.R * 255), math.floor(default.G * 255), math.floor(default.B * 255)
                
                local rInput = createRGBInput("R", r)
                local gInput = createRGBInput("G", g)
                local bInput = createRGBInput("B", b)
                
                local confirmBtn = U:New("TextButton", {
                    BackgroundColor3 = Library.Config.Theme.Accent,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -30, 1, -35),
                    Size = UDim2.new(0, 50, 0, 30),
                    Font = Enum.Font.GothamBold,
                    Text = "✓",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 16,
                    AutoButtonColor = false,
                    ZIndex = 51,
                    Parent = palette
                })
                
                Library:Reg(confirmBtn, "A")
                U:Corner(confirmBtn, 6)
                
                local expanded = false
                
                if flag then
                    Library.Flags[flag] = default
                    Library.Options[flag] = {
                        Set = function(self, color)
                            h, s, v = color:ToHSV()
                            r, g, b = math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255)
                            
                            display.BackgroundColor3 = color
                            canvas.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                            
                            canvasCursor.Position = UDim2.new(s, 0, 1 - v, 0)
                            hueCursor.Position = UDim2.new(0.5, 0, 1 - h, 0)
                            
                            rInput.Text = tostring(r)
                            gInput.Text = tostring(g)
                            bInput.Text = tostring(b)
                            
                            if flag then Library.Flags[flag] = color end
                            callback(color)
                        end,
                        Get = function(self) return Color3.fromHSV(h, s, v) end
                    }
                end
                
                canvas.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                canvasCursor.Position = UDim2.new(s, 0, 1 - v, 0)
                hueCursor.Position = UDim2.new(0.5, 0, 1 - h, 0)
                
                local hueDragging, canvasDragging = false, false
                
                local function updateColor()
                    local color = Color3.fromHSV(h, s, v)
                    r, g, b = math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255)
                    
                    display.BackgroundColor3 = color
                    canvas.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                    
                    rInput.Text = tostring(r)
                    gInput.Text = tostring(g)
                    bInput.Text = tostring(b)
                    
                    if flag then Library.Flags[flag] = color end
                    callback(color)
                end
                
                hueBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        if not isDragging() then
                            hueDragging = true
                        end
                    end
                end)
                
                hueBar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        hueDragging = false
                    end
                end)
                
                canvas.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        if not isDragging() then
                            canvasDragging = true
                        end
                    end
                end)
                
                canvas.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        canvasDragging = false
                    end
                end)
                
                Services.UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                        if hueDragging then
                            local posY = math.clamp((input.Position.Y - hueBar.AbsolutePosition.Y) / hueBar.AbsoluteSize.Y, 0, 1)
                            h = 1 - posY
                            hueCursor.Position = UDim2.new(0.5, 0, posY, 0)
                            updateColor()
                        end
                        
                        if canvasDragging then
                            local posX = math.clamp((input.Position.X - canvas.AbsolutePosition.X) / canvas.AbsoluteSize.X, 0, 1)
                            local posY = math.clamp((input.Position.Y - canvas.AbsolutePosition.Y) / canvas.AbsoluteSize.Y, 0, 1)
                            s = posX
                            v = 1 - posY
                            canvasCursor.Position = UDim2.new(posX, 0, posY, 0)
                            updateColor()
                        end
                    end
                end)
                
                local function updateFromRGB()
                    local nr = tonumber(rInput.Text) or 0
                    local ng = tonumber(gInput.Text) or 0
                    local nb = tonumber(bInput.Text) or 0
                    
                    nr = math.clamp(nr, 0, 255)
                    ng = math.clamp(ng, 0, 255)
                    nb = math.clamp(nb, 0, 255)
                    
                    r, g, b = nr, ng, nb
                    
                    local color = Color3.fromRGB(r, g, b)
                    h, s, v = color:ToHSV()
                    
                    display.BackgroundColor3 = color
                    canvas.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                    canvasCursor.Position = UDim2.new(s, 0, 1 - v, 0)
                    hueCursor.Position = UDim2.new(0.5, 0, 1 - h, 0)
                    
                    if flag then Library.Flags[flag] = color end
                    callback(color)
                end
                
                rInput.FocusLost:Connect(updateFromRGB)
                gInput.FocusLost:Connect(updateFromRGB)
                bInput.FocusLost:Connect(updateFromRGB)
                
                display.MouseButton1Click:Connect(function()
                    if isDragging() then return end
                    
                    expanded = not expanded
                    palette.Visible = expanded
                    
                    if expanded then
                        picker.ZIndex = 50
                        U:Tween(picker, {Size = UDim2.new(1, 0, 0, 242)}, 0.3, Enum.EasingStyle.Back)
                    else
                        U:Tween(picker, {Size = UDim2.new(1, 0, 0, 42)}, 0.25, Enum.EasingStyle.Back)
                        task.wait(0.3)
                        picker.ZIndex = 5
                    end
                end)
                
                confirmBtn.MouseButton1Click:Connect(function()
                    expanded = false
                    palette.Visible = false
                    U:Tween(picker, {Size = UDim2.new(1, 0, 0, 42)}, 0.25, Enum.EasingStyle.Back)
                    task.wait(0.3)
                    picker.ZIndex = 5
                end)
                
                confirmBtn.MouseEnter:Connect(function()
                    U:Tween(confirmBtn, {Size = UDim2.new(0, 55, 0, 32)}, 0.2, Enum.EasingStyle.Back)
                end)
                
                confirmBtn.MouseLeave:Connect(function()
                    U:Tween(confirmBtn, {Size = UDim2.new(0, 50, 0, 30)}, 0.2)
                end)
                
                return Library.Options[flag] or {Set = function(self, c) end, Get = function() return Color3.fromHSV(h, s, v) end}
            end
            
            -- ════════════════════════════════════════════════════════
            -- TEXTBOX
            -- ════════════════════════════════════════════════════════
            
            function Section:AddTextbox(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Textbox"
                local default = cfg.Default or ""
                local placeholder = cfg.Placeholder or "Enter text..."
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                
                local box = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.TertiaryBG,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 42),
                    Parent = content
                })
                
                Library:Reg(box, "T")
                U:Corner(box, 8)
                
                U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(0.35, 0, 1, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = box
                })
                
                local input = U:New("TextBox", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.4, 0, 0.2, 0),
                    Size = UDim2.new(0.58, 0, 0.6, 0),
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
                
                Library:Reg(input, "AT")
                U:Corner(input, 6)
                U:New("UIPadding", {PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), Parent = input})
                
                if flag then
                    Library.Flags[flag] = default
                    Library.Options[flag] = {
                        Set = function(self, v)
                            input.Text = v
                            if flag then Library.Flags[flag] = v end
                        end,
                        Get = function(self) return input.Text end
                    }
                end
                
                input.FocusLost:Connect(function(enter)
                    if enter then
                        if flag then Library.Flags[flag] = input.Text end
                        callback(input.Text)
                    end
                end)
                
                return Library.Options[flag] or {Set = function(self, v) end, Get = function() return input.Text end}
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
                    Size = UDim2.new(1, 0, 0, 42),
                    Parent = content
                })
                
                Library:Reg(keybind, "T")
                U:Corner(keybind, 8)
                
                U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(0.55, 0, 1, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = keybind
                })
                
                local keyBtn = U:New("TextButton", {
                    BackgroundColor3 = Library.Config.Theme.Background,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -110, 0.5, 0),
                    Size = UDim2.new(0, 98, 0, 26),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Font = Enum.Font.Gotham,
                    Text = default.Name,
                    TextColor3 = Library.Config.Theme.Accent,
                    TextSize = 13,
                    AutoButtonColor = false,
                    Parent = keybind
                })
                
                Library:Reg(keyBtn, "AT")
                U:Corner(keyBtn, 6)
                
                local current = default
                local listening = false
                local toggled = false
                
                if flag then
                    Library.Flags[flag] = current
                    Library.Options[flag] = {
                        Set = function(self, key)
                            current = key
                            keyBtn.Text = key.Name
                            if flag then Library.Flags[flag] = key end
                        end,
                        Get = function(self) return current end
                    }
                end
                
                keyBtn.MouseButton1Click:Connect(function()
                    if isDragging() then return end
                    
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
                        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                            listening = false
                            keyBtn.Text = current.Name
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
                
                return Library.Options[flag] or {Set = function(self, k) end, Get = function() return current end}
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
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
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
                    Size = UDim2.new(1, 0, 0, 75),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Parent = content
                })
                
                U:Corner(para, 8)
                U:Stroke(para, Library.Config.Theme.Border, 1, 0.6)
                
                local paraTitle = U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 12, 0, 8),
                    Size = UDim2.new(1, -24, 0, 20),
                    Font = Enum.Font.GothamBold,
                    Text = title or "Title",
                    TextColor3 = Library.Config.Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = para
                })
                
                local paraContent = U:New("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 12, 0, 32),
                    Size = UDim2.new(1, -24, 1, -44),
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
                    Size = UDim2.new(1, 0, 0, text and 28 or 10),
                    Parent = content
                })
                
                local line = U:New("Frame", {
                    BackgroundColor3 = Library.Config.Theme.Border,
                    BackgroundTransparency = 0.5,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0.5, 0),
                    Size = UDim2.new(1, 0, 0, 2),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Parent = div
                })
                
                if text then
                    local textLabel = U:New("TextLabel", {
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
                    
                    U:New("UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), Parent = textLabel})
                end
            end
            
            return Section
        end
        
        -- تفعيل أول تاب تلقائياً مع المؤشر
        if #Window.Tabs == 0 then
            tabContent.Visible = true
            Window.CurrentTab = tabName
            
            tabIndicator.Visible = true
            tabIndicator.Position = UDim2.new(0, tabBtn.Position.X.Offset, 0, 10)
            
            icon.TextColor3 = Library.Config.Theme.Text
            text.TextColor3 = Library.Config.Theme.Text
        end
        
        table.insert(Window.Tabs, Tab)
        return Tab
    end
    
    -- ════════════════════════════════════════════════════════
    -- KEYBIND TOGGLE
    -- ════════════════════════════════════════════════════════
    
    if keybind then
        local visible = true
        Services.UserInputService.InputBegan:Connect(function(input, gp)
            if not gp and input.KeyCode == keybind then
                visible = not visible
                
                if miniBox.Visible then
                    U:Tween(miniBox, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                    task.wait(0.35)
                    miniBox.Visible = false
                    if visible then
                        main.Visible = true
                        U:Tween(main, {Size = size}, 0.4, Enum.EasingStyle.Back)
                    end
                else
                    if visible then
                        main.Visible = true
                        U:Tween(main, {Size = size}, 0.4, Enum.EasingStyle.Back)
                    else
                        local mainPos = main.AbsolutePosition
                        local mainSize = main.AbsoluteSize
                        
                        U:Tween(main, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                        task.wait(0.35)
                        main.Visible = false
                    end
                end
            end
        end)
    end
    
    -- ════════════════════════════════════════════════════════
    -- INTRO ANIMATION
    -- ════════════════════════════════════════════════════════
    
    U:Tween(main, {Size = size}, 0.5, Enum.EasingStyle.Back)
    
    return Window
end

-- ════════════════════════════════════════════════════════
-- RETURN LIBRARY
-- ════════════════════════════════════════════════════════

return Library
