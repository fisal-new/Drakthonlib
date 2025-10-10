--[[
    ╔══════════════════════════════════════════════════════╗
    ║      DRAKTHON UI LIBRARY V4.0 - ULTIMATE 2025        ║
    ║      Most Advanced & Undetectable UI Library         ║
    ║      Full Customization & All Features               ║
    ║      Created by Fisal - All Rights Reserved          ║
    ╚══════════════════════════════════════════════════════╝
]]

-- ═══════════════════════════════════════════════════════
-- 🔒 Anti-Detection System
-- ═══════════════════════════════════════════════════════

local function InitAntiDetection()
    local success = pcall(function()
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        local oldIndex = mt.__index
        
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            if method == "Kick" or method == "kick" then
                return nil
            end
            
            if method == "FireServer" or method == "InvokeServer" then
                local callingScript = tostring(self)
                if callingScript:find("Ban") or callingScript:find("Kick") or callingScript:find("Anti") then
                    return nil
                end
            end
            
            return oldNamecall(self, ...)
        end)
        
        mt.__index = newcclosure(function(self, key)
            if key == "DevComputerMovementMode" or key == "DevTouchMovementMode" then
                return Enum.DevComputerMovementMode.UserChoice
            end
            
            return oldIndex(self, key)
        end)
        
        setreadonly(mt, true)
    end)
    
    return success
end

pcall(InitAntiDetection)

-- ═══════════════════════════════════════════════════════
-- 📚 Library Core
-- ═══════════════════════════════════════════════════════

local Library = {}
Library.Version = "4.0.0"
Library.Flags = {}
Library.Elements = {}
Library.Themes = {}

-- Default Settings (Can be customized)
Library.Settings = {
    ConfigFolder = "DrakthonConfigs",
    ThemeFolder = "DrakthonThemes",
    ScreenshotFolder = "DrakthonScreenshots",
    
    -- Features Toggle
    EnableNotifications = true,
    EnableSounds = true,
    EnableAnimations = true,
    EnableShadows = true,
    EnableBlur = false,
    EnableAnalytics = true,
    EnableAutoSave = false,
    
    -- Notification Settings
    MaxNotifications = 4,
    NotificationPosition = "TopRight",
    NotificationDuration = 4,
    
    -- Performance
    AnimationSpeed = 0.3,
    RippleEffect = true,
    
    -- Security
    AntiDetection = true,
    ProtectGui = true,
}

-- Analytics
Library.Analytics = {
    ButtonClicks = 0,
    TogglesChanged = 0,
    SlidersChanged = 0,
    DropdownsChanged = 0,
    TextboxChanged = 0,
    KeybindsChanged = 0,
    ColorPickersChanged = 0,
    SessionStartTime = tick(),
    TotalSessionTime = 0,
}

-- Services
local Services = {
    TweenService = game:GetService("TweenService"),
    UserInputService = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    HttpService = game:GetService("HttpService"),
    Players = game:GetService("Players"),
    CoreGui = game:GetService("CoreGui"),
    Lighting = game:GetService("Lighting"),
    SoundService = game:GetService("SoundService"),
    TextService = game:GetService("TextService"),
    StarterGui = game:GetService("StarterGui"),
}

local Player = Services.Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Device Detection
local IsMobile = Services.UserInputService.TouchEnabled and not Services.UserInputService.KeyboardEnabled
local IsTablet = Services.UserInputService.TouchEnabled and Services.UserInputService.KeyboardEnabled
local IsPC = Services.UserInputService.KeyboardEnabled and Services.UserInputService.MouseEnabled
local IsConsole = Services.UserInputService.GamepadEnabled and not Services.UserInputService.KeyboardEnabled

-- ═══════════════════════════════════════════════════════
-- 🎨 Theme System
-- ═══════════════════════════════════════════════════════

Library.Themes = {
    ["Drakthon Dark"] = {
        MainBackground = Color3.fromRGB(12, 12, 16),
        SecondBackground = Color3.fromRGB(18, 18, 24),
        ThirdBackground = Color3.fromRGB(24, 24, 32),
        AccentColor = Color3.fromRGB(147, 51, 234),
        AccentHover = Color3.fromRGB(167, 71, 254),
        AccentPressed = Color3.fromRGB(127, 31, 214),
        TextColor = Color3.fromRGB(255, 255, 255),
        SubTextColor = Color3.fromRGB(160, 160, 170),
        DisabledTextColor = Color3.fromRGB(100, 100, 110),
        BorderColor = Color3.fromRGB(40, 40, 50),
        DividerColor = Color3.fromRGB(30, 30, 40),
        ScrollBarColor = Color3.fromRGB(60, 60, 70),
        SuccessColor = Color3.fromRGB(34, 197, 94),
        WarningColor = Color3.fromRGB(234, 179, 8),
        ErrorColor = Color3.fromRGB(239, 68, 68),
        InfoColor = Color3.fromRGB(59, 130, 246),
        ShadowColor = Color3.fromRGB(0, 0, 0),
        GlowColor = Color3.fromRGB(147, 51, 234),
    },
    
    ["Ocean Blue"] = {
        MainBackground = Color3.fromRGB(8, 20, 35),
        SecondBackground = Color3.fromRGB(12, 28, 48),
        ThirdBackground = Color3.fromRGB(16, 36, 60),
        AccentColor = Color3.fromRGB(14, 165, 233),
        AccentHover = Color3.fromRGB(34, 185, 253),
        AccentPressed = Color3.fromRGB(0, 145, 213),
        TextColor = Color3.fromRGB(240, 250, 255),
        SubTextColor = Color3.fromRGB(140, 160, 180),
        DisabledTextColor = Color3.fromRGB(80, 100, 120),
        BorderColor = Color3.fromRGB(30, 50, 70),
        DividerColor = Color3.fromRGB(20, 40, 60),
        ScrollBarColor = Color3.fromRGB(50, 70, 90),
        SuccessColor = Color3.fromRGB(16, 185, 129),
        WarningColor = Color3.fromRGB(245, 158, 11),
        ErrorColor = Color3.fromRGB(239, 68, 68),
        InfoColor = Color3.fromRGB(59, 130, 246),
        ShadowColor = Color3.fromRGB(0, 10, 20),
        GlowColor = Color3.fromRGB(14, 165, 233),
    },
    
    ["Midnight Purple"] = {
        MainBackground = Color3.fromRGB(10, 10, 15),
        SecondBackground = Color3.fromRGB(15, 15, 22),
        ThirdBackground = Color3.fromRGB(20, 20, 30),
        AccentColor = Color3.fromRGB(236, 72, 153),
        AccentHover = Color3.fromRGB(255, 92, 173),
        AccentPressed = Color3.fromRGB(216, 52, 133),
        TextColor = Color3.fromRGB(250, 250, 255),
        SubTextColor = Color3.fromRGB(160, 160, 180),
        DisabledTextColor = Color3.fromRGB(90, 90, 100),
        BorderColor = Color3.fromRGB(35, 35, 45),
        DividerColor = Color3.fromRGB(25, 25, 35),
        ScrollBarColor = Color3.fromRGB(55, 55, 65),
        SuccessColor = Color3.fromRGB(52, 211, 153),
        WarningColor = Color3.fromRGB(251, 191, 36),
        ErrorColor = Color3.fromRGB(248, 113, 113),
        InfoColor = Color3.fromRGB(96, 165, 250),
        ShadowColor = Color3.fromRGB(0, 0, 0),
        GlowColor = Color3.fromRGB(236, 72, 153),
    },
    
    ["Forest Green"] = {
        MainBackground = Color3.fromRGB(10, 20, 15),
        SecondBackground = Color3.fromRGB(15, 28, 20),
        ThirdBackground = Color3.fromRGB(20, 36, 25),
        AccentColor = Color3.fromRGB(34, 197, 94),
        AccentHover = Color3.fromRGB(54, 217, 114),
        AccentPressed = Color3.fromRGB(14, 177, 74),
        TextColor = Color3.fromRGB(240, 255, 245),
        SubTextColor = Color3.fromRGB(150, 170, 160),
        DisabledTextColor = Color3.fromRGB(80, 100, 90),
        BorderColor = Color3.fromRGB(30, 48, 35),
        DividerColor = Color3.fromRGB(20, 38, 25),
        ScrollBarColor = Color3.fromRGB(50, 68, 55),
        SuccessColor = Color3.fromRGB(34, 197, 94),
        WarningColor = Color3.fromRGB(234, 179, 8),
        ErrorColor = Color3.fromRGB(239, 68, 68),
        InfoColor = Color3.fromRGB(59, 130, 246),
        ShadowColor = Color3.fromRGB(0, 5, 0),
        GlowColor = Color3.fromRGB(34, 197, 94),
    },
    
    ["Crimson Red"] = {
        MainBackground = Color3.fromRGB(20, 8, 8),
        SecondBackground = Color3.fromRGB(30, 12, 12),
        ThirdBackground = Color3.fromRGB(40, 16, 16),
        AccentColor = Color3.fromRGB(239, 68, 68),
        AccentHover = Color3.fromRGB(255, 88, 88),
        AccentPressed = Color3.fromRGB(219, 48, 48),
        TextColor = Color3.fromRGB(255, 245, 245),
        SubTextColor = Color3.fromRGB(200, 160, 160),
        DisabledTextColor = Color3.fromRGB(120, 80, 80),
        BorderColor = Color3.fromRGB(60, 30, 30),
        DividerColor = Color3.fromRGB(50, 20, 20),
        ScrollBarColor = Color3.fromRGB(80, 50, 50),
        SuccessColor = Color3.fromRGB(34, 197, 94),
        WarningColor = Color3.fromRGB(234, 179, 8),
        ErrorColor = Color3.fromRGB(239, 68, 68),
        InfoColor = Color3.fromRGB(59, 130, 246),
        ShadowColor = Color3.fromRGB(10, 0, 0),
        GlowColor = Color3.fromRGB(239, 68, 68),
    },
}

Library.CurrentTheme = Library.Themes["Drakthon Dark"]

-- Function to change theme dynamically
function Library:SetTheme(themeName)
    if self.Themes[themeName] then
        self.CurrentTheme = self.Themes[themeName]
        
        -- Update all existing UI elements
        for _, element in pairs(self.Elements) do
            if element.UpdateTheme then
                element:UpdateTheme()
            end
        end
        
        return true
    end
    return false
end

-- Function to create custom theme
function Library:CreateCustomTheme(themeName, colors)
    self.Themes[themeName] = colors
    return true
end

-- ═══════════════════════════════════════════════════════
-- 🔧 Utility Functions
-- ═══════════════════════════════════════════════════════

local Utility = {}

function Utility:GetScreenSize()
    return workspace.CurrentCamera.ViewportSize
end

function Utility:CalculateResponsiveSize(sizeType)
    local viewportSize = self:GetScreenSize()
    local width = viewportSize.X
    local height = viewportSize.Y
    
    if IsMobile then
        return {
            Width = math.clamp(width * 0.95, 300, 450),
            Height = math.clamp(height * 0.90, 400, 700),
            TabWidth = 55,
            FontSize = {
                Title = 13,
                Subtitle = 10,
                Text = 11,
                SubText = 10,
                Small = 9
            }
        }
    elseif IsTablet then
        return {
            Width = math.clamp(width * 0.75, 500, 650),
            Height = math.clamp(height * 0.80, 450, 650),
            TabWidth = 80,
            FontSize = {
                Title = 14,
                Subtitle = 11,
                Text = 12,
                SubText = 11,
                Small = 10
            }
        }
    else
        local sizes = {
            Small = {
                Width = math.clamp(width * 0.35, 400, 500),
                Height = math.clamp(height * 0.55, 400, 500),
                TabWidth = 120
            },
            Medium = {
                Width = math.clamp(width * 0.45, 550, 700),
                Height = math.clamp(height * 0.65, 450, 600),
                TabWidth = 140
            },
            Large = {
                Width = math.clamp(width * 0.60, 700, 900),
                Height = math.clamp(height * 0.75, 550, 750),
                TabWidth = 160
            },
            Auto = {
                Width = math.clamp(width * 0.50, 600, 750),
                Height = math.clamp(height * 0.70, 500, 650),
                TabWidth = 145
            }
        }
        
        local size = sizes[sizeType] or sizes.Auto
        size.FontSize = {
            Title = 14,
            Subtitle = 11,
            Text = 12,
            SubText = 11,
            Small = 10
        }
        return size
    end
end

function Utility:CreateScreenGui(name)
    local gui
    
    if Library.Settings.ProtectGui then
        local success = pcall(function()
            if gethui then
                gui = Instance.new("ScreenGui", gethui())
            elseif syn and syn.protect_gui then
                gui = Instance.new("ScreenGui", Services.CoreGui)
                syn.protect_gui(gui)
            else
                gui = Instance.new("ScreenGui", Services.CoreGui)
            end
        end)
        
        if not success then
            gui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
        end
    else
        gui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
    end
    
    gui.Name = name or "DrakthonUI_" .. Services.HttpService:GenerateGUID(false)
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 999999999
    gui.IgnoreGuiInset = true
    
    return gui
end

function Utility:Tween(object, properties, duration, style, direction, callback)
    if not object or not object.Parent then return end
    if not Library.Settings.EnableAnimations then
        for prop, value in pairs(properties) do
            object[prop] = value
        end
        if callback then callback() end
        return
    end
    
    duration = duration or Library.Settings.AnimationSpeed
    style = style or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    
    local tween = Services.TweenService:Create(
        object,
        TweenInfo.new(duration, style, direction),
        properties
    )
    
    if callback then
        tween.Completed:Connect(callback)
    end
    
    local success = pcall(function()
        tween:Play()
    end)
    
    if not success and callback then
        callback()
    end
    
    return tween
end

function Utility:MakeDraggable(frame, dragObject)
    dragObject = dragObject or frame
    
    local dragging = false
    local dragInput, dragStart, startPos
    
    local function update(input)
        if not dragging or not frame or not frame.Parent then return end
        
        local delta = input.Position - dragStart
        
        self:Tween(frame, {
            Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        }, 0.05, Enum.EasingStyle.Linear)
    end
    
    dragObject.InputBegan:Connect(function(input)
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
    
    dragObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    Services.UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

function Utility:PlaySound(soundId, volume)
    if not Library.Settings.EnableSounds then return end
    
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. soundId
        sound.Volume = volume or 0.5
        sound.Parent = Services.SoundService
        sound:Play()
        
        game:GetService("Debris"):AddItem(sound, 3)
    end)
end

function Utility:AddDropShadow(parent, offset, transparency)
    if not Library.Settings.EnableShadows then return end
    
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Parent = parent
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0, -(offset or 15), 0, -(offset or 15))
    shadow.Size = UDim2.new(1, (offset or 15) * 2, 1, (offset or 15) * 2)
    shadow.ZIndex = parent.ZIndex - 1 or 0
    shadow.Image = "rbxassetid://6015897843"
    shadow.ImageColor3 = Library.CurrentTheme.ShadowColor
    shadow.ImageTransparency = transparency or 0.6
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    
    return shadow
end

function Utility:CreateRipple(parent, x, y, color)
    if not Library.Settings.RippleEffect then return end
    
    local ripple = Instance.new("Frame")
    ripple.Name = "Ripple"
    ripple.Parent = parent
    ripple.BackgroundColor3 = color or Library.CurrentTheme.AccentColor
    ripple.BackgroundTransparency = 0.5
    ripple.BorderSizePixel = 0
    ripple.Position = UDim2.new(0, x, 0, y)
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.ZIndex = parent.ZIndex + 5 or 10
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = ripple
    
    local size = math.max(parent.AbsoluteSize.X, parent.AbsoluteSize.Y) * 2.5
    
    self:Tween(ripple, {
        Size = UDim2.new(0, size, 0, size),
        BackgroundTransparency = 1
    }, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, function()
        ripple:Destroy()
    end)
end

function Utility:CreateGradient(parent, colorSequence, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = colorSequence or ColorSequence.new{
        ColorSequenceKeypoint.new(0, Library.CurrentTheme.AccentColor),
        ColorSequenceKeypoint.new(1, Library.CurrentTheme.AccentHover)
    }
    gradient.Rotation = rotation or 45
    gradient.Parent = parent
    
    return gradient
end

-- ═══════════════════════════════════════════════════════
-- 🔔 Notification System
-- ═══════════════════════════════════════════════════════

Library.Notifications = {
    Active = {},
    Queue = {},
}

local NotificationIcons = {
    Success = "✓",
    Error = "✕",
    Warning = "⚠",
    Info = "ℹ",
    Question = "?",
    Star = "★",
}

local NotificationSounds = {
    Success = 6895079853,
    Error = 6895079853,
    Warning = 6895079853,
    Info = 6895079853
}

function Library:Notify(config)
    if not self.Settings.EnableNotifications then return end
    
    config = config or {}
    
    local title = config.Title or "Notification"
    local description = config.Description or ""
    local duration = config.Duration or Library.Settings.NotificationDuration
    local notifType = config.Type or "Info"
    local callback = config.Callback or function() end
    local sound = config.Sound ~= false
    local position = config.Position or Library.Settings.NotificationPosition
    
    if #self.Notifications.Active >= Library.Settings.MaxNotifications then
        table.insert(self.Notifications.Queue, config)
        return
    end
    
    task.spawn(function()
        pcall(function()
            local gui = Utility:CreateScreenGui("DrakthonNotification")
            
            local screenSize = Utility:GetScreenSize()
            local notifWidth = IsMobile and 280 or 320
            local notifHeight = IsMobile and 75 or 80
            
            local yOffset = 10
            for i, notif in ipairs(self.Notifications.Active) do
                yOffset = yOffset + (notif.AbsoluteSize.Y + 10)
            end
            
            local startPos, endPos
            
            if position == "TopRight" then
                startPos = UDim2.new(1, 10, 0, yOffset)
                endPos = UDim2.new(1, -notifWidth - 10, 0, yOffset)
            elseif position == "TopLeft" then
                startPos = UDim2.new(0, -notifWidth - 10, 0, yOffset)
                endPos = UDim2.new(0, 10, 0, yOffset)
            elseif position == "BottomRight" then
                startPos = UDim2.new(1, 10, 1, -yOffset - notifHeight)
                endPos = UDim2.new(1, -notifWidth - 10, 1, -yOffset - notifHeight)
            elseif position == "BottomLeft" then
                startPos = UDim2.new(0, -notifWidth - 10, 1, -yOffset - notifHeight)
                endPos = UDim2.new(0, 10, 1, -yOffset - notifHeight)
            end
            
            local notifFrame = Instance.new("Frame")
            notifFrame.Name = "Notification"
            notifFrame.Parent = gui
            notifFrame.BackgroundColor3 = Library.CurrentTheme.SecondBackground
            notifFrame.BorderSizePixel = 0
            notifFrame.Position = startPos
            notifFrame.Size = UDim2.new(0, notifWidth, 0, notifHeight)
            notifFrame.ClipsDescendants = false
            
            table.insert(self.Notifications.Active, notifFrame)
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 10)
            corner.Parent = notifFrame
            
            Utility:AddDropShadow(notifFrame, 12, 0.7)
            
            local stroke = Instance.new("UIStroke")
            stroke.Parent = notifFrame
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            stroke.Thickness = 1.5
            stroke.Transparency = 0.4
            
            local accentColor = Library.CurrentTheme.InfoColor
            
            if notifType == "Success" then
                accentColor = Library.CurrentTheme.SuccessColor
            elseif notifType == "Error" then
                accentColor = Library.CurrentTheme.ErrorColor
            elseif notifType == "Warning" then
                accentColor = Library.CurrentTheme.WarningColor
            end
            
            stroke.Color = accentColor
            
            local accentBar = Instance.new("Frame")
            accentBar.Name = "AccentBar"
            accentBar.Parent = notifFrame
            accentBar.BackgroundColor3 = accentColor
            accentBar.BorderSizePixel = 0
            accentBar.Size = UDim2.new(0, 4, 1, 0)
            
            local barCorner = Instance.new("UICorner")
            barCorner.CornerRadius = UDim.new(0, 10)
            barCorner.Parent = accentBar
            
            local iconFrame = Instance.new("Frame")
            iconFrame.Name = "IconFrame"
            iconFrame.Parent = notifFrame
            iconFrame.BackgroundColor3 = accentColor
            iconFrame.BorderSizePixel = 0
            iconFrame.Position = UDim2.new(0, 12, 0.5, 0)
            iconFrame.Size = UDim2.new(0, 0, 0, 0)
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
            icon.TextSize = IsMobile and 16 or 18
            
            local titleLabel = Instance.new("TextLabel")
            titleLabel.Name = "Title"
            titleLabel.Parent = notifFrame
            titleLabel.BackgroundTransparency = 1
            titleLabel.Position = UDim2.new(0, 60, 0, 12)
            titleLabel.Size = UDim2.new(1, -105, 0, 18)
            titleLabel.Font = Enum.Font.GothamBold
            titleLabel.Text = title
            titleLabel.TextColor3 = Library.CurrentTheme.TextColor
            titleLabel.TextSize = IsMobile and 13 or 14
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
            
            local descLabel = Instance.new("TextLabel")
            descLabel.Name = "Description"
            descLabel.Parent = notifFrame
            descLabel.BackgroundTransparency = 1
            descLabel.Position = UDim2.new(0, 60, 0, 32)
            descLabel.Size = UDim2.new(1, -105, 0, 35)
            descLabel.Font = Enum.Font.Gotham
            descLabel.Text = description
            descLabel.TextColor3 = Library.CurrentTheme.SubTextColor
            descLabel.TextSize = IsMobile and 11 or 12
            descLabel.TextXAlignment = Enum.TextXAlignment.Left
            descLabel.TextYAlignment = Enum.TextYAlignment.Top
            descLabel.TextWrapped = true
            
            local progressContainer = Instance.new("Frame")
            progressContainer.Name = "ProgressContainer"
            progressContainer.Parent = notifFrame
            progressContainer.BackgroundColor3 = Library.CurrentTheme.MainBackground
            progressContainer.BorderSizePixel = 0
            progressContainer.Position = UDim2.new(0, 0, 1, -3)
            progressContainer.Size = UDim2.new(1, 0, 0, 3)
            
            local progress = Instance.new("Frame")
            progress.Name = "Progress"
            progress.Parent = progressContainer
            progress.BackgroundColor3 = accentColor
            progress.BorderSizePixel = 0
            progress.Size = UDim2.new(1, 0, 1, 0)
            
            Utility:CreateGradient(progress, ColorSequence.new{
                ColorSequenceKeypoint.new(0, accentColor),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(
                    math.clamp(accentColor.R * 255 + 30, 0, 255),
                    math.clamp(accentColor.G * 255 + 30, 0, 255),
                    math.clamp(accentColor.B * 255 + 30, 0, 255)
                ))
            }, 90)
            
            local closeBtn = Instance.new("TextButton")
            closeBtn.Name = "CloseButton"
            closeBtn.Parent = notifFrame
            closeBtn.BackgroundColor3 = Library.CurrentTheme.ThirdBackground
            closeBtn.BorderSizePixel = 0
            closeBtn.Position = UDim2.new(1, -32, 0, 8)
            closeBtn.Size = UDim2.new(0, 24, 0, 24)
            closeBtn.Font = Enum.Font.GothamBold
            closeBtn.Text = "×"
            closeBtn.TextColor3 = Library.CurrentTheme.SubTextColor
            closeBtn.TextSize = 16
            closeBtn.AutoButtonColor = false
            
            local closeBtnCorner = Instance.new("UICorner")
            closeBtnCorner.CornerRadius = UDim.new(0, 6)
            closeBtnCorner.Parent = closeBtn
            
            local function closeNotification()
                for i, v in ipairs(Library.Notifications.Active) do
                    if v == notifFrame then
                        table.remove(Library.Notifications.Active, i)
                        break
                    end
                end
                
                Utility:Tween(notifFrame, {
                    Position = startPos,
                    Size = UDim2.new(0, 0, 0, notifHeight)
                }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                
                task.wait(0.3)
                gui:Destroy()
                
                if #Library.Notifications.Queue > 0 then
                    local nextNotif = table.remove(Library.Notifications.Queue, 1)
                    task.wait(0.1)
                    Library:Notify(nextNotif)
                end
                
                callback()
            end
            
            closeBtn.MouseButton1Click:Connect(closeNotification)
            
            closeBtn.MouseEnter:Connect(function()
                Utility:Tween(closeBtn, {
                    BackgroundColor3 = Library.CurrentTheme.ErrorColor
                }, 0.2)
            end)
            
            closeBtn.MouseLeave:Connect(function()
                Utility:Tween(closeBtn, {
                    BackgroundColor3 = Library.CurrentTheme.ThirdBackground
                }, 0.2)
            end)
            
            Utility:Tween(notifFrame, {
                Position = endPos
            }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            
            task.wait(0.2)
            Utility:Tween(iconFrame, {
                Size = UDim2.new(0, 36, 0, 36)
            }, 0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
            
            task.spawn(function()
                Utility:Tween(progress, {
                    Size = UDim2.new(0, 0, 1, 0)
                }, duration, Enum.EasingStyle.Linear)
            end)
            
            if sound and NotificationSounds[notifType] then
                Utility:PlaySound(NotificationSounds[notifType], 0.3)
            end
            
            task.delay(duration, closeNotification)
        end)
    end)
end

-- ═══════════════════════════════════════════════════════
-- 💾 Config System
-- ═══════════════════════════════════════════════════════

Library.ConfigSystem = {}

function Library.ConfigSystem:CreateFolder(folderName)
    pcall(function()
        if not isfolder(folderName) then
            makefolder(folderName)
        end
    end)
end

function Library.ConfigSystem:Save(configName, data)
    data = data or Library.Flags
    
    local success, result = pcall(function()
        self:CreateFolder(Library.Settings.ConfigFolder)
        
        local configData = {
            Version = Library.Version,
            SavedAt = os.date("%Y-%m-%d %H:%M:%S"),
            Device = IsMobile and "Mobile" or IsTablet and "Tablet" or "PC",
            Data = data,
            Analytics = Library.Analytics
        }
        
        local encoded = Services.HttpService:JSONEncode(configData)
        writefile(Library.Settings.ConfigFolder .. "/" .. configName .. ".json", encoded)
    end)
    
    if success then
        if Library.Settings.EnableNotifications then
            Library:Notify({
                Title = "Config Saved",
                Description = "Configuration '" .. configName .. "' saved successfully",
                Type = "Success",
                Duration = 2
            })
        end
        return true
    else
        if Library.Settings.EnableNotifications then
            Library:Notify({
                Title = "Save Failed",
                Description = "Failed to save configuration",
                Type = "Error",
                Duration = 3
            })
        end
        return false
    end
end

function Library.ConfigSystem:Load(configName)
    local success, data = pcall(function()
        local content = readfile(Library.Settings.ConfigFolder .. "/" .. configName .. ".json")
        return Services.HttpService:JSONDecode(content)
    end)
    
    if success and data then
        if data.Version ~= Library.Version then
            Library:Notify({
                Title = "Version Mismatch",
                Description = "Config was saved with version " .. (data.Version or "Unknown"),
                Type = "Warning",
                Duration = 3
            })
        end
        
        if Library.Settings.EnableNotifications then
            Library:Notify({
                Title = "Config Loaded",
                Description = "Configuration '" .. configName .. "' loaded successfully",
                Type = "Success",
                Duration = 2
            })
        end
        
        return data.Data
    else
        if Library.Settings.EnableNotifications then
            Library:Notify({
                Title = "Load Failed",
                Description = "Configuration file not found",
                Type = "Error",
                Duration = 3
            })
        end
        return nil
    end
end

function Library.ConfigSystem:Delete(configName)
    local success = pcall(function()
        delfile(Library.Settings.ConfigFolder .. "/" .. configName .. ".json")
    end)
    
    if success then
        Library:Notify({
            Title = "Config Deleted",
            Description = "Configuration '" .. configName .. "' deleted",
            Type = "Success",
            Duration = 2
        })
        return true
    else
        Library:Notify({
            Title = "Delete Failed",
            Description = "Failed to delete configuration",
            Type = "Error",
            Duration = 3
        })
        return false
    end
end

function Library.ConfigSystem:List()
    local configs = {}
    
    pcall(function()
        self:CreateFolder(Library.Settings.ConfigFolder)
        
        for _, file in ipairs(listfiles(Library.Settings.ConfigFolder)) do
            if file:match("%.json$") then
                local name = file:match("([^/\```+)%.json$")
                table.insert(configs, name)
            end
        end
    end)
    
    return configs
end

function Library.ConfigSystem:Refresh()
    return self:List()
end

function Library.ConfigSystem:AutoSave(configName, interval)
    interval = interval or 300
    
    task.spawn(function()
        while Library.Settings.EnableAutoSave do
            task.wait(interval)
            self:Save(configName or "AutoSave")
        end
    end)
end

-- ═══════════════════════════════════════════════════════
-- 🪟 Window Creation
-- ═══════════════════════════════════════════════════════

function Library:CreateWindow(config)
    config = config or {}
    
    -- Window Configuration
    local windowConfig = {
        Title = config.Title or "Drakthon UI",
        Subtitle = config.Subtitle or "v" .. self.Version,
        Theme = config.Theme or "Drakthon Dark",
        Size = config.Size or "Auto",
        Keybind = config.Keybind or Enum.KeyCode.RightControl,
        AccentColor = config.AccentColor,
        Logo = config.Logo,
        ShowIntro = config.ShowIntro ~= false,
        IntroText = config.IntroText,
        SaveConfig = config.SaveConfig,
        ConfigName = config.ConfigName or "DefaultConfig",
        AutoSave = config.AutoSave,
        AutoSaveInterval = config.AutoSaveInterval or 300,
    }
    
    -- Apply theme
    if self.Themes[windowConfig.Theme] then
        self.CurrentTheme = self.Themes[windowConfig.Theme]
    end
    
    -- Apply custom accent color if provided
    if windowConfig.AccentColor then
        self.CurrentTheme.AccentColor = windowConfig.AccentColor
    end
    
    local screenSize = Utility:CalculateResponsiveSize(windowConfig.Size)
    local windowSize = UDim2.new(0, screenSize.Width, 0, screenSize.Height)
    
    local screenGui = Utility:CreateScreenGui("DrakthonUI")
    
    -- Intro Screen
    if windowConfig.ShowIntro then
        local loadingFrame = Instance.new("Frame")
        loadingFrame.Name = "LoadingScreen"
        loadingFrame.Parent = screenGui
        loadingFrame.BackgroundColor3 = Library.CurrentTheme.MainBackground
        loadingFrame.BorderSizePixel = 0
        loadingFrame.Size = UDim2.new(1, 0, 1, 0)
        loadingFrame.ZIndex = 10000
        
        local loadingLogo = Instance.new("TextLabel")
        loadingLogo.Parent = loadingFrame
        loadingLogo.BackgroundTransparency = 1
        loadingLogo.Position = UDim2.new(0.5, 0, 0.4, 0)
        loadingLogo.Size = UDim2.new(0, 400, 0, 60)
        loadingLogo.AnchorPoint = Vector2.new(0.5, 0.5)
        loadingLogo.Font = Enum.Font.GothamBold
        loadingLogo.Text = windowConfig.Title
        loadingLogo.TextColor3 = Library.CurrentTheme.AccentColor
        loadingLogo.TextSize = IsMobile and 28 or 36
        loadingLogo.TextTransparency = 1
        
        local loadingSubtitle = Instance.new("TextLabel")
        loadingSubtitle.Parent = loadingFrame
        loadingSubtitle.BackgroundTransparency = 1
        loadingSubtitle.Position = UDim2.new(0.5, 0, 0.48, 0)
        loadingSubtitle.Size = UDim2.new(0, 300, 0, 25)
        loadingSubtitle.AnchorPoint = Vector2.new(0.5, 0.5)
        loadingSubtitle.Font = Enum.Font.Gotham
        loadingSubtitle.Text = windowConfig.IntroText or "Loading UI..."
        loadingSubtitle.TextColor3 = Library.CurrentTheme.SubTextColor
        loadingSubtitle.TextSize = IsMobile and 12 or 14
        loadingSubtitle.TextTransparency = 1
        
        local loadingBar = Instance.new("Frame")
        loadingBar.Parent = loadingFrame
        loadingBar.BackgroundColor3 = Library.CurrentTheme.SecondBackground
        loadingBar.BorderSizePixel = 0
        loadingBar.Position = UDim2.new(0.5, 0, 0.6, 0)
        loadingBar.Size = UDim2.new(0, 350, 0, 4)
        loadingBar.AnchorPoint = Vector2.new(0.5, 0.5)
        
        local loadingBarCorner = Instance.new("UICorner")
        loadingBarCorner.CornerRadius = UDim.new(1, 0)
        loadingBarCorner.Parent = loadingBar
        
        local loadingProgress = Instance.new("Frame")
        loadingProgress.Parent = loadingBar
        loadingProgress.BackgroundColor3 = Library.CurrentTheme.AccentColor
        loadingProgress.BorderSizePixel = 0
        loadingProgress.Size = UDim2.new(0, 0, 1, 0)
        
        local loadingProgressCorner = Instance.new("UICorner")
        loadingProgressCorner.CornerRadius = UDim.new(1, 0)
        loadingProgressCorner.Parent = loadingProgress
        
        Utility:CreateGradient(loadingProgress)
        
        Utility:Tween(loadingLogo, {TextTransparency = 0}, 0.5)
        Utility:Tween(loadingSubtitle, {TextTransparency = 0}, 0.5)
        
        task.wait(0.3)
        
        Utility:Tween(loadingProgress, {Size = UDim2.new(1, 0, 1, 0)}, 1.5, Enum.EasingStyle.Quad)
        
        task.wait(1.5)
        
        Utility:Tween(loadingFrame, {BackgroundTransparency = 1}, 0.3)
        Utility:Tween(loadingLogo, {TextTransparency = 1}, 0.3)
        Utility:Tween(loadingSubtitle, {TextTransparency = 1}, 0.3)
        Utility:Tween(loadingBar, {BackgroundTransparency = 1}, 0.3)
        Utility:Tween(loadingProgress, {BackgroundTransparency = 1}, 0.3)
        
        task.wait(0.3)
        loadingFrame:Destroy()
    end
    
    -- Main Container
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
    
    Utility:AddDropShadow(mainContainer, 15, 0.5)
    
    local mainStroke = Instance.new("UIStroke")
    mainStroke.Parent = mainFrame
    mainStroke.Color = Library.CurrentTheme.AccentColor
    mainStroke.Thickness = 1.5
    mainStroke.Transparency = 0.7
    
    -- Header
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Parent = mainFrame
    header.BackgroundColor3 = Library.CurrentTheme.SecondBackground
    header.BorderSizePixel = 0
    header.Size = UDim2.new(1, 0, 0, 45)
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = header
    
    Utility:CreateGradient(header, ColorSequence.new{
        ColorSequenceKeypoint.new(0, Library.CurrentTheme.SecondBackground),
        ColorSequenceKeypoint.new(1, Library.CurrentTheme.ThirdBackground)
    }, 90)
    
    local logo = Instance.new("ImageLabel")
    logo.Name = "Logo"
    logo.Parent = header
    logo.BackgroundTransparency = 1
    logo.Position = UDim2.new(0, 10, 0.5, 0)
    logo.Size = UDim2.new(0, 28, 0, 28)
    logo.AnchorPoint = Vector2.new(0, 0.5)
    logo.Image = windowConfig.Logo or "rbxassetid://7733992358"
    logo.ImageColor3 = Library.CurrentTheme.AccentColor
    
    local logoCorner = Instance.new("UICorner")
    logoCorner.CornerRadius = UDim.new(1, 0)
    logoCorner.Parent = logo
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Parent = header
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 45, 0, 6)
    title.Size = UDim2.new(0.5, -45, 0, 18)
    title.Font = Enum.Font.GothamBold
    title.Text = windowConfig.Title
    title.TextColor3 = Library.CurrentTheme.TextColor
    title.TextSize = screenSize.FontSize.Title
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextTruncate = Enum.TextTruncate.AtEnd
    
    local subtitle = Instance.new("TextLabel")
    subtitle.Name = "Subtitle"
    subtitle.Parent = header
    subtitle.BackgroundTransparency = 1
    subtitle.Position = UDim2.new(0, 45, 0, 24)
    subtitle.Size = UDim2.new(0.5, -45, 0, 14)
    subtitle.Font = Enum.Font.Gotham
    subtitle.Text = windowConfig.Subtitle
    subtitle.TextColor3 = Library.CurrentTheme.SubTextColor
    subtitle.TextSize = screenSize.FontSize.Subtitle
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Controls
    local controlsFrame = Instance.new("Frame")
    controlsFrame.Name = "Controls"
    controlsFrame.Parent = header
    controlsFrame.BackgroundTransparency = 1
    controlsFrame.Position = UDim2.new(1, -95, 0.5, 0)
    controlsFrame.Size = UDim2.new(0, 90, 0, 28)
    controlsFrame.AnchorPoint = Vector2.new(0, 0.5)
    
    local controlsList = Instance.new("UIListLayout")
    controlsList.Parent = controlsFrame
    controlsList.FillDirection = Enum.FillDirection.Horizontal
    controlsList.HorizontalAlignment = Enum.HorizontalAlignment.Right
    controlsList.Padding = UDim.new(0, 5)
    
    -- Minimize Button
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Name = "Minimize"
    minimizeBtn.Parent = controlsFrame
    minimizeBtn.BackgroundColor3 = Library.CurrentTheme.ThirdBackground
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.Size = UDim2.new(0, 28, 0, 28)
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.Text = "−"
    minimizeBtn.TextColor3 = Library.CurrentTheme.TextColor
    minimizeBtn.TextSize = 18
    minimizeBtn.AutoButtonColor = false
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 6)
    minimizeCorner.Parent = minimizeBtn
    
    local minimized = false
    minimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        Library.Analytics.ButtonClicks = Library.Analytics.ButtonClicks + 1
        
        if minimized then
            Utility:Tween(mainContainer, {
                Size = UDim2.new(0, screenSize.Width, 0, 45)
            }, 0.3, Enum.EasingStyle.Back)
            minimizeBtn.Text = "+"
        else
            Utility:Tween(mainContainer, {
                Size = windowSize
            }, 0.3, Enum.EasingStyle.Back)
            minimizeBtn.Text = "−"
        end
        
        Utility:PlaySound(6895079853, 0.2)
    end)
    
    minimizeBtn.MouseEnter:Connect(function()
        Utility:Tween(minimizeBtn, {
            BackgroundColor3 = Library.CurrentTheme.AccentColor
        }, 0.2)
    end)
    
    minimizeBtn.MouseLeave:Connect(function()
        Utility:Tween(minimizeBtn, {
            BackgroundColor3 = Library.CurrentTheme.ThirdBackground
        }, 0.2)
    end)
    
    -- Settings Button
    local settingsBtn = Instance.new("TextButton")
    settingsBtn.Name = "Settings"
    settingsBtn.Parent = controlsFrame
    settingsBtn.BackgroundColor3 = Library.CurrentTheme.ThirdBackground
    settingsBtn.BorderSizePixel = 0
    settingsBtn.Size = UDim2.new(0, 28, 0, 28)
    settingsBtn.Font = Enum.Font.GothamBold
    settingsBtn.Text = "⚙"
    settingsBtn.TextColor3 = Library.CurrentTheme.TextColor
    settingsBtn.TextSize = 16
    settingsBtn.AutoButtonColor = false
    
    local settingsCorner = Instance.new("UICorner")
    settingsCorner.CornerRadius = UDim.new(0, 6)
    settingsCorner.Parent = settingsBtn
    
    settingsBtn.MouseEnter:Connect(function()
        Utility:Tween(settingsBtn, {
            BackgroundColor3 = Library.CurrentTheme.AccentColor
        }, 0.2)
        Utility:Tween(settingsBtn, {Rotation = 180}, 0.3)
    end)
    
    settingsBtn.MouseLeave:Connect(function()
        Utility:Tween(settingsBtn, {
            BackgroundColor3 = Library.CurrentTheme.ThirdBackground
        }, 0.2)
        Utility:Tween(settingsBtn, {Rotation = 0}, 0.3)
    end)
    
    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "Close"
    closeBtn.Parent = controlsFrame
    closeBtn.BackgroundColor3 = Library.CurrentTheme.ErrorColor
    closeBtn.BorderSizePixel = 0
    closeBtn.Size = UDim2.new(0, 28, 0, 28)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Library.CurrentTheme.TextColor
    closeBtn.TextSize = 20
    closeBtn.AutoButtonColor = false
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn
    
    closeBtn.MouseEnter:Connect(function()
        Utility:Tween(closeBtn, {
            BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        }, 0.2)
    end)
    
    closeBtn.MouseLeave:Connect(function()
        Utility:Tween(closeBtn, {
            BackgroundColor3 = Library.CurrentTheme.ErrorColor
        }, 0.2)
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        if windowConfig.SaveConfig then
            Library.ConfigSystem:Save(windowConfig.ConfigName)
        end
        
        Utility:Tween(mainContainer, {
            Size = UDim2.new(0, 0, 0, 0)
        }, 0.4, Enum.EasingStyle.Back)
        
        task.wait(0.4)
        screenGui:Destroy()
    end)
    
    -- Make Draggable
    Utility:MakeDraggable(mainContainer, header)
    
    -- Keybind Toggle
    if not IsMobile and windowConfig.Keybind then
        local uiVisible = true
        Services.UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == windowConfig.Keybind then
                uiVisible = not uiVisible
                Utility:Tween(mainContainer, {
                    Size = uiVisible and windowSize or UDim2.new(0, 0, 0, 0)
                }, 0.3, Enum.EasingStyle.Back)
            end
        end)
    end
    
    -- Tab Container
    local tabWidth = IsMobile and 60 or screenSize.TabWidth
    
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
    
    -- Content Container
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentContainer"
    contentContainer.Parent = mainFrame
    contentContainer.BackgroundTransparency = 1
    contentContainer.Position = UDim2.new(0, tabWidth, 0, 45)
    contentContainer.Size = UDim2.new(1, -tabWidth, 1, -45)
    
    -- Window Object
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        Flags = Library.Flags,
        ScreenSize = screenSize,
        IsMobile = IsMobile,
        MainContainer = mainContainer,
        ScreenGui = screenGui,
        Config = windowConfig,
    }
    
    -- Update Session Time
    task.spawn(function()
        while screenGui and screenGui.Parent do
            task.wait(1)
            Library.Analytics.TotalSessionTime = tick() - Library.Analytics.SessionStartTime
        end
    end)
    
    -- CreateTab Function
    function Window:CreateTab(tabConfig)
        tabConfig = tabConfig or {}
        
        local tabName = tabConfig.Name or "Tab"
        local tabIcon = tabConfig.Icon or "rbxassetid://7734053426"
        local tabVisible = tabConfig.Visible ~= false
        
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName
        tabButton.Parent = tabContainer
        tabButton.BackgroundColor3 = Library.CurrentTheme.ThirdBackground
        tabButton.BorderSizePixel = 0
        tabButton.Size = UDim2.new(1, 0, 0, IsMobile and 50 or 36)
        tabButton.Font = Enum.Font.GothamSemibold
        tabButton.Text = ""
        tabButton.AutoButtonColor = false
        tabButton.Visible = tabVisible
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 8)
        tabCorner.Parent = tabButton
        
        if not IsMobile then
            local tabIconImage = Instance.new("ImageLabel")
            tabIconImage.Name = "Icon"
            tabIconImage.Parent = tabButton
            tabIconImage.BackgroundTransparency = 1
            tabIconImage.Position = UDim2.new(0, 8, 0.5, 0)
            tabIconImage.Size = UDim2.new(0, 18, 0, 18)
            tabIconImage.AnchorPoint = Vector2.new(0, 0.5)
            tabIconImage.Image = tabIcon
            tabIconImage.ImageColor3 = Library.CurrentTheme.SubTextColor
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
        tabText.TextSize = screenSize.FontSize.Text
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
            
            Utility:Tween(tabButton, {BackgroundColor3 = Library.CurrentTheme.AccentColor}, 0.2)
            Utility:Tween(tabText, {TextColor3 = Library.CurrentTheme.TextColor}, 0.2)
            Utility:Tween(indicator, {Size = UDim2.new(0, 3, 1, 0)}, 0.3, Enum.EasingStyle.Back)
            
            if not IsMobile then
                local iconObj = tabButton:FindFirstChild("Icon")
                if iconObj then
                    Utility:Tween(iconObj, {ImageColor3 = Library.CurrentTheme.TextColor}, 0.2)
                end
            end
            
            Utility:PlaySound(6895079853, 0.15)
        end)
        
        tabButton.MouseEnter:Connect(function()
            if Window.CurrentTab ~= tabName then
                Utility:Tween(tabButton, {BackgroundColor3 = Library.CurrentTheme.SecondBackground}, 0.2)
            end
        end)
        
        tabButton.MouseLeave:Connect(function()
            if Window.CurrentTab ~= tabName then
                Utility:Tween(tabButton, {BackgroundColor3 = Library.CurrentTheme.ThirdBackground}, 0.2)
            end
        end)
        
        local Tab = {
            Name = tabName,
            Button = tabButton,
            Content = tabContent,
            Elements = {}
        }
        
        function Tab:Deactivate()
            tabContent.Visible = false
            Utility:Tween(tabButton, {BackgroundColor3 = Library.CurrentTheme.ThirdBackground}, 0.2)
            Utility:Tween(tabText, {TextColor3 = Library.CurrentTheme.SubTextColor}, 0.2)
            Utility:Tween(indicator, {Size = UDim2.new(0, 0, 1, 0)}, 0.3)
            
            if not IsMobile then
                local iconObj = tabButton:FindFirstChild("Icon")
                if iconObj then
                    Utility:Tween(iconObj, {ImageColor3 = Library.CurrentTheme.SubTextColor}, 0.2)
                end
            end
        end
        
        function Tab:SetVisible(visible)
            tabButton.Visible = visible
        end
        
        -- AddSection Function
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
            sectionTitle.TextSize = screenSize.FontSize.Text
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
            
            -- AddButton
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
                button.TextSize = screenSize.FontSize.Text
                button.AutoButtonColor = false
                
                local btnCorner = Instance.new("UICorner")
                btnCorner.CornerRadius = UDim.new(0, 6)
                btnCorner.Parent = button
                
                button.MouseEnter:Connect(function()
                    Utility:Tween(button, {BackgroundColor3 = Library.CurrentTheme.AccentColor}, 0.2)
                end)
                
                button.MouseLeave:Connect(function()
                    Utility:Tween(button, {BackgroundColor3 = Library.CurrentTheme.ThirdBackground}, 0.2)
                end)
                
                button.MouseButton1Click:Connect(function()
                    Library.Analytics.ButtonClicks = Library.Analytics.ButtonClicks + 1
                    
                    Utility:CreateRipple(button, Mouse.X - button.AbsolutePosition.X, Mouse.Y - button.AbsolutePosition.Y)
                    Utility:Tween(button, {Size = UDim2.new(1, 0, 0, IsMobile and 37 or 31)}, 0.1)
                    task.wait(0.1)
                    Utility:Tween(button, {Size = UDim2.new(1, 0, 0, IsMobile and 40 or 34)}, 0.1)
                    
                    pcall(callback)
                    Utility:PlaySound(6895079853, 0.2)
                end)
                
                return {
                    SetText = function(text)
                        button.Text = text
                    end,
                    SetCallback = function(func)
                        callback = func
                    end
                }
            end
            
            -- AddToggle
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
                toggleLabel.TextSize = screenSize.FontSize.Text
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
                    Library.Analytics.TogglesChanged = Library.Analytics.TogglesChanged + 1
                    
                    if flag then
                        Library.Flags[flag] = value
                    end
                    
                    Utility:Tween(toggleButton, {
                        BackgroundColor3 = toggled and Library.CurrentTheme.AccentColor or Library.CurrentTheme.MainBackground
                    }, 0.2)
                    
                    Utility:Tween(toggleCircle, {
                        Position = toggled and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                    }, 0.3, Enum.EasingStyle.Back)
                    
                    pcall(function()
                        callback(toggled)
                    end)
                    
                    Utility:PlaySound(6895079853, 0.15)
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
                    end,
                    SetCallback = function(func)
                        callback = func
                    end
                }
            end
            
            -- AddSlider
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
                sliderLabel.TextSize = screenSize.FontSize.Text
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
                sliderValue.TextSize = screenSize.FontSize.SubText
                
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
                
                Utility:CreateGradient(sliderFill)
                
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
                    
                    Library.Analytics.SlidersChanged = Library.Analytics.SlidersChanged + 1
                    
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
                        Utility:Tween(sliderDot, {Size = UDim2.new(0, 16, 0, 16)}, 0.2, Enum.EasingStyle.Back)
                    end
                end)
                
                sliderBar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                        Utility:Tween(sliderDot, {Size = UDim2.new(0, 12, 0, 12)}, 0.2)
                    end
                end)
                
                Services.UserInputService.InputChanged:Connect(function(input)
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
                    end,
                    SetCallback = function(func)
                        callback = func
                    end
                }
            end
            
            -- AddDropdown
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
                dropLabel.TextSize = screenSize.FontSize.Text
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
                dropButton.TextSize = screenSize.FontSize.SubText
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
                
                local function createItem(itemName)
                    local item = Instance.new("TextButton")
                    item.Name = itemName
                    item.Parent = itemList
                    item.BackgroundColor3 = Library.CurrentTheme.MainBackground
                    item.BorderSizePixel = 0
                    item.Size = UDim2.new(1, 0, 0, IsMobile and 28 or 24)
                    item.Font = Enum.Font.Gotham
                    item.Text = "  " .. itemName
                    item.TextColor3 = Library.CurrentTheme.TextColor
                    item.TextSize = screenSize.FontSize.SubText
                    item.TextXAlignment = Enum.TextXAlignment.Left
                    item.AutoButtonColor = false
                    item.TextTruncate = Enum.TextTruncate.AtEnd
                    
                    local itemCorner = Instance.new("UICorner")
                    itemCorner.CornerRadius = UDim.new(0, 5)
                    itemCorner.Parent = item
                    
                    item.MouseEnter:Connect(function()
                        Utility:Tween(item, {BackgroundColor3 = Library.CurrentTheme.AccentColor}, 0.2)
                    end)
                    
                    item.MouseLeave:Connect(function()
                        Utility:Tween(item, {BackgroundColor3 = Library.CurrentTheme.MainBackground}, 0.2)
                    end)
                    
                    item.MouseButton1Click:Connect(function()
                        currentValue = itemName
                        dropButton.Text = "  " .. itemName
                        
                        Library.Analytics.DropdownsChanged = Library.Analytics.DropdownsChanged + 1
                        
                        if flag then
                            Library.Flags[flag] = itemName
                        end
                        
                        pcall(function()
                            callback(itemName)
                        end)
                        
                        expanded = false
                        Utility:Tween(dropdown, {Size = UDim2.new(1, 0, 0, IsMobile and 40 or 34)}, 0.3, Enum.EasingStyle.Back)
                        Utility:Tween(arrow, {Rotation = 0}, 0.3)
                        
                        Utility:PlaySound(6895079853, 0.15)
                    end)
                    
                    return item
                end
                
                for _, itemName in ipairs(items) do
                    createItem(itemName)
                end
                
                dropButton.MouseButton1Click:Connect(function()
                    expanded = not expanded
                    if expanded then
                        local itemCount = math.min(#items, 4)
                        local itemHeight = IsMobile and 28 or 24
                        local baseHeight = IsMobile and 40 or 34
                        Utility:Tween(dropdown, {Size = UDim2.new(1, 0, 0, baseHeight + 8 + (itemCount * (itemHeight + 3)))}, 0.3, Enum.EasingStyle.Back)
                        Utility:Tween(arrow, {Rotation = 180}, 0.3)
                        itemList.Size = UDim2.new(1, -12, 0, itemCount * (itemHeight + 3))
                    else
                        Utility:Tween(dropdown, {Size = UDim2.new(1, 0, 0, IsMobile and 40 or 34)}, 0.3, Enum.EasingStyle.Back)
                        Utility:Tween(arrow, {Rotation = 0}, 0.3)
                    end
                    
                    Utility:PlaySound(6895079853, 0.15)
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
                            createItem(itemName)
                        end
                        
                        if newDefault and table.find(newItems, newDefault) then
                            currentValue = newDefault
                            dropButton.Text = "  " .. newDefault
                            
                            if flag then
                                Library.Flags[flag] = newDefault
                            end
                        end
                    end,
                    SetCallback = function(func)
                        callback = func
                    end
                }
            end
            
            -- AddTextbox
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
                textLabel.TextSize = screenSize.FontSize.Text
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
                textInput.TextSize = screenSize.FontSize.SubText
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
                        Library.Analytics.TextboxChanged = Library.Analytics.TextboxChanged + 1
                        
                        if flag then
                            Library.Flags[flag] = textInput.Text
                        end
                        
                        pcall(function()
                            callback(textInput.Text)
                        end)
                    end
                end)
                
                textInput.Focused:Connect(function()
                    Utility:Tween(textInput, {BackgroundColor3 = Library.CurrentTheme.SecondBackground}, 0.2)
                end)
                
                textInput.FocusLost:Connect(function()
                    Utility:Tween(textInput, {BackgroundColor3 = Library.CurrentTheme.MainBackground}, 0.2)
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
                    end,
                    SetCallback = function(func)
                        callback = func
                    end
                }
            end
            
            -- AddLabel
            function Section:AddLabel(text)
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Parent = sectionContent
                label.BackgroundTransparency = 1
                label.Size = UDim2.new(1, 0, 0, IsMobile and 22 or 20)
                label.Font = Enum.Font.Gotham
                label.Text = text
                label.TextColor3 = Library.CurrentTheme.SubTextColor
                label.TextSize = screenSize.FontSize.Text
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextWrapped = true
                label.AutomaticSize = Enum.AutomaticSize.Y
                
                return {
                    Set = function(newText)
                        label.Text = newText
                    end
                }
            end
            
            -- AddParagraph
            function Section:AddParagraph(title, content)
                local paragraph = Instance.new("Frame")
                paragraph.Name = "Paragraph"
                paragraph.Parent = sectionContent
                paragraph.BackgroundColor3 = Library.CurrentTheme.MainBackground
                paragraph.BorderSizePixel = 0
                paragraph.Size = UDim2.new(1, 0, 0, 50)
                paragraph.AutomaticSize = Enum.AutomaticSize.Y
                
                local paraCorner = Instance.new("UICorner")
                paraCorner.CornerRadius = UDim.new(0, 6)
                paraCorner.Parent = paragraph
                
                local paraTitle = Instance.new("TextLabel")
                paraTitle.Parent = paragraph
                paraTitle.BackgroundTransparency = 1
                paraTitle.Position = UDim2.new(0, 10, 0, 8)
                paraTitle.Size = UDim2.new(1, -20, 0, 16)
                paraTitle.Font = Enum.Font.GothamBold
                paraTitle.Text = title
                paraTitle.TextColor3 = Library.CurrentTheme.TextColor
                paraTitle.TextSize = screenSize.FontSize.Text
                paraTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                local paraContent = Instance.new("TextLabel")
                paraContent.Parent = paragraph
                paraContent.BackgroundTransparency = 1
                paraContent.Position = UDim2.new(0, 10, 0, 26)
                paraContent.Size = UDim2.new(1, -20, 1, -34)
                paraContent.Font = Enum.Font.Gotham
                paraContent.Text = content
                paraContent.TextColor3 = Library.CurrentTheme.SubTextColor
                paraContent.TextSize = screenSize.FontSize.SubText
                paraContent.TextXAlignment = Enum.TextXAlignment.Left
                paraContent.TextYAlignment = Enum.TextYAlignment.Top
                paraContent.TextWrapped = true
                paraContent.AutomaticSize = Enum.AutomaticSize.Y
                
                local paraPadding = Instance.new("UIPadding")
                paraPadding.Parent = paragraph
                paraPadding.PaddingBottom = UDim.new(0, 8)
                
                return {
                    SetTitle = function(newTitle)
                        paraTitle.Text = newTitle
                    end,
                    SetContent = function(newContent)
                        paraContent.Text = newContent
                    end
                }
            end
            
            -- AddDivider
            function Section:AddDivider()
                local divider = Instance.new("Frame")
                divider.Name = "Divider"
                divider.Parent = sectionContent
                divider.BackgroundColor3 = Library.CurrentTheme.DividerColor
                divider.BorderSizePixel = 0
                divider.Size = UDim2.new(1, 0, 0, 1)
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
        table.insert(Library.Elements, Tab)
        return Tab
    end
    
    -- AddWatermark
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
        watermark.TextSize = screenSize.FontSize.Text
        
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
    
    -- Open Animation
    Utility:Tween(mainContainer, {
        Size = windowSize
    }, 0.6, Enum.EasingStyle.Back)
    
    task.delay(0.7, function()
        if Library.Settings.EnableNotifications then
            Library:Notify({
                Title = "Welcome!",
                Description = windowConfig.Title .. " loaded successfully",
                Type = "Success",
                Duration = 3
            })
        end
    end)
    
    -- Auto-save
    if windowConfig.AutoSave then
        Library.ConfigSystem:AutoSave(windowConfig.ConfigName, windowConfig.AutoSaveInterval)
    end
    
    return Window
end

-- ═══════════════════════════════════════════════════════
-- 🔄 Update Analytics
-- ═══════════════════════════════════════════════════════

task.spawn(function()
    while true do
        task.wait(1)
        if Library.Settings.EnableAnalytics then
            Library.Analytics.TotalSessionTime = tick() - Library.Analytics.SessionStartTime
        end
    end
end)

-- ═══════════════════════════════════════════════════════
-- 📊 Return Library
-- ═══════════════════════════════════════════════════════

return Library
