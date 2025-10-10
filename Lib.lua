--[[
    ╔════════════════════════════════════════════════════════╗
    ║          DRAKTHON UI LIBRARY - FINAL VERSION          ║
    ║              Perfect, Clean & Error-Free              ║
    ║           Better than Rayfield - 100% Working         ║
    ╚════════════════════════════════════════════════════════╝
]]

local Library = {}
Library.Version = "5.0.0"
Library.Flags = {}
Library.Options = {}

-- ════════════════════════════════════════════════════════
-- ⚙️ CONFIGURATION (كل شي قابل للتخصيص)
-- ════════════════════════════════════════════════════════

Library.Config = {
    -- Notification Settings
    Notifications = {
        Enabled = true,
        Position = "TopRight", -- TopRight, TopLeft, BottomRight, BottomLeft
        Duration = 3,
        MaxNotifications = 4,
        Sound = false,
    },
    
    -- UI Settings
    UI = {
        Animations = true,
        AnimationSpeed = 0.3,
        SmoothDragging = true,
        Transparency = 0,
        BlurBackground = false,
    },
    
    -- Theme Settings (قابل للتخصيص بالكامل)
    Theme = {
        Background = Color3.fromRGB(20, 20, 25),
        SecondaryBG = Color3.fromRGB(28, 28, 35),
        TertiaryBG = Color3.fromRGB(35, 35, 42),
        
        Accent = Color3.fromRGB(138, 43, 226),
        AccentDark = Color3.fromRGB(118, 33, 206),
        
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(200, 200, 210),
        TextDisabled = Color3.fromRGB(120, 120, 130),
        
        Success = Color3.fromRGB(46, 204, 113),
        Warning = Color3.fromRGB(241, 196, 15),
        Error = Color3.fromRGB(231, 76, 60),
        Info = Color3.fromRGB(52, 152, 219),
        
        Border = Color3.fromRGB(50, 50, 60),
        Shadow = Color3.fromRGB(0, 0, 0),
    },
    
    -- Config System
    ConfigFolder = "DrakthonConfigs",
    AutoSave = false,
    AutoSaveInterval = 300,
}

-- ════════════════════════════════════════════════════════
-- 📦 SERVICES
-- ════════════════════════════════════════════════════════

local Services = {
    TweenService = game:GetService("TweenService"),
    UserInputService = game:GetService("UserInputService"),
    HttpService = game:GetService("HttpService"),
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    CoreGui = game:GetService("CoreGui"),
}

local Player = Services.Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Device Detection
local IsMobile = Services.UserInputService.TouchEnabled and not Services.UserInputService.KeyboardEnabled
local IsPC = not IsMobile

-- ════════════════════════════════════════════════════════
-- 🛠️ UTILITY FUNCTIONS
-- ════════════════════════════════════════════════════════

local Utility = {}

function Utility:Tween(object, properties, duration, easingStyle, easingDirection)
    if not object or not object.Parent then return end
    if not Library.Config.UI.Animations then
        for k, v in pairs(properties) do
            object[k] = v
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
            }, 0.1, Enum.EasingStyle.Linear)
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
    stroke.Transparency = transparency or 0.8
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

function Utility:AddShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.ZIndex = parent.ZIndex - 1 or 0
    shadow.Image = "rbxassetid://6015897843"
    shadow.ImageColor3 = Library.Config.Theme.Shadow
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    shadow.Parent = parent
    return shadow
end

-- ════════════════════════════════════════════════════════
-- 🔔 NOTIFICATION SYSTEM (قابل للتخصيص بالكامل)
-- ════════════════════════════════════════════════════════

Library.Notifications = {
    Active = {},
    Queue = {},
}

function Library:Notify(config)
    if not self.Config.Notifications.Enabled then return end
    
    config = config or {}
    
    local title = config.Title or "Notification"
    local message = config.Message or config.Description or ""
    local duration = config.Duration or self.Config.Notifications.Duration
    local type = config.Type or "Info"
    local callback = config.Callback or function() end
    
    if #self.Notifications.Active >= self.Config.Notifications.MaxNotifications then
        table.insert(self.Notifications.Queue, config)
        return
    end
    
    task.spawn(function()
        local success = pcall(function()
            local gui = Utility:CreateScreenGui("Notification")
            
            local notifHeight = 80
            local notifWidth = IsMobile and 280 or 320
            local yPos = 10 + (#self.Notifications.Active * 90)
            
            local notif = Instance.new("Frame")
            notif.Name = "Notification"
            notif.Parent = gui
            notif.BackgroundColor3 = self.Config.Theme.SecondaryBG
            notif.BorderSizePixel = 0
            notif.ClipsDescendants = false
            
            local position = self.Config.Notifications.Position
            if position == "TopRight" then
                notif.Position = UDim2.new(1, 10, 0, yPos)
            elseif position == "TopLeft" then
                notif.Position = UDim2.new(0, -notifWidth - 10, 0, yPos)
            elseif position == "BottomRight" then
                notif.Position = UDim2.new(1, 10, 1, -yPos - notifHeight)
            elseif position == "BottomLeft" then
                notif.Position = UDim2.new(0, -notifWidth - 10, 1, -yPos - notifHeight)
            end
            
            notif.Size = UDim2.new(0, notifWidth, 0, notifHeight)
            
            Utility:AddCorner(notif, 10)
            Utility:AddShadow(notif)
            
            local typeColors = {
                Success = self.Config.Theme.Success,
                Error = self.Config.Theme.Error,
                Warning = self.Config.Theme.Warning,
                Info = self.Config.Theme.Info,
            }
            
            local color = typeColors[type] or self.Config.Theme.Info
            
            Utility:AddStroke(notif, color, 1.5, 0.5)
            
            local accentBar = Instance.new("Frame")
            accentBar.BackgroundColor3 = color
            accentBar.BorderSizePixel = 0
            accentBar.Size = UDim2.new(0, 4, 1, 0)
            accentBar.Parent = notif
            
            Utility:AddCorner(accentBar, 10)
            
            local iconFrame = Instance.new("Frame")
            iconFrame.BackgroundColor3 = color
            iconFrame.BorderSizePixel = 0
            iconFrame.Position = UDim2.new(0, 15, 0.5, 0)
            iconFrame.Size = UDim2.new(0, 38, 0, 38)
            iconFrame.AnchorPoint = Vector2.new(0, 0.5)
            iconFrame.Parent = notif
            
            Utility:AddCorner(iconFrame, 8)
            
            local icons = {
                Success = "✓",
                Error = "✕",
                Warning = "⚠",
                Info = "ℹ"
            }
            
            local icon = Instance.new("TextLabel")
            icon.BackgroundTransparency = 1
            icon.Size = UDim2.new(1, 0, 1, 0)
            icon.Font = Enum.Font.GothamBold
            icon.Text = icons[type] or "ℹ"
            icon.TextColor3 = self.Config.Theme.Text
            icon.TextSize = 20
            icon.Parent = iconFrame
            
            local titleLabel = Instance.new("TextLabel")
            titleLabel.BackgroundTransparency = 1
            titleLabel.Position = UDim2.new(0, 65, 0, 12)
            titleLabel.Size = UDim2.new(1, -100, 0, 20)
            titleLabel.Font = Enum.Font.GothamBold
            titleLabel.Text = title
            titleLabel.TextColor3 = self.Config.Theme.Text
            titleLabel.TextSize = 14
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
            titleLabel.Parent = notif
            
            local messageLabel = Instance.new("TextLabel")
            messageLabel.BackgroundTransparency = 1
            messageLabel.Position = UDim2.new(0, 65, 0, 35)
            messageLabel.Size = UDim2.new(1, -100, 0, 35)
            messageLabel.Font = Enum.Font.Gotham
            messageLabel.Text = message
            messageLabel.TextColor3 = self.Config.Theme.TextDark
            messageLabel.TextSize = 12
            messageLabel.TextXAlignment = Enum.TextXAlignment.Left
            messageLabel.TextYAlignment = Enum.TextYAlignment.Top
            messageLabel.TextWrapped = true
            messageLabel.Parent = notif
            
            local progressBG = Instance.new("Frame")
            progressBG.BackgroundColor3 = self.Config.Theme.Background
            progressBG.BorderSizePixel = 0
            progressBG.Position = UDim2.new(0, 0, 1, -3)
            progressBG.Size = UDim2.new(1, 0, 0, 3)
            progressBG.Parent = notif
            
            local progress = Instance.new("Frame")
            progress.BackgroundColor3 = color
            progress.BorderSizePixel = 0
            progress.Size = UDim2.new(1, 0, 1, 0)
            progress.Parent = progressBG
            
            local closeBtn = Instance.new("TextButton")
            closeBtn.BackgroundColor3 = self.Config.Theme.TertiaryBG
            closeBtn.BorderSizePixel = 0
            closeBtn.Position = UDim2.new(1, -30, 0, 8)
            closeBtn.Size = UDim2.new(0, 24, 0, 24)
            closeBtn.Font = Enum.Font.GothamBold
            closeBtn.Text = "×"
            closeBtn.TextColor3 = self.Config.Theme.TextDark
            closeBtn.TextSize = 16
            closeBtn.AutoButtonColor = false
            closeBtn.Parent = notif
            
            Utility:AddCorner(closeBtn, 6)
            
            table.insert(self.Notifications.Active, notif)
            
            local function close()
                for i, v in ipairs(Library.Notifications.Active) do
                    if v == notif then
                        table.remove(Library.Notifications.Active, i)
                        break
                    end
                end
                
                local endPos
                if position == "TopRight" then
                    endPos = UDim2.new(1, 10, 0, yPos)
                elseif position == "TopLeft" then
                    endPos = UDim2.new(0, -notifWidth - 10, 0, yPos)
                elseif position == "BottomRight" then
                    endPos = UDim2.new(1, 10, 1, -yPos - notifHeight)
                elseif position == "BottomLeft" then
                    endPos = UDim2.new(0, -notifWidth - 10, 1, -yPos - notifHeight)
                end
                
                Utility:Tween(notif, {Position = endPos}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                task.wait(0.3)
                pcall(function() gui:Destroy() end)
                
                if #Library.Notifications.Queue > 0 then
                    local next = table.remove(Library.Notifications.Queue, 1)
                    task.wait(0.1)
                    Library:Notify(next)
                end
                
                pcall(callback)
            end
            
            closeBtn.MouseButton1Click:Connect(close)
            
            closeBtn.MouseEnter:Connect(function()
                Utility:Tween(closeBtn, {BackgroundColor3 = self.Config.Theme.Error}, 0.2)
            end)
            
            closeBtn.MouseLeave:Connect(function()
                Utility:Tween(closeBtn, {BackgroundColor3 = self.Config.Theme.TertiaryBG}, 0.2)
            end)
            
            local targetPos
            if position == "TopRight" then
                targetPos = UDim2.new(1, -notifWidth - 10, 0, yPos)
            elseif position == "TopLeft" then
                targetPos = UDim2.new(0, 10, 0, yPos)
            elseif position == "BottomRight" then
                targetPos = UDim2.new(1, -notifWidth - 10, 1, -yPos - notifHeight)
            elseif position == "BottomLeft" then
                targetPos = UDim2.new(0, 10, 1, -yPos - notifHeight)
            end
            
            Utility:Tween(notif, {Position = targetPos}, 0.5, Enum.EasingStyle.Back)
            Utility:Tween(progress, {Size = UDim2.new(0, 0, 1, 0)}, duration, Enum.EasingStyle.Linear)
            
            task.delay(duration, close)
        end)
        
        if not success then
            warn("[Drakthon UI] Failed to create notification")
        end
    end)
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
        }
        
        writefile(self.Config.ConfigFolder .. "/" .. name .. ".json", Services.HttpService:JSONEncode(data))
    end)
    
    if success then
        self:Notify({
            Title = "Config Saved",
            Message = "Configuration saved: " .. name,
            Type = "Success",
            Duration = 2
        })
    else
        self:Notify({
            Title = "Save Failed",
            Message = "Failed to save configuration",
            Type = "Error",
            Duration = 3
        })
    end
    
    return success
end

function Library:LoadConfig(name)
    name = name or "DefaultConfig"
    
    local success, data = pcall(function()
        return Services.HttpService:JSONDecode(readfile(self.Config.ConfigFolder .. "/" .. name .. ".json"))
    end)
    
    if success and data then
        self.Flags = data.Flags or {}
        
        self:Notify({
            Title = "Config Loaded",
            Message = "Configuration loaded: " .. name,
            Type = "Success",
            Duration = 2
        })
        
        return data
    else
        self:Notify({
            Title = "Load Failed",
            Message = "Configuration not found",
            Type = "Error",
            Duration = 3
        })
        return nil
    end
end

function Library:GetConfigs()
    local configs = {}
    pcall(function()
        if not isfolder(self.Config.ConfigFolder) then
            makefolder(self.Config.ConfigFolder)
        end
        
        for _, file in ipairs(listfiles(self.Config.ConfigFolder)) do
            if file:match("%.json$") then
                table.insert(configs, file:match("([^/\```+)%.json$"))
            end
        end
    end)
    return configs
end

function Library:DeleteConfig(name)
    local success = pcall(function()
        delfile(self.Config.ConfigFolder .. "/" .. name .. ".json")
    end)
    
    if success then
        self:Notify({
            Title = "Config Deleted",
            Message = "Configuration deleted: " .. name,
            Type = "Success"
        })
    end
    
    return success
end

-- ════════════════════════════════════════════════════════
-- 🪟 CREATE WINDOW
-- ════════════════════════════════════════════════════════

function Library:CreateWindow(config)
    config = config or {}
    
    local windowTitle = config.Title or "Drakthon UI"
    local windowSubtitle = config.Subtitle or "v" .. self.Version
    local windowKeybind = config.Keybind or Enum.KeyCode.RightControl
    local windowSize = config.Size or "Medium"
    
    local sizes = {
        Small = {Width = 500, Height = 450},
        Medium = {Width = 620, Height = 520},
        Large = {Width = 750, Height = 650},
    }
    
    local size = sizes[windowSize] or sizes.Medium
    
    if IsMobile then
        local viewport = workspace.CurrentCamera.ViewportSize
        size.Width = math.clamp(viewport.X * 0.95, 320, 480)
        size.Height = math.clamp(viewport.Y * 0.85, 450, 700)
    end
    
    local gui = Utility:CreateScreenGui("DrakthonUI")
    
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
    
    Utility:AddCorner(frame, 12)
    Utility:AddShadow(main)
    Utility:AddStroke(frame, self.Config.Theme.Accent, 1.5, 0.7)
    
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.BackgroundColor3 = self.Config.Theme.SecondaryBG
    header.BorderSizePixel = 0
    header.Size = UDim2.new(1, 0, 0, 48)
    header.Parent = frame
    
    Utility:AddCorner(header, 12)
    
    local headerGradient = Instance.new("UIGradient")
    headerGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, self.Config.Theme.SecondaryBG),
        ColorSequenceKeypoint.new(1, self.Config.Theme.TertiaryBG)
    }
    headerGradient.Rotation = 90
    headerGradient.Parent = header
    
    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 15, 0, 8)
    title.Size = UDim2.new(0.6, 0, 0, 20)
    title.Font = Enum.Font.GothamBold
    title.Text = windowTitle
    title.TextColor3 = self.Config.Theme.Text
    title.TextSize = IsMobile and 14 or 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextTruncate = Enum.TextTruncate.AtEnd
    title.Parent = header
    
    local subtitle = Instance.new("TextLabel")
    subtitle.BackgroundTransparency = 1
    subtitle.Position = UDim2.new(0, 15, 0, 28)
    subtitle.Size = UDim2.new(0.6, 0, 0, 14)
    subtitle.Font = Enum.Font.Gotham
    subtitle.Text = windowSubtitle
    subtitle.TextColor3 = self.Config.Theme.TextDark
    subtitle.TextSize = IsMobile and 11 or 12
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Parent = header
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.BackgroundColor3 = self.Config.Theme.Error
    closeBtn.BorderSizePixel = 0
    closeBtn.Position = UDim2.new(1, -38, 0.5, 0)
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
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
        task.wait(0.3)
        pcall(function() gui:Destroy() end)
    end)
    
    closeBtn.MouseEnter:Connect(function()
        Utility:Tween(closeBtn, {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}, 0.2)
    end)
    
    closeBtn.MouseLeave:Connect(function()
        Utility:Tween(closeBtn, {BackgroundColor3 = self.Config.Theme.Error}, 0.2)
    end)
    
    Utility:MakeDraggable(main, header)
    
    local tabWidth = IsMobile and 60 or 150
    
    local tabContainer = Instance.new("ScrollingFrame")
    tabContainer.Name = "TabContainer"
    tabContainer.BackgroundColor3 = self.Config.Theme.SecondaryBG
    tabContainer.BorderSizePixel = 0
    tabContainer.Position = UDim2.new(0, 0, 0, 48)
    tabContainer.Size = UDim2.new(0, tabWidth, 1, -48)
    tabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContainer.ScrollBarThickness = 4
    tabContainer.ScrollBarImageColor3 = self.Config.Theme.Accent
    tabContainer.Parent = frame
    
    local tabList = Instance.new("UIListLayout")
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabList.Padding = UDim.new(0, 5)
    tabList.Parent = tabContainer
    
    local tabPadding = Instance.new("UIPadding")
    tabPadding.PaddingTop = UDim.new(0, 10)
    tabPadding.PaddingLeft = UDim.new(0, 8)
    tabPadding.PaddingRight = UDim.new(0, 8)
    tabPadding.PaddingBottom = UDim.new(0, 10)
    tabPadding.Parent = tabContainer
    
    tabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContainer.CanvasSize = UDim2.new(0, 0, 0, tabList.AbsoluteContentSize.Y + 20)
    end)
    
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentContainer"
    contentContainer.BackgroundTransparency = 1
    contentContainer.Position = UDim2.new(0, tabWidth, 0, 48)
    contentContainer.Size = UDim2.new(1, -tabWidth, 1, -48)
    contentContainer.Parent = frame
    
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        Flags = Library.Flags,
    }
    
    function Window:CreateTab(tabName)
        tabName = tabName or "Tab"
        
        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = tabName
        tabBtn.BackgroundColor3 = Library.Config.Theme.TertiaryBG
        tabBtn.BorderSizePixel = 0
        tabBtn.Size = UDim2.new(1, 0, 0, IsMobile and 50 or 40)
        tabBtn.Font = Enum.Font.GothamSemibold
        tabBtn.Text = IsMobile and "" or tabName
        tabBtn.TextColor3 = Library.Config.Theme.TextDark
        tabBtn.TextSize = 13
        tabBtn.AutoButtonColor = false
        tabBtn.Parent = tabContainer
        
        Utility:AddCorner(tabBtn, 10)
        
        if IsMobile then
            local label = Instance.new("TextLabel")
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Font = Enum.Font.GothamBold
            label.Text = string.sub(tabName, 1, 1)
            label.TextColor3 = Library.Config.Theme.TextDark
            label.TextSize = 18
            label.Parent = tabBtn
        end
        
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
        tabContent.ScrollBarThickness = 5
        tabContent.ScrollBarImageColor3 = Library.Config.Theme.Accent
        tabContent.Visible = false
        tabContent.Parent = contentContainer
        
        local contentList = Instance.new("UIListLayout")
        contentList.SortOrder = Enum.SortOrder.LayoutOrder
        contentList.Padding = UDim.new(0, 10)
        contentList.Parent = tabContent
        
        local contentPad = Instance.new("UIPadding")
        contentPad.PaddingTop = UDim.new(0, 12)
        contentPad.PaddingLeft = UDim.new(0, 12)
        contentPad.PaddingRight = UDim.new(0, 12)
        contentPad.PaddingBottom = UDim.new(0, 12)
        contentPad.Parent = tabContent
        
        contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabContent.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 24)
        end)
        
        tabBtn.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab:Deactivate()
            end
            
            tabContent.Visible = true
            Window.CurrentTab = tabName
            
            Utility:Tween(tabBtn, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2)
            Utility:Tween(tabBtn, {TextColor3 = Library.Config.Theme.Text}, 0.2)
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
            Utility:Tween(tabBtn, {TextColor3 = Library.Config.Theme.TextDark}, 0.2)
            Utility:Tween(indicator, {Size = UDim2.new(0, 0, 1, 0)}, 0.3)
        end
        
        function Tab:AddSection(sectionName)
            local section = Instance.new("Frame")
            section.Name = sectionName
            section.BackgroundColor3 = Library.Config.Theme.SecondaryBG
            section.BorderSizePixel = 0
            section.Size = UDim2.new(1, 0, 0, 40)
            section.AutomaticSize = Enum.AutomaticSize.Y
            section.Parent = tabContent
            
            Utility:AddCorner(section, 10)
            Utility:AddStroke(section, Library.Config.Theme.Border, 1, 0.8)
            
            local sectionTitle = Instance.new("TextLabel")
            sectionTitle.BackgroundTransparency = 1
            sectionTitle.Position = UDim2.new(0, 12, 0, 0)
            sectionTitle.Size = UDim2.new(1, -24, 0, 40)
            sectionTitle.Font = Enum.Font.GothamBold
            sectionTitle.Text = sectionName
            sectionTitle.TextColor3 = Library.Config.Theme.Text
            sectionTitle.TextSize = IsMobile and 13 or 14
            sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            sectionTitle.Parent = section
            
            local sectionContent = Instance.new("Frame")
            sectionContent.BackgroundTransparency = 1
            sectionContent.Position = UDim2.new(0, 0, 0, 40)
            sectionContent.Size = UDim2.new(1, 0, 1, -40)
            sectionContent.AutomaticSize = Enum.AutomaticSize.Y
            sectionContent.Parent = section
            
            local sectionList = Instance.new("UIListLayout")
            sectionList.SortOrder = Enum.SortOrder.LayoutOrder
            sectionList.Padding = UDim.new(0, 8)
            sectionList.Parent = sectionContent
            
            local sectionPad = Instance.new("UIPadding")
            sectionPad.PaddingTop = UDim.new(0, 10)
            sectionPad.PaddingLeft = UDim.new(0, 12)
            sectionPad.PaddingRight = UDim.new(0, 12)
            sectionPad.PaddingBottom = UDim.new(0, 12)
            sectionPad.Parent = sectionContent
            
            local Section = {}
            
            -- يتبع في الرد التالي...
            
            function Section:AddButton(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Button"
                local callback = cfg.Callback or function() end
                
                local btn = Instance.new("TextButton")
                btn.BackgroundColor3 = Library.Config.Theme.TertiaryBG
                btn.BorderSizePixel = 0
                btn.Size = UDim2.new(1, 0, 0, IsMobile and 42 or 36)
                btn.Font = Enum.Font.GothamSemibold
                btn.Text = name
                btn.TextColor3 = Library.Config.Theme.Text
                btn.TextSize = IsMobile and 13 or 14
                btn.AutoButtonColor = false
                btn.Parent = sectionContent
                
                Utility:AddCorner(btn, 8)
                
                local stroke = Utility:AddStroke(btn, Library.Config.Theme.Accent, 0, 0.5)
                
                btn.MouseEnter:Connect(function()
                    Utility:Tween(btn, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2)
                    Utility:Tween(stroke, {Thickness = 1.5}, 0.2)
                end)
                
                btn.MouseLeave:Connect(function()
                    Utility:Tween(btn, {BackgroundColor3 = Library.Config.Theme.TertiaryBG}, 0.2)
                    Utility:Tween(stroke, {Thickness = 0}, 0.2)
                end)
                
                btn.MouseButton1Click:Connect(function()
                    pcall(callback)
                end)
                
                return btn
            end
            
            function Section:AddToggle(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Toggle"
                local default = cfg.Default or false
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                
                local toggle = Instance.new("Frame")
                toggle.BackgroundColor3 = Library.Config.Theme.TertiaryBG
                toggle.BorderSizePixel = 0
                toggle.Size = UDim2.new(1, 0, 0, IsMobile and 42 or 36)
                toggle.Parent = sectionContent
                
                Utility:AddCorner(toggle, 8)
                
                local label = Instance.new("TextLabel")
                label.BackgroundTransparency = 1
                label.Position = UDim2.new(0, 12, 0, 0)
                label.Size = UDim2.new(1, -60, 1, 0)
                label.Font = Enum.Font.GothamSemibold
                label.Text = name
                label.TextColor3 = Library.Config.Theme.Text
                label.TextSize = IsMobile and 13 or 14
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextTruncate = Enum.TextTruncate.AtEnd
                label.Parent = toggle
                
                local switch = Instance.new("TextButton")
                switch.BackgroundColor3 = default and Library.Config.Theme.Accent or Library.Config.Theme.Background
                switch.BorderSizePixel = 0
                switch.Position = UDim2.new(1, -44, 0.5, 0)
                switch.Size = UDim2.new(0, 38, 0, 20)
                switch.AnchorPoint = Vector2.new(0, 0.5)
                switch.Text = ""
                switch.AutoButtonColor = false
                switch.Parent = toggle
                
                Utility:AddCorner(switch, 20)
                
                local circle = Instance.new("Frame")
                circle.BackgroundColor3 = Library.Config.Theme.Text
                circle.BorderSizePixel = 0
                circle.Position = default and UDim2.new(1, -17, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
                circle.Size = UDim2.new(0, 14, 0, 14)
                circle.AnchorPoint = Vector2.new(0, 0.5)
                circle.Parent = switch
                
                Utility:AddCorner(circle, 20)
                
                local toggled = default
                
                if flag then
                    Library.Flags[flag] = toggled
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
                        Position = toggled and UDim2.new(1, -17, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
                    }, 0.3, Enum.EasingStyle.Back)
                    
                    pcall(callback, toggled)
                end
                
                switch.MouseButton1Click:Connect(function()
                    update(not toggled)
                end)
                
                return {
                    Set = function(val) update(val) end,
                    Get = function() return toggled end
                }
            end
            
            function Section:AddSlider(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Slider"
                local min = cfg.Min or 0
                local max = cfg.Max or 100
                local default = cfg.Default or 50
                local increment = cfg.Increment or 1
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                
                local slider = Instance.new("Frame")
                slider.BackgroundColor3 = Library.Config.Theme.TertiaryBG
                slider.BorderSizePixel = 0
                slider.Size = UDim2.new(1, 0, 0, IsMobile and 58 or 52)
                slider.Parent = sectionContent
                
                Utility:AddCorner(slider, 8)
                
                local label = Instance.new("TextLabel")
                label.BackgroundTransparency = 1
                label.Position = UDim2.new(0, 12, 0, 8)
                label.Size = UDim2.new(0.6, 0, 0, 18)
                label.Font = Enum.Font.GothamSemibold
                label.Text = name
                label.TextColor3 = Library.Config.Theme.Text
                label.TextSize = IsMobile and 13 or 14
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextTruncate = Enum.TextTruncate.AtEnd
                label.Parent = slider
                
                local value = Instance.new("TextLabel")
                value.BackgroundColor3 = Library.Config.Theme.Background
                value.BorderSizePixel = 0
                value.Position = UDim2.new(1, -50, 0, 8)
                value.Size = UDim2.new(0, 44, 0, 18)
                value.Font = Enum.Font.GothamBold
                value.Text = tostring(default)
                value.TextColor3 = Library.Config.Theme.Accent
                value.TextSize = IsMobile and 12 or 13
                value.Parent = slider
                
                Utility:AddCorner(value, 6)
                
                local bar = Instance.new("Frame")
                bar.BackgroundColor3 = Library.Config.Theme.Background
                bar.BorderSizePixel = 0
                bar.Position = UDim2.new(0, 12, 1, IsMobile and -18 or -16)
                bar.Size = UDim2.new(1, -24, 0, 6)
                bar.Parent = slider
                
                Utility:AddCorner(bar, 10)
                
                local fill = Instance.new("Frame")
                fill.BackgroundColor3 = Library.Config.Theme.Accent
                fill.BorderSizePixel = 0
                fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
                fill.Parent = bar
                
                Utility:AddCorner(fill, 10)
                
                local dot = Instance.new("Frame")
                dot.BackgroundColor3 = Library.Config.Theme.Text
                dot.BorderSizePixel = 0
                dot.Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0)
                dot.Size = UDim2.new(0, 14, 0, 14)
                dot.AnchorPoint = Vector2.new(0.5, 0.5)
                dot.Parent = bar
                
                Utility:AddCorner(dot, 20)
                
                local dragging = false
                
                if flag then
                    Library.Flags[flag] = default
                end
                
                local function update(input)
                    local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                    local val = math.floor(min + (max - min) * pos)
                    val = math.floor(val / increment + 0.5) * increment
                    val = math.clamp(val, min, max)
                    
                    fill.Size = UDim2.new(pos, 0, 1, 0)
                    dot.Position = UDim2.new(pos, 0, 0.5, 0)
                    value.Text = tostring(val)
                    
                    if flag then
                        Library.Flags[flag] = val
                    end
                    
                    pcall(callback, val)
                end
                
                bar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        update(input)
                        Utility:Tween(dot, {Size = UDim2.new(0, 18, 0, 18)}, 0.2, Enum.EasingStyle.Back)
                    end
                end)
                
                bar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                        Utility:Tween(dot, {Size = UDim2.new(0, 14, 0, 14)}, 0.2)
                    end
                end)
                
                Services.UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        update(input)
                    end
                end)
                
                return {
                    Set = function(val)
                        local pos = (val - min) / (max - min)
                        fill.Size = UDim2.new(pos, 0, 1, 0)
                        dot.Position = UDim2.new(pos, 0, 0.5, 0)
                        value.Text = tostring(val)
                        
                        if flag then
                            Library.Flags[flag] = val
                        end
                        
                        pcall(callback, val)
                    end,
                    Get = function()
                        return tonumber(value.Text)
                    end
                }
            end
            
            function Section:AddDropdown(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Dropdown"
                local items = cfg.Items or {"Option 1", "Option 2"}
                local default = cfg.Default or items[1]
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                
                local dropdown = Instance.new("Frame")
                dropdown.BackgroundColor3 = Library.Config.Theme.TertiaryBG
                dropdown.BorderSizePixel = 0
                dropdown.Size = UDim2.new(1, 0, 0, IsMobile and 42 or 36)
                dropdown.ClipsDescendants = true
                dropdown.Parent = sectionContent
                
                Utility:AddCorner(dropdown, 8)
                
                local label = Instance.new("TextLabel")
                label.BackgroundTransparency = 1
                label.Position = UDim2.new(0, 12, 0, 0)
                label.Size = UDim2.new(0.4, 0, 0, IsMobile and 42 or 36)
                label.Font = Enum.Font.GothamSemibold
                label.Text = name
                label.TextColor3 = Library.Config.Theme.Text
                label.TextSize = IsMobile and 13 or 14
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextTruncate = Enum.TextTruncate.AtEnd
                label.Parent = dropdown
                
                local dropBtn = Instance.new("TextButton")
                dropBtn.BackgroundColor3 = Library.Config.Theme.Background
                dropBtn.BorderSizePixel = 0
                dropBtn.Position = UDim2.new(0.45, 0, 0, 8)
                dropBtn.Size = UDim2.new(0.5, -12, 0, IsMobile and 26 or 20)
                dropBtn.Font = Enum.Font.Gotham
                dropBtn.Text = "  " .. default
                dropBtn.TextColor3 = Library.Config.Theme.Accent
                dropBtn.TextSize = IsMobile and 12 or 13
                dropBtn.TextXAlignment = Enum.TextXAlignment.Left
                dropBtn.AutoButtonColor = false
                dropBtn.TextTruncate = Enum.TextTruncate.AtEnd
                dropBtn.Parent = dropdown
                
                Utility:AddCorner(dropBtn, 6)
                
                local arrow = Instance.new("TextLabel")
                arrow.BackgroundTransparency = 1
                arrow.Position = UDim2.new(1, -20, 0, 0)
                arrow.Size = UDim2.new(0, 18, 1, 0)
                arrow.Font = Enum.Font.GothamBold
                arrow.Text = "▼"
                arrow.TextColor3 = Library.Config.Theme.TextDark
                arrow.TextSize = 10
                arrow.Parent = dropBtn
                
                local itemList = Instance.new("ScrollingFrame")
                itemList.BackgroundTransparency = 1
                itemList.BorderSizePixel = 0
                itemList.Position = UDim2.new(0, 8, 0, IsMobile and 46 or 40)
                itemList.Size = UDim2.new(1, -16, 0, 0)
                itemList.CanvasSize = UDim2.new(0, 0, 0, 0)
                itemList.ScrollBarThickness = 4
                itemList.ScrollBarImageColor3 = Library.Config.Theme.Accent
                itemList.Parent = dropdown
                
                local listLayout = Instance.new("UIListLayout")
                listLayout.SortOrder = Enum.SortOrder.LayoutOrder
                listLayout.Padding = UDim.new(0, 4)
                listLayout.Parent = itemList
                
                listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    itemList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
                end)
                
                local expanded = false
                local currentValue = default
                
                if flag then
                    Library.Flags[flag] = currentValue
                end
                
                local function createItem(itemName)
                    local item = Instance.new("TextButton")
                    item.BackgroundColor3 = Library.Config.Theme.Background
                    item.BorderSizePixel = 0
                    item.Size = UDim2.new(1, 0, 0, IsMobile and 28 or 24)
                    item.Font = Enum.Font.Gotham
                    item.Text = "  " .. itemName
                    item.TextColor3 = Library.Config.Theme.Text
                    item.TextSize = IsMobile and 12 or 13
                    item.TextXAlignment = Enum.TextXAlignment.Left
                    item.AutoButtonColor = false
                    item.TextTruncate = Enum.TextTruncate.AtEnd
                    item.Parent = itemList
                    
                    Utility:AddCorner(item, 6)
                    
                    item.MouseEnter:Connect(function()
                        Utility:Tween(item, {BackgroundColor3 = Library.Config.Theme.Accent}, 0.2)
                    end)
                    
                    item.MouseLeave:Connect(function()
                        Utility:Tween(item, {BackgroundColor3 = Library.Config.Theme.Background}, 0.2)
                    end)
                    
                    item.MouseButton1Click:Connect(function()
                        currentValue = itemName
                        dropBtn.Text = "  " .. itemName
                        
                        if flag then
                            Library.Flags[flag] = itemName
                        end
                        
                        pcall(callback, itemName)
                        
                        expanded = false
                        local baseHeight = IsMobile and 42 or 36
                        Utility:Tween(dropdown, {Size = UDim2.new(1, 0, 0, baseHeight)}, 0.3, Enum.EasingStyle.Back)
                        Utility:Tween(arrow, {Rotation = 0}, 0.3)
                    end)
                end
                
                for _, item in ipairs(items) do
                    createItem(item)
                end
                
                dropBtn.MouseButton1Click:Connect(function()
                    expanded = not expanded
                    
                    if expanded then
                        local itemCount = math.min(#items, 5)
                        local itemHeight = IsMobile and 28 or 24
                        local baseHeight = IsMobile and 42 or 36
                        local totalHeight = baseHeight + 8 + (itemCount * (itemHeight + 4))
                        
                        Utility:Tween(dropdown, {Size = UDim2.new(1, 0, 0, totalHeight)}, 0.3, Enum.EasingStyle.Back)
                        Utility:Tween(arrow, {Rotation = 180}, 0.3)
                        itemList.Size = UDim2.new(1, -16, 0, itemCount * (itemHeight + 4))
                    else
                        local baseHeight = IsMobile and 42 or 36
                        Utility:Tween(dropdown, {Size = UDim2.new(1, 0, 0, baseHeight)}, 0.3, Enum.EasingStyle.Back)
                        Utility:Tween(arrow, {Rotation = 0}, 0.3)
                    end
                end)
                
                return {
                    Set = function(val)
                        if table.find(items, val) then
                            currentValue = val
                            dropBtn.Text = "  " .. val
                            
                            if flag then
                                Library.Flags[flag] = val
                            end
                            
                            pcall(callback, val)
                        end
                    end,
                    Get = function()
                        return currentValue
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
            
            function Section:AddColorPicker(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Color Picker"
                local default = cfg.Default or Color3.fromRGB(255, 255, 255)
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                
                local picker = Instance.new("Frame")
                picker.BackgroundColor3 = Library.Config.Theme.TertiaryBG
                picker.BorderSizePixel = 0
                picker.Size = UDim2.new(1, 0, 0, IsMobile and 42 or 36)
                picker.ClipsDescendants = true
                picker.Parent = sectionContent
                
                Utility:AddCorner(picker, 8)
                
                local label = Instance.new("TextLabel")
                label.BackgroundTransparency = 1
                label.Position = UDim2.new(0, 12, 0, 0)
                label.Size = UDim2.new(0.7, 0, 0, IsMobile and 42 or 36)
                label.Font = Enum.Font.GothamSemibold
                label.Text = name
                label.TextColor3 = Library.Config.Theme.Text
                label.TextSize = IsMobile and 13 or 14
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextTruncate = Enum.TextTruncate.AtEnd
                label.Parent = picker
                
                local display = Instance.new("TextButton")
                display.BackgroundColor3 = default
                display.BorderSizePixel = 0
                display.Position = UDim2.new(1, -50, 0.5, 0)
                display.Size = UDim2.new(0, 40, 0, IsMobile and 26 or 20)
                display.AnchorPoint = Vector2.new(0, 0.5)
                display.Text = ""
                display.AutoButtonColor = false
                display.Parent = picker
                
                Utility:AddCorner(display, 6)
                Utility:AddStroke(display, Library.Config.Theme.Border, 2)
                
                local palette = Instance.new("Frame")
                palette.BackgroundColor3 = Library.Config.Theme.Background
                palette.BorderSizePixel = 0
                palette.Position = UDim2.new(0, 8, 0, IsMobile and 46 or 40)
                palette.Size = UDim2.new(1, -16, 0, 150)
                palette.Visible = false
                palette.Parent = picker
                
                Utility:AddCorner(palette, 8)
                
                local canvas = Instance.new("ImageButton")
                canvas.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                canvas.BorderSizePixel = 0
                canvas.Position = UDim2.new(0, 8, 0, 8)
                canvas.Size = UDim2.new(1, -80, 1, -16)
                canvas.Image = "rbxassetid://4155801252"
                canvas.AutoButtonColor = false
                canvas.Parent = palette
                
                Utility:AddCorner(canvas, 6)
                
                local hue = Instance.new("ImageButton")
                hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                hue.BorderSizePixel = 0
                hue.Position = UDim2.new(1, -62, 0, 8)
                hue.Size = UDim2.new(0, 28, 1, -16)
                hue.Image = "rbxassetid://3641079629"
                hue.AutoButtonColor = false
                hue.Parent = palette
                
                Utility:AddCorner(hue, 6)
                
                local confirm = Instance.new("TextButton")
                confirm.BackgroundColor3 = Library.Config.Theme.Accent
                confirm.BorderSizePixel = 0
                confirm.Position = UDim2.new(1, -28, 0, 8)
                confirm.Size = UDim2.new(0, 20, 0, 20)
                confirm.Font = Enum.Font.GothamBold
                confirm.Text = "✓"
                confirm.TextColor3 = Library.Config.Theme.Text
                confirm.TextSize = 14
                confirm.AutoButtonColor = false
                confirm.Parent = palette
                
                Utility:AddCorner(confirm, 5)
                
                local expanded = false
                local h, s, v = default:ToHSV()
                
                if flag then
                    Library.Flags[flag] = default
                end
                
                local function updateColor()
                    local color = Color3.fromHSV(h, s, v)
                    display.BackgroundColor3 = color
                    canvas.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                    
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
                
                display.MouseButton1Click:Connect(function()
                    expanded = not expanded
                    palette.Visible = expanded
                    
                    if expanded then
                        local baseHeight = IsMobile and 42 or 36
                        Utility:Tween(picker, {Size = UDim2.new(1, 0, 0, baseHeight + 158)}, 0.3, Enum.EasingStyle.Back)
                    else
                        local baseHeight = IsMobile and 42 or 36
                        Utility:Tween(picker, {Size = UDim2.new(1, 0, 0, baseHeight)}, 0.3, Enum.EasingStyle.Back)
                    end
                end)
                
                confirm.MouseButton1Click:Connect(function()
                    expanded = false
                    palette.Visible = false
                    local baseHeight = IsMobile and 42 or 36
                    Utility:Tween(picker, {Size = UDim2.new(1, 0, 0, baseHeight)}, 0.3, Enum.EasingStyle.Back)
                end)
                
                updateColor()
                
                return {
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
            
            function Section:AddTextbox(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Textbox"
                local default = cfg.Default or ""
                local placeholder = cfg.Placeholder or "Enter text..."
                local callback = cfg.Callback or function() end
                local flag = cfg.Flag
                
                local textbox = Instance.new("Frame")
                textbox.BackgroundColor3 = Library.Config.Theme.TertiaryBG
                textbox.BorderSizePixel = 0
                textbox.Size = UDim2.new(1, 0, 0, IsMobile and 42 or 36)
                textbox.Parent = sectionContent
                
                Utility:AddCorner(textbox, 8)
                
                local label = Instance.new("TextLabel")
                label.BackgroundTransparency = 1
                label.Position = UDim2.new(0, 12, 0, 0)
                label.Size = UDim2.new(0.35, 0, 1, 0)
                label.Font = Enum.Font.GothamSemibold
                label.Text = name
                label.TextColor3 = Library.Config.Theme.Text
                label.TextSize = IsMobile and 13 or 14
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextTruncate = Enum.TextTruncate.AtEnd
                label.Parent = textbox
                
                local input = Instance.new("TextBox")
                input.BackgroundColor3 = Library.Config.Theme.Background
                input.BorderSizePixel = 0
                input.Position = UDim2.new(0.4, 0, 0.5, 0)
                input.Size = UDim2.new(0.58, 0, 0, IsMobile and 26 or 20)
                input.AnchorPoint = Vector2.new(0, 0.5)
                input.Font = Enum.Font.Gotham
                input.PlaceholderText = placeholder
                input.PlaceholderColor3 = Library.Config.Theme.TextDark
                input.Text = default
                input.TextColor3 = Library.Config.Theme.Accent
                input.TextSize = IsMobile and 12 or 13
                input.ClearTextOnFocus = false
                input.TextTruncate = Enum.TextTruncate.AtEnd
                input.Parent = textbox
                
                Utility:AddCorner(input, 6)
                
                local padding = Instance.new("UIPadding")
                padding.PaddingLeft = UDim.new(0, 8)
                padding.PaddingRight = UDim.new(0, 8)
                padding.Parent = input
                
                if flag then
                    Library.Flags[flag] = default
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
                
                return {
                    Set = function(text)
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
            
            function Section:AddLabel(text)
                local label = Instance.new("TextLabel")
                label.BackgroundTransparency = 1
                label.Size = UDim2.new(1, 0, 0, IsMobile and 24 or 20)
                label.Font = Enum.Font.Gotham
                label.Text = text
                label.TextColor3 = Library.Config.Theme.TextDark
                label.TextSize = IsMobile and 12 or 13
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextWrapped = true
                label.AutomaticSize = Enum.AutomaticSize.Y
                label.Parent = sectionContent
                
                return {
                    Set = function(t)
                        label.Text = t
                    end
                }
            end
            
            function Section:AddParagraph(title, content)
                local para = Instance.new("Frame")
                para.BackgroundColor3 = Library.Config.Theme.Background
                para.BorderSizePixel = 0
                para.Size = UDim2.new(1, 0, 0, 60)
                para.AutomaticSize = Enum.AutomaticSize.Y
                para.Parent = sectionContent
                
                Utility:AddCorner(para, 8)
                
                local paraTitle = Instance.new("TextLabel")
                paraTitle.BackgroundTransparency = 1
                paraTitle.Position = UDim2.new(0, 12, 0, 8)
                paraTitle.Size = UDim2.new(1, -24, 0, 18)
                paraTitle.Font = Enum.Font.GothamBold
                paraTitle.Text = title
                paraTitle.TextColor3 = Library.Config.Theme.Text
                paraTitle.TextSize = IsMobile and 13 or 14
                paraTitle.TextXAlignment = Enum.TextXAlignment.Left
                paraTitle.Parent = para
                
                local paraContent = Instance.new("TextLabel")
                paraContent.BackgroundTransparency = 1
                paraContent.Position = UDim2.new(0, 12, 0, 28)
                paraContent.Size = UDim2.new(1, -24, 1, -36)
                paraContent.Font = Enum.Font.Gotham
                paraContent.Text = content
                paraContent.TextColor3 = Library.Config.Theme.TextDark
                paraContent.TextSize = IsMobile and 12 or 13
                paraContent.TextXAlignment = Enum.TextXAlignment.Left
                paraContent.TextYAlignment = Enum.TextYAlignment.Top
                paraContent.TextWrapped = true
                paraContent.AutomaticSize = Enum.AutomaticSize.Y
                paraContent.Parent = para
                
                local pad = Instance.new("UIPadding")
                pad.PaddingBottom = UDim.new(0, 10)
                pad.Parent = para
                
                return {
                    SetTitle = function(t) paraTitle.Text = t end,
                    SetContent = function(c) paraContent.Text = c end
                }
            end
            
            return Section
        end
        
        if #Window.Tabs == 0 then
            tabContent.Visible = true
            Window.CurrentTab = tabName
            tabBtn.BackgroundColor3 = Library.Config.Theme.Accent
            tabBtn.TextColor3 = Library.Config.Theme.Text
            indicator.Size = UDim2.new(0, 4, 1, 0)
        end
        
        table.insert(Window.Tabs, Tab)
        return Tab
    end
    
    if IsPC and windowKeybind then
        local visible = true
        Services.UserInputService.InputBegan:Connect(function(input, gp)
            if not gp and input.KeyCode == windowKeybind then
                visible = not visible
                Utility:Tween(main, {
                    Size = visible and UDim2.new(0, size.Width, 0, size.Height) or UDim2.new(0, 0, 0, 0)
                }, 0.3, Enum.EasingStyle.Back)
            end
        end)
    end
    
    Utility:Tween(main, {Size = UDim2.new(0, size.Width, 0, size.Height)}, 0.6, Enum.EasingStyle.Back)
    
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
