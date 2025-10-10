--[[
    ╔══════════════════════════════════════════════════════╗
    ║      DRAKTHON UI LIBRARY V3.0 - ULTIMATE             ║
    ║      Full PC & Mobile Support + Customizable         ║
    ║      Created by Fisal - 2024                         ║
    ╚══════════════════════════════════════════════════════╝
]]

local Library = {}
Library.Version = "3.0.0"
Library.Flags = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Device Detection
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local IsPC = UserInputService.KeyboardEnabled and UserInputService.MouseEnabled

-- ═══════════════════════════════════════════════════════
-- 🎨 Theme System (Customizable by User)
-- ═══════════════════════════════════════════════════════

Library.Themes = {
    Default = {
        MainBackground = Color3.fromRGB(15, 15, 20),
        SecondBackground = Color3.fromRGB(25, 25, 30),
        ThirdBackground = Color3.fromRGB(35, 35, 40),
        AccentColor = Color3.fromRGB(138, 43, 226),
        AccentColorHover = Color3.fromRGB(158, 63, 246),
        TextColor = Color3.fromRGB(255, 255, 255),
        SubTextColor = Color3.fromRGB(180, 180, 180),
        BorderColor = Color3.fromRGB(50, 50, 60),
        SuccessColor = Color3.fromRGB(46, 204, 113),
        WarningColor = Color3.fromRGB(241, 196, 15),
        ErrorColor = Color3.fromRGB(231, 76, 60),
        InfoColor = Color3.fromRGB(52, 152, 219),
    },
    Dark = {
        MainBackground = Color3.fromRGB(10, 10, 15),
        SecondBackground = Color3.fromRGB(20, 20, 25),
        ThirdBackground = Color3.fromRGB(30, 30, 35),
        AccentColor = Color3.fromRGB(0, 122, 204),
        AccentColorHover = Color3.fromRGB(20, 142, 224),
        TextColor = Color3.fromRGB(240, 240, 240),
        SubTextColor = Color3.fromRGB(160, 160, 160),
        BorderColor = Color3.fromRGB(40, 40, 50),
        SuccessColor = Color3.fromRGB(39, 174, 96),
        WarningColor = Color3.fromRGB(230, 126, 34),
        ErrorColor = Color3.fromRGB(192, 57, 43),
        InfoColor = Color3.fromRGB(41, 128, 185),
    },
    Ocean = {
        MainBackground = Color3.fromRGB(10, 25, 40),
        SecondBackground = Color3.fromRGB(15, 35, 55),
        ThirdBackground = Color3.fromRGB(20, 45, 70),
        AccentColor = Color3.fromRGB(52, 152, 219),
        AccentColorHover = Color3.fromRGB(72, 172, 239),
        TextColor = Color3.fromRGB(236, 240, 241),
        SubTextColor = Color3.fromRGB(149, 165, 166),
        BorderColor = Color3.fromRGB(41, 128, 185),
        SuccessColor = Color3.fromRGB(26, 188, 156),
        WarningColor = Color3.fromRGB(243, 156, 18),
        ErrorColor = Color3.fromRGB(231, 76, 60),
        InfoColor = Color3.fromRGB(52, 152, 219),
    },
    Midnight = {
        MainBackground = Color3.fromRGB(18, 18, 24),
        SecondBackground = Color3.fromRGB(28, 28, 36),
        ThirdBackground = Color3.fromRGB(38, 38, 48),
        AccentColor = Color3.fromRGB(255, 71, 87),
        AccentColorHover = Color3.fromRGB(255, 91, 107),
        TextColor = Color3.fromRGB(248, 248, 255),
        SubTextColor = Color3.fromRGB(170, 170, 180),
        BorderColor = Color3.fromRGB(58, 58, 68),
        SuccessColor = Color3.fromRGB(72, 219, 251),
        WarningColor = Color3.fromRGB(254, 202, 87),
        ErrorColor = Color3.fromRGB(255, 71, 87),
        InfoColor = Color3.fromRGB(158, 148, 255),
    }
}

Library.CurrentTheme = Library.Themes.Default

-- ═══════════════════════════════════════════════════════
-- 📱 Responsive System
-- ═══════════════════════════════════════════════════════

local function GetScreenSize()
    local Camera = workspace.CurrentCamera
    return Camera.ViewportSize
end

local function CalculateResponsiveSize(sizeType)
    local ViewportSize = GetScreenSize()
    local baseWidth = ViewportSize.X
    local baseHeight = ViewportSize.Y
    
    if IsMobile then
        return {
            Width = math.clamp(baseWidth * 0.95, 320, 500),
            Height = math.clamp(baseHeight * 0.85, 400, 650)
        }
    end
    
    local sizes = {
        Small = {
            Width = math.clamp(baseWidth * 0.35, 400, 500),
            Height = math.clamp(baseHeight * 0.5, 350, 450)
        },
        Medium = {
            Width = math.clamp(baseWidth * 0.45, 500, 650),
            Height = math.clamp(baseHeight * 0.6, 400, 550)
        },
        Large = {
            Width = math.clamp(baseWidth * 0.55, 650, 800),
            Height = math.clamp(baseHeight * 0.7, 500, 700)
        },
        Auto = {
            Width = math.clamp(baseWidth * 0.45, 500, 650),
            Height = math.clamp(baseHeight * 0.65, 450, 600)
        }
    }
    
    return sizes[sizeType] or sizes.Auto
end

-- ═══════════════════════════════════════════════════════
-- 🔧 Utility Functions
-- ═══════════════════════════════════════════════════════

local function CreateScreenGui()
    local success, gui = pcall(function()
        return CoreGui:FindFirstChild("DrakthonUI") or Instance.new("ScreenGui", CoreGui)
    end)
    
    if not success then
        gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
    end
    
    gui.Name = "DrakthonUI"
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 999999999
    
    return gui
end

local function Tween(object, properties, duration, easingStyle, easingDirection)
    if not object or not object.Parent then return end
    
    easingStyle = easingStyle or Enum.EasingStyle.Quad
    easingDirection = easingDirection or Enum.EasingDirection.Out
    duration = duration or 0.3
    
    local tweenInfo = TweenInfo.new(duration, easingStyle, easingDirection)
    local tween = TweenService:Create(object, tweenInfo, properties)
    
    pcall(function()
        tween:Play()
    end)
    
    return tween
end

local function MakeDraggable(gui, dragObject)
    local dragging = false
    local dragInput, mousePos, framePos
    
    dragObject = dragObject or gui
    
    local function update(input)
        if not dragging or not gui or not gui.Parent then return end
        
        local delta = input.Position - mousePos
        gui.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
    
    dragObject.InputBegan:Connect(function(input)
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
    
    dragObject.InputChanged:Connect(function(input)
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

-- ═══════════════════════════════════════════════════════
-- 🔔 Enhanced Notification System
-- ═══════════════════════════════════════════════════════

Library.NotificationQueue = {}
Library.ActiveNotifications = 0
Library.MaxNotifications = 3

local NotificationIcons = {
    Success = "✓",
    Error = "✕",
    Warning = "!",
    Info = "i"
}

function Library:Notify(config)
    config = config or {}
    local title = config.Title or "Notification"
    local description = config.Description or ""
    local duration = config.Duration or 4
    local notifType = config.Type or "Info"
    local callback = config.Callback or function() end
    
    if Library.ActiveNotifications >= Library.MaxNotifications then
        table.insert(Library.NotificationQueue, config)
        return
    end
    
    Library.ActiveNotifications = Library.ActiveNotifications + 1
    
    task.spawn(function()
        pcall(function()
            local gui = CreateScreenGui()
            local notifFrame = Instance.new("Frame")
            notifFrame.Name = "Notification_" .. HttpService:GenerateGUID(false)
            notifFrame.Parent = gui
            notifFrame.BackgroundColor3 = Library.CurrentTheme.SecondBackground
            notifFrame.BorderSizePixel = 0
            notifFrame.AnchorPoint = Vector2.new(1, 0)
            notifFrame.Size = UDim2.new(0, 0, 0, 70)
            
            local yPos = 10 + ((Library.ActiveNotifications - 1) * 80)
            notifFrame.Position = UDim2.new(1, -10, 0, yPos)
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 10)
            corner.Parent = notifFrame
            
            local stroke = Instance.new("UIStroke")
            stroke.Parent = notifFrame
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            stroke.Thickness = 1.5
            stroke.Transparency = 0.5
            
            if notifType == "Success" then
                stroke.Color = Library.CurrentTheme.SuccessColor
            elseif notifType == "Error" then
                stroke.Color = Library.CurrentTheme.ErrorColor
            elseif notifType == "Warning" then
                stroke.Color = Library.CurrentTheme.WarningColor
            else
                stroke.Color = Library.CurrentTheme.InfoColor
            end
            
            local iconFrame = Instance.new("Frame")
            iconFrame.Name = "IconFrame"
            iconFrame.Parent = notifFrame
            iconFrame.BackgroundColor3 = stroke.Color
            iconFrame.BorderSizePixel = 0
            iconFrame.Position = UDim2.new(0, 10, 0.5, 0)
            iconFrame.Size = UDim2.new(0, 35, 0, 35)
            iconFrame.AnchorPoint = Vector2.new(0, 0.5)
            
            local iconCorner = Instance.new("UICorner")
            iconCorner.CornerRadius = UDim.new(0, 8)
            iconCorner.Parent = iconFrame
            
            local icon = Instance.new("TextLabel")
            icon.Parent = iconFrame
            icon.BackgroundTransparency = 1
            icon.Size = UDim2.new(1, 0, 1, 0)
            icon.Font = Enum.Font.GothamBold
            icon.Text = NotificationIcons[notifType] or "i"
            icon.TextColor3 = Library.CurrentTheme.TextColor
            icon.TextSize = 18
            
            local titleLabel = Instance.new("TextLabel")
            titleLabel.Name = "Title"
            titleLabel.Parent = notifFrame
            titleLabel.BackgroundTransparency = 1
            titleLabel.Position = UDim2.new(0, 55, 0, 10)
            titleLabel.Size = UDim2.new(1, -100, 0, 18)
            titleLabel.Font = Enum.Font.GothamBold
            titleLabel.Text = title
            titleLabel.TextColor3 = Library.CurrentTheme.TextColor
            titleLabel.TextSize = 14
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
            
            local descLabel = Instance.new("TextLabel")
            descLabel.Name = "Description"
            descLabel.Parent = notifFrame
            descLabel.BackgroundTransparency = 1
            descLabel.Position = UDim2.new(0, 55, 0, 30)
            descLabel.Size = UDim2.new(1, -100, 0, 30)
            descLabel.Font = Enum.Font.Gotham
            descLabel.Text = description
            descLabel.TextColor3 = Library.CurrentTheme.SubTextColor
            descLabel.TextSize = 12
            descLabel.TextXAlignment = Enum.TextXAlignment.Left
            descLabel.TextYAlignment = Enum.TextYAlignment.Top
            descLabel.TextWrapped = true
            
            local progressBar = Instance.new("Frame")
            progressBar.Name = "ProgressBar"
            progressBar.Parent = notifFrame
            progressBar.BackgroundColor3 = Library.CurrentTheme.MainBackground
            progressBar.BorderSizePixel = 0
            progressBar.Position = UDim2.new(0, 0, 1, -3)
            progressBar.Size = UDim2.new(1, 0, 0, 3)
            
            local progress = Instance.new("Frame")
            progress.Name = "Progress"
            progress.Parent = progressBar
            progress.BackgroundColor3 = stroke.Color
            progress.BorderSizePixel = 0
            progress.Size = UDim2.new(1, 0, 1, 0)
            
            local closeBtn = Instance.new("TextButton")
            closeBtn.Name = "CloseButton"
            closeBtn.Parent = notifFrame
            closeBtn.BackgroundColor3 = Library.CurrentTheme.ThirdBackground
            closeBtn.BorderSizePixel = 0
            closeBtn.Position = UDim2.new(1, -30, 0, 5)
            closeBtn.Size = UDim2.new(0, 25, 0, 25)
            closeBtn.Font = Enum.Font.GothamBold
            closeBtn.Text = "×"
            closeBtn.TextColor3 = Library.CurrentTheme.SubTextColor
            closeBtn.TextSize = 16
            closeBtn.AutoButtonColor = false
            
            local closeBtnCorner = Instance.new("UICorner")
            closeBtnCorner.CornerRadius = UDim.new(0, 6)
            closeBtnCorner.Parent = closeBtn
            
            local function closeNotification()
                Library.ActiveNotifications = Library.ActiveNotifications - 1
                
                Tween(notifFrame, {Size = UDim2.new(0, 0, 0, 70)}, 0.3)
                
                task.wait(0.3)
                
                pcall(function()
                    gui:Destroy()
                end)
                
                if #Library.NotificationQueue > 0 then
                    local nextNotif = table.remove(Library.NotificationQueue, 1)
                    task.wait(0.1)
                    Library:Notify(nextNotif)
                end
                
                callback()
            end
            
            closeBtn.MouseButton1Click:Connect(closeNotification)
            
            closeBtn.MouseEnter:Connect(function()
                Tween(closeBtn, {BackgroundColor3 = Library.CurrentTheme.ErrorColor}, 0.2)
            end)
            
            closeBtn.MouseLeave:Connect(function()
                Tween(closeBtn, {BackgroundColor3 = Library.CurrentTheme.ThirdBackground}, 0.2)
            end)
            
            Tween(notifFrame, {Size = UDim2.new(0, 300, 0, 70)}, 0.4, Enum.EasingStyle.Back)
            
            task.spawn(function()
                wait(0.2)
                Tween(iconFrame, {Size = UDim2.new(0, 35, 0, 35)}, 0.3, Enum.EasingStyle.Elastic)
            end)
            
            task.spawn(function()
                Tween(progress, {Size = UDim2.new(0, 0, 1, 0)}, duration, Enum.EasingStyle.Linear)
            end)
            
            task.delay(duration, function()
                closeNotification()
            end)
        end)
    end)
end

-- ═══════════════════════════════════════════════════════
-- 💾 Config System
-- ═══════════════════════════════════════════════════════

Library.ConfigSystem = {}

function Library.ConfigSystem:Save(configName, data)
    local success = pcall(function()
        writefile(configName .. ".json", HttpService:JSONEncode(data))
    end)
    
    if success then
        Library:Notify({
            Title = "Config Saved",
            Description = "Configuration saved: " .. configName,
            Type = "Success",
            Duration = 2
        })
        return true
    else
        Library:Notify({
            Title = "Save Failed",
            Description = "Failed to save configuration",
            Type = "Error",
            Duration = 3
        })
        return false
    end
end

function Library.ConfigSystem:Load(configName)
    local success, data = pcall(function()
        return HttpService:JSONDecode(readfile(configName .. ".json"))
    end)
    
    if success then
        Library:Notify({
            Title = "Config Loaded",
            Description = "Configuration loaded: " .. configName,
            Type = "Success",
            Duration = 2
        })
        return data
    else
        Library:Notify({
            Title = "Load Failed",
            Description = "Configuration file not found",
            Type = "Warning",
            Duration = 3
        })
        return nil
    end
end

-- ═══════════════════════════════════════════════════════
-- 🪟 Main Window Creation
-- ═══════════════════════════════════════════════════════

function Library:CreateWindow(config)
    config = config or {}
    
    local windowTitle = config.Title or "Drakthon UI"
    local windowSubtitle = config.Subtitle or "v" .. Library.Version
    local themeName = config.Theme or "Default"
    local sizeType = config.Size or "Auto"
    local keybind = config.Keybind or Enum.KeyCode.RightControl
    
    if Library.Themes[themeName] then
        Library.CurrentTheme = Library.Themes[themeName]
    end
    
    local screenSize = CalculateResponsiveSize(sizeType)
    local windowSize = UDim2.new(0, screenSize.Width, 0, screenSize.Height)
    
    local screenGui = CreateScreenGui()
    
    local mainContainer = Instance.new("Frame")
    mainContainer.Name = "MainContainer"
    mainContainer.Parent = screenGui
    mainContainer.BackgroundTransparency = 1
    mainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainContainer.Size = UDim2.new(0, 0, 0, 0)
    mainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    mainContainer.ClipsDescendants = false
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Parent = mainContainer
    mainFrame.BackgroundColor3 = Library.CurrentTheme.MainBackground
    mainFrame.BorderSizePixel = 0
    mainFrame.Size = UDim2.new(1, 0, 1, 0)
    mainFrame.ClipsDescendants = true
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainFrame
    
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Parent = mainContainer
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.ZIndex = -1
    shadow.Image = "rbxassetid://6015897843"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    
    local stroke = Instance.new("UIStroke")
    stroke.Parent = mainFrame
    stroke.Color = Library.CurrentTheme.AccentColor
    stroke.Thickness = 1.5
    stroke.Transparency = 0.7
    
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Parent = mainFrame
    header.BackgroundColor3 = Library.CurrentTheme.SecondBackground
    header.BorderSizePixel = 0
    header.Size = UDim2.new(1, 0, 0, 45)
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = header
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Parent = header
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 12, 0, 6)
    title.Size = UDim2.new(0.6, -12, 0, 16)
    title.Font = Enum.Font.GothamBold
    title.Text = windowTitle
    title.TextColor3 = Library.CurrentTheme.TextColor
    title.TextSize = IsMobile and 13 or 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextTruncate = Enum.TextTruncate.AtEnd
    
    local subtitle = Instance.new("TextLabel")
    subtitle.Name = "Subtitle"
    subtitle.Parent = header
    subtitle.BackgroundTransparency = 1
    subtitle.Position = UDim2.new(0, 12, 0, 23)
    subtitle.Size = UDim2.new(0.6, -12, 0, 14)
    subtitle.Font = Enum.Font.Gotham
    subtitle.Text = windowSubtitle
    subtitle.TextColor3 = Library.CurrentTheme.SubTextColor
    subtitle.TextSize = IsMobile and 10 or 11
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local controlsFrame = Instance.new("Frame")
    controlsFrame.Name = "Controls"
    controlsFrame.Parent = header
    controlsFrame.BackgroundTransparency = 1
    controlsFrame.Position = UDim2.new(1, -75, 0.5, 0)
    controlsFrame.Size = UDim2.new(0, 70, 0, 26)
    controlsFrame.AnchorPoint = Vector2.new(0, 0.5)
    
    local controlsList = Instance.new("UIListLayout")
    controlsList.Parent = controlsFrame
    controlsList.FillDirection = Enum.FillDirection.Horizontal
    controlsList.HorizontalAlignment = Enum.HorizontalAlignment.Right
    controlsList.Padding = UDim.new(0, 5)
    
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Name = "Minimize"
    minimizeBtn.Parent = controlsFrame
    minimizeBtn.BackgroundColor3 = Library.CurrentTheme.ThirdBackground
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.Size = UDim2.new(0, 26, 0, 26)
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.Text = "−"
    minimizeBtn.TextColor3 = Library.CurrentTheme.TextColor
    minimizeBtn.TextSize = 16
    minimizeBtn.AutoButtonColor = false
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 6)
    minimizeCorner.Parent = minimizeBtn
    
    local minimized = false
    minimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Tween(mainContainer, {Size = UDim2.new(0, screenSize.Width, 0, 45)}, 0.3, Enum.EasingStyle.Back)
            minimizeBtn.Text = "+"
        else
            Tween(mainContainer, {Size = windowSize}, 0.3, Enum.EasingStyle.Back)
            minimizeBtn.Text = "−"
        end
    end)
    
    minimizeBtn.MouseEnter:Connect(function()
        Tween(minimizeBtn, {BackgroundColor3 = Library.CurrentTheme.AccentColor}, 0.2)
    end)
    
    minimizeBtn.MouseLeave:Connect(function()
        Tween(minimizeBtn, {BackgroundColor3 = Library.CurrentTheme.ThirdBackground}, 0.2)
    end)
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "Close"
    closeBtn.Parent = controlsFrame
    closeBtn.BackgroundColor3 = Library.CurrentTheme.ErrorColor
    closeBtn.BorderSizePixel = 0
    closeBtn.Size = UDim2.new(0, 26, 0, 26)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Library.CurrentTheme.TextColor
    closeBtn.TextSize = 18
    closeBtn.AutoButtonColor = false
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn
    
    closeBtn.MouseEnter:Connect(function()
        Tween(closeBtn, {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}, 0.2)
    end)
    
    closeBtn.MouseLeave:Connect(function()
        Tween(closeBtn, {BackgroundColor3 = Library.CurrentTheme.ErrorColor}, 0.2)
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        Tween(mainContainer, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        task.wait(0.3)
        screenGui:Destroy()
    end)
    
    MakeDraggable(mainContainer, header)
    
    if not IsMobile then
        local uiVisible = true
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == keybind then
                uiVisible = not uiVisible
                Tween(mainContainer, {
                    Size = uiVisible and windowSize or UDim2.new(0, 0, 0, 0)
                }, 0.3, Enum.EasingStyle.Back)
            end
        end)
    end
    
    local tabWidth = IsMobile and 60 or math.clamp(screenSize.Width * 0.22, 100, 140)
    
    local tabContainer = Instance.new("ScrollingFrame")
    tabContainer.Name = "TabContainer"
    tabContainer.Parent = mainFrame
    tabContainer.BackgroundColor3 = Library.CurrentTheme.SecondBackground
    tabContainer.BorderSizePixel = 0
    tabContainer.Position = UDim2.new(0, 0, 0, 45)
    tabContainer.Size = UDim2.new(0, tabWidth, 1, -45)
    tabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContainer.ScrollBarThickness = 3
    tabContainer.ScrollBarImageColor3 = Library.CurrentTheme.AccentColor
    
    local tabList = Instance.new("UIListLayout")
    tabList.Parent = tabContainer
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabList.Padding = UDim.new(0, 4)
    
    local tabPadding = Instance.new("UIPadding")
    tabPadding.Parent = tabContainer
    tabPadding.PaddingTop = UDim.new(0, 8)
    tabPadding.PaddingBottom = UDim.new(0, 8)
    tabPadding.PaddingLeft = UDim.new(0, 6)
    tabPadding.PaddingRight = UDim.new(0, 6)
    
    tabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContainer.CanvasSize = UDim2.new(0, 0, 0, tabList.AbsoluteContentSize.Y + 16)
    end)
    
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentContainer"
    contentContainer.Parent = mainFrame
    contentContainer.BackgroundTransparency = 1
    contentContainer.Position = UDim2.new(0, tabWidth, 0, 45)
    contentContainer.Size = UDim2.new(1, -tabWidth, 1, -45)
    
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        Flags = Library.Flags,
        ScreenSize = screenSize
    }
    
    function Window:CreateTab(tabConfig)
        tabConfig = tabConfig or {}
        local tabName = tabConfig.Name or "Tab"
        local tabIcon = tabConfig.Icon or "rbxassetid://7734053426"
        
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName
        tabButton.Parent = tabContainer
        tabButton.BackgroundColor3 = Library.CurrentTheme.ThirdBackground
        tabButton.BorderSizePixel = 0
        tabButton.Size = UDim2.new(1, 0, 0, IsMobile and 50 or 36)
        tabButton.Font = Enum.Font.GothamSemibold
        tabButton.Text = ""
        tabButton.AutoButtonColor = false
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 8)
        tabCorner.Parent = tabButton
        
        if not IsMobile then
            local tabIcon = Instance.new("ImageLabel")
            tabIcon.Name = "Icon"
            tabIcon.Parent = tabButton
            tabIcon.BackgroundTransparency = 1
            tabIcon.Position = UDim2.new(0, 8, 0.5, 0)
            tabIcon.Size = UDim2.new(0, 18, 0, 18)
            tabIcon.AnchorPoint = Vector2.new(0, 0.5)
            tabIcon.Image = tabConfig.Icon or ""
            tabIcon.ImageColor3 = Library.CurrentTheme.SubTextColor
        end
        
        local tabText = Instance.new("TextLabel")
        tabText.Name = "Text"
        tabText.Parent = tabButton
        tabText.BackgroundTransparency = 1
        tabText.Position = UDim2.new(0, IsMobile and 8 or 32, 0, 0)
        tabText.Size = UDim2.new(1, IsMobile and -16 or -40, 1, 0)
        tabText.Font = Enum.Font.GothamSemibold
        tabText.Text = tabName
        tabText.TextColor3 = Library.CurrentTheme.SubTextColor
        tabText.TextSize = IsMobile and 12 or 12
        tabText.TextXAlignment = Enum.TextXAlignment.Left
        tabText.TextTruncate = Enum.TextTruncate.AtEnd
        
        local indicator = Instance.new("Frame")
        indicator.Name = "Indicator"
        indicator.Parent = tabButton
        indicator.BackgroundColor3 = Library.CurrentTheme.AccentColor
        indicator.BorderSizePixel = 0
        indicator.Position = UDim2.new(0, 0, 0, 0)
        indicator.Size = UDim2.new(0, 0, 1, 0)
        
        local indicatorCorner = Instance.new("UICorner")
        indicatorCorner.CornerRadius = UDim.new(0, 8)
        indicatorCorner.Parent = indicator
        
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = tabName .. "_Content"
        tabContent.Parent = contentContainer
        tabContent.BackgroundTransparency = 1
        tabContent.BorderSizePixel = 0
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.ScrollBarThickness = 4
        tabContent.ScrollBarImageColor3 = Library.CurrentTheme.AccentColor
        tabContent.Visible = false
        
        local contentList = Instance.new("UIListLayout")
        contentList.Parent = tabContent
        contentList.SortOrder = Enum.SortOrder.LayoutOrder
        contentList.Padding = UDim.new(0, 8)
        
        local contentPadding = Instance.new("UIPadding")
        contentPadding.Parent = tabContent
        contentPadding.PaddingTop = UDim.new(0, 10)
        contentPadding.PaddingBottom = UDim.new(0, 10)
        contentPadding.PaddingLeft = UDim.new(0, 10)
        contentPadding.PaddingRight = UDim.new(0, 10)
        
        contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabContent.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 20)
        end)
        
        tabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab:Deactivate()
            end
            
            tabContent.Visible = true
            Window.CurrentTab = tabName
            
            Tween(tabButton, {BackgroundColor3 = Library.CurrentTheme.AccentColor}, 0.2)
            Tween(tabText, {TextColor3 = Library.CurrentTheme.TextColor}, 0.2)
            Tween(indicator, {Size = UDim2.new(0, 3, 1, 0)}, 0.3, Enum.EasingStyle.Back)
            
            if not IsMobile then
                local iconObj = tabButton:FindFirstChild("Icon")
                if iconObj then
                    Tween(iconObj, {ImageColor3 = Library.CurrentTheme.TextColor}, 0.2)
                end
            end
        end)
        
        tabButton.MouseEnter:Connect(function()
            if Window.CurrentTab ~= tabName then
                Tween(tabButton, {BackgroundColor3 = Library.CurrentTheme.SecondBackground}, 0.2)
            end
        end)
        
        tabButton.MouseLeave:Connect(function()
            if Window.CurrentTab ~= tabName then
                Tween(tabButton, {BackgroundColor3 = Library.CurrentTheme.ThirdBackground}, 0.2)
            end
        end)
        
        local Tab = {
            Name = tabName,
            Button = tabButton,
            Content = tabContent
        }
        
        function Tab:Deactivate()
            tabContent.Visible = false
            Tween(tabButton, {BackgroundColor3 = Library.CurrentTheme.ThirdBackground}, 0.2)
            Tween(tabText, {TextColor3 = Library.CurrentTheme.SubTextColor}, 0.2)
            Tween(indicator, {Size = UDim2.new(0, 0, 1, 0)}, 0.3)
            
            if not IsMobile then
                local iconObj = tabButton:FindFirstChild("Icon")
                if iconObj then
                    Tween(iconObj, {ImageColor3 = Library.CurrentTheme.SubTextColor}, 0.2)
                end
            end
        end
        
        function Tab:AddSection(sectionName)
            local section = Instance.new("Frame")
            section.Name = sectionName
            section.Parent = tabContent
            section.BackgroundColor3 = Library.CurrentTheme.SecondBackground
            section.BorderSizePixel = 0
            section.Size = UDim2.new(1, 0, 0, 35)
            section.AutomaticSize = Enum.AutomaticSize.Y
            
            local sectionCorner = Instance.new("UICorner")
            sectionCorner.CornerRadius = UDim.new(0, 8)
            sectionCorner.Parent = section
            
            local sectionTitle = Instance.new("TextLabel")
            sectionTitle.Name = "Title"
            sectionTitle.Parent = section
            sectionTitle.BackgroundTransparency = 1
            sectionTitle.Position = UDim2.new(0, 10, 0, 0)
            sectionTitle.Size = UDim2.new(1, -20, 0, 35)
            sectionTitle.Font = Enum.Font.GothamBold
            sectionTitle.Text = sectionName
            sectionTitle.TextColor3 = Library.CurrentTheme.TextColor
            sectionTitle.TextSize = IsMobile and 12 or 13
            sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local sectionContent = Instance.new("Frame")
            sectionContent.Name = "Content"
            sectionContent.Parent = section
            sectionContent.BackgroundTransparency = 1
            sectionContent.Position = UDim2.new(0, 0, 0, 35)
            sectionContent.Size = UDim2.new(1, 0, 1, -35)
            sectionContent.AutomaticSize = Enum.AutomaticSize.Y
            
            local sectionList = Instance.new("UIListLayout")
            sectionList.Parent = sectionContent
            sectionList.SortOrder = Enum.SortOrder.LayoutOrder
            sectionList.Padding = UDim.new(0, 6)
            
            local sectionPadding = Instance.new("UIPadding")
            sectionPadding.Parent = sectionContent
            sectionPadding.PaddingTop = UDim.new(0, 8)
            sectionPadding.PaddingBottom = UDim.new(0, 10)
            sectionPadding.PaddingLeft = UDim.new(0, 10)
            sectionPadding.PaddingRight = UDim.new(0, 10)
            
            local Section = {}
            
            function Section:AddButton(btnConfig)
                btnConfig = btnConfig or {}
                local btnName = btnConfig.Name or "Button"
                local callback = btnConfig.Callback or function() end
                
                local button = Instance.new("TextButton")
                button.Name = btnName
                button.Parent = sectionContent
                button.BackgroundColor3 = Library.CurrentTheme.ThirdBackground
                button.BorderSizePixel = 0
                button.Size = UDim2.new(1, 0, 0, IsMobile and 40 or 34)
                button.Font = Enum.Font.GothamSemibold
                button.Text = btnName
                button.TextColor3 = Library.CurrentTheme.TextColor
                button.TextSize = IsMobile and 12 or 13
                button.AutoButtonColor = false
                
                local btnCorner = Instance.new("UICorner")
                btnCorner.CornerRadius = UDim.new(0, 6)
                btnCorner.Parent = button
                
                button.MouseEnter:Connect(function()
                    Tween(button, {BackgroundColor3 = Library.CurrentTheme.AccentColor}, 0.2)
                end)
                
                button.MouseLeave:Connect(function()
                    Tween(button, {BackgroundColor3 = Library.CurrentTheme.ThirdBackground}, 0.2)
                end)
                
                button.MouseButton1Click:Connect(function()
                    Tween(button, {Size = UDim2.new(1, 0, 0, IsMobile and 37 or 31)}, 0.1)
                    task.wait(0.1)
                    Tween(button, {Size = UDim2.new(1, 0, 0, IsMobile and 40 or 34)}, 0.1)
                    pcall(callback)
                end)
                
                return button
            end
            
            function Section:AddToggle(toggleConfig)
                toggleConfig = toggleConfig or {}
                local toggleName = toggleConfig.Name or "Toggle"
                local defaultValue = toggleConfig.Default or false
                local callback = toggleConfig.Callback or function() end
                local flag = toggleConfig.Flag
                
                local toggle = Instance.new("Frame")
                toggle.Name = toggleName
                toggle.Parent = sectionContent
                toggle.BackgroundColor3 = Library.CurrentTheme.ThirdBackground
                toggle.BorderSizePixel = 0
                toggle.Size = UDim2.new(1, 0, 0, IsMobile and 40 or 34)
                
                local toggleCorner = Instance.new("UICorner")
                toggleCorner.CornerRadius = UDim.new(0, 6)
                toggleCorner.Parent = toggle
                
                local toggleLabel = Instance.new("TextLabel")
                toggleLabel.Parent = toggle
                toggleLabel.BackgroundTransparency = 1
                toggleLabel.Position = UDim2.new(0, 10, 0, 0)
                toggleLabel.Size = UDim2.new(1, -55, 1, 0)
                toggleLabel.Font = Enum.Font.GothamSemibold
                toggleLabel.Text = toggleName
                toggleLabel.TextColor3 = Library.CurrentTheme.TextColor
                toggleLabel.TextSize = IsMobile and 12 or 12
                toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                toggleLabel.TextTruncate = Enum.TextTruncate.AtEnd
                
                local toggleButton = Instance.new("TextButton")
                toggleButton.Parent = toggle
                toggleButton.BackgroundColor3 = defaultValue and Library.CurrentTheme.AccentColor or Library.CurrentTheme.MainBackground
                toggleButton.BorderSizePixel = 0
                toggleButton.Position = UDim2.new(1, -42, 0.5, 0)
                toggleButton.Size = UDim2.new(0, 36, 0, 18)
                toggleButton.AnchorPoint = Vector2.new(0, 0.5)
                toggleButton.Text = ""
                toggleButton.AutoButtonColor = false
                
                local toggleBtnCorner = Instance.new("UICorner")
                toggleBtnCorner.CornerRadius = UDim.new(1, 0)
                toggleBtnCorner.Parent = toggleButton
                
                local toggleCircle = Instance.new("Frame")
                toggleCircle.Parent = toggleButton
                toggleCircle.BackgroundColor3 = Library.CurrentTheme.TextColor
                toggleCircle.BorderSizePixel = 0
                toggleCircle.Position = defaultValue and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                toggleCircle.Size = UDim2.new(0, 14, 0, 14)
                toggleCircle.AnchorPoint = Vector2.new(0, 0.5)
                
                local circleCorner = Instance.new("UICorner")
                circleCorner.CornerRadius = UDim.new(1, 0)
                circleCorner.Parent = toggleCircle
                
                local toggled = defaultValue
                
                if flag then
                    Library.Flags[flag] = toggled
                end
                
                local function updateToggle(value)
                    toggled = value
                    
                    if flag then
                        Library.Flags[flag] = value
                    end
                    
                    Tween(toggleButton, {
                        BackgroundColor3 = toggled and Library.CurrentTheme.AccentColor or Library.CurrentTheme.MainBackground
                    }, 0.2)
                    
                    Tween(toggleCircle, {
                        Position = toggled and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                    }, 0.3, Enum.EasingStyle.Back)
                    
                    pcall(function()
                        callback(toggled)
                    end)
                end
                
                toggleButton.MouseButton1Click:Connect(function()
                    updateToggle(not toggled)
                end)
                
                return {
                    Set = function(value)
                        updateToggle(value)
                    end,
                    Get = function()
                        return toggled
                    end
                }
            end
            
            function Section:AddSlider(sliderConfig)
                sliderConfig = sliderConfig or {}
                local sliderName = sliderConfig.Name or "Slider"
                local min = sliderConfig.Min or 0
                local max = sliderConfig.Max or 100
                local default = sliderConfig.Default or 50
                local increment = sliderConfig.Increment or 1
                local callback = sliderConfig.Callback or function() end
                local flag = sliderConfig.Flag
                
                local slider = Instance.new("Frame")
                slider.Name = sliderName
                slider.Parent = sectionContent
                slider.BackgroundColor3 = Library.CurrentTheme.ThirdBackground
                slider.BorderSizePixel = 0
                slider.Size = UDim2.new(1, 0, 0, IsMobile and 55 or 48)
                
                local sliderCorner = Instance.new("UICorner")
                sliderCorner.CornerRadius = UDim.new(0, 6)
                sliderCorner.Parent = slider
                
                local sliderLabel = Instance.new("TextLabel")
                sliderLabel.Parent = slider
                sliderLabel.BackgroundTransparency = 1
                sliderLabel.Position = UDim2.new(0, 10, 0, 6)
                sliderLabel.Size = UDim2.new(0.6, 0, 0, 16)
                sliderLabel.Font = Enum.Font.GothamSemibold
                sliderLabel.Text = sliderName
                sliderLabel.TextColor3 = Library.CurrentTheme.TextColor
                sliderLabel.TextSize = IsMobile and 11 or 12
                sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                sliderLabel.TextTruncate = Enum.TextTruncate.AtEnd
                
                local sliderValue = Instance.new("TextLabel")
                sliderValue.Parent = slider
                sliderValue.BackgroundColor3 = Library.CurrentTheme.MainBackground
                sliderValue.BorderSizePixel = 0
                sliderValue.Position = UDim2.new(1, -48, 0, 6)
                sliderValue.Size = UDim2.new(0, 42, 0, 16)
                sliderValue.Font = Enum.Font.GothamBold
                sliderValue.Text = tostring(default)
                sliderValue.TextColor3 = Library.CurrentTheme.AccentColor
                sliderValue.TextSize = IsMobile and 10 or 11
                
                local valueCorner = Instance.new("UICorner")
                valueCorner.CornerRadius = UDim.new(0, 4)
                valueCorner.Parent = sliderValue
                
                local sliderBar = Instance.new("Frame")
                sliderBar.Parent = slider
                sliderBar.BackgroundColor3 = Library.CurrentTheme.MainBackground
                sliderBar.BorderSizePixel = 0
                sliderBar.Position = UDim2.new(0, 10, 1, IsMobile and -18 or -16)
                sliderBar.Size = UDim2.new(1, -20, 0, 6)
                
                local barCorner = Instance.new("UICorner")
                barCorner.CornerRadius = UDim.new(1, 0)
                barCorner.Parent = sliderBar
                
                local sliderFill = Instance.new("Frame")
                sliderFill.Parent = sliderBar
                sliderFill.BackgroundColor3 = Library.CurrentTheme.AccentColor
                sliderFill.BorderSizePixel = 0
                sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
                
                local fillCorner = Instance.new("UICorner")
                fillCorner.CornerRadius = UDim.new(1, 0)
                fillCorner.Parent = sliderFill
                
                local sliderDot = Instance.new("Frame")
                sliderDot.Parent = sliderBar
                sliderDot.BackgroundColor3 = Library.CurrentTheme.TextColor
                sliderDot.BorderSizePixel = 0
                sliderDot.Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0)
                sliderDot.Size = UDim2.new(0, 12, 0, 12)
                sliderDot.AnchorPoint = Vector2.new(0.5, 0.5)
                
                local dotCorner = Instance.new("UICorner")
                dotCorner.CornerRadius = UDim.new(1, 0)
                dotCorner.Parent = sliderDot
                
                local dragging = false
                
                if flag then
                    Library.Flags[flag] = default
                end
                
                local function updateSlider(input)
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
                    
                    pcall(function()
                        callback(value)
                    end)
                end
                
                sliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        updateSlider(input)
                        Tween(sliderDot, {Size = UDim2.new(0, 16, 0, 16)}, 0.2, Enum.EasingStyle.Back)
                    end
                end)
                
                sliderBar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                        Tween(sliderDot, {Size = UDim2.new(0, 12, 0, 12)}, 0.2)
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        updateSlider(input)
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
                        
                        pcall(function()
                            callback(value)
                        end)
                    end,
                    Get = function()
                        return tonumber(sliderValue.Text)
                    end
                }
            end
            
            function Section:AddDropdown(dropConfig)
                dropConfig = dropConfig or {}
                local dropName = dropConfig.Name or "Dropdown"
                local items = dropConfig.Items or {"Option 1", "Option 2"}
                local default = dropConfig.Default or items[1]
                local callback = dropConfig.Callback or function() end
                local flag = dropConfig.Flag
                
                local dropdown = Instance.new("Frame")
                dropdown.Name = dropName
                dropdown.Parent = sectionContent
                dropdown.BackgroundColor3 = Library.CurrentTheme.ThirdBackground
                dropdown.BorderSizePixel = 0
                dropdown.Size = UDim2.new(1, 0, 0, IsMobile and 40 or 34)
                dropdown.ClipsDescendants = true
                
                local dropCorner = Instance.new("UICorner")
                dropCorner.CornerRadius = UDim.new(0, 6)
                dropCorner.Parent = dropdown
                
                local dropLabel = Instance.new("TextLabel")
                dropLabel.Parent = dropdown
                dropLabel.BackgroundTransparency = 1
                dropLabel.Position = UDim2.new(0, 10, 0, 0)
                dropLabel.Size = UDim2.new(0.4, 0, 0, IsMobile and 40 or 34)
                dropLabel.Font = Enum.Font.GothamSemibold
                dropLabel.Text = dropName
                dropLabel.TextColor3 = Library.CurrentTheme.TextColor
                dropLabel.TextSize = IsMobile and 11 or 12
                dropLabel.TextXAlignment = Enum.TextXAlignment.Left
                dropLabel.TextTruncate = Enum.TextTruncate.AtEnd
                
                local dropButton = Instance.new("TextButton")
                dropButton.Parent = dropdown
                dropButton.BackgroundColor3 = Library.CurrentTheme.MainBackground
                dropButton.BorderSizePixel = 0
                dropButton.Position = UDim2.new(0.45, 0, 0, 6)
                dropButton.Size = UDim2.new(0.5, -10, 0, IsMobile and 28 : 22)
                dropButton.Font = Enum.Font.Gotham
                dropButton.Text = "  " .. default
                dropButton.TextColor3 = Library.CurrentTheme.AccentColor
                dropButton.TextSize = IsMobile and 10 or 11
                dropButton.TextXAlignment = Enum.TextXAlignment.Left
                dropButton.AutoButtonColor = false
                dropButton.TextTruncate = Enum.TextTruncate.AtEnd
                
                local dropBtnCorner = Instance.new("UICorner")
                dropBtnCorner.CornerRadius = UDim.new(0, 5)
                dropBtnCorner.Parent = dropButton
                
                local arrow = Instance.new("TextLabel")
                arrow.Parent = dropButton
                arrow.BackgroundTransparency = 1
                arrow.Position = UDim2.new(1, -18, 0, 0)
                arrow.Size = UDim2.new(0, 16, 1, 0)
                arrow.Font = Enum.Font.GothamBold
                arrow.Text = "▼"
                arrow.TextColor3 = Library.CurrentTheme.SubTextColor
                arrow.TextSize = 8
                
                local itemList = Instance.new("ScrollingFrame")
                itemList.Parent = dropdown
                itemList.BackgroundTransparency = 1
                itemList.BorderSizePixel = 0
                itemList.Position = UDim2.new(0, 6, 0, IsMobile and 44 or 38)
                itemList.Size = UDim2.new(1, -12, 0, 0)
                itemList.CanvasSize = UDim2.new(0, 0, 0, 0)
                itemList.ScrollBarThickness = 3
                itemList.ScrollBarImageColor3 = Library.CurrentTheme.AccentColor
                
                local itemLayout = Instance.new("UIListLayout")
                itemLayout.Parent = itemList
                itemLayout.SortOrder = Enum.SortOrder.LayoutOrder
                itemLayout.Padding = UDim.new(0, 3)
                
                itemLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    itemList.CanvasSize = UDim2.new(0, 0, 0, itemLayout.AbsoluteContentSize.Y)
                end)
                
                local expanded = false
                local currentValue = default
                
                if flag then
                    Library.Flags[flag] = currentValue
                end
                
                for _, itemName in ipairs(items) do
                    local item = Instance.new("TextButton")
                    item.Name = itemName
                    item.Parent = itemList
                    item.BackgroundColor3 = Library.CurrentTheme.MainBackground
                    item.BorderSizePixel = 0
                    item.Size = UDim2.new(1, 0, 0, IsMobile and 28 or 24)
                    item.Font = Enum.Font.Gotham
                    item.Text = "  " .. itemName
                    item.TextColor3 = Library.CurrentTheme.TextColor
                    item.TextSize = IsMobile and 10 or 11
                    item.TextXAlignment = Enum.TextXAlignment.Left
                    item.AutoButtonColor = false
                    item.TextTruncate = Enum.TextTruncate.AtEnd
                    
                    local itemCorner = Instance.new("UICorner")
                    itemCorner.CornerRadius = UDim.new(0, 5)
                    itemCorner.Parent = item
                    
                    item.MouseEnter:Connect(function()
                        Tween(item, {BackgroundColor3 = Library.CurrentTheme.AccentColor}, 0.2)
                    end)
                    
                    item.MouseLeave:Connect(function()
                        Tween(item, {BackgroundColor3 = Library.CurrentTheme.MainBackground}, 0.2)
                    end)
                    
                    item.MouseButton1Click:Connect(function()
                        currentValue = itemName
                        dropButton.Text = "  " .. itemName
                        
                        if flag then
                            Library.Flags[flag] = itemName
                        end
                        
                        pcall(function()
                            callback(itemName)
                        end)
                        
                        expanded = false
                        Tween(dropdown, {Size = UDim2.new(1, 0, 0, IsMobile and 40 or 34)}, 0.3, Enum.EasingStyle.Back)
                        Tween(arrow, {Rotation = 0}, 0.3)
                    end)
                end
                
                dropButton.MouseButton1Click:Connect(function()
                    expanded = not expanded
                    if expanded then
                        local itemCount = math.min(#items, 4)
                        local itemHeight = IsMobile and 28 or 24
                        local baseHeight = IsMobile and 40 or 34
                        Tween(dropdown, {Size = UDim2.new(1, 0, 0, baseHeight + 8 + (itemCount * (itemHeight + 3)))}, 0.3, Enum.EasingStyle.Back)
                        Tween(arrow, {Rotation = 180}, 0.3)
                        itemList.Size = UDim2.new(1, -12, 0, itemCount * (itemHeight + 3))
                    else
                        Tween(dropdown, {Size = UDim2.new(1, 0, 0, IsMobile and 40 or 34)}, 0.3, Enum.EasingStyle.Back)
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
                            
                            pcall(function()
                                callback(value)
                            end)
                        end
                    end,
                    Get = function()
                        return currentValue
                    end,
                    Refresh = function(newItems, newDefault)
                        items = newItems
                        itemList:ClearAllChildren()
                        itemLayout.Parent = itemList
                        
                        for _, itemName in ipairs(newItems) do
                            local item = Instance.new("TextButton")
                            item.Name = itemName
                            item.Parent = itemList
                            item.BackgroundColor3 = Library.CurrentTheme.MainBackground
                            item.BorderSizePixel = 0
                            item.Size = UDim2.new(1, 0, 0, IsMobile and 28 or 24)
                            item.Font = Enum.Font.Gotham
                            item.Text = "  " .. itemName
                            item.TextColor3 = Library.CurrentTheme.TextColor
                            item.TextSize = IsMobile and 10 or 11
                            item.TextXAlignment = Enum.TextXAlignment.Left
                            item.AutoButtonColor = false
                            
                            local itemCorner = Instance.new("UICorner")
                            itemCorner.CornerRadius = UDim.new(0, 5)
                            itemCorner.Parent = item
                            
                            item.MouseButton1Click:Connect(function()
                                currentValue = itemName
                                dropButton.Text = "  " .. itemName
                                
                                if flag then
                                    Library.Flags[flag] = itemName
                                end
                                
                                pcall(callback, itemName)
                                expanded = false
                                Tween(dropdown, {Size = UDim2.new(1, 0, 0, IsMobile and 40 or 34)}, 0.3)
                            end)
                        end
                        
                        if newDefault and table.find(newItems, newDefault) then
                            currentValue = newDefault
                            dropButton.Text = "  " .. newDefault
                        end
                    end
                }
            end
            
            function Section:AddTextbox(textConfig)
                textConfig = textConfig or {}
                local textName = textConfig.Name or "Textbox"
                local defaultText = textConfig.Default or ""
                local placeholder = textConfig.Placeholder or "Enter text..."
                local callback = textConfig.Callback or function() end
                local flag = textConfig.Flag
                
                local textbox = Instance.new("Frame")
                textbox.Name = textName
                textbox.Parent = sectionContent
                textbox.BackgroundColor3 = Library.CurrentTheme.ThirdBackground
                textbox.BorderSizePixel = 0
                textbox.Size = UDim2.new(1, 0, 0, IsMobile and 40 or 34)
                
                local textCorner = Instance.new("UICorner")
                textCorner.CornerRadius = UDim.new(0, 6)
                textCorner.Parent = textbox
                
                local textLabel = Instance.new("TextLabel")
                textLabel.Parent = textbox
                textLabel.BackgroundTransparency = 1
                textLabel.Position = UDim2.new(0, 10, 0, 0)
                textLabel.Size = UDim2.new(0.35, 0, 1, 0)
                textLabel.Font = Enum.Font.GothamSemibold
                textLabel.Text = textName
                textLabel.TextColor3 = Library.CurrentTheme.TextColor
                textLabel.TextSize = IsMobile and 11 or 12
                textLabel.TextXAlignment = Enum.TextXAlignment.Left
                textLabel.TextTruncate = Enum.TextTruncate.AtEnd
                
                local textInput = Instance.new("TextBox")
                textInput.Parent = textbox
                textInput.BackgroundColor3 = Library.CurrentTheme.MainBackground
                textInput.BorderSizePixel = 0
                textInput.Position = UDim2.new(0.4, 0, 0, 6)
                textInput.Size = UDim2.new(0.58, 0, 0, IsMobile and 28 or 22)
                textInput.Font = Enum.Font.Gotham
                textInput.PlaceholderText = placeholder
                textInput.PlaceholderColor3 = Library.CurrentTheme.SubTextColor
                textInput.Text = defaultText
                textInput.TextColor3 = Library.CurrentTheme.AccentColor
                textInput.TextSize = IsMobile and 10 or 11
                textInput.ClearTextOnFocus = false
                textInput.TextTruncate = Enum.TextTruncate.AtEnd
                
                local inputCorner = Instance.new("UICorner")
                inputCorner.CornerRadius = UDim.new(0, 5)
                inputCorner.Parent = textInput
                
                local inputPadding = Instance.new("UIPadding")
                inputPadding.Parent = textInput
                inputPadding.PaddingLeft = UDim.new(0, 6)
                inputPadding.PaddingRight = UDim.new(0, 6)
                
                if flag then
                    Library.Flags[flag] = defaultText
                end
                
                textInput.FocusLost:Connect(function(enter)
                    if enter then
                        if flag then
                            Library.Flags[flag] = textInput.Text
                        end
                        
                        pcall(function()
                            callback(textInput.Text)
                        end)
                    end
                end)
                
                textInput.Focused:Connect(function()
                    Tween(textInput, {BackgroundColor3 = Library.CurrentTheme.SecondBackground}, 0.2)
                end)
                
                textInput.FocusLost:Connect(function()
                    Tween(textInput, {BackgroundColor3 = Library.CurrentTheme.MainBackground}, 0.2)
                end)
                
                return {
                    Set = function(value)
                        textInput.Text = value
                        
                        if flag then
                            Library.Flags[flag] = value
                        end
                        
                        pcall(function()
                            callback(value)
                        end)
                    end,
                    Get = function()
                        return textInput.Text
                    end
                }
            end
            
            function Section:AddLabel(text)
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Parent = sectionContent
                label.BackgroundTransparency = 1
                label.Size = UDim2.new(1, 0, 0, IsMobile and 22 or 20)
                label.Font = Enum.Font.Gotham
                label.Text = text
                label.TextColor3 = Library.CurrentTheme.SubTextColor
                label.TextSize = IsMobile and 11 or 12
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextWrapped = true
                label.AutomaticSize = Enum.AutomaticSize.Y
                
                return {
                    Set = function(newText)
                        label.Text = newText
                    end
                }
            end
            
            return Section
        end
        
        if #Window.Tabs == 0 then
            tabContent.Visible = true
            Window.CurrentTab = tabName
            tabButton.BackgroundColor3 = Library.CurrentTheme.AccentColor
            tabText.TextColor3 = Library.CurrentTheme.TextColor
            indicator.Size = UDim2.new(0, 3, 1, 0)
            
            if not IsMobile then
                local iconObj = tabButton:FindFirstChild("Icon")
                if iconObj then
                    iconObj.ImageColor3 = Library.CurrentTheme.TextColor
                end
            end
        end
        
        table.insert(Window.Tabs, Tab)
        return Tab
    end
    
    function Window:AddWatermark(text)
        local watermark = Instance.new("TextLabel")
        watermark.Name = "Watermark"
        watermark.Parent = screenGui
        watermark.BackgroundColor3 = Library.CurrentTheme.SecondBackground
        watermark.BorderSizePixel = 0
        watermark.Position = UDim2.new(0, 8, 0, 8)
        watermark.Size = UDim2.new(0, 180, 0, 26)
        watermark.Font = Enum.Font.GothamBold
        watermark.Text = text or "Drakthon UI"
        watermark.TextColor3 = Library.CurrentTheme.TextColor
        watermark.TextSize = IsMobile and 11 or 12
        
        local watermarkCorner = Instance.new("UICorner")
        watermarkCorner.CornerRadius = UDim.new(0, 7)
        watermarkCorner.Parent = watermark
        
        local watermarkStroke = Instance.new("UIStroke")
        watermarkStroke.Parent = watermark
        watermarkStroke.Color = Library.CurrentTheme.AccentColor
        watermarkStroke.Thickness = 1
        watermarkStroke.Transparency = 0.7
        
        return {
            Set = function(newText)
                watermark.Text = newText
            end,
            Remove = function()
                watermark:Destroy()
            end
        }
    end
    
    Tween(mainContainer, {Size = windowSize}, 0.5, Enum.EasingStyle.Back)
    
    task.delay(0.6, function()
        Library:Notify({
            Title = "Welcome!",
            Description = windowTitle .. " loaded successfully",
            Type = "Success",
            Duration = 3
        })
    end)
    
    return Window
end

return Library
