--[[
    ╔════════════════════════════════════════════════════════╗
    ║        DRAKTHON UI LIBRARY - COMPLETE VERSION         ║
    ║           RESPONSIVE + 15 THEMES + NO NOTIFS          ║
    ║                  VERSION 7.0.0 FINAL                   ║
    ║                    3500+ LINES CODE                    ║
    ╚════════════════════════════════════════════════════════╝
]]

local Library = {}
Library.Version = "7.0.0"
Library.Flags = {}
Library.Options = {}

-- ════════════════════════════════════════════════════════
-- ⚙️ CONFIGURATION
-- ════════════════════════════════════════════════════════

Library.Config = {
    UI = {
        Animations = true,
        AnimationSpeed = 0.25,
        SmoothDragging = true,
        RippleEffect = true,
        Font = Enum.Font.Gotham,
        TextSize = 13,
    },
    
    Theme = {
        Background = Color3.fromRGB(15, 15, 20),
        SecondaryBG = Color3.fromRGB(25, 25, 30),
        TertiaryBG = Color3.fromRGB(30, 30, 38),
        
        Accent = Color3.fromRGB(138, 43, 226),
        AccentDark = Color3.fromRGB(118, 33, 206),
        AccentLight = Color3.fromRGB(158, 63, 246),
        
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(180, 180, 190),
        TextDisabled = Color3.fromRGB(100, 100, 110),
        
        Success = Color3.fromRGB(46, 204, 113),
        Warning = Color3.fromRGB(241, 196, 15),
        Error = Color3.fromRGB(231, 76, 60),
        Info = Color3.fromRGB(52, 152, 219),
        
        Border = Color3.fromRGB(45, 45, 55),
        Shadow = Color3.fromRGB(0, 0, 0),
    },
    
    ConfigFolder = "DrakthonConfigs",
    AutoSave = false,
    AutoSaveInterval = 300,
}

-- ════════════════════════════════════════════════════════
-- 📦 SERVICES
-- ════════════════════════════════════════════════════════

local Services = setmetatable({}, {
    __index = function(t, k)
        local success, service = pcall(game.GetService, game, k)
        if success then
            rawset(t, k, service)
            return service
        end
    end
})

local Player = Services.Players.LocalPlayer
local Mouse = Player:GetMouse()

local IsMobile = Services.UserInputService.TouchEnabled and not Services.UserInputService.KeyboardEnabled
local IsPC = not IsMobile

-- ════════════════════════════════════════════════════════
-- 🎨 THEME PRESETS (15 THEMES)
-- ════════════════════════════════════════════════════════

Library.Themes = {
    Default = {
        Name = "Default Purple",
        Accent = Color3.fromRGB(138, 43, 226),
        Background = Color3.fromRGB(15, 15, 20),
        SecondaryBG = Color3.fromRGB(25, 25, 30),
        TertiaryBG = Color3.fromRGB(30, 30, 38),
    },
    Midnight = {
        Name = "Midnight Dark",
        Accent = Color3.fromRGB(30, 136, 229),
        Background = Color3.fromRGB(10, 10, 15),
        SecondaryBG = Color3.fromRGB(15, 15, 22),
        TertiaryBG = Color3.fromRGB(20, 20, 28),
    },
    Ocean = {
        Name = "Ocean Blue",
        Accent = Color3.fromRGB(52, 152, 219),
        Background = Color3.fromRGB(10, 20, 30),
        SecondaryBG = Color3.fromRGB(15, 28, 40),
        TertiaryBG = Color3.fromRGB(20, 35, 48),
    },
    Sunset = {
        Name = "Sunset Orange",
        Accent = Color3.fromRGB(255, 107, 107),
        Background = Color3.fromRGB(25, 15, 20),
        SecondaryBG = Color3.fromRGB(32, 20, 28),
        TertiaryBG = Color3.fromRGB(38, 25, 32),
    },
    Forest = {
        Name = "Forest Green",
        Accent = Color3.fromRGB(46, 204, 113),
        Background = Color3.fromRGB(15, 25, 15),
        SecondaryBG = Color3.fromRGB(20, 32, 20),
        TertiaryBG = Color3.fromRGB(25, 38, 25),
    },
    Rose = {
        Name = "Rose Pink",
        Accent = Color3.fromRGB(255, 105, 180),
        Background = Color3.fromRGB(25, 15, 20),
        SecondaryBG = Color3.fromRGB(32, 20, 28),
        TertiaryBG = Color3.fromRGB(38, 25, 32),
    },
    Mint = {
        Name = "Mint Fresh",
        Accent = Color3.fromRGB(26, 188, 156),
        Background = Color3.fromRGB(15, 25, 23),
        SecondaryBG = Color3.fromRGB(20, 32, 30),
        TertiaryBG = Color3.fromRGB(25, 38, 35),
    },
    Cherry = {
        Name = "Cherry Red",
        Accent = Color3.fromRGB(220, 20, 60),
        Background = Color3.fromRGB(20, 12, 15),
        SecondaryBG = Color3.fromRGB(28, 18, 22),
        TertiaryBG = Color3.fromRGB(35, 22, 28),
    },
    Gold = {
        Name = "Golden Luxury",
        Accent = Color3.fromRGB(255, 215, 0),
        Background = Color3.fromRGB(20, 18, 10),
        SecondaryBG = Color3.fromRGB(28, 25, 15),
        TertiaryBG = Color3.fromRGB(35, 30, 18),
    },
    Cyber = {
        Name = "Cyber Neon",
        Accent = Color3.fromRGB(0, 255, 255),
        Background = Color3.fromRGB(10, 10, 15),
        SecondaryBG = Color3.fromRGB(15, 15, 22),
        TertiaryBG = Color3.fromRGB(18, 18, 28),
    },
    Toxic = {
        Name = "Toxic Green",
        Accent = Color3.fromRGB(0, 255, 0),
        Background = Color3.fromRGB(8, 15, 8),
        SecondaryBG = Color3.fromRGB(12, 22, 12),
        TertiaryBG = Color3.fromRGB(15, 28, 15),
    },
    Royal = {
        Name = "Royal Purple",
        Accent = Color3.fromRGB(147, 51, 234),
        Background = Color3.fromRGB(18, 10, 25),
        SecondaryBG = Color3.fromRGB(25, 15, 35),
        TertiaryBG = Color3.fromRGB(30, 18, 42),
    },
    Blood = {
        Name = "Blood Moon",
        Accent = Color3.fromRGB(139, 0, 0),
        Background = Color3.fromRGB(18, 8, 8),
        SecondaryBG = Color3.fromRGB(25, 12, 12),
        TertiaryBG = Color3.fromRGB(32, 15, 15),
    },
    Ice = {
        Name = "Ice Blue",
        Accent = Color3.fromRGB(135, 206, 250),
        Background = Color3.fromRGB(12, 15, 20),
        SecondaryBG = Color3.fromRGB(18, 22, 28),
        TertiaryBG = Color3.fromRGB(22, 28, 35),
    },
    Dark = {
        Name = "Pure Dark",
        Accent = Color3.fromRGB(100, 100, 110),
        Background = Color3.fromRGB(8, 8, 10),
        SecondaryBG = Color3.fromRGB(12, 12, 15),
        TertiaryBG = Color3.fromRGB(15, 15, 18),
    },
}

function Library:SetTheme(themeName)
    local theme = self.Themes[themeName]
    if theme then
        self.Config.Theme.Accent = theme.Accent
        self.Config.Theme.Background = theme.Background
        self.Config.Theme.SecondaryBG = theme.SecondaryBG
        self.Config.Theme.TertiaryBG = theme.TertiaryBG
        
        self.Config.Theme.AccentDark = Color3.fromRGB(
            math.clamp(theme.Accent.R * 255 - 20, 0, 255),
            math.clamp(theme.Accent.G * 255 - 20, 0, 255),
            math.clamp(theme.Accent.B * 255 - 20, 0, 255)
        )
        
        self.Config.Theme.AccentLight = Color3.fromRGB(
            math.clamp(theme.Accent.R * 255 + 20, 0, 255),
            math.clamp(theme.Accent.G * 255 + 20, 0, 255),
            math.clamp(theme.Accent.B * 255 + 20, 0, 255)
        )
        
        return true
    end
    return false
end

function Library:GetThemeNames()
    local names = {}
    for name, _ in pairs(self.Themes) do
        table.insert(names, name)
    end
    table.sort(names)
    return names
end

-- ════════════════════════════════════════════════════════
-- 🛠️ UTILITY FUNCTIONS
-- ════════════════════════════════════════════════════════

local Utility = {}

function Utility:Tween(object, properties, duration, easingStyle, easingDirection)
    if not object or not pcall(function() return object.Parent end) then return end
    
    if not Library.Config.UI.Animations then
        for k, v in pairs(properties) do
            pcall(function() object[k] = v end)
        end
        return
    end
    
    duration = duration or Library.Config.UI.AnimationSpeed
    easingStyle = easingStyle or Enum.EasingStyle.Quad
    easingDirection = easingDirection or Enum.EasingDirection.Out
    
    local success, tween = pcall(function()
        return Services.TweenService:Create(
            object,
            TweenInfo.new(duration, easingStyle, easingDirection),
            properties
        )
    end)
    
    if success and tween then
        pcall(function()
            tween:Play()
        end)
        return tween
    end
end

function Utility:MakeDraggable(gui, dragHandle)
    dragHandle = dragHandle or gui
    
    local dragging = false
    local dragInput, dragStart, startPos
    
    local function update(input)
        if not dragging then return end
        local delta = input.Position - dragStart
        
        if Library.Config.UI.SmoothDragging then
            self:Tween(gui, {
                Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            }, 0.08, Enum.EasingStyle.Linear)
        else
            gui.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end
    
    dragHandle.InputBegan:Connect(function(input)
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
    
    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    Services.UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

function Utility:CreateScreenGui(name)
    local gui = Instance.new("ScreenGui")
    gui.Name = name or "DrakthonUI_" .. Services.HttpService:GenerateGUID(false)
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 100
    gui.IgnoreGuiInset = true
    
    local success = pcall(function()
        if gethui then
            gui.Parent = gethui()
        elseif syn and syn.protect_gui then
            gui.Parent = Services.CoreGui
            syn.protect_gui(gui)
        else
            gui.Parent = Services.CoreGui
        end
    end)
    
    if not success then
        gui.Parent = Player:WaitForChild("PlayerGui")
    end
    
    return gui
end

function Utility:AddCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

function Utility:AddStroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Library.Config.Theme.Border
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

function Utility:AddShadow(parent, size)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0, -(size or 15), 0, -(size or 15))
    shadow.Size = UDim2.new(1, (size or 15) * 2, 1, (size or 15) * 2)
    shadow.ZIndex = (parent.ZIndex or 1) - 1
    shadow.Image = "rbxassetid://6015897843"
    shadow.ImageColor3 = Library.Config.Theme.Shadow
    shadow.ImageTransparency = 0.4
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    shadow.Parent = parent
    return shadow
end

function Utility:AddGradient(parent, rotation, colors)
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = rotation or 90
    if colors then
        gradient.Color = colors
    end
    gradient.Parent = parent
    return gradient
end

function Utility:RippleEffect(button)
    if not Library.Config.UI.RippleEffect then return end
    
    button.ClipsDescendants = true
    
    button.MouseButton1Click:Connect(function()
        local ripple = Instance.new("ImageLabel")
        ripple.BackgroundTransparency = 1
        ripple.Image = "rbxassetid://3570695787"
        ripple.ImageColor3 = Library.Config.Theme.Accent
        ripple.ImageTransparency = 0.5
        ripple.ScaleType = Enum.ScaleType.Slice
        ripple.SliceCenter = Rect.new(100, 100, 100, 100)
        ripple.ZIndex = button.ZIndex + 1
        
        local mousePos = Services.UserInputService:GetMouseLocation()
        local buttonPos = button.AbsolutePosition
        local relativePos = mousePos - buttonPos
        
        ripple.Position = UDim2.new(0, relativePos.X, 0, relativePos.Y)
        ripple.Size = UDim2.new(0, 0, 0, 0)
        ripple.AnchorPoint = Vector2.new(0.5, 0.5)
        ripple.Parent = button
        
        local size = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2
        
        Utility:Tween(ripple, {
            Size = UDim2.new(0, size, 0, size),
            ImageTransparency = 1
        }, 0.5)
        
        task.delay(0.5, function()
            pcall(function() ripple:Destroy() end)
        end)
    end)
end

function Utility:GetIcon(name)
    local icons = {
        Home = "🏠", Settings = "⚙️", Player = "👤", Combat = "⚔️",
        Misc = "📦", Teleport = "📍", ESP = "👁️", Aimbot = "🎯",
        Speed = "⚡", Farm = "🌾", Money = "💰", Weapon = "🔫",
        Info = "ℹ️", Warning = "⚠️", Error = "❌", Success = "✓",
        Search = "🔍", Save = "💾", Load = "📂", Delete = "🗑️",
        Discord = "💬", Star = "⭐", Crown = "👑", Fire = "🔥",
        Lock = "🔒", Unlock = "🔓", Paint = "🎨", Code = "💻",
    }
    return icons[name] or "•"
end

-- ════════════════════════════════════════════════════════
-- 💾 CONFIG SYSTEM
-- ════════════════════════════════════════════════════════

function Library:SaveConfig(name)
    name = name or "DefaultConfig"
    
    local success = pcall(function()
        if not isfolder(self.Config.ConfigFolder) then
            makefolder(self.Config.ConfigFolder)
        end
        
        local data = {
            Version = self.Version,
            Flags = self.Flags,
            SavedAt = os.date("%Y-%m-%d %H:%M:%S"),
            GameId = game.PlaceId,
        }
        
        writefile(self.Config.ConfigFolder .. "/" .. name .. ".json", Services.HttpService:JSONEncode(data))
    end)
    
    return success
end

function Library:LoadConfig(name)
    name = name or "DefaultConfig"
    
    local success, data = pcall(function()
        return Services.HttpService:JSONDecode(readfile(self.Config.ConfigFolder .. "/" .. name .. ".json"))
    end)
    
    if success and data then
        for flag, value in pairs(data.Flags or {}) do
            if self.Options[flag] then
                pcall(function()
                    self.Options[flag]:Set(value)
                end)
            end
        end
        
        self.Flags = data.Flags or {}
        return data
    end
    
    return nil
end

function Library:GetConfigs()
    local configs = {}
    pcall(function()
        if not isfolder(self.Config.ConfigFolder) then
            makefolder(self.Config.ConfigFolder)
        end
        
        for _, file in ipairs(listfiles(self.Config.ConfigFolder)) do
            if file:match("%.json$") then
                local fileName = file:match("([^/\```+)%.json$")
                if fileName then
                    table.insert(configs, fileName)
                end
            end
        end
    end)
    return configs
end

function Library:DeleteConfig(name)
    local success = pcall(function()
        delfile(self.Config.ConfigFolder .. "/" .. name .. ".json")
    end)
    
    return success
end

-- ════════════════════════════════════════════════════════
-- 🪟 CREATE WINDOW
-- ════════════════════════════════════════════════════════

function Library:CreateWindow(config)
    config = config or {}
    
    local windowTitle = config.Title or config.Name or "Drakthon UI"
    local windowSubtitle = config.Subtitle or "v" .. self.Version
    local windowKeybind = config.Keybind or config.ToggleKey or Enum.KeyCode.RightControl
    local windowIcon = config.Icon or "rbxassetid://7733964640"
    
    -- RESPONSIVE SIZE
    local viewport = workspace.CurrentCamera.ViewportSize
    local baseWidth = IsMobile and math.clamp(viewport.X * 0.95, 340, 500) or math.clamp(viewport.X * 0.5, 600, 800)
    local baseHeight = IsMobile and math.clamp(viewport.Y * 0.88, 480, 750) or math.clamp(viewport.Y * 0.7, 500, 700)
    
    local gui = Utility:CreateScreenGui("DrakthonUI")
    
    -- MINIMIZE BOX
    local minimizeBox = Instance.new("Frame")
    minimizeBox.Name = "MinimizeBox"
    minimizeBox.BackgroundColor3 = self.Config.Theme.SecondaryBG
    minimizeBox.BorderSizePixel = 0
    minimizeBox.Position = UDim2.new(0.5, 0, 0.5, 0)
    minimizeBox.Size = UDim2.new(0, 80, 0, 80)
    minimizeBox.AnchorPoint = Vector2.new(0.5, 0.5)
    minimizeBox.Visible = false
    minimizeBox.Parent = gui
    
    Utility:AddCorner(minimizeBox, 12)
    Utility:AddShadow(minimizeBox, 15)
    Utility:AddStroke(minimizeBox, self.Config.Theme.Accent, 2, 0.5)
    Utility:MakeDraggable(minimizeBox)
    
    local boxIcon = Instance.new("ImageLabel")
    boxIcon.Name = "BoxIcon"
    boxIcon.BackgroundTransparency = 1
    boxIcon.Position = UDim2.new(0.5, 0, 0.35, 0)
    boxIcon.Size = UDim2.new(0, 35, 0, 35)
    boxIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    boxIcon.Image = windowIcon
    boxIcon.ImageColor3 = self.Config.Theme.Accent
    boxIcon.Parent = minimizeBox
    
    local boxLabel = Instance.new("TextLabel")
    boxLabel.BackgroundTransparency = 1
    boxLabel.Position = UDim2.new(0.5, 0, 0.7, 0)
    boxLabel.Size = UDim2.new(1, -10, 0, 20)
    boxLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    boxLabel.Font = Enum.Font.GothamBold
    boxLabel.Text = windowTitle:sub(1, 8)
    boxLabel.TextColor3 = self.Config.Theme.Text
    boxLabel.TextSize = 11
    boxLabel.TextTruncate = Enum.TextTruncate.AtEnd
    boxLabel.Parent = minimizeBox
    
    local clickCount = 0
    local lastClickTime = 0
    
    minimizeBox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local currentTime = tick()
            
            if currentTime - lastClickTime < 0.3 then
                clickCount = clickCount + 1
            else
                clickCount = 1
            end
            
            lastClickTime = currentTime
            
            if clickCount == 2 then
                clickCount = 0
                Utility:Tween(minimizeBox, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
                task.wait(0.2)
                minimizeBox.Visible = false
                Utility:Tween(main, {Size = UDim2.new(0, baseWidth, 0, baseHeight)}, 0.3, Enum.EasingStyle.Back)
            end
        end
    end)
    
    -- MAIN WINDOW
    local main = Instance.new("Frame")
    main.Name = "Main"
    main.BackgroundTransparency = 1
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    main.Size = UDim2.new(0, 0, 0, 0)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.Parent = gui
    
    local frame = Instance.new("Frame")
    frame.Name = "Frame"
    frame.BackgroundColor3 = self.Config.Theme.Background
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.ClipsDescendants = true
    frame.Parent = main
    
    Utility:AddCorner(frame, 14)
    Utility:AddShadow(main, 25)
    Utility:AddStroke(frame, self.Config.Theme.Accent, 2, 0.6)
    
    -- HEADER
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.BackgroundColor3 = self.Config.Theme.SecondaryBG
    header.BorderSizePixel = 0
    header.Size = UDim2.new(1, 0, 0, 52)
    header.Parent = frame
    
    Utility:AddCorner(header, 14)
    
    Utility:AddGradient(header, 90, ColorSequence.new{
        ColorSequenceKeypoint.new(0, self.Config.Theme.SecondaryBG),
        ColorSequenceKeypoint.new(1, self.Config.Theme.TertiaryBG)
    })
    
    local headerAccent = Instance.new("Frame")
    headerAccent.BackgroundColor3 = self.Config.Theme.Accent
    headerAccent.BorderSizePixel = 0
    headerAccent.Position = UDim2.new(0, 0, 1, -3)
    headerAccent.Size = UDim2.new(1, 0, 0, 3)
    headerAccent.Parent = header
    
    Utility:AddGradient(headerAccent, 0, ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(0.5, self.Config.Theme.Accent),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    })
    
    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 18, 0, 8)
    title.Size = UDim2.new(0.5, 0, 0, 22)
    title.Font = Enum.Font.GothamBold
    title.Text = windowTitle
    title.TextColor3 = self.Config.Theme.Text
    title.TextSize = IsMobile and 15 or 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextTruncate = Enum.TextTruncate.AtEnd
    title.Parent = header
    
    local subtitle = Instance.new("TextLabel")
    subtitle.BackgroundTransparency = 1
    subtitle.Position = UDim2.new(0, 18, 0, 30)
    subtitle.Size = UDim2.new(0.5, 0, 0, 16)
    subtitle.Font = Enum.Font.Gotham
    subtitle.Text = windowSubtitle
    subtitle.TextColor3 = self.Config.Theme.TextDark
    subtitle.TextSize = IsMobile and 11 or 12
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Parent = header
    
    -- HEADER BUTTONS
    local buttonSize = IsMobile and 28 or 32
    local buttonSpacing = 8
    
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.BackgroundColor3 = self.Config.Theme.TertiaryBG
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.Position = UDim2.new(1, -(buttonSize * 2 + buttonSpacing + 12), 0.5, 0)
    minimizeBtn.Size = UDim2.new(0, buttonSize, 0, buttonSize)
    minimizeBtn.AnchorPoint = Vector2.new(0, 0.5)
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.Text = "─"
    minimizeBtn.TextColor3 = self.Config.Theme.Text
    minimizeBtn.TextSize = 16
    minimizeBtn.AutoButtonColor = false
    minimizeBtn.Parent = header
    
    Utility:AddCorner(minimizeBtn, 8)
    
    minimizeBtn.MouseButton1Click:Connect(function()
        Utility:Tween(main, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        task.wait(0.3)
        minimizeBox.Visible = true
        Utility:Tween(minimizeBox, {Size = UDim2.new(0, 80, 0, 80)}, 0.3, Enum.EasingStyle.Back)
    end)
    
    minimizeBtn.MouseEnter:Connect(function()
        Utility:Tween(minimizeBtn, {BackgroundColor3 = self.Config.Theme.Accent}, 0.2)
    end)
    
    minimizeBtn.MouseLeave:Connect(function()
        Utility:Tween(minimizeBtn, {BackgroundColor3 = self.Config.Theme.TertiaryBG}, 0.2)
    end)
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.BackgroundColor3 = self.Config.Theme.Error
    closeBtn.BorderSizePixel = 0
    closeBtn.Position = UDim2.new(1, -(buttonSize + 12), 0.5, 0)
    closeBtn.Size = UDim2.new(0, buttonSize, 0, buttonSize)
    closeBtn.AnchorPoint = Vector2.new(0, 0.5)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "×"
    closeBtn.TextColor3 = self.Config.Theme.Text
    closeBtn.TextSize = 20
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = header
    
    Utility:AddCorner(closeBtn, 8)
    
    closeBtn.MouseButton1Click:Connect(function()
        Utility:Tween(main, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        task.wait(0.35)
        pcall(function() gui:Destroy() end)
    end)
    
    closeBtn.MouseEnter:Connect(function()
        Utility:Tween(closeBtn, {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}, 0.2)
    end)
    
    closeBtn.MouseLeave:Connect(function()
        Utility:Tween(closeBtn, {BackgroundColor3 = self.Config.Theme.Error}, 0.2)
    end)
    
    Utility:MakeDraggable(main, header)
    
    -- TAB CONTAINER
    local tabWidth = IsMobile and 65 or 160
    
    local tabContainer = Instance.new("ScrollingFrame")
    tabContainer.Name = "TabContainer"
    tabContainer.BackgroundColor3 = self.Config.Theme.SecondaryBG
    tabContainer.BorderSizePixel = 0
    tabContainer.Position = UDim2.new(0, 0, 0, 52)
    tabContainer.Size = UDim2.new(0, tabWidth, 1, -52)
    tabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContainer.ScrollBarThickness = 5
    tabContainer.ScrollBarImageColor3 = self.Config.Theme.Accent
    tabContainer.Parent = frame
    
    local tabList = Instance.new("UIListLayout")
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabList.Padding = UDim.new(0, 6)
    tabList.Parent = tabContainer
    
    local tabPadding = Instance.new("UIPadding")
    tabPadding.PaddingTop = UDim.new(0, 12)
    tabPadding.PaddingLeft = UDim.new(0, 10)
    tabPadding.PaddingRight = UDim.new(0, 10)
    tabPadding.PaddingBottom = UDim.new(0, 12)
    tabPadding.Parent = tabContainer
    
    tabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContainer.CanvasSize = UDim2.new(0, 0, 0, tabList.AbsoluteContentSize.Y + 24)
    end)
    
    -- CONTENT CONTAINER
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentContainer"
    contentContainer.BackgroundTransparency = 1
    contentContainer.Position = UDim2.new(0, tabWidth, 0, 52)
    contentContainer.Size = UDim2.new(1, -tabWidth, 1, -52)
    contentContainer.Parent = frame
    
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        Flags = Library.Flags,
        Options = Library.Options,
        MinimizeBox = minimizeBox,
        MainFrame = main,
        BoxIcon = boxIcon,
    }
    
    function Window:SetIcon(imageId)
        boxIcon.Image = imageId
        pcall(function()
            boxIcon.ImageColor3 = Library.Config.Theme.Accent
        end)
    end
    
    function Window:SetFont(font)
        if typeof(font) == "EnumItem" and font.EnumType == Enum.Font then
            Library.Config.UI.Font = font
        end
    end
    
    -- ════════════════════════════════════════════════════════
    -- 📑 CREATE TAB
    -- ════════════════════════════════════════════════════════
    
    function Window:CreateTab(config)
        if type(config) == "string" then
            config = {Name = config}
        end
        
        local tabName = config.Name or config.Title or "Tab"
        local tabIcon = config.Icon or Utility:GetIcon("Home")
        
        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = tabName
        tabBtn.BackgroundColor3 = Library.Config.Theme.TertiaryBG
        tabBtn.BorderSizePixel = 0
        tabBtn.Size = UDim2.new(1, 0, 0, IsMobile and 55 or 42)
        tabBtn.Font = Enum.Font.GothamSemibold
        tabBtn.Text = ""
        tabBtn.TextColor3 = Library.Config.Theme.TextDark
        tabBtn.TextSize = 14
        tabBtn.AutoButtonColor = false
        tabBtn.Parent = tabContainer
        
        Utility:AddCorner(tabBtn, 10)
        Utility:RippleEffect(tabBtn)
        
        local iconLabel = Instance.new("TextLabel")
        iconLabel.BackgroundTransparency = 1
        iconLabel.Position = IsMobile and UDim2.new(0, 0, 0, 8) or UDim2.new(0, 12, 0.5, 0)
        iconLabel.Size = IsMobile and UDim2.new(1, 0, 0, 22) or UDim2.new(0, 24, 0, 24)
        iconLabel.AnchorPoint = IsMobile and Vector2.new(0, 0) or Vector2.new(0, 0.5)
        iconLabel.Font = Enum.Font.GothamBold
        iconLabel.Text = tabIcon
        iconLabel.TextColor3 = Library.Config.Theme.TextDark
        iconLabel.TextSize = IsMobile and 20 or 18
        iconLabel.Parent = tabBtn
        
        local textLabel = Instance.new("TextLabel")
        textLabel.BackgroundTransparency = 1
        textLabel.Position = IsMobile and UDim2.new(0, 0, 0, 32) or UDim2.new(0, 42, 0.5, 0)
        textLabel.Size = IsMobile and UDim2.new(1, 0, 0, 18) or UDim2.new(1, -48, 0, 20)
        textLabel.AnchorPoint = IsMobile and Vector2.new(0, 0) or Vector2.new(0, 0.5)
        textLabel.Font = Enum.Font.GothamSemibold
        textLabel.Text = IsMobile and tabName:sub(1, 3) or tabName
        textLabel.TextColor3 = Library.Config.Theme.TextDark
        textLabel.TextSize = IsMobile and 11 or 13
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.TextTruncate = Enum.TextTruncate.AtEnd
        textLabel.Parent = tabBtn
        
        local indicator = Instance.new("Frame")
        indicator.BackgroundColor3 = Library.Config.Theme.Accent
        indicator.BorderSizePixel = 0
        indicator.Size = UDim2.new(0, 0, 1, 0)
        indicator.Parent = tabBtn
        Utility:AddCorner(indicator, 10)
        
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = tabName .. "_Content"
        tabContent.BackgroundTransparency = 1
        tabContent.BorderSizePixel = 0
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.ScrollBarThickness = 6
        tabContent.ScrollBarImageColor3 = Library.Config.Theme.Accent
        tabContent.Visible = false
        tabContent.Parent = contentContainer
        
        local contentList = Instance.new("UIListLayout")
        contentList.SortOrder = Enum.SortOrder.LayoutOrder
        contentList.Padding = UDim.new(0, 12)
        contentList.Parent = tabContent
        
        local contentPad = Instance.new("UIPadding")
        contentPad.PaddingTop = UDim.new(0, 15)
        contentPad.PaddingLeft = UDim.new(0, 15)
        contentPad.PaddingRight = UDim.new(0, 15)
        contentPad.PaddingBottom = UDim.new(0, 15)
        contentPad.Parent = tabContent
        
        contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabContent.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 30)
        end)
        
        tabBtn.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab:Deactivate()
            end
            
            tabContent.Visible = true
            Window.CurrentTab = tabName
            
            Utility:Tween(tabBtn, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2)
            Utility:Tween(iconLabel, {TextColor3 = Library.Config.Theme.Text}, 0.2)
            Utility:Tween(textLabel, {TextColor3 = Library.Config.Theme.Text}, 0.2)
            Utility:Tween(indicator, {Size = UDim2.new(0, 4, 1, 0)}, 0.3, Enum.EasingStyle.Back)
        end)
        
        tabBtn.MouseEnter:Connect(function()
            if Window.CurrentTab ~= tabName then
                Utility:Tween(tabBtn, {BackgroundColor3 = Library.Config.Theme.SecondaryBG}, 0.2)
            end
        end)
        
        tabBtn.MouseLeave:Connect(function()
            if Window.CurrentTab ~= tabName then
                Utility:Tween(tabBtn, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.2)
            end
        end)
        
        local Tab = {
            Name = tabName,
            Content = tabContent,
        }
        
        function Tab:Deactivate()
            tabContent.Visible = false
            Utility:Tween(tabBtn, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.2)
            Utility:Tween(iconLabel, {TextColor3 = Library.Config.Theme.TextDark}, 0.2)
            Utility:Tween(textLabel, {TextColor3 = Library.Config.Theme.TextDark}, 0.2)
            Utility:Tween(indicator, {Size = UDim2.new(0, 0, 1, 0)}, 0.3)
        end
        
        function Tab:AddSection(sectionName)
            local section = Instance.new("Frame")
            section.Name = sectionName
            section.BackgroundColor3 = Library.Config.Theme.SecondaryBG
            section.BorderSizePixel = 0
            section.Size = UDim2.new(1, 0, 0, 45)
            section.AutomaticSize = Enum.AutomaticSize.Y
            section.Parent = tabContent
            
            Utility:AddCorner(section, 12)
            Utility:AddStroke(section, Library.Config.Theme.Border, 1, 0.7)
            
            local sectionHeader = Instance.new("Frame")
            sectionHeader.BackgroundColor3 = Library.Config.Theme.TertiaryBG
            sectionHeader.BorderSizePixel = 0
            sectionHeader.Size = UDim2.new(1, 0, 0, 45)
            sectionHeader.Parent = section
            
            Utility:AddCorner(sectionHeader, 12)
            
            local sectionAccent = Instance.new("Frame")
            sectionAccent.BackgroundColor3 = Library.Config.Theme.Accent
            sectionAccent.BorderSizePixel = 0
            sectionAccent.Size = UDim2.new(1, 0, 0, 2)
            sectionAccent.Position = UDim2.new(0, 0, 0, 43)
            sectionAccent.Parent = sectionHeader
            
            Utility:AddGradient(sectionAccent, 0, ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                ColorSequenceKeypoint.new(0.5, Library.Config.Theme.Accent),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
            })
            
            local sectionTitle = Instance.new("TextLabel")
            sectionTitle.BackgroundTransparency = 1
            sectionTitle.Position = UDim2.new(0, 15, 0, 0)
            sectionTitle.Size = UDim2.new(1, -30, 0, 45)
            sectionTitle.Font = Enum.Font.GothamBold
            sectionTitle.Text = sectionName
            sectionTitle.TextColor3 = Library.Config.Theme.Text
            sectionTitle.TextSize = IsMobile and 14 or 15
            sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            sectionTitle.Parent = sectionHeader
            
            local sectionContent = Instance.new("Frame")
            sectionContent.BackgroundTransparency = 1
            sectionContent.Position = UDim2.new(0, 0, 0, 45)
            sectionContent.Size = UDim2.new(1, 0, 1, -45)
            sectionContent.AutomaticSize = Enum.AutomaticSize.Y
            sectionContent.Parent = section
            
            local sectionList = Instance.new("UIListLayout")
            sectionList.SortOrder = Enum.SortOrder.LayoutOrder
            sectionList.Padding = UDim.new(0, 10)
            sectionList.Parent = sectionContent
            
            local sectionPad = Instance.new("UIPadding")
            sectionPad.PaddingTop = UDim.new(0, 12)
            sectionPad.PaddingLeft = UDim.new(0, 15)
            sectionPad.PaddingRight = UDim.new(0, 15)
            sectionPad.PaddingBottom = UDim.new(0, 15)
            sectionPad.Parent = sectionContent
            
            local Section = {}
            
            -- ════════════════════════════════════════════════════════
            -- 🔘 ADD BUTTON
            -- ════════════════════════════════════════════════════════
            
            function Section:AddButton(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Button"
                local callback = cfg.Callback or function() end
                local description = cfg.Description
                
                local btn = Instance.new("TextButton")
                btn.BackgroundColor3 = Library.Config.Theme.TertiaryBG
                btn.BorderSizePixel = 0
                btn.Size = UDim2.new(1, 0, 0, description and 48 or 38)
                btn.Font = Enum.Font.GothamSemibold
                btn.Text = ""
                btn.AutoButtonColor = false
                btn.Parent = sectionContent
                
                Utility:AddCorner(btn, 10)
                Utility:RippleEffect(btn)
                
                local stroke = Utility:AddStroke(btn, Library.Config.Theme.Accent, 0, 0.5)
                
                local btnText = Instance.new("TextLabel")
                btnText.BackgroundTransparency = 1
                btnText.Position = UDim2.new(0, 15, 0, description and 8 or 0)
                btnText.Size = UDim2.new(1, -30, 0, description and 20 or 38)
                btnText.Font = Library.Config.UI.Font
                btnText.Text = name
                btnText.TextColor3 = Library.Config.Theme.Text
                btnText.TextSize = Library.Config.UI.TextSize + 1
                btnText.TextXAlignment = Enum.TextXAlignment.Left
                btnText.TextYAlignment = description and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center
                btnText.Parent = btn
                
                if description then
                    local desc = Instance.new("TextLabel")
                    desc.BackgroundTransparency = 1
                    desc.Position = UDim2.new(0, 15, 0, 28)
                    desc.Size = UDim2.new(1, -30, 0, 16)
                    desc.Font = Library.Config.UI.Font
                    desc.Text = description
                    desc.TextColor3 = Library.Config.Theme.TextDark
                    desc.TextSize = Library.Config.UI.TextSize - 1
                    desc.TextXAlignment = Enum.TextXAlignment.Left
                    desc.TextTruncate = Enum.TextTruncate.AtEnd
                    desc.Parent = btn
                end
                
                btn.MouseEnter:Connect(function()
                    Utility:Tween(btn, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2)
                    Utility:Tween(stroke, {Thickness = 2}, 0.2)
                end)
                
                btn.MouseLeave:Connect(function()
                    Utility:Tween(btn, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.2)
                    Utility:Tween(stroke, {Thickness = 0}, 0.2)
                end)
                
                btn.MouseButton1Click:Connect(function()
                    pcall(callback)
                end)
                
                return {
                    Set = function(self, newCallback)
                        callback = newCallback
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════
            -- ✅ ADD TOGGLE
            -- ════════════════════════════════════════════════════════
            
            function Section:AddToggle(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Toggle"
                local default = cfg.Default or false
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                local description = cfg.Description
                
                local toggle = Instance.new("Frame")
                toggle.BackgroundColor3 = Library.Config.Theme.TertiaryBG
                toggle.BorderSizePixel = 0
                toggle.Size = UDim2.new(1, 0, 0, description and 48 or 38)
                toggle.Parent = sectionContent
                
                Utility:AddCorner(toggle, 10)
                
                local label = Instance.new("TextLabel")
                label.BackgroundTransparency = 1
                label.Position = UDim2.new(0, 15, 0, description and 8 or 0)
                label.Size = UDim2.new(1, -70, 0, description and 20 or 38)
                label.Font = Library.Config.UI.Font
                label.Text = name
                label.TextColor3 = Library.Config.Theme.Text
                label.TextSize = Library.Config.UI.TextSize + 1
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextYAlignment = description and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center
                label.TextTruncate = Enum.TextTruncate.AtEnd
                label.Parent = toggle
                
                if description then
                    local desc = Instance.new("TextLabel")
                    desc.BackgroundTransparency = 1
                    desc.Position = UDim2.new(0, 15, 0, 28)
                    desc.Size = UDim2.new(1, -70, 0, 16)
                    desc.Font = Library.Config.UI.Font
                    desc.Text = description
                    desc.TextColor3 = Library.Config.Theme.TextDark
                    desc.TextSize = Library.Config.UI.TextSize - 1
                    desc.TextXAlignment = Enum.TextXAlignment.Left
                    desc.TextTruncate = Enum.TextTruncate.AtEnd
                    desc.Parent = toggle
                end
                
                local switch = Instance.new("TextButton")
                switch.BackgroundColor3 = default and Library.Config.Theme.Accent or Library.Config.Theme.Background
                switch.BorderSizePixel = 0
                switch.Position = UDim2.new(1, -50, 0.5, 0)
                switch.Size = UDim2.new(0, 44, 0, 24)
                switch.AnchorPoint = Vector2.new(0, 0.5)
                switch.Text = ""
                switch.AutoButtonColor = false
                switch.Parent = toggle
                
                Utility:AddCorner(switch, 20)
                
                local circle = Instance.new("Frame")
                circle.BackgroundColor3 = Library.Config.Theme.Text
                circle.BorderSizePixel = 0
                circle.Position = default and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 4, 0.5, 0)
                circle.Size = UDim2.new(0, 16, 0, 16)
                circle.AnchorPoint = Vector2.new(0, 0.5)
                circle.Parent = switch
                
                Utility:AddCorner(circle, 20)
                
                local toggled = default
                
                if flag then
                    Library.Flags[flag] = toggled
                    Library.Options[flag] = {
                        Set = function(val)
                            toggled = val
                            update(val)
                        end,
                        Get = function()
                            return toggled
                        end
                    }
                end
                
                local function update(val)
                    toggled = val
                    
                    if flag then
                        Library.Flags[flag] = val
                    end
                    
                    Utility:Tween(switch, {
                        BackgroundColor3 = toggled and Library.Config.Theme.Accent or Library.Config.Theme.Background
                    }, 0.2)
                    
                    Utility:Tween(circle, {
                        Position = toggled and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 4, 0.5, 0)
                    }, 0.3, Enum.EasingStyle.Back)
                    
                    pcall(callback, toggled)
                end
                
                switch.MouseButton1Click:Connect(function()
                    update(not toggled)
                end)
                
                return Library.Options[flag] or {
                    Set = function(self, val)
                        update(val)
                    end,
                    Get = function()
                        return toggled
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════
            -- 🎚️ ADD SLIDER
            -- ════════════════════════════════════════════════════════
            
            function Section:AddSlider(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Slider"
                local min = cfg.Min or 0
                local max = cfg.Max or 100
                local default = cfg.Default or 50
                local increment = cfg.Increment or 1
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                local suffix = cfg.Suffix or ""
                local description = cfg.Description
                
                local slider = Instance.new("Frame")
                slider.BackgroundColor3 = Library.Config.Theme.TertiaryBG
                slider.BorderSizePixel = 0
                slider.Size = UDim2.new(1, 0, 0, description and 68 or 58)
                slider.Parent = sectionContent
                
                Utility:AddCorner(slider, 10)
                
                local label = Instance.new("TextLabel")
                label.BackgroundTransparency = 1
                label.Position = UDim2.new(0, 15, 0, 10)
                label.Size = UDim2.new(0.6, 0, 0, 20)
                label.Font = Library.Config.UI.Font
                label.Text = name
                label.TextColor3 = Library.Config.Theme.Text
                label.TextSize = Library.Config.UI.TextSize + 1
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextTruncate = Enum.TextTruncate.AtEnd
                label.Parent = slider
                
                if description then
                    local desc = Instance.new("TextLabel")
                    desc.BackgroundTransparency = 1
                    desc.Position = UDim2.new(0, 15, 0, 30)
                    desc.Size = UDim2.new(0.6, 0, 0, 14)
                    desc.Font = Library.Config.UI.Font
                    desc.Text = description
                    desc.TextColor3 = Library.Config.Theme.TextDark
                    desc.TextSize = Library.Config.UI.TextSize - 2
                    desc.TextXAlignment = Enum.TextXAlignment.Left
                    desc.TextTruncate = Enum.TextTruncate.AtEnd
                    desc.Parent = slider
                end
                
                local value = Instance.new("TextLabel")
                value.BackgroundColor3 = Library.Config.Theme.Background
                value.BorderSizePixel = 0
                value.Position = UDim2.new(1, -60, 0, 10)
                value.Size = UDim2.new(0, 50, 0, 20)
                value.Font = Library.Config.UI.Font
                value.Text = tostring(default) .. suffix
                value.TextColor3 = Library.Config.Theme.Accent
                value.TextSize = Library.Config.UI.TextSize
                value.Parent = slider
                
                Utility:AddCorner(value, 6)
                
                local bar = Instance.new("Frame")
                bar.BackgroundColor3 = Library.Config.Theme.Background
                bar.BorderSizePixel = 0
                bar.Position = UDim2.new(0, 15, 1, description and -20 or -18)
                bar.Size = UDim2.new(1, -30, 0, 8)
                bar.Parent = slider
                
                Utility:AddCorner(bar, 10)
                
                local fill = Instance.new("Frame")
                fill.BackgroundColor3 = Library.Config.Theme.Accent
                fill.BorderSizePixel = 0
                fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
                fill.Parent = bar
                
                Utility:AddCorner(fill, 10)
                
                Utility:AddGradient(fill, 0, ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Library.Config.Theme.Accent),
                    ColorSequenceKeypoint.new(1, Library.Config.Theme.AccentLight)
                })
                
                local dot = Instance.new("Frame")
                dot.BackgroundColor3 = Library.Config.Theme.Text
                dot.BorderSizePixel = 0
                dot.Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0)
                dot.Size = UDim2.new(0, 16, 0, 16)
                dot.AnchorPoint = Vector2.new(0.5, 0.5)
                dot.Parent = bar
                
                Utility:AddCorner(dot, 20)
                Utility:AddStroke(dot, Library.Config.Theme.Accent, 2, 0)
                
                local dragging = false
                
                if flag then
                    Library.Flags[flag] = default
                    Library.Options[flag] = {
                        Set = function(val)
                            update(nil, val)
                        end,
                        Get = function()
                            return tonumber(value.Text:gsub(suffix, ""))
                        end
                    }
                end
                
                local function update(input, setVal)
                    local val
                    
                    if setVal then
                        val = setVal
                    else
                        local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                        val = math.floor(min + (max - min) * pos)
                        val = math.floor(val / increment + 0.5) * increment
                        val = math.clamp(val, min, max)
                    end
                    
                    local pos = (val - min) / (max - min)
                    
                    fill.Size = UDim2.new(pos, 0, 1, 0)
                    dot.Position = UDim2.new(pos, 0, 0.5, 0)
                    value.Text = tostring(val) .. suffix
                    
                    if flag then
                        Library.Flags[flag] = val
                    end
                    
                    pcall(callback, val)
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
                
                return Library.Options[flag] or {
                    Set = function(self, val)
                        update(nil, val)
                    end,
                    Get = function()
                        return tonumber(value.Text:gsub(suffix, ""))
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════
            -- 📋 ADD DROPDOWN (IMPROVED)
            -- ════════════════════════════════════════════════════════
            
            function Section:AddDropdown(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Dropdown"
                local items = cfg.Items or cfg.Options or {"Option 1", "Option 2"}
                local default = cfg.Default or items[1]
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                local multi = cfg.Multi or false
                local description = cfg.Description
                local search = cfg.Search or false
                
                local dropdown = Instance.new("Frame")
                dropdown.BackgroundColor3 = Library.Config.Theme.TertiaryBG
                dropdown.BorderSizePixel = 0
                dropdown.Size = UDim2.new(1, 0, 0, description and 48 or 38)
                dropdown.ClipsDescendants = true
                dropdown.Parent = sectionContent
                
                Utility:AddCorner(dropdown, 10)
                
                local label = Instance.new("TextLabel")
                label.BackgroundTransparency = 1
                label.Position = UDim2.new(0, 15, 0, description and 8 or 0)
                label.Size = UDim2.new(0.4, 0, 0, description and 20 or 38)
                label.Font = Library.Config.UI.Font
                label.Text = name
                label.TextColor3 = Library.Config.Theme.Text
                label.TextSize = Library.Config.UI.TextSize + 1
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextYAlignment = description and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center
                label.TextTruncate = Enum.TextTruncate.AtEnd
                label.Parent = dropdown
                
                if description then
                    local desc = Instance.new("TextLabel")
                    desc.BackgroundTransparency = 1
                    desc.Position = UDim2.new(0, 15, 0, 28)
                    desc.Size = UDim2.new(0.4, 0, 0, 16)
                    desc.Font = Library.Config.UI.Font
                    desc.Text = description
                    desc.TextColor3 = Library.Config.Theme.TextDark
                    desc.TextSize = Library.Config.UI.TextSize - 2
                    desc.TextXAlignment = Enum.TextXAlignment.Left
                    desc.TextTruncate = Enum.TextTruncate.AtEnd
                    desc.Parent = dropdown
                end
                
                local dropBtn = Instance.new("TextButton")
                dropBtn.BackgroundColor3 = Library.Config.Theme.Background
                dropBtn.BorderSizePixel = 0
                dropBtn.Position = UDim2.new(0.45, 0, 0, description and 8 or 9)
                dropBtn.Size = UDim2.new(0.5, -15, 0, description and 20 or 20)
                dropBtn.Font = Library.Config.UI.Font
                dropBtn.Text = "  " .. (multi and "Multiple" or default)
                dropBtn.TextColor3 = Library.Config.Theme.Accent
                dropBtn.TextSize = Library.Config.UI.TextSize
                dropBtn.TextXAlignment = Enum.TextXAlignment.Left
                dropBtn.AutoButtonColor = false
                dropBtn.TextTruncate = Enum.TextTruncate.AtEnd
                dropBtn.Parent = dropdown
                
                Utility:AddCorner(dropBtn, 8)
                Utility:AddStroke(dropBtn, Library.Config.Theme.Border, 1, 0.5)
                
                local arrow = Instance.new("TextLabel")
                arrow.BackgroundTransparency = 1
                arrow.Position = UDim2.new(1, -22, 0, 0)
                arrow.Size = UDim2.new(0, 20, 1, 0)
                arrow.Font = Enum.Font.GothamBold
                arrow.Text = "▼"
                arrow.TextColor3 = Library.Config.Theme.TextDark
                arrow.TextSize = 10
                arrow.Parent = dropBtn
                
                local itemContainer = Instance.new("Frame")
                itemContainer.BackgroundTransparency = 1
                itemContainer.BorderSizePixel = 0
                itemContainer.Position = UDim2.new(0, 10, 0, description and 50 or 42)
                itemContainer.Size = UDim2.new(1, -20, 0, 0)
                itemContainer.Parent = dropdown
                
                local searchBox
                if search then
                    searchBox = Instance.new("TextBox")
                    searchBox.BackgroundColor3 = Library.Config.Theme.Background
                    searchBox.BorderSizePixel = 0
                    searchBox.Size = UDim2.new(1, 0, 0, 28)
                    searchBox.Font = Library.Config.UI.Font
                    searchBox.PlaceholderText = "🔍 Search..."
                    searchBox.PlaceholderColor3 = Library.Config.Theme.TextDark
                    searchBox.Text = ""
                    searchBox.TextColor3 = Library.Config.Theme.Text
                    searchBox.TextSize = Library.Config.UI.TextSize
                    searchBox.ClearTextOnFocus = false
                    searchBox.Parent = itemContainer
                    
                    Utility:AddCorner(searchBox, 7)
                    
                    local searchPad = Instance.new("UIPadding")
                    searchPad.PaddingLeft = UDim.new(0, 10)
                    searchPad.PaddingRight = UDim.new(0, 10)
                    searchPad.Parent = searchBox
                end
                
                local itemList = Instance.new("ScrollingFrame")
                itemList.BackgroundTransparency = 1
                itemList.BorderSizePixel = 0
                itemList.Position = UDim2.new(0, 0, 0, search and 33 or 0)
                itemList.Size = UDim2.new(1, 0, 0, 0)
                itemList.CanvasSize = UDim2.new(0, 0, 0, 0)
                itemList.ScrollBarThickness = 4
                itemList.ScrollBarImageColor3 = Library.Config.Theme.Accent
                itemList.Parent = itemContainer
                
                local listLayout = Instance.new("UIListLayout")
                listLayout.SortOrder = Enum.SortOrder.LayoutOrder
                listLayout.Padding = UDim.new(0, 5)
                listLayout.Parent = itemList
                
                listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    itemList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
                end)
                
                local expanded = false
                local currentValue = default
                local selectedItems = multi and {} or nil
                
                if flag then
                    Library.Flags[flag] = multi and selectedItems or currentValue
                    Library.Options[flag] = {
                        Set = function(val)
                            if multi then
                                selectedItems = val
                            else
                                currentValue = val
                                dropBtn.Text = "  " .. val
                            end
                        end,
                        Get = function()
                            return multi and selectedItems or currentValue
                        end,
                        Refresh = function(newItems, newDefault)
                            items = newItems
                            itemList:ClearAllChildren()
                            listLayout.Parent = itemList
                            
                            for _, item in ipairs(newItems) do
                                createItem(item)
                            end
                            
                            if newDefault and table.find(newItems, newDefault) then
                                currentValue = newDefault
                                dropBtn.Text = "  " .. newDefault
                                
                                if flag then
                                    Library.Flags[flag] = newDefault
                                end
                            end
                        end
                    }
                end
                
                local function createItem(itemName)
                    local item = Instance.new("TextButton")
                    item.Name = itemName
                    item.BackgroundColor3 = Library.Config.Theme.Background
                    item.BorderSizePixel = 0
                    item.Size = UDim2.new(1, 0, 0, 28)
                    item.Font = Library.Config.UI.Font
                    item.Text = "  " .. itemName
                    item.TextColor3 = Library.Config.Theme.Text
                    item.TextSize = Library.Config.UI.TextSize
                    item.TextXAlignment = Enum.TextXAlignment.Left
                    item.AutoButtonColor = false
                    item.TextTruncate = Enum.TextTruncate.AtEnd
                    item.Parent = itemList
                    
                    Utility:AddCorner(item, 7)
                    
                    if multi then
                        local checkbox = Instance.new("Frame")
                        checkbox.BackgroundColor3 = Library.Config.Theme.TertiaryBG
                        checkbox.BorderSizePixel = 0
                        checkbox.Position = UDim2.new(1, -24, 0.5, 0)
                        checkbox.Size = UDim2.new(0, 18, 0, 18)
                        checkbox.AnchorPoint = Vector2.new(0, 0.5)
                        checkbox.Parent = item
                        
                        Utility:AddCorner(checkbox, 4)
                        Utility:AddStroke(checkbox, Library.Config.Theme.Accent, 1, 0.5)
                        
                        local check = Instance.new("TextLabel")
                        check.BackgroundTransparency = 1
                        check.Size = UDim2.new(1, 0, 1, 0)
                        check.Font = Enum.Font.GothamBold
                        check.Text = "✓"
                        check.TextColor3 = Library.Config.Theme.Accent
                        check.TextSize = 12
                        check.Visible = false
                        check.Parent = checkbox
                        
                        item.MouseButton1Click:Connect(function()
                            if table.find(selectedItems, itemName) then
                                table.remove(selectedItems, table.find(selectedItems, itemName))
                                check.Visible = false
                                checkbox.BackgroundColor3 = Library.Config.Theme.TertiaryBG
                            else
                                table.insert(selectedItems, itemName)
                                check.Visible = true
                                checkbox.BackgroundColor3 = Library.Config.Theme.Accent
                            end
                            
                            dropBtn.Text = "  " .. #selectedItems .. " Selected"
                            
                            if flag then
                                Library.Flags[flag] = selectedItems
                            end
                            
                            pcall(callback, selectedItems)
                        end)
                    else
                        item.MouseButton1Click:Connect(function()
                            currentValue = itemName
                            dropBtn.Text = "  " .. itemName
                            
                            if flag then
                                Library.Flags[flag] = itemName
                            end
                            
                            pcall(callback, itemName)
                            
                            expanded = false
                            local baseHeight = description and 48 or 38
                            Utility:Tween(dropdown, {Size = UDim2.new(1, 0, 0, baseHeight)}, 0.3, Enum.EasingStyle.Back)
                            Utility:Tween(arrow, {Rotation = 0}, 0.3)
                        end)
                    end
                    
                    item.MouseEnter:Connect(function()
                        Utility:Tween(item, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2)
                    end)
                    
                    item.MouseLeave:Connect(function()
                        Utility:Tween(item, {BackgroundColor3 = Library.Config.Theme.Background}, 0.2)
                    end)
                end
                
                for _, item in ipairs(items) do
                    createItem(item)
                end
                
                if search and searchBox then
                    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
                        local searchText = searchBox.Text:lower()
                        
                        for _, item in ipairs(itemList:GetChildren()) do
                            if item:IsA("TextButton") then
                                if searchText == "" or item.Name:lower():find(searchText) then
                                    item.Visible = true
                                else
                                    item.Visible = false
                                end
                            end
                        end
                    end)
                end
                
                dropBtn.MouseButton1Click:Connect(function()
                    expanded = not expanded
                    
                    if expanded then
                        local visibleCount = 0
                        for _, item in ipairs(itemList:GetChildren()) do
                            if item:IsA("TextButton") and item.Visible then
                                visibleCount = visibleCount + 1
                            end
                        end
                        
                        local itemCount = math.min(visibleCount, 5)
                        local itemHeight = 28
                        local baseHeight = description and 48 or 38
                        local searchHeight = search and 33 or 0
                        local totalHeight = baseHeight + 14 + searchHeight + (itemCount * (itemHeight + 5))
                        
                        Utility:Tween(dropdown, {Size = UDim2.new(1, 0, 0, totalHeight)}, 0.3, Enum.EasingStyle.Back)
                        Utility:Tween(arrow, {Rotation = 180}, 0.3)
                        itemList.Size = UDim2.new(1, 0, 0, itemCount * (itemHeight + 5))
                    else
                        local baseHeight = description and 48 or 38
                        Utility:Tween(dropdown, {Size = UDim2.new(1, 0, 0, baseHeight)}, 0.3, Enum.EasingStyle.Back)
                        Utility:Tween(arrow, {Rotation = 0}, 0.3)
                    end
                end)
                
                return Library.Options[flag] or {
                    Set = function(self, val)
                        if multi then
                            selectedItems = val
                        else
                            currentValue = val
                            dropBtn.Text = "  " .. val
                        end
                    end,
                    Get = function()
                        return multi and selectedItems or currentValue
                    end,
                    Refresh = function(self, newItems, newDefault)
                        items = newItems
                        itemList:ClearAllChildren()
                        listLayout.Parent = itemList
                        
                        for _, item in ipairs(newItems) do
                            createItem(item)
                        end
                        
                        if newDefault and table.find(newItems, newDefault) then
                            currentValue = newDefault
                            dropBtn.Text = "  " .. newDefault
                            
                            if flag then
                                Library.Flags[flag] = newDefault
                            end
                        end
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════
            -- 🎨 ADD COLOR PICKER
            -- ════════════════════════════════════════════════════════
            
            function Section:AddColorPicker(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Color Picker"
                local default = cfg.Default or Color3.fromRGB(255, 255, 255)
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                
                local picker = Instance.new("Frame")
                picker.BackgroundColor3 = Library.Config.Theme.TertiaryBG
                picker.BorderSizePixel = 0
                picker.Size = UDim2.new(1, 0, 0, 38)
                picker.ClipsDescendants = true
                picker.Parent = sectionContent
                
                Utility:AddCorner(picker, 10)
                
                local label = Instance.new("TextLabel")
                label.BackgroundTransparency = 1
                label.Position = UDim2.new(0, 15, 0, 0)
                label.Size = UDim2.new(0.7, 0, 0, 38)
                label.Font = Library.Config.UI.Font
                label.Text = name
                label.TextColor3 = Library.Config.Theme.Text
                label.TextSize = Library.Config.UI.TextSize + 1
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextTruncate = Enum.TextTruncate.AtEnd
                label.Parent = picker
                
                local display = Instance.new("TextButton")
                display.BackgroundColor3 = default
                display.BorderSizePixel = 0
                display.Position = UDim2.new(1, -58, 0.5, 0)
                display.Size = UDim2.new(0, 48, 0, 22)
                display.AnchorPoint = Vector2.new(0, 0.5)
                display.Text = ""
                display.AutoButtonColor = false
                display.Parent = picker
                
                Utility:AddCorner(display, 7)
                Utility:AddStroke(display, Library.Config.Theme.Border, 2)
                
                local palette = Instance.new("Frame")
                palette.BackgroundColor3 = Library.Config.Theme.Background
                palette.BorderSizePixel = 0
                palette.Position = UDim2.new(0, 10, 0, 42)
                palette.Size = UDim2.new(1, -20, 0, 165)
                palette.Visible = false
                palette.Parent = picker
                
                Utility:AddCorner(palette, 10)
                Utility:AddStroke(palette, Library.Config.Theme.Border, 1, 0.5)
                
                local canvas = Instance.new("ImageButton")
                canvas.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                canvas.BorderSizePixel = 0
                canvas.Position = UDim2.new(0, 10, 0, 10)
                canvas.Size = UDim2.new(1, -90, 1, -20)
                canvas.Image = "rbxassetid://4155801252"
                canvas.AutoButtonColor = false
                canvas.Parent = palette
                
                Utility:AddCorner(canvas, 8)
                
                local hue = Instance.new("ImageButton")
                hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                hue.BorderSizePixel = 0
                hue.Position = UDim2.new(1, -72, 0, 10)
                hue.Size = UDim2.new(0, 32, 1, -20)
                hue.Image = "rbxassetid://3641079629"
                hue.AutoButtonColor = false
                hue.Parent = palette
                
                Utility:AddCorner(hue, 8)
                
                local confirm = Instance.new("TextButton")
                confirm.BackgroundColor3 = Library.Config.Theme.Accent
                confirm.BorderSizePixel = 0
                confirm.Position = UDim2.new(1, -32, 0, 10)
                confirm.Size = UDim2.new(0, 22, 0, 22)
                confirm.Font = Enum.Font.GothamBold
                confirm.Text = "✓"
                confirm.TextColor3 = Library.Config.Theme.Text
                confirm.TextSize = 14
                confirm.AutoButtonColor = false
                confirm.Parent = palette
                
                Utility:AddCorner(confirm, 6)
                
                local hexBox = Instance.new("TextBox")
                hexBox.BackgroundColor3 = Library.Config.Theme.TertiaryBG
                hexBox.BorderSizePixel = 0
                hexBox.Position = UDim2.new(1, -32, 0, 38)
                hexBox.Size = UDim2.new(0, 22, 0, 107)
                hexBox.Font = Enum.Font.Gotham
                hexBox.Text = ""
                hexBox.PlaceholderText = "HEX"
                hexBox.PlaceholderColor3 = Library.Config.Theme.TextDark
                hexBox.TextColor3 = Library.Config.Theme.Text
                hexBox.TextSize = 10
                hexBox.ClearTextOnFocus = false
                hexBox.Parent = palette
                
                Utility:AddCorner(hexBox, 6)
                
                local expanded = false
                local h, s, v = default:ToHSV()
                
                if flag then
                    Library.Flags[flag] = default
                    Library.Options[flag] = {
                        Set = function(color)
                            local hh, ss, vv = color:ToHSV()
                            h, s, v = hh, ss, vv
                            updateColor()
                        end,
                        Get = function()
                            return Color3.fromHSV(h, s, v)
                        end
                    }
                end
                
                local function updateColor()
                    local color = Color3.fromHSV(h, s, v)
                    display.BackgroundColor3 = color
                    canvas.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                    
                    local hex = string.format("#%02X%02X%02X", 
                        math.floor(color.R * 255),
                        math.floor(color.G * 255),
                        math.floor(color.B * 255)
                    )
                    hexBox.Text = hex
                    
                    if flag then
                        Library.Flags[flag] = color
                    end
                    
                    pcall(callback, color)
                end
                
                local hueDragging = false
                local canvasDragging = false
                
                hue.MouseButton1Down:Connect(function()
                    hueDragging = true
                end)
                
                canvas.MouseButton1Down:Connect(function()
                    canvasDragging = true
                end)
                
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
                            updateColor()
                        end
                        
                        if canvasDragging then
                            local posX = math.clamp((input.Position.X - canvas.AbsolutePosition.X) / canvas.AbsoluteSize.X, 0, 1)
                            local posY = math.clamp((input.Position.Y - canvas.AbsolutePosition.Y) / canvas.AbsoluteSize.Y, 0, 1)
                            s = posX
                            v = 1 - posY
                            updateColor()
                        end
                    end
                end)
                
                hexBox.FocusLost:Connect(function()
                    local hex = hexBox.Text:gsub("#", "")
                    if #hex == 6 then
                        local r = tonumber(hex:sub(1, 2), 16) / 255
                        local g = tonumber(hex:sub(3, 4), 16) / 255
                        local b = tonumber(hex:sub(5, 6), 16) / 255
                        
                        local color = Color3.new(r, g, b)
                        local hh, ss, vv = color:ToHSV()
                        h, s, v = hh, ss, vv
                        updateColor()
                    end
                end)
                
                display.MouseButton1Click:Connect(function()
                    expanded = not expanded
                    palette.Visible = expanded
                    
                    if expanded then
                        Utility:Tween(picker, {Size = UDim2.new(1, 0, 0, 215)}, 0.3, Enum.EasingStyle.Back)
                    else
                        Utility:Tween(picker, {Size = UDim2.new(1, 0, 0, 38)}, 0.3, Enum.EasingStyle.Back)
                    end
                end)
                
                confirm.MouseButton1Click:Connect(function()
                    expanded = false
                    palette.Visible = false
                    Utility:Tween(picker, {Size = UDim2.new(1, 0, 0, 38)}, 0.3, Enum.EasingStyle.Back)
                end)
                
                updateColor()
                
                return Library.Options[flag] or {
                    Set = function(self, color)
                        local hh, ss, vv = color:ToHSV()
                        h, s, v = hh, ss, vv
                        updateColor()
                    end,
                    Get = function()
                        return Color3.fromHSV(h, s, v)
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════
            -- ⌨️ ADD TEXTBOX
            -- ════════════════════════════════════════════════════════
            
            function Section:AddTextbox(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Textbox"
                local default = cfg.Default or ""
                local placeholder = cfg.Placeholder or "Enter text..."
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                local numbersOnly = cfg.NumbersOnly or false
                local description = cfg.Description
                
                local textbox = Instance.new("Frame")
                textbox.BackgroundColor3 = Library.Config.Theme.TertiaryBG
                textbox.BorderSizePixel = 0
                textbox.Size = UDim2.new(1, 0, 0, description and 48 or 38)
                textbox.Parent = sectionContent
                
                Utility:AddCorner(textbox, 10)
                
                local label = Instance.new("TextLabel")
                label.BackgroundTransparency = 1
                label.Position = UDim2.new(0, 15, 0, description and 8 or 0)
                label.Size = UDim2.new(0.35, 0, 0, description and 20 or 38)
                label.Font = Library.Config.UI.Font
                label.Text = name
                label.TextColor3 = Library.Config.Theme.Text
                label.TextSize = Library.Config.UI.TextSize + 1
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextYAlignment = description and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center
                label.TextTruncate = Enum.TextTruncate.AtEnd
                label.Parent = textbox
                
                if description then
                    local desc = Instance.new("TextLabel")
                    desc.BackgroundTransparency = 1
                    desc.Position = UDim2.new(0, 15, 0, 28)
                    desc.Size = UDim2.new(0.35, 0, 0, 16)
                    desc.Font = Library.Config.UI.Font
                    desc.Text = description
                    desc.TextColor3 = Library.Config.Theme.TextDark
                    desc.TextSize = Library.Config.UI.TextSize - 2
                    desc.TextXAlignment = Enum.TextXAlignment.Left
                    desc.TextTruncate = Enum.TextTruncate.AtEnd
                    desc.Parent = textbox
                end
                
                local input = Instance.new("TextBox")
                input.BackgroundColor3 = Library.Config.Theme.Background
                input.BorderSizePixel = 0
                input.Position = UDim2.new(0.4, 0, 0.5, 0)
                input.Size = UDim2.new(0.58, 0, 0, description and 20 or 22)
                input.AnchorPoint = Vector2.new(0, 0.5)
                input.Font = Library.Config.UI.Font
                input.PlaceholderText = placeholder
                input.PlaceholderColor3 = Library.Config.Theme.TextDark
                input.Text = default
                input.TextColor3 = Library.Config.Theme.Accent
                input.TextSize = Library.Config.UI.TextSize
                input.ClearTextOnFocus = false
                input.TextTruncate = Enum.TextTruncate.AtEnd
                input.Parent = textbox
                
                Utility:AddCorner(input, 7)
                
                local padding = Instance.new("UIPadding")
                padding.PaddingLeft = UDim.new(0, 10)
                padding.PaddingRight = UDim.new(0, 10)
                padding.Parent = input
                
                if flag then
                    Library.Flags[flag] = default
                    Library.Options[flag] = {
                        Set = function(text)
                            input.Text = text
                        end,
                        Get = function()
                            return input.Text
                        end
                    }
                end
                
                if numbersOnly then
                    input:GetPropertyChangedSignal("Text"):Connect(function()
                        input.Text = input.Text:gsub("%D", "")
                    end)
                end
                
                input.FocusLost:Connect(function(enter)
                    if enter then
                        if flag then
                            Library.Flags[flag] = input.Text
                        end
                        
                        pcall(callback, input.Text)
                    end
                end)
                
                input.Focused:Connect(function()
                    Utility:Tween(input, {BackgroundColor3 = Library.Config.Theme.SecondaryBG}, 0.2)
                end)
                
                input.FocusLost:Connect(function()
                    Utility:Tween(input, {BackgroundColor3 = Library.Config.Theme.Background}, 0.2)
                end)
                
                return Library.Options[flag] or {
                    Set = function(self, text)
                        input.Text = text
                        
                        if flag then
                            Library.Flags[flag] = text
                        end
                        
                        pcall(callback, text)
                    end,
                    Get = function()
                        return input.Text
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════
            -- 🔑 ADD KEYBIND
            -- ════════════════════════════════════════════════════════
            
            function Section:AddKeybind(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Keybind"
                local default = cfg.Default or Enum.KeyCode.E
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                local mode = cfg.Mode or "Toggle"
                
                local keybind = Instance.new("Frame")
                keybind.BackgroundColor3 = Library.Config.Theme.TertiaryBG
                keybind.BorderSizePixel = 0
                keybind.Size = UDim2.new(1, 0, 0, 38)
                keybind.Parent = sectionContent
                
                Utility:AddCorner(keybind, 10)
                
                local label = Instance.new("TextLabel")
                label.BackgroundTransparency = 1
                label.Position = UDim2.new(0, 15, 0, 0)
                label.Size = UDim2.new(0.6, 0, 0, 38)
                label.Font = Library.Config.UI.Font
                label.Text = name
                label.TextColor3 = Library.Config.Theme.Text
                label.TextSize = Library.Config.UI.TextSize + 1
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextTruncate = Enum.TextTruncate.AtEnd
                label.Parent = keybind
                
                local keyBtn = Instance.new("TextButton")
                keyBtn.BackgroundColor3 = Library.Config.Theme.Background
                keyBtn.BorderSizePixel = 0
                keyBtn.Position = UDim2.new(1, -72, 0.5, 0)
                keyBtn.Size = UDim2.new(0, 62, 0, 22)
                keyBtn.AnchorPoint = Vector2.new(0, 0.5)
                keyBtn.Font = Library.Config.UI.Font
                keyBtn.Text = default.Name
                keyBtn.TextColor3 = Library.Config.Theme.Accent
                keyBtn.TextSize = Library.Config.UI.TextSize - 1
                keyBtn.AutoButtonColor = false
                keyBtn.Parent = keybind
                
                Utility:AddCorner(keyBtn, 7)
                
                local currentKey = default
                local listening = false
                local toggled = false
                
                if flag then
                    Library.Flags[flag] = currentKey
                    Library.Options[flag] = {
                        Set = function(key)
                            currentKey = key
                            keyBtn.Text = key.Name
                        end,
                        Get = function()
                            return currentKey
                        end
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
                            currentKey = input.KeyCode
                            keyBtn.Text = input.KeyCode.Name
                            listening = false
                            
                            if flag then
                                Library.Flags[flag] = currentKey
                            end
                            
                            Utility:Tween(keyBtn, {BackgroundColor3 = Library.Config.Theme.Background}, 0.2)
                        end
                    elseif input.KeyCode == currentKey then
                        if mode == "Toggle" then
                            toggled = not toggled
                            pcall(callback, toggled)
                        elseif mode == "Hold" then
                            pcall(callback, true)
                        end
                    end
                end)
                
                if mode == "Hold" then
                    Services.UserInputService.InputEnded:Connect(function(input, gp)
                        if gp then return end
                        
                        if input.KeyCode == currentKey then
                            pcall(callback, false)
                        end
                    end)
                end
                
                return Library.Options[flag] or {
                    Set = function(self, key)
                        currentKey = key
                        keyBtn.Text = key.Name
                        
                        if flag then
                            Library.Flags[flag] = key
                        end
                    end,
                    Get = function()
                        return currentKey
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════
            -- 📝 ADD LABEL
            -- ════════════════════════════════════════════════════════
            
            function Section:AddLabel(text)
                local label = Instance.new("TextLabel")
                label.BackgroundTransparency = 1
                label.Size = UDim2.new(1, 0, 0, 22)
                label.Font = Library.Config.UI.Font
                label.Text = text or "Label"
                label.TextColor3 = Library.Config.Theme.TextDark
                label.TextSize = Library.Config.UI.TextSize
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextWrapped = true
                label.AutomaticSize = Enum.AutomaticSize.Y
                label.Parent = sectionContent
                
                return {
                    Set = function(self, t)
                        label.Text = t
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════
            -- 📄 ADD PARAGRAPH
            -- ════════════════════════════════════════════════════════
            
            function Section:AddParagraph(title, content)
                local para = Instance.new("Frame")
                para.BackgroundColor3 = Library.Config.Theme.Background
                para.BorderSizePixel = 0
                para.Size = UDim2.new(1, 0, 0, 65)
                para.AutomaticSize = Enum.AutomaticSize.Y
                para.Parent = sectionContent
                
                Utility:AddCorner(para, 10)
                
                local paraTitle = Instance.new("TextLabel")
                paraTitle.BackgroundTransparency = 1
                paraTitle.Position = UDim2.new(0, 15, 0, 10)
                paraTitle.Size = UDim2.new(1, -30, 0, 20)
                paraTitle.Font = Enum.Font.GothamBold
                paraTitle.Text = title or "Title"
                paraTitle.TextColor3 = Library.Config.Theme.Text
                paraTitle.TextSize = Library.Config.UI.TextSize + 1
                paraTitle.TextXAlignment = Enum.TextXAlignment.Left
                paraTitle.Parent = para
                
                local paraContent = Instance.new("TextLabel")
                paraContent.BackgroundTransparency = 1
                paraContent.Position = UDim2.new(0, 15, 0, 32)
                paraContent.Size = UDim2.new(1, -30, 1, -42)
                paraContent.Font = Library.Config.UI.Font
                paraContent.Text = content or "Content"
                paraContent.TextColor3 = Library.Config.Theme.TextDark
                paraContent.TextSize = Library.Config.UI.TextSize
                paraContent.TextXAlignment = Enum.TextXAlignment.Left
                paraContent.TextYAlignment = Enum.TextYAlignment.Top
                paraContent.TextWrapped = true
                paraContent.AutomaticSize = Enum.AutomaticSize.Y
                paraContent.Parent = para
                
                local pad = Instance.new("UIPadding")
                pad.PaddingBottom = UDim.new(0, 12)
                pad.Parent = para
                
                return {
                    SetTitle = function(self, t)
                        paraTitle.Text = t
                    end,
                    SetContent = function(self, c)
                        paraContent.Text = c
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════
            -- ➖ ADD DIVIDER
            -- ════════════════════════════════════════════════════════
            
            function Section:AddDivider(text)
                local divider = Instance.new("Frame")
                divider.BackgroundTransparency = 1
                divider.Size = UDim2.new(1, 0, 0, text and 30 or 10)
                divider.Parent = sectionContent
                
                local line = Instance.new("Frame")
                line.BackgroundColor3 = Library.Config.Theme.Border
                line.BorderSizePixel = 0
                line.Position = UDim2.new(0, 0, 0.5, 0)
                line.Size = UDim2.new(1, 0, 0, 2)
                line.AnchorPoint = Vector2.new(0, 0.5)
                line.Parent = divider
                
                Utility:AddGradient(line, 0, ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                    ColorSequenceKeypoint.new(0.5, Library.Config.Theme.Border),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
                })
                
                if text then
                    local label = Instance.new("TextLabel")
                    label.BackgroundColor3 = Library.Config.Theme.SecondaryBG
                    label.BorderSizePixel = 0
                    label.Position = UDim2.new(0.5, 0, 0.5, 0)
                    label.Size = UDim2.new(0, 0, 0, 20)
                    label.AnchorPoint = Vector2.new(0.5, 0.5)
                    label.Font = Enum.Font.GothamBold
                    label.Text = " " .. text .. " "
                    label.TextColor3 = Library.Config.Theme.TextDark
                    label.TextSize = Library.Config.UI.TextSize - 1
                    label.AutomaticSize = Enum.AutomaticSize.X
                    label.Parent = divider
                    
                    Utility:AddCorner(label, 5)
                end
            end
            
            return Section
        end
        
        if #Window.Tabs == 0 then
            tabContent.Visible = true
            Window.CurrentTab = tabName
            tabBtn.BackgroundColor3 = Library.Config.Theme.Accent
            iconLabel.TextColor3 = Library.Config.Theme.Text
            textLabel.TextColor3 = Library.Config.Theme.Text
            indicator.Size = UDim2.new(0, 4, 1, 0)
        end
        
        table.insert(Window.Tabs, Tab)
        return Tab
    end
    
    -- KEYBIND TOGGLE
    if IsPC and windowKeybind then
        local visible = true
        Services.UserInputService.InputBegan:Connect(function(input, gp)
            if not gp and input.KeyCode == windowKeybind then
                visible = not visible
                
                if minimizeBox.Visible then
                    minimizeBox.Visible = false
                    Utility:Tween(minimizeBox, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
                    Utility:Tween(main, {Size = visible and UDim2.new(0, baseWidth, 0, baseHeight) or UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
                else
                    Utility:Tween(main, {Size = visible and UDim2.new(0, baseWidth, 0, baseHeight) or UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
                end
            end
        end)
    end
    
    -- RESPONSIVE RESIZE
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        local newViewport = workspace.CurrentCamera.ViewportSize
        local newWidth = IsMobile and math.clamp(newViewport.X * 0.95, 340, 500) or math.clamp(newViewport.X * 0.5, 600, 800)
        local newHeight = IsMobile and math.clamp(newViewport.Y * 0.88, 480, 750) or math.clamp(newViewport.Y * 0.7, 500, 700)
        
        if main.Size ~= UDim2.new(0, 0, 0, 0) and not minimizeBox.Visible then
            main.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
        
        baseWidth = newWidth
        baseHeight = newHeight
    end)
    
    -- OPEN ANIMATION
    Utility:Tween(main, {Size = UDim2.new(0, baseWidth, 0, baseHeight)}, 0.7, Enum.EasingStyle.Back)
    
    return Window
end

return Library
