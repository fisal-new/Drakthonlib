--[[
    ╔═══════════════════════════════════════════════════════╗
    ║           DRAKTHON UI LIBRARY - COMPLETE             ║
    ║     Beautiful, Responsive & Feature-Rich UI          ║
    ║              All Elements Included                    ║
    ╚═══════════════════════════════════════════════════════╝
]]

local Library = {}
Library.Version = "5.0.0"
Library.Flags = {}

-- ════════════════════════════════════════════════════════
-- 🔧 SERVICES
-- ════════════════════════════════════════════════════════

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Device Detection
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- ════════════════════════════════════════════════════════
-- 🎨 THEME COLORS
-- ════════════════════════════════════════════════════════

local Theme = {
    -- Background Colors
    Background = Color3.fromRGB(20, 20, 25),
    SecondaryBackground = Color3.fromRGB(28, 28, 35),
    TertiaryBackground = Color3.fromRGB(35, 35, 42),
    
    -- Accent Colors
    Accent = Color3.fromRGB(138, 43, 226), -- Purple
    AccentDark = Color3.fromRGB(118, 33, 206),
    AccentLight = Color3.fromRGB(158, 63, 246),
    
    -- Text Colors
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(200, 200, 210),
    TextDisabled = Color3.fromRGB(120, 120, 130),
    
    -- Status Colors
    Success = Color3.fromRGB(46, 204, 113),
    Warning = Color3.fromRGB(241, 196, 15),
    Error = Color3.fromRGB(231, 76, 60),
    Info = Color3.fromRGB(52, 152, 219),
    
    -- UI Colors
    Border = Color3.fromRGB(50, 50, 60),
    Shadow = Color3.fromRGB(0, 0, 0),
    Outline = Color3.fromRGB(60, 60, 70),
}

-- ════════════════════════════════════════════════════════
-- ⚙️ UTILITY FUNCTIONS
-- ════════════════════════════════════════════════════════

local function Tween(object, properties, duration, style, direction)
    if not object then return end
    
    duration = duration or 0.3
    style = style or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    
    local tween = TweenService:Create(object, TweenInfo.new(duration, style, direction), properties)
    tween:Play()
    return tween
end

local function MakeDraggable(gui, dragHandle)
    local dragging = false
    local dragInput, mousePos, framePos
    
    dragHandle = dragHandle or gui
    
    local function update(input)
        local delta = input.Position - mousePos
        gui.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
    
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = gui.Position
            
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
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

local function CreateScreenGui()
    local gui = Instance.new("ScreenGui")
    
    pcall(function()
        if gethui then
            gui.Parent = gethui()
        elseif syn and syn.protect_gui then
            gui.Parent = game:GetService("CoreGui")
            syn.protect_gui(gui)
        else
            gui.Parent = game:GetService("CoreGui")
        end
    end)
    
    if not gui.Parent then
        gui.Parent = Player:WaitForChild("PlayerGui")
    end
    
    gui.Name = "DrakthonUI_" .. HttpService:GenerateGUID(false)
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 100
    
    return gui
end

local function AddShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Parent = parent
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Image = "rbxassetid://6015897843"
    shadow.ImageColor3 = Theme.Shadow
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    return shadow
end

-- ════════════════════════════════════════════════════════
-- 🔔 NOTIFICATION SYSTEM
-- ════════════════════════════════════════════════════════

local Notifications = {}

function Library:Notify(config)
    config = config or {}
    
    local title = config.Title or "Notification"
    local message = config.Message or config.Description or ""
    local duration = config.Duration or 3
    local type = config.Type or "Info" -- Success, Error, Warning, Info
    
    local gui = CreateScreenGui()
    
    local notificationHeight = 80
    local yPosition = 10 + (#Notifications * 90)
    
    local notif = Instance.new("Frame")
    notif.Name = "Notification"
    notif.Parent = gui
    notif.BackgroundColor3 = Theme.SecondaryBackground
    notif.BorderSizePixel = 0
    notif.Position = UDim2.new(1, 10, 0, yPosition)
    notif.Size = UDim2.new(0, 300, 0, notificationHeight)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = notif
    
    local stroke = Instance.new("UIStroke")
    stroke.Parent = notif
    stroke.Color = Theme[type] or Theme.Info
    stroke.Thickness = 1.5
    stroke.Transparency = 0.5
    
    AddShadow(notif)
    
    local accentBar = Instance.new("Frame")
    accentBar.Name = "AccentBar"
    accentBar.Parent = notif
    accentBar.BackgroundColor3 = stroke.Color
    accentBar.BorderSizePixel = 0
    accentBar.Size = UDim2.new(0, 4, 1, 0)
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 10)
    barCorner.Parent = accentBar
    
    local iconFrame = Instance.new("Frame")
    iconFrame.Name = "IconFrame"
    iconFrame.Parent = notif
    iconFrame.BackgroundColor3 = stroke.Color
    iconFrame.BorderSizePixel = 0
    iconFrame.Position = UDim2.new(0, 15, 0.5, 0)
    iconFrame.Size = UDim2.new(0, 38, 0, 38)
    iconFrame.AnchorPoint = Vector2.new(0, 0.5)
    
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 8)
    iconCorner.Parent = iconFrame
    
    local icons = {
        Success = "✓",
        Error = "✕",
        Warning = "⚠",
        Info = "ℹ"
    }
    
    local icon = Instance.new("TextLabel")
    icon.Parent = iconFrame
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.new(1, 0, 1, 0)
    icon.Font = Enum.Font.GothamBold
    icon.Text = icons[type] or "ℹ"
    icon.TextColor3 = Theme.Text
    icon.TextSize = 20
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Parent = notif
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 65, 0, 12)
    titleLabel.Size = UDim2.new(1, -100, 0, 20)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Theme.Text
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message"
    messageLabel.Parent = notif
    messageLabel.BackgroundTransparency = 1
    messageLabel.Position = UDim2.new(0, 65, 0, 35)
    messageLabel.Size = UDim2.new(1, -100, 0, 35)
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.Text = message
    messageLabel.TextColor3 = Theme.TextDark
    messageLabel.TextSize = 12
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Top
    messageLabel.TextWrapped = true
    
    local progressBG = Instance.new("Frame")
    progressBG.Name = "ProgressBackground"
    progressBG.Parent = notif
    progressBG.BackgroundColor3 = Theme.Background
    progressBG.BorderSizePixel = 0
    progressBG.Position = UDim2.new(0, 0, 1, -3)
    progressBG.Size = UDim2.new(1, 0, 0, 3)
    
    local progress = Instance.new("Frame")
    progress.Name = "Progress"
    progress.Parent = progressBG
    progress.BackgroundColor3 = stroke.Color
    progress.BorderSizePixel = 0
    progress.Size = UDim2.new(1, 0, 1, 0)
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "Close"
    closeBtn.Parent = notif
    closeBtn.BackgroundColor3 = Theme.TertiaryBackground
    closeBtn.BorderSizePixel = 0
    closeBtn.Position = UDim2.new(1, -30, 0, 8)
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Theme.TextDark
    closeBtn.TextSize = 16
    closeBtn.AutoButtonColor = false
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn
    
    table.insert(Notifications, notif)
    
    local function Close()
        for i, v in ipairs(Notifications) do
            if v == notif then
                table.remove(Notifications, i)
                break
            end
        end
        
        Tween(notif, {Position = UDim2.new(1, 10, 0, yPosition)}, 0.3)
        task.wait(0.3)
        gui:Destroy()
    end
    
    closeBtn.MouseButton1Click:Connect(Close)
    
    closeBtn.MouseEnter:Connect(function()
        Tween(closeBtn, {BackgroundColor3 = Theme.Error}, 0.2)
    end)
    
    closeBtn.MouseLeave:Connect(function()
        Tween(closeBtn, {BackgroundColor3 = Theme.TertiaryBackground}, 0.2)
    end)
    
    Tween(notif, {Position = UDim2.new(1, -310, 0, yPosition)}, 0.5, Enum.EasingStyle.Back)
    Tween(progress, {Size = UDim2.new(0, 0, 1, 0)}, duration, Enum.EasingStyle.Linear)
    
    task.delay(duration, Close)
end

-- ════════════════════════════════════════════════════════
-- 💾 CONFIG SYSTEM
-- ════════════════════════════════════════════════════════

Library.ConfigFolder = "DrakthonConfigs"

function Library:SaveConfig(name)
    pcall(function()
        if not isfolder(self.ConfigFolder) then
            makefolder(self.ConfigFolder)
        end
        
        local data = {
            Version = self.Version,
            Flags = self.Flags,
            SavedAt = os.date("%Y-%m-%d %H:%M:%S")
        }
        
        writefile(self.ConfigFolder .. "/" .. name .. ".json", HttpService:JSONEncode(data))
        
        self:Notify({
            Title = "Config Saved",
            Message = "Configuration '" .. name .. "' saved successfully",
            Type = "Success",
            Duration = 2
        })
    end)
end

function Library:LoadConfig(name)
    local success, data = pcall(function()
        return HttpService:JSONDecode(readfile(self.ConfigFolder .. "/" .. name .. ".json"))
    end)
    
    if success and data then
        self.Flags = data.Flags or {}
        
        self:Notify({
            Title = "Config Loaded",
            Message = "Configuration '" .. name .. "' loaded successfully",
            Type = "Success",
            Duration = 2
        })
        
        return data
    else
        self:Notify({
            Title = "Load Failed",
            Message = "Configuration file not found",
            Type = "Error",
            Duration = 3
        })
        return nil
    end
end

function Library:GetConfigs()
    local configs = {}
    pcall(function()
        if isfolder(self.ConfigFolder) then
            for _, file in ipairs(listfiles(self.ConfigFolder)) do
                if file:match("%.json$") then
                    table.insert(configs, file:match("([^/]+)%.json$"))
                end
            end
        end
    end)
    return configs
end

-- ════════════════════════════════════════════════════════
-- 🪟 CREATE WINDOW
-- ════════════════════════════════════════════════════════

function Library:CreateWindow(config)
    config = config or {}
    
    local windowTitle = config.Title or "Drakthon UI"
    local windowSubtitle = config.Subtitle or "v" .. self.Version
    local windowKeybind = config.Keybind or Enum.KeyCode.RightControl
    
    local screenSize = workspace.CurrentCamera.ViewportSize
    local windowWidth = IsMobile and math.clamp(screenSize.X * 0.95, 320, 480) or 620
    local windowHeight = IsMobile and math.clamp(screenSize.Y * 0.85, 450, 700) or 520
    
    local gui = CreateScreenGui()
    
    local mainContainer = Instance.new("Frame")
    mainContainer.Name = "MainContainer"
    mainContainer.Parent = gui
    mainContainer.BackgroundTransparency = 1
    mainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainContainer.Size = UDim2.new(0, 0, 0, 0)
    mainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Parent = mainContainer
    mainFrame.BackgroundColor3 = Theme.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.Size = UDim2.new(1, 0, 1, 0)
    mainFrame.ClipsDescendants = true
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainFrame
    
    AddShadow(mainContainer)
    
    local mainStroke = Instance.new("UIStroke")
    mainStroke.Parent = mainFrame
    mainStroke.Color = Theme.Accent
    mainStroke.Thickness = 1.5
    mainStroke.Transparency = 0.7
    
    -- ════════════════════════════════════════════════════════
    -- HEADER
    -- ════════════════════════════════════════════════════════
    
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Parent = mainFrame
    header.BackgroundColor3 = Theme.SecondaryBackground
    header.BorderSizePixel = 0
    header.Size = UDim2.new(1, 0, 0, 48)
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = header
    
    local headerGradient = Instance.new("UIGradient")
    headerGradient.Parent = header
    headerGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Theme.SecondaryBackground),
        ColorSequenceKeypoint.new(1, Theme.TertiaryBackground)
    }
    headerGradient.Rotation = 90
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Parent = header
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 15, 0, 8)
    titleLabel.Size = UDim2.new(0.6, 0, 0, 20)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = windowTitle
    titleLabel.TextColor3 = Theme.Text
    titleLabel.TextSize = IsMobile and 14 or 15
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
    
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Name = "Subtitle"
    subtitleLabel.Parent = header
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Position = UDim2.new(0, 15, 0, 28)
    subtitleLabel.Size = UDim2.new(0.6, 0, 0, 14)
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.Text = windowSubtitle
    subtitleLabel.TextColor3 = Theme.TextDark
    subtitleLabel.TextSize = IsMobile and 11 or 12
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "Close"
    closeButton.Parent = header
    closeButton.BackgroundColor3 = Theme.Error
    closeButton.BorderSizePixel = 0
    closeButton.Position = UDim2.new(1, -38, 0.5, 0)
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.AnchorPoint = Vector2.new(0, 0.5)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Text = "×"
    closeButton.TextColor3 = Theme.Text
    closeButton.TextSize = 20
    closeButton.AutoButtonColor = false
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeButton
    
    closeButton.MouseButton1Click:Connect(function()
        Tween(mainContainer, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        task.wait(0.3)
        gui:Destroy()
    end)
    
    closeButton.MouseEnter:Connect(function()
        Tween(closeButton, {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}, 0.2)
    end)
    
    closeButton.MouseLeave:Connect(function()
        Tween(closeButton, {BackgroundColor3 = Theme.Error}, 0.2)
    end)
    
    MakeDraggable(mainContainer, header)
    
    -- ════════════════════════════════════════════════════════
    -- TAB CONTAINER
    -- ════════════════════════════════════════════════════════
    
    local tabWidth = IsMobile and 60 or 150
    
    local tabContainer = Instance.new("ScrollingFrame")
    tabContainer.Name = "TabContainer"
    tabContainer.Parent = mainFrame
    tabContainer.BackgroundColor3 = Theme.SecondaryBackground
    tabContainer.BorderSizePixel = 0
    tabContainer.Position = UDim2.new(0, 0, 0, 48)
    tabContainer.Size = UDim2.new(0, tabWidth, 1, -48)
    tabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContainer.ScrollBarThickness = 4
    tabContainer.ScrollBarImageColor3 = Theme.Accent
    
    local tabList = Instance.new("UIListLayout")
    tabList.Parent = tabContainer
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabList.Padding = UDim.new(0, 5)
    
    local tabPadding = Instance.new("UIPadding")
    tabPadding.Parent = tabContainer
    tabPadding.PaddingTop = UDim.new(0, 10)
    tabPadding.PaddingLeft = UDim.new(0, 8)
    tabPadding.PaddingRight = UDim.new(0, 8)
    tabPadding.PaddingBottom = UDim.new(0, 10)
    
    tabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContainer.CanvasSize = UDim2.new(0, 0, 0, tabList.AbsoluteContentSize.Y + 20)
    end)
    
    -- ════════════════════════════════════════════════════════
    -- CONTENT CONTAINER
    -- ════════════════════════════════════════════════════════
    
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentContainer"
    contentContainer.Parent = mainFrame
    contentContainer.BackgroundTransparency = 1
    contentContainer.Position = UDim2.new(0, tabWidth, 0, 48)
    contentContainer.Size = UDim2.new(1, -tabWidth, 1, -48)
    
    -- ════════════════════════════════════════════════════════
    -- WINDOW OBJECT
    -- ════════════════════════════════════════════════════════
    
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        Flags = Library.Flags
    }
    
    -- ════════════════════════════════════════════════════════
    -- CREATE TAB FUNCTION
    -- ════════════════════════════════════════════════════════
    
    function Window:CreateTab(tabName)
        tabName = tabName or "Tab"
        
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName
        tabButton.Parent = tabContainer
        tabButton.BackgroundColor3 = Theme.TertiaryBackground
        tabButton.BorderSizePixel = 0
        tabButton.Size = UDim2.new(1, 0, 0, IsMobile and 50 : 40)
        tabButton.Font = Enum.Font.GothamSemibold
        tabButton.Text = IsMobile and "" or tabName
        tabButton.TextColor3 = Theme.TextDark
        tabButton.TextSize = 13
        tabButton.AutoButtonColor = false
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 10)
        tabCorner.Parent = tabButton
        
        if IsMobile then
            local tabLabel = Instance.new("TextLabel")
            tabLabel.Parent = tabButton
            tabLabel.BackgroundTransparency = 1
            tabLabel.Size = UDim2.new(1, 0, 1, 0)
            tabLabel.Font = Enum.Font.GothamBold
            tabLabel.Text = string.sub(tabName, 1, 1)
            tabLabel.TextColor3 = Theme.TextDark
            tabLabel.TextSize = 18
        end
        
        local indicator = Instance.new("Frame")
        indicator.Name = "Indicator"
        indicator.Parent = tabButton
        indicator.BackgroundColor3 = Theme.Accent
        indicator.BorderSizePixel = 0
        indicator.Position = UDim2.new(0, 0, 0, 0)
        indicator.Size = UDim2.new(0, 0, 1, 0)
        
        local indicatorCorner = Instance.new("UICorner")
        indicatorCorner.CornerRadius = UDim.new(0, 10)
        indicatorCorner.Parent = indicator
        
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = tabName .. "_Content"
        tabContent.Parent = contentContainer
        tabContent.BackgroundTransparency = 1
        tabContent.BorderSizePixel = 0
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.ScrollBarThickness = 5
        tabContent.ScrollBarImageColor3 = Theme.Accent
        tabContent.Visible = false
        
        local contentList = Instance.new("UIListLayout")
        contentList.Parent = tabContent
        contentList.SortOrder = Enum.SortOrder.LayoutOrder
        contentList.Padding = UDim.new(0, 10)
        
        local contentPadding = Instance.new("UIPadding")
        contentPadding.Parent = tabContent
        contentPadding.PaddingTop = UDim.new(0, 12)
        contentPadding.PaddingLeft = UDim.new(0, 12)
        contentPadding.PaddingRight = UDim.new(0, 12)
        contentPadding.PaddingBottom = UDim.new(0, 12)
        
        contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabContent.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 24)
        end)
        
        tabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab:Deactivate()
            end
            
            tabContent.Visible = true
            Window.CurrentTab = tabName
            
            Tween(tabButton, {BackgroundColor3 = Theme.Accent}, 0.2)
            Tween(tabButton, {TextColor3 = Theme.Text}, 0.2)
            Tween(indicator, {Size = UDim2.new(0, 4, 1, 0)}, 0.3, Enum.EasingStyle.Back)
        end)
        
        tabButton.MouseEnter:Connect(function()
            if Window.CurrentTab ~= tabName then
                Tween(tabButton, {BackgroundColor3 = Theme.SecondaryBackground}, 0.2)
            end
        end)
        
        tabButton.MouseLeave:Connect(function()
            if Window.CurrentTab ~= tabName then
                Tween(tabButton, {BackgroundColor3 = Theme.TertiaryBackground}, 0.2)
            end
        end)
        
        local Tab = {
            Name = tabName,
            Content = tabContent
        }
        
        function Tab:Deactivate()
            tabContent.Visible = false
            Tween(tabButton, {BackgroundColor3 = Theme.TertiaryBackground}, 0.2)
            Tween(tabButton, {TextColor3 = Theme.TextDark}, 0.2)
            Tween(indicator, {Size = UDim2.new(0, 0, 1, 0)}, 0.3)
        end
        
        -- ════════════════════════════════════════════════════════
        -- ADD SECTION
        -- ════════════════════════════════════════════════════════
        
        function Tab:AddSection(sectionName)
            sectionName = sectionName or "Section"
            
            local section = Instance.new("Frame")
            section.Name = sectionName
            section.Parent = tabContent
            section.BackgroundColor3 = Theme.SecondaryBackground
            section.BorderSizePixel = 0
            section.Size = UDim2.new(1, 0, 0, 40)
            section.AutomaticSize = Enum.AutomaticSize.Y
            
            local sectionCorner = Instance.new("UICorner")
            sectionCorner.CornerRadius = UDim.new(0, 10)
            sectionCorner.Parent = section
            
            local sectionStroke = Instance.new("UIStroke")
            sectionStroke.Parent = section
            sectionStroke.Color = Theme.Border
            sectionStroke.Thickness = 1
            sectionStroke.Transparency = 0.8
            
            local sectionTitle = Instance.new("TextLabel")
            sectionTitle.Name = "Title"
            sectionTitle.Parent = section
            sectionTitle.BackgroundTransparency = 1
            sectionTitle.Position = UDim2.new(0, 12, 0, 0)
            sectionTitle.Size = UDim2.new(1, -24, 0, 40)
            sectionTitle.Font = Enum.Font.GothamBold
            sectionTitle.Text = sectionName
            sectionTitle.TextColor3 = Theme.Text
            sectionTitle.TextSize = IsMobile and 13 or 14
            sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local sectionContent = Instance.new("Frame")
            sectionContent.Name = "Content"
            sectionContent.Parent = section
            sectionContent.BackgroundTransparency = 1
            sectionContent.Position = UDim2.new(0, 0, 0, 40)
            sectionContent.Size = UDim2.new(1, 0, 1, -40)
            sectionContent.AutomaticSize = Enum.AutomaticSize.Y
            
            local sectionList = Instance.new("UIListLayout")
            sectionList.Parent = sectionContent
            sectionList.SortOrder = Enum.SortOrder.LayoutOrder
            sectionList.Padding = UDim.new(0, 8)
            
            local sectionPadding = Instance.new("UIPadding")
            sectionPadding.Parent = sectionContent
            sectionPadding.PaddingTop = UDim.new(0, 10)
            sectionPadding.PaddingLeft = UDim.new(0, 12)
            sectionPadding.PaddingRight = UDim.new(0, 12)
            sectionPadding.PaddingBottom = UDim.new(0, 12)
            
            local Section = {}
            
            -- ════════════════════════════════════════════════════════
            -- BUTTON ELEMENT
            -- ════════════════════════════════════════════════════════
            
            function Section:AddButton(config)
                config = config or {}
                local buttonName = config.Name or "Button"
                local callback = config.Callback or function() end
                
                local button = Instance.new("TextButton")
                button.Name = buttonName
                button.Parent = sectionContent
                button.BackgroundColor3 = Theme.TertiaryBackground
                button.BorderSizePixel = 0
                button.Size = UDim2.new(1, 0, 0, IsMobile and 42 : 36)
                button.Font = Enum.Font.GothamSemibold
                button.Text = buttonName
                button.TextColor3 = Theme.Text
                button.TextSize = IsMobile and 13 : 14
                button.AutoButtonColor = false
                
                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(0, 8)
                buttonCorner.Parent = button
                
                local buttonStroke = Instance.new("UIStroke")
                buttonStroke.Parent = button
                buttonStroke.Color = Theme.Accent
                buttonStroke.Thickness = 0
                buttonStroke.Transparency = 0.5
                
                button.MouseEnter:Connect(function()
                    Tween(button, {BackgroundColor3 = Theme.Accent}, 0.2)
                    Tween(buttonStroke, {Thickness = 1.5}, 0.2)
                end)
                
                button.MouseLeave:Connect(function()
                    Tween(button, {BackgroundColor3 = Theme.TertiaryBackground}, 0.2)
                    Tween(buttonStroke, {Thickness = 0}, 0.2)
                end)
                
                button.MouseButton1Click:Connect(function()
                    Tween(button, {Size = UDim2.new(1, 0, 0, IsMobile and 38 : 33)}, 0.1)
                    task.wait(0.1)
                    Tween(button, {Size = UDim2.new(1, 0, 0, IsMobile and 42 : 36)}, 0.1)
                    pcall(callback)
                end)
                
                return button
            end
            
            -- ════════════════════════════════════════════════════════
            -- TOGGLE ELEMENT
            -- ════════════════════════════════════════════════════════
            
            function Section:AddToggle(config)
                config = config or {}
                local toggleName = config.Name or "Toggle"
                local defaultValue = config.Default or false
                local callback = config.Callback or function() end
                local flag = config.Flag
                
                local toggle = Instance.new("Frame")
                toggle.Name = toggleName
                toggle.Parent = sectionContent
                toggle.BackgroundColor3 = Theme.TertiaryBackground
                toggle.BorderSizePixel = 0
                toggle.Size = UDim2.new(1, 0, 0, IsMobile and 42 : 36)
                
                local toggleCorner = Instance.new("UICorner")
                toggleCorner.CornerRadius = UDim.new(0, 8)
                toggleCorner.Parent = toggle
                
                local toggleLabel = Instance.new("TextLabel")
                toggleLabel.Parent = toggle
                toggleLabel.BackgroundTransparency = 1
                toggleLabel.Position = UDim2.new(0, 12, 0, 0)
                toggleLabel.Size = UDim2.new(1, -60, 1, 0)
                toggleLabel.Font = Enum.Font.GothamSemibold
                toggleLabel.Text = toggleName
                toggleLabel.TextColor3 = Theme.Text
                toggleLabel.TextSize = IsMobile and 13 : 14
                toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                toggleLabel.TextTruncate = Enum.TextTruncate.AtEnd
                
                local toggleSwitch = Instance.new("TextButton")
                toggleSwitch.Parent = toggle
                toggleSwitch.BackgroundColor3 = defaultValue and Theme.Accent or Theme.Background
                toggleSwitch.BorderSizePixel = 0
                toggleSwitch.Position = UDim2.new(1, -44, 0.5, 0)
                toggleSwitch.Size = UDim2.new(0, 38, 0, 20)
                toggleSwitch.AnchorPoint = Vector2.new(0, 0.5)
                toggleSwitch.Text = ""
                toggleSwitch.AutoButtonColor = false
                
                local switchCorner = Instance.new("UICorner")
                switchCorner.CornerRadius = UDim.new(1, 0)
                switchCorner.Parent = toggleSwitch
                
                local toggleCircle = Instance.new("Frame")
                toggleCircle.Parent = toggleSwitch
                toggleCircle.BackgroundColor3 = Theme.Text
                toggleCircle.BorderSizePixel = 0
                toggleCircle.Position = defaultValue and UDim2.new(1, -17, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
                toggleCircle.Size = UDim2.new(0, 14, 0, 14)
                toggleCircle.AnchorPoint = Vector2.new(0, 0.5)
                
                local circleCorner = Instance.new("UICorner")
                circleCorner.CornerRadius = UDim.new(1, 0)
                circleCorner.Parent = toggleCircle
                
                local toggled = defaultValue
                
                if flag then
                    Library.Flags[flag] = toggled
                end
                
                local function Update(value)
                    toggled = value
                    
                    if flag then
                        Library.Flags[flag] = value
                    end
                    
                    Tween(toggleSwitch, {
                        BackgroundColor3 = toggled and Theme.Accent or Theme.Background
                    }, 0.2)
                    
                    Tween(toggleCircle, {
                        Position = toggled and UDim2.new(1, -17, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
                    }, 0.3, Enum.EasingStyle.Back)
                    
                    pcall(callback, toggled)
                end
                
                toggleSwitch.MouseButton1Click:Connect(function()
                    Update(not toggled)
                end)
                
                return {
                    Set = function(value)
                        Update(value)
                    end,
                    Get = function()
                        return toggled
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════
            -- SLIDER ELEMENT
            -- ════════════════════════════════════════════════════════
            
            function Section:AddSlider(config)
                config = config or {}
                local sliderName = config.Name or "Slider"
                local min = config.Min or 0
                local max = config.Max or 100
                local default = config.Default or 50
                local increment = config.Increment or 1
                local callback = config.Callback or function() end
                local flag = config.Flag
                
                local slider = Instance.new("Frame")
                slider.Name = sliderName
                slider.Parent = sectionContent
                slider.BackgroundColor3 = Theme.TertiaryBackground
                slider.BorderSizePixel = 0
                slider.Size = UDim2.new(1, 0, 0, IsMobile and 58 : 52)
                
                local sliderCorner = Instance.new("UICorner")
                sliderCorner.CornerRadius = UDim.new(0, 8)
                sliderCorner.Parent = slider
                
                local sliderLabel = Instance.new("TextLabel")
                sliderLabel.Parent = slider
                sliderLabel.BackgroundTransparency = 1
                sliderLabel.Position = UDim2.new(0, 12, 0, 8)
                sliderLabel.Size = UDim2.new(0.6, 0, 0, 18)
                sliderLabel.Font = Enum.Font.GothamSemibold
                sliderLabel.Text = sliderName
                sliderLabel.TextColor3 = Theme.Text
                sliderLabel.TextSize = IsMobile and 13 : 14
                sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                sliderLabel.TextTruncate = Enum.TextTruncate.AtEnd
                
                local sliderValue = Instance.new("TextLabel")
                sliderValue.Parent = slider
                sliderValue.BackgroundColor3 = Theme.Background
                sliderValue.BorderSizePixel = 0
                sliderValue.Position = UDim2.new(1, -50, 0, 8)
                sliderValue.Size = UDim2.new(0, 44, 0, 18)
                sliderValue.Font = Enum.Font.GothamBold
                sliderValue.Text = tostring(default)
                sliderValue.TextColor3 = Theme.Accent
                sliderValue.TextSize = IsMobile and 12 : 13
                
                local valueCorner = Instance.new("UICorner")
                valueCorner.CornerRadius = UDim.new(0, 6)
                valueCorner.Parent = sliderValue
                
                local sliderBar = Instance.new("Frame")
                sliderBar.Parent = slider
                sliderBar.BackgroundColor3 = Theme.Background
                sliderBar.BorderSizePixel = 0
                sliderBar.Position = UDim2.new(0, 12, 1, IsMobile and -18 : -16)
                sliderBar.Size = UDim2.new(1, -24, 0, 6)
                
                local barCorner = Instance.new("UICorner")
                barCorner.CornerRadius = UDim.new(1, 0)
                barCorner.Parent = sliderBar
                
                local sliderFill = Instance.new("Frame")
                sliderFill.Parent = sliderBar
                sliderFill.BackgroundColor3 = Theme.Accent
                sliderFill.BorderSizePixel = 0
                sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
                
                local fillCorner = Instance.new("UICorner")
                fillCorner.CornerRadius = UDim.new(1, 0)
                fillCorner.Parent = sliderFill
                
                local sliderDot = Instance.new("Frame")
                sliderDot.Parent = sliderBar
                sliderDot.BackgroundColor3 = Theme.Text
                sliderDot.BorderSizePixel = 0
                sliderDot.Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0)
                sliderDot.Size = UDim2.new(0, 14, 0, 14)
                sliderDot.AnchorPoint = Vector2.new(0.5, 0.5)
                
                local dotCorner = Instance.new("UICorner")
                dotCorner.CornerRadius = UDim.new(1, 0)
                dotCorner.Parent = sliderDot
                
                local dragging = false
                
                if flag then
                    Library.Flags[flag] = default
                end
                
                local function Update(input)
                    local pos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
                    local value = math.floor(min + (max - min) * pos)
                    value = math.floor(value / increment + 0.5) * increment
                    value = math.clamp(value, min, max)
                    
                    sliderFill.Size = UDim2.new(pos, 0, 1, 0)
                    sliderDot.Position = UDim2.new(pos, 0, 0.5, 0)
                    sliderValue.Text = tostring(value)
                    
                    if flag then
                        Library.Flags[flag] = value
                    end
                    
                    pcall(callback, value)
                end
                
                sliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        Update(input)
                        Tween(sliderDot, {Size = UDim2.new(0, 18, 0, 18)}, 0.2, Enum.EasingStyle.Back)
                    end
                end)
                
                sliderBar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                        Tween(sliderDot, {Size = UDim2.new(0, 14, 0, 14)}, 0.2)
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        Update(input)
                    end
                end)
                
                return {
                    Set = function(value)
                        local pos = (value - min) / (max - min)
                        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
                        sliderDot.Position = UDim2.new(pos, 0, 0.5, 0)
                        sliderValue.Text = tostring(value)
                        
                        if flag then
                            Library.Flags[flag] = value
                        end
                        
                        pcall(callback, value)
                    end,
                    Get = function()
                        return tonumber(sliderValue.Text)
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════
            -- DROPDOWN ELEMENT
            -- ════════════════════════════════════════════════════════
            
            function Section:AddDropdown(config)
                config = config or {}
                local dropdownName = config.Name or "Dropdown"
                local items = config.Items or {"Option 1", "Option 2"}
                local default = config.Default or items[1]
                local callback = config.Callback or function() end
                local flag = config.Flag
                
                local dropdown = Instance.new("Frame")
                dropdown.Name = dropdownName
                dropdown.Parent = sectionContent
                dropdown.BackgroundColor3 = Theme.TertiaryBackground
                dropdown.BorderSizePixel = 0
                dropdown.Size = UDim2.new(1, 0, 0, IsMobile and 42 : 36)
                dropdown.ClipsDescendants = true
                
                local dropCorner = Instance.new("UICorner")
                dropCorner.CornerRadius = UDim.new(0, 8)
                dropCorner.Parent = dropdown
                
                local dropLabel = Instance.new("TextLabel")
                dropLabel.Parent = dropdown
                dropLabel.BackgroundTransparency = 1
                dropLabel.Position = UDim2.new(0, 12, 0, 0)
                dropLabel.Size = UDim2.new(0.4, 0, 0, IsMobile and 42 : 36)
                dropLabel.Font = Enum.Font.GothamSemibold
                dropLabel.Text = dropdownName
                dropLabel.TextColor3 = Theme.Text
                dropLabel.TextSize = IsMobile and 13 : 14
                dropLabel.TextXAlignment = Enum.TextXAlignment.Left
                dropLabel.TextTruncate = Enum.TextTruncate.AtEnd
                
                local dropButton = Instance.new("TextButton")
                dropButton.Parent = dropdown
                dropButton.BackgroundColor3 = Theme.Background
                dropButton.BorderSizePixel = 0
                dropButton.Position = UDim2.new(0.45, 0, 0, 8)
                dropButton.Size = UDim2.new(0.5, -12, 0, IsMobile and 26 : 20)
                dropButton.Font = Enum.Font.Gotham
                dropButton.Text = "  " .. default
                dropButton.TextColor3 = Theme.Accent
                dropButton.TextSize = IsMobile and 12 : 13
                dropButton.TextXAlignment = Enum.TextXAlignment.Left
                dropButton.AutoButtonColor = false
                dropButton.TextTruncate = Enum.TextTruncate.AtEnd
                
                local dropBtnCorner = Instance.new("UICorner")
                dropBtnCorner.CornerRadius = UDim.new(0, 6)
                dropBtnCorner.Parent = dropButton
                
                local arrow = Instance.new("TextLabel")
                arrow.Parent = dropButton
                arrow.BackgroundTransparency = 1
                arrow.Position = UDim2.new(1, -20, 0, 0)
                arrow.Size = UDim2.new(0, 18, 1, 0)
                arrow.Font = Enum.Font.GothamBold
                arrow.Text = "▼"
                arrow.TextColor3 = Theme.TextDark
                arrow.TextSize = 10
                
                local itemList = Instance.new("ScrollingFrame")
                itemList.Parent = dropdown
                itemList.BackgroundTransparency = 1
                itemList.BorderSizePixel = 0
                itemList.Position = UDim2.new(0, 8, 0, IsMobile and 46 : 40)
                itemList.Size = UDim2.new(1, -16, 0, 0)
                itemList.CanvasSize = UDim2.new(0, 0, 0, 0)
                itemList.ScrollBarThickness = 4
                itemList.ScrollBarImageColor3 = Theme.Accent
                
                local listLayout = Instance.new("UIListLayout")
                listLayout.Parent = itemList
                listLayout.SortOrder = Enum.SortOrder.LayoutOrder
                listLayout.Padding = UDim.new(0, 4)
                
                listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    itemList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
                end)
                
                local expanded = false
                local currentValue = default
                
                if flag then
                    Library.Flags[flag] = currentValue
                end
                
                local function CreateItem(itemName)
                    local item = Instance.new("TextButton")
                    item.Name = itemName
                    item.Parent = itemList
                    item.BackgroundColor3 = Theme.Background
                    item.BorderSizePixel = 0
                    item.Size = UDim2.new(1, 0, 0, IsMobile and 28 : 24)
                    item.Font = Enum.Font.Gotham
                    item.Text = "  " .. itemName
                    item.TextColor3 = Theme.Text
                    item.TextSize = IsMobile and 12 : 13
                    item.TextXAlignment = Enum.TextXAlignment.Left
                    item.AutoButtonColor = false
                    item.TextTruncate = Enum.TextTruncate.AtEnd
                    
                    local itemCorner = Instance.new("UICorner")
                    itemCorner.CornerRadius = UDim.new(0, 6)
                    itemCorner.Parent = item
                    
                    item.MouseEnter:Connect(function()
                        Tween(item, {BackgroundColor3 = Theme.Accent}, 0.2)
                    end)
                    
                    item.MouseLeave:Connect(function()
                        Tween(item, {BackgroundColor3 = Theme.Background}, 0.2)
                    end)
                    
                    item.MouseButton1Click:Connect(function()
                        currentValue = itemName
                        dropButton.Text = "  " .. itemName
                        
                        if flag then
                            Library.Flags[flag] = itemName
                        end
                        
                        pcall(callback, itemName)
                        
                        expanded = false
                        local baseHeight = IsMobile and 42 : 36
                        Tween(dropdown, {Size = UDim2.new(1, 0, 0, baseHeight)}, 0.3, Enum.EasingStyle.Back)
                        Tween(arrow, {Rotation = 0}, 0.3)
                    end)
                end
                
                for _, itemName in ipairs(items) do
                    CreateItem(itemName)
                end
                
                dropButton.MouseButton1Click:Connect(function()
                    expanded = not expanded
                    
                    if expanded then
                        local itemCount = math.min(#items, 5)
                        local itemHeight = IsMobile and 28 : 24
                        local baseHeight = IsMobile and 42 : 36
                        local totalHeight = baseHeight + 8 + (itemCount * (itemHeight + 4))
                        
                        Tween(dropdown, {Size = UDim2.new(1, 0, 0, totalHeight)}, 0.3, Enum.EasingStyle.Back)
                        Tween(arrow, {Rotation = 180}, 0.3)
                        itemList.Size = UDim2.new(1, -16, 0, itemCount * (itemHeight + 4))
                    else
                        local baseHeight = IsMobile and 42 : 36
                        Tween(dropdown, {Size = UDim2.new(1, 0, 0, baseHeight)}, 0.3, Enum.EasingStyle.Back)
                        Tween(arrow, {Rotation = 0}, 0.3)
                    end
                end)
                
                return {
                    Set = function(value)
                        if table.find(items, value) then
                            currentValue = value
                            dropButton.Text = "  " .. value
                            
                            if flag then
                                Library.Flags[flag] = value
                            end
                            
                            pcall(callback, value)
                        end
                    end,
                    Get = function()
                        return currentValue
                    end,
                    Refresh = function(newItems, newDefault)
                        items = newItems
                        itemList:ClearAllChildren()
                        listLayout.Parent = itemList
                        
                        for _, itemName in ipairs(newItems) do
                            CreateItem(itemName)
                        end
                        
                        if newDefault and table.find(newItems, newDefault) then
                            currentValue = newDefault
                            dropButton.Text = "  " .. newDefault
                            
                            if flag then
                                Library.Flags[flag] = newDefault
                            end
                        end
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════
            -- COLOR PICKER ELEMENT
            -- ════════════════════════════════════════════════════════
            
            function Section:AddColorPicker(config)
                config = config or {}
                local pickerName = config.Name or "Color Picker"
                local defaultColor = config.Default or Color3.fromRGB(255, 255, 255)
                local callback = config.Callback or function() end
                local flag = config.Flag
                
                local colorPicker = Instance.new("Frame")
                colorPicker.Name = pickerName
                colorPicker.Parent = sectionContent
                colorPicker.BackgroundColor3 = Theme.TertiaryBackground
                colorPicker.BorderSizePixel = 0
                colorPicker.Size = UDim2.new(1, 0, 0, IsMobile and 42 : 36)
                colorPicker.ClipsDescendants = true
                
                local pickerCorner = Instance.new("UICorner")
                pickerCorner.CornerRadius = UDim.new(0, 8)
                pickerCorner.Parent = colorPicker
                
                local pickerLabel = Instance.new("TextLabel")
                pickerLabel.Parent = colorPicker
                pickerLabel.BackgroundTransparency = 1
                pickerLabel.Position = UDim2.new(0, 12, 0, 0)
                pickerLabel.Size = UDim2.new(0.7, 0, 0, IsMobile and 42 : 36)
                pickerLabel.Font = Enum.Font.GothamSemibold
                pickerLabel.Text = pickerName
                pickerLabel.TextColor3 = Theme.Text
                pickerLabel.TextSize = IsMobile and 13 : 14
                pickerLabel.TextXAlignment = Enum.TextXAlignment.Left
                pickerLabel.TextTruncate = Enum.TextTruncate.AtEnd
                
                local colorDisplay = Instance.new("TextButton")
                colorDisplay.Parent = colorPicker
                colorDisplay.BackgroundColor3 = defaultColor
                colorDisplay.BorderSizePixel = 0
                colorDisplay.Position = UDim2.new(1, -50, 0.5, 0)
                colorDisplay.Size = UDim2.new(0, 40, 0, IsMobile and 26 : 20)
                colorDisplay.AnchorPoint = Vector2.new(0, 0.5)
                colorDisplay.Text = ""
                colorDisplay.AutoButtonColor = false
                
                local displayCorner = Instance.new("UICorner")
                displayCorner.CornerRadius = UDim.new(0, 6)
                displayCorner.Parent = colorDisplay
                
                local displayStroke = Instance.new("UIStroke")
                displayStroke.Parent = colorDisplay
                displayStroke.Color = Theme.Border
                displayStroke.Thickness = 2
                
                local paletteFrame = Instance.new("Frame")
                paletteFrame.Parent = colorPicker
                paletteFrame.BackgroundColor3 = Theme.Background
                paletteFrame.BorderSizePixel = 0
                paletteFrame.Position = UDim2.new(0, 8, 0, IsMobile and 46 : 40)
                paletteFrame.Size = UDim2.new(1, -16, 0, 150)
                paletteFrame.Visible = false
                
                local paletteCorner = Instance.new("UICorner")
                paletteCorner.CornerRadius = UDim.new(0, 8)
                paletteCorner.Parent = paletteFrame
                
                local colorCanvas = Instance.new("ImageButton")
                colorCanvas.Parent = paletteFrame
                colorCanvas.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                colorCanvas.BorderSizePixel = 0
                colorCanvas.Position = UDim2.new(0, 8, 0, 8)
                colorCanvas.Size = UDim2.new(1, -80, 1, -16)
                colorCanvas.Image = "rbxassetid://4155801252"
                colorCanvas.AutoButtonColor = false
                
                local canvasCorner = Instance.new("UICorner")
                canvasCorner.CornerRadius = UDim.new(0, 6)
                canvasCorner.Parent = colorCanvas
                
                local hueSlider = Instance.new("ImageButton")
                hueSlider.Parent = paletteFrame
                hueSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                hueSlider.BorderSizePixel = 0
                hueSlider.Position = UDim2.new(1, -62, 0, 8)
                hueSlider.Size = UDim2.new(0, 28, 1, -16)
                hueSlider.Image = "rbxassetid://3641079629"
                hueSlider.AutoButtonColor = false
                
                local hueCorner = Instance.new("UICorner")
                hueCorner.CornerRadius = UDim.new(0, 6)
                hueCorner.Parent = hueSlider
                
                local confirmBtn = Instance.new("TextButton")
                confirmBtn.Parent = paletteFrame
                confirmBtn.BackgroundColor3 = Theme.Accent
                confirmBtn.BorderSizePixel = 0
                confirmBtn.Position = UDim2.new(1, -28, 0, 8)
                confirmBtn.Size = UDim2.new(0, 20, 0, 20)
                confirmBtn.Font = Enum.Font.GothamBold
                confirmBtn.Text = "✓"
                confirmBtn.TextColor3 = Theme.Text
                confirmBtn.TextSize = 14
                confirmBtn.AutoButtonColor = false
                
                local confirmCorner = Instance.new("UICorner")
                confirmCorner.CornerRadius = UDim.new(0, 5)
                confirmCorner.Parent = confirmBtn
                
                local expanded = false
                local currentHue = 0
                local currentSat = 1
                local currentVal = 1
                
                if flag then
                    Library.Flags[flag] = defaultColor
                end
                
                local function UpdateColor()
                    local color = Color3.fromHSV(currentHue, currentSat, currentVal)
                    colorDisplay.BackgroundColor3 = color
                    colorCanvas.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)
                    
                    if flag then
                        Library.Flags[flag] = color
                    end
                    
                    pcall(callback, color)
                end
                
                local hueDragging = false
                local canvasDragging = false
                
                hueSlider.MouseButton1Down:Connect(function()
                    hueDragging = true
                end)
                
                colorCanvas.MouseButton1Down:Connect(function()
                    canvasDragging = true
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        hueDragging = false
                        canvasDragging = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                        if hueDragging then
                            local pos = math.clamp((input.Position.Y - hueSlider.AbsolutePosition.Y) / hueSlider.AbsoluteSize.Y, 0, 1)
                            currentHue = 1 - pos
                            UpdateColor()
                        end
                        
                        if canvasDragging then
                            local posX = math.clamp((input.Position.X - colorCanvas.AbsolutePosition.X) / colorCanvas.AbsoluteSize.X, 0, 1)
                            local posY = math.clamp((input.Position.Y - colorCanvas.AbsolutePosition.Y) / colorCanvas.AbsoluteSize.Y, 0, 1)
                            currentSat = posX
                            currentVal = 1 - posY
                            UpdateColor()
                        end
                    end
                end)
                
                colorDisplay.MouseButton1Click:Connect(function()
                    expanded = not expanded
                    paletteFrame.Visible = expanded
                    
                    if expanded then
                        local baseHeight = IsMobile and 42 : 36
                        Tween(colorPicker, {Size = UDim2.new(1, 0, 0, baseHeight + 158)}, 0.3, Enum.EasingStyle.Back)
                    else
                        local baseHeight = IsMobile and 42 : 36
                        Tween(colorPicker, {Size = UDim2.new(1, 0, 0, baseHeight)}, 0.3, Enum.EasingStyle.Back)
                    end
                end)
                
                confirmBtn.MouseButton1Click:Connect(function()
                    expanded = false
                    paletteFrame.Visible = false
                    local baseHeight = IsMobile and 42 : 36
                    Tween(colorPicker, {Size = UDim2.new(1, 0, 0, baseHeight)}, 0.3, Enum.EasingStyle.Back)
                end)
                
                local h, s, v = defaultColor:ToHSV()
                currentHue = h
                currentSat = s
                currentVal = v
                UpdateColor()
                
                return {
                    Set = function(color)
                        local h, s, v = color:ToHSV()
                        currentHue = h
                        currentSat = s
                        currentVal = v
                        UpdateColor()
                    end,
                    Get = function()
                        return Color3.fromHSV(currentHue, currentSat, currentVal)
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════
            -- TEXTBOX ELEMENT
            -- ════════════════════════════════════════════════════════
            
            function Section:AddTextbox(config)
                config = config or {}
                local textboxName = config.Name or "Textbox"
                local defaultText = config.Default or ""
                local placeholder = config.Placeholder or "Enter text..."
                local callback = config.Callback or function() end
                local flag = config.Flag
                
                local textbox = Instance.new("Frame")
                textbox.Name = textboxName
                textbox.Parent = sectionContent
                textbox.BackgroundColor3 = Theme.TertiaryBackground
                textbox.BorderSizePixel = 0
                textbox.Size = UDim2.new(1, 0, 0, IsMobile and 42 : 36)
                
                local textboxCorner = Instance.new("UICorner")
                textboxCorner.CornerRadius = UDim.new(0, 8)
                textboxCorner.Parent = textbox
                
                local textboxLabel = Instance.new("TextLabel")
                textboxLabel.Parent = textbox
                textboxLabel.BackgroundTransparency = 1
                textboxLabel.Position = UDim2.new(0, 12, 0, 0)
                textboxLabel.Size = UDim2.new(0.35, 0, 1, 0)
                textboxLabel.Font = Enum.Font.GothamSemibold
                textboxLabel.Text = textboxName
                textboxLabel.TextColor3 = Theme.Text
                textboxLabel.TextSize = IsMobile and 13 : 14
                textboxLabel.TextXAlignment = Enum.TextXAlignment.Left
                textboxLabel.TextTruncate = Enum.TextTruncate.AtEnd
                
                local textboxInput = Instance.new("TextBox")
                textboxInput.Parent = textbox
                textboxInput.BackgroundColor3 = Theme.Background
                textboxInput.BorderSizePixel = 0
                textboxInput.Position = UDim2.new(0.4, 0, 0.5, 0)
                textboxInput.Size = UDim2.new(0.58, 0, 0, IsMobile and 26 : 20)
                textboxInput.AnchorPoint = Vector2.new(0, 0.5)
                textboxInput.Font = Enum.Font.Gotham
                textboxInput.PlaceholderText = placeholder
                textboxInput.PlaceholderColor3 = Theme.TextDark
                textboxInput.Text = defaultText
                textboxInput.TextColor3 = Theme.Accent
                textboxInput.TextSize = IsMobile and 12 : 13
                textboxInput.ClearTextOnFocus = false
                textboxInput.TextTruncate = Enum.TextTruncate.AtEnd
                
                local inputCorner = Instance.new("UICorner")
                inputCorner.CornerRadius = UDim.new(0, 6)
                inputCorner.Parent = textboxInput
                
                local inputPadding = Instance.new("UIPadding")
                inputPadding.Parent = textboxInput
                inputPadding.PaddingLeft = UDim.new(0, 8)
                inputPadding.PaddingRight = UDim.new(0, 8)
                
                if flag then
                    Library.Flags[flag] = defaultText
                end
                
                textboxInput.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        if flag then
                            Library.Flags[flag] = textboxInput.Text
                        end
                        
                        pcall(callback, textboxInput.Text)
                    end
                end)
                
                textboxInput.Focused:Connect(function()
                    Tween(textboxInput, {BackgroundColor3 = Theme.SecondaryBackground}, 0.2)
                end)
                
                textboxInput.FocusLost:Connect(function()
                    Tween(textboxInput, {BackgroundColor3 = Theme.Background}, 0.2)
                end)
                
                return {
                    Set = function(text)
                        textboxInput.Text = text
                        
                        if flag then
                            Library.Flags[flag] = text
                        end
                        
                        pcall(callback, text)
                    end,
                    Get = function()
                        return textboxInput.Text
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════
            -- LABEL ELEMENT
            -- ════════════════════════════════════════════════════════
            
            function Section:AddLabel(text)
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Parent = sectionContent
                label.BackgroundTransparency = 1
                label.Size = UDim2.new(1, 0, 0, IsMobile and 24 : 20)
                label.Font = Enum.Font.Gotham
                label.Text = text
                label.TextColor3 = Theme.TextDark
                label.TextSize = IsMobile and 12 : 13
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextWrapped = true
                label.AutomaticSize = Enum.AutomaticSize.Y
                
                return {
                    Set = function(newText)
                        label.Text = newText
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════
            -- PARAGRAPH ELEMENT
            -- ════════════════════════════════════════════════════════
            
            function Section:AddParagraph(title, content)
                local paragraph = Instance.new("Frame")
                paragraph.Name = "Paragraph"
                paragraph.Parent = sectionContent
                paragraph.BackgroundColor3 = Theme.Background
                paragraph.BorderSizePixel = 0
                paragraph.Size = UDim2.new(1, 0, 0, 60)
                paragraph.AutomaticSize = Enum.AutomaticSize.Y
                
                local paraCorner = Instance.new("UICorner")
                paraCorner.CornerRadius = UDim.new(0, 8)
                paraCorner.Parent = paragraph
                
                local paraTitle = Instance.new("TextLabel")
                paraTitle.Parent = paragraph
                paraTitle.BackgroundTransparency = 1
                paraTitle.Position = UDim2.new(0, 12, 0, 8)
                paraTitle.Size = UDim2.new(1, -24, 0, 18)
                paraTitle.Font = Enum.Font.GothamBold
                paraTitle.Text = title
                paraTitle.TextColor3 = Theme.Text
                paraTitle.TextSize = IsMobile and 13 : 14
                paraTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                local paraContent = Instance.new("TextLabel")
                paraContent.Parent = paragraph
                paraContent.BackgroundTransparency = 1
                paraContent.Position = UDim2.new(0, 12, 0, 28)
                paraContent.Size = UDim2.new(1, -24, 1, -36)
                paraContent.Font = Enum.Font.Gotham
                paraContent.Text = content
                paraContent.TextColor3 = Theme.TextDark
                paraContent.TextSize = IsMobile and 12 : 13
                paraContent.TextXAlignment = Enum.TextXAlignment.Left
                paraContent.TextYAlignment = Enum.TextYAlignment.Top
                paraContent.TextWrapped = true
                paraContent.AutomaticSize = Enum.AutomaticSize.Y
                
                local paraPadding = Instance.new("UIPadding")
                paraPadding.Parent = paragraph
                paraPadding.PaddingBottom = UDim.new(0, 10)
                
                return {
                    SetTitle = function(newTitle)
                        paraTitle.Text = newTitle
                    end,
                    SetContent = function(newContent)
                        paraContent.Text = newContent
                    end
                }
            end
            
            return Section
        end
        
        -- Activate first tab
        if #Window.Tabs == 0 then
            tabContent.Visible = true
            Window.CurrentTab = tabName
            tabButton.BackgroundColor3 = Theme.Accent
            tabButton.TextColor3 = Theme.Text
            indicator.Size = UDim2.new(0, 4, 1, 0)
        end
        
        table.insert(Window.Tabs, Tab)
        return Tab
    end
    
    -- Keybind toggle (PC only)
    if not IsMobile and windowKeybind then
        local visible = true
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == windowKeybind then
                visible = not visible
                Tween(mainContainer, {
                    Size = visible and UDim2.new(0, windowWidth, 0, windowHeight) or UDim2.new(0, 0, 0, 0)
                }, 0.3, Enum.EasingStyle.Back)
            end
        end)
    end
    
    -- Opening animation
    Tween(mainContainer, {Size = UDim2.new(0, windowWidth, 0, windowHeight)}, 0.6, Enum.EasingStyle.Back)
    
    -- Welcome notification
    task.delay(0.7, function()
        Library:Notify({
            Title = "Welcome!",
            Message = windowTitle .. " loaded successfully",
            Type = "Success",
            Duration = 3
        })
    end)
    
    return Window
end

return Library
