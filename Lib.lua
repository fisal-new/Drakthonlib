--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║         DRAKTHON UI LIBRARY V3.0 FINAL - PRODUCTION          ║
    ║                                                              ║
    ║  ✅ Fixed: Canvas Size Conflicts                            ║
    ║  ✅ Fixed: Memory Leaks                                     ║
    ║  ✅ Added: Maid System                                      ║
    ║  ✅ Added: Error Handling                                   ║
    ║  ✅ Added: Update Methods                                   ║
    ║  ✅ Added: Mobile Support                                   ║
    ║  ✅ Optimized: Performance                                  ║
    ╚══════════════════════════════════════════════════════════════╝
]]

local DrakthonLib = {}

-- ═══════════════════════════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════════════════════════
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ═══════════════════════════════════════════════════════════════
-- DEVICE DETECTION
-- ═══════════════════════════════════════════════════════════════
local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

-- ═══════════════════════════════════════════════════════════════
-- PRE-CREATED CONSTANTS (Performance Optimization)
-- ═══════════════════════════════════════════════════════════════

-- Colors Cache
local Colors = {
    Background = Color3.fromRGB(33, 33, 33),
    DarkBackground = Color3.fromRGB(28, 28, 28),
    Sidebar = Color3.fromRGB(26, 26, 26),
    LightBackground = Color3.fromRGB(44, 44, 44),
    Border = Color3.fromRGB(55, 55, 55),
    BorderDark = Color3.fromRGB(60, 60, 60),
    Accent = Color3.fromRGB(80, 140, 220),
    AccentHover = Color3.fromRGB(100, 160, 240),
    Success = Color3.fromRGB(80, 200, 120),
    Danger = Color3.fromRGB(190, 50, 50),
    DangerHover = Color3.fromRGB(220, 70, 70),
    DangerPressed = Color3.fromRGB(240, 90, 90),
    ButtonPrimary = Color3.fromRGB(60, 120, 200),
    ButtonHover = Color3.fromRGB(80, 140, 220),
    ButtonPressed = Color3.fromRGB(50, 110, 190),
    TabNormal = Color3.fromRGB(33, 33, 33),
    TabHover = Color3.fromRGB(44, 44, 44),
    TabActive = Color3.fromRGB(50, 50, 50),
    ControlNormal = Color3.fromRGB(55, 55, 55),
    ControlHover = Color3.fromRGB(75, 75, 75),
    ControlPressed = Color3.fromRGB(90, 90, 90),
    SliderBg = Color3.fromRGB(60, 60, 60),
    White = Color3.fromRGB(255, 255, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(200, 200, 200),
    Black = Color3.fromRGB(0, 0, 0),
}

-- TweenInfo Cache
local TWEEN_INFO_NORMAL = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_INFO_FAST = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_INFO_BACK = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local TWEEN_INFO_BACK_FAST = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- ZIndex Layers
local ZIndexLayers = {
    BackgroundOverlay = 1,
    MainWindow = 2,
    TitleBar = 3,
    Sidebar = 3,
    Content = 3,
    TabButton = 5,
    TabIndicator = 6,
    TabLabel = 7,
    Element = 6,
    ElementContent = 7,
    DropdownList = 50,
    DropdownItem = 51,
    ConfirmationOverlay = 500,
    ConfirmationModal = 501,
    LoaderIcon = 10,
}

-- Vectors Cache
local Vectors = {
    Center = Vector2.new(0.5, 0.5),
    Zero = Vector2.new(0, 0),
    One = Vector2.new(1, 1),
}

-- ═══════════════════════════════════════════════════════════════
-- MAID SYSTEM (Memory Management)
-- ═══════════════════════════════════════════════════════════════
local Maid = {}
Maid.__index = Maid

function Maid.new()
    return setmetatable({
        _tasks = {}
    }, Maid)
end

function Maid:Add(task)
    table.insert(self._tasks, task)
    return task
end

function Maid:Cleanup()
    for _, task in ipairs(self._tasks) do
        if typeof(task) == "RBXScriptConnection" then
            task:Disconnect()
        elseif typeof(task) == "Instance" then
            task:Destroy()
        elseif type(task) == "function" then
            task()
        elseif type(task) == "table" and task.Cleanup then
            task:Cleanup()
        end
    end
    self._tasks = {}
end

-- ═══════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

local function CreateInstance(className, properties)
    local instance = Instance.new(className)
    for property, value in pairs(properties) do
        if property ~= "Parent" then
            instance[property] = value
        end
    end
    if properties.Parent then
        instance.Parent = properties.Parent
    end
    return instance
end

local function Tween(object, properties, tweenInfo)
    tweenInfo = tweenInfo or TWEEN_INFO_NORMAL
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

local function SafeCallback(callback, ...)
    local args = {...}
    task.spawn(function()
        local success, result = pcall(callback, table.unpack(args))
        if not success then
            warn("[Drakthon UI] Callback Error:", result)
        end
    end)
end

local function GetResponsiveSize(pcSize, mobileMultiplier)
    if isMobile then
        return pcSize * (mobileMultiplier or 1.2)
    end
    return pcSize
end

-- ═══════════════════════════════════════════════════════════════
-- IMPROVED DRAGGABLE (Fixed Memory Leak)
-- ═══════════════════════════════════════════════════════════════
local function MakeDraggable(frame, dragHandle, backgroundOverlay, maid)
    local dragConnection
    local framePos
    
    maid:Add(dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            
            local mousePos = input.Position
            framePos = frame.Position
            
            if backgroundOverlay then
                backgroundOverlay.Visible = true
                Tween(backgroundOverlay, {BackgroundTransparency = 0.3}, TWEEN_INFO_FAST)
            end
            
            dragConnection = UserInputService.InputChanged:Connect(function(changedInput)
                if changedInput.UserInputType == input.UserInputType then
                    local delta = changedInput.Position - mousePos
                    local viewport = workspace.CurrentCamera.ViewportSize
                    
                    local newPosX = framePos.X.Scale * viewport.X + framePos.X.Offset + delta.X
                    local newPosY = framePos.Y.Scale * viewport.Y + framePos.Y.Offset + delta.Y
                    
                    -- Dragging Bounds (keep part of window visible)
                    local minVisible = 50
                    newPosX = math.clamp(newPosX, -(frame.AbsoluteSize.X - minVisible), viewport.X - minVisible)
                    newPosY = math.clamp(newPosY, 0, viewport.Y - minVisible)
                    
                    frame.Position = UDim2.new(0, newPosX, 0, newPosY)
                end
            end)
        end
    end))
    
    maid:Add(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            if dragConnection then
                dragConnection:Disconnect()
                dragConnection = nil
                
                if backgroundOverlay and backgroundOverlay.Visible then
                    Tween(backgroundOverlay, {BackgroundTransparency = 1}, TWEEN_INFO_NORMAL)
                    task.delay(0.3, function()
                        if backgroundOverlay then
                            backgroundOverlay.Visible = false
                        end
                    end)
                end
            end
        end
    end))
end

-- ═══════════════════════════════════════════════════════════════
-- IMPROVED RESIZABLE (Fixed Memory Leak + Bounds)
-- ═══════════════════════════════════════════════════════════════
local function MakeResizable(frame, minSize, maid)
    local resizeButton = CreateInstance("TextButton", {
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(1, -20, 1, -20),
        AnchorPoint = Vectors.One,
        BackgroundColor3 = Colors.ControlNormal,
        Text = "",
        ZIndex = 100,
        Parent = frame
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = resizeButton
    })
    
    CreateInstance("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "⇲",
        TextColor3 = Colors.TextSecondary,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        Parent = resizeButton
    })
    
    local resizeConnection
    local startSize
    
    maid:Add(resizeButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            
            local startPos = input.Position
            startSize = frame.AbsoluteSize
            
            resizeConnection = UserInputService.InputChanged:Connect(function(changedInput)
                if changedInput.UserInputType == input.UserInputType then
                    local delta = changedInput.Position - startPos
                    
                    local newWidth = math.max(minSize.X, startSize.X + delta.X)
                    local newHeight = math.max(minSize.Y, startSize.Y + delta.Y)
                    
                    -- Max bounds (screen size)
                    local viewport = workspace.CurrentCamera.ViewportSize
                    newWidth = math.min(newWidth, viewport.X - 20)
                    newHeight = math.min(newHeight, viewport.Y - 20)
                    
                    frame.Size = UDim2.new(0, newWidth, 0, newHeight)
                end
            end)
        end
    end))
    
    maid:Add(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            if resizeConnection then
                resizeConnection:Disconnect()
                resizeConnection = nil
            end
        end
    end))
end

-- ═══════════════════════════════════════════════════════════════
-- IMPROVED HOVER EFFECT (Mobile Support)
-- ═══════════════════════════════════════════════════════════════
local function AddHoverEffect(button, normalColor, hoverColor, pressedColor, maid)
    if not isMobile then
        maid:Add(button.MouseEnter:Connect(function()
            Tween(button, {BackgroundColor3 = hoverColor}, TWEEN_INFO_FAST)
        end))
        
        maid:Add(button.MouseLeave:Connect(function()
            Tween(button, {BackgroundColor3 = normalColor}, TWEEN_INFO_FAST)
        end))
    end
    
    if pressedColor then
        maid:Add(button.MouseButton1Down:Connect(function()
            Tween(button, {BackgroundColor3 = pressedColor}, TWEEN_INFO_FAST)
        end))
        
        maid:Add(button.MouseButton1Up:Connect(function()
            local targetColor = (isMobile and normalColor) or hoverColor
            Tween(button, {BackgroundColor3 = targetColor}, TWEEN_INFO_FAST)
        end))
    end
end

-- ═══════════════════════════════════════════════════════════════
-- MAIN WINDOW FUNCTION
-- ═══════════════════════════════════════════════════════════════

function DrakthonLib:MakeWindow(options)
    options = options or {}
    local windowName = options.Name or "Drakthon Library"
    local defaultSize = options.DefaultSize or UDim2.new(0, 700, 0, 500)
    local minSize = options.MinSize or Vector2.new(500, 350)
    local loaderImage = options.LoaderImage or "rbxassetid://11422155687"
    
    -- Window Maid (Memory Management)
    local windowMaid = Maid.new()
    local activeTweens = {}
    
    -- ═══════════════════════════════════════════════════════════
    -- SCREEN GUI
    -- ═══════════════════════════════════════════════════════════
    local screenGuiName = "DrakthonLib_" .. tostring(os.clock()):gsub("%.", "")
    
    local screenGui = CreateInstance("ScreenGui", {
        Name = screenGuiName,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = PlayerGui
    })
    
    windowMaid:Add(screenGui)
    
    -- ═══════════════════════════════════════════════════════════
    -- BACKGROUND OVERLAY
    -- ═══════════════════════════════════════════════════════════
    local backgroundOverlay = CreateInstance("Frame", {
        Name = "BackgroundOverlay",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Colors.Black,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = ZIndexLayers.BackgroundOverlay,
        Parent = screenGui
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- MAIN WINDOW FRAME
    -- ═══════════════════════════════════════════════════════════
    local mainFrame = CreateInstance("Frame", {
        Name = "MainWindow",
        Size = defaultSize,
        Position = UDim2.new(0.5, -350, 0.5, -250),
        AnchorPoint = Vectors.Zero,
        BackgroundColor3 = Colors.Background,
        BorderSizePixel = 0,
        ClipsDescendants = false,
        ZIndex = ZIndexLayers.MainWindow,
        Parent = screenGui
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = mainFrame
    })
    
    CreateInstance("UIStroke", {
        Color = Colors.Border,
        Thickness = 1.5,
        Transparency = 0.5,
        Parent = mainFrame
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- TITLE BAR
    -- ═══════════════════════════════════════════════════════════
    local titleBarHeight = GetResponsiveSize(45, 1.2)
    
    local titleBar = CreateInstance("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, titleBarHeight),
        BackgroundColor3 = Colors.DarkBackground,
        BorderSizePixel = 0,
        ZIndex = ZIndexLayers.TitleBar,
        Parent = mainFrame
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = titleBar
    })
    
    CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 15),
        Position = UDim2.new(0, 0, 1, -15),
        BackgroundColor3 = Colors.DarkBackground,
        BorderSizePixel = 0,
        ZIndex = ZIndexLayers.TitleBar,
        Parent = titleBar
    })
    
    CreateInstance("TextLabel", {
        Size = UDim2.new(1, -120, 1, 0),
        Position = UDim2.new(0, 20, 0, 0),
        BackgroundTransparency = 1,
        Text = "🌙 " .. windowName,
        TextColor3 = Colors.Text,
        TextSize = GetResponsiveSize(16, 1.1),
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = ZIndexLayers.TitleBar + 1,
        Parent = titleBar
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- CONTROL BUTTONS
    -- ═══════════════════════════════════════════════════════════
    local minimizeBtn = CreateInstance("TextButton", {
        Size = UDim2.new(0, 40, 0, 30),
        Position = UDim2.new(1, -95, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Colors.ControlNormal,
        Text = "—",
        TextColor3 = Colors.Text,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        ZIndex = ZIndexLayers.TitleBar + 1,
        Parent = titleBar
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = minimizeBtn
    })
    
    local closeBtn = CreateInstance("TextButton", {
        Size = UDim2.new(0, 40, 0, 30),
        Position = UDim2.new(1, -45, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Colors.Danger,
        Text = "✕",
        TextColor3 = Colors.Text,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        ZIndex = ZIndexLayers.TitleBar + 1,
        Parent = titleBar
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = closeBtn
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- LOADER ICON
    -- ═══════════════════════════════════════════════════════════
    local loaderIcon = CreateInstance("ImageButton", {
        Name = "LoaderIcon",
        Size = UDim2.new(0, 70, 0, 70),
        Position = UDim2.new(0, 20, 1, -90),
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = Colors.DarkBackground,
        Image = loaderImage,
        ScaleType = Enum.ScaleType.Fit,
        Visible = false,
        ZIndex = ZIndexLayers.LoaderIcon,
        Parent = screenGui
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 15),
        Parent = loaderIcon
    })
    
    CreateInstance("UIStroke", {
        Color = Colors.Accent,
        Thickness = 3,
        Parent = loaderIcon
    })
    
    local loaderMaid = Maid.new()
    MakeDraggable(loaderIcon, loaderIcon, nil, loaderMaid)
    windowMaid:Add(loaderMaid)
    
    local loaderRotation = 0
    local loaderConnection
    
    -- ═══════════════════════════════════════════════════════════
    -- CONFIRMATION MODAL (Fixed: Parent = screenGui)
    -- ═══════════════════════════════════════════════════════════
    local confirmOverlay = CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Colors.Black,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = ZIndexLayers.ConfirmationOverlay,
        Parent = screenGui
    })
    
    local confirmModal = CreateInstance("Frame", {
        Size = UDim2.new(0, 350, 0, 170),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vectors.Center,
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        BorderSizePixel = 0,
        ZIndex = ZIndexLayers.ConfirmationModal,
        Parent = confirmOverlay
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = confirmModal
    })
    
    CreateInstance("UIStroke", {
        Color = Colors.Danger,
        Thickness = 2.5,
        Parent = confirmModal
    })
    
    CreateInstance("TextLabel", {
        Size = UDim2.new(1, -20, 0, 35),
        Position = UDim2.new(0, 10, 0, 15),
        BackgroundTransparency = 1,
        Text = "⚠️ تحذير",
        TextColor3 = Color3.fromRGB(255, 200, 50),
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = ZIndexLayers.ConfirmationModal + 1,
        Parent = confirmModal
    })
    
    CreateInstance("TextLabel", {
        Size = UDim2.new(1, -30, 0, 50),
        Position = UDim2.new(0, 15, 0, 55),
        BackgroundTransparency = 1,
        Text = "هل أنت متأكد أنك تريد إغلاق الواجهة؟",
        TextColor3 = Color3.fromRGB(220, 220, 220),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Top,
        ZIndex = ZIndexLayers.ConfirmationModal + 1,
        Parent = confirmModal
    })
    
    local confirmYesBtn = CreateInstance("TextButton", {
        Size = UDim2.new(0, 140, 0, 40),
        Position = UDim2.new(0.5, -150, 1, -50),
        BackgroundColor3 = Colors.Danger,
        Text = "✓ نعم",
        TextColor3 = Colors.Text,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        ZIndex = ZIndexLayers.ConfirmationModal + 1,
        Parent = confirmModal
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = confirmYesBtn
    })
    
    local confirmNoBtn = CreateInstance("TextButton", {
        Size = UDim2.new(0, 140, 0, 40),
        Position = UDim2.new(0.5, 10, 1, -50),
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        Text = "✕ لا",
        TextColor3 = Colors.Text,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        ZIndex = ZIndexLayers.ConfirmationModal + 1,
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
        Size = UDim2.new(0.35, 0, 1, -titleBarHeight),
        Position = UDim2.new(0, 0, 0, titleBarHeight),
        BackgroundColor3 = Colors.Sidebar,
        BorderSizePixel = 0,
        ZIndex = ZIndexLayers.Sidebar,
        Parent = mainFrame
    })
    
    local tabsContainer = CreateInstance("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Colors.Border,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ZIndex = ZIndexLayers.Sidebar + 1,
        Parent = sidebar
    })
    
    local tabsLayout = CreateInstance("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        Parent = tabsContainer
    })
    
    CreateInstance("UIPadding", {
        PaddingTop = UDim.new(0, 12),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 12),
        Parent = tabsContainer
    })
    
    windowMaid:Add(tabsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabsContainer.CanvasSize = UDim2.new(0, 0, 0, tabsLayout.AbsoluteContentSize.Y + 24)
    end))
    
    -- ═══════════════════════════════════════════════════════════
    -- CONTENT AREA
    -- ═══════════════════════════════════════════════════════════
    local contentArea = CreateInstance("Frame", {
        Size = UDim2.new(0.65, 0, 1, -titleBarHeight),
        Position = UDim2.new(0.35, 0, 0, titleBarHeight),
        BackgroundColor3 = Colors.Background,
        BorderSizePixel = 0,
        ZIndex = ZIndexLayers.Content,
        Parent = mainFrame
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- BUTTON INTERACTIONS
    -- ═══════════════════════════════════════════════════════════
    AddHoverEffect(minimizeBtn, Colors.ControlNormal, Colors.ControlHover, Colors.ControlPressed, windowMaid)
    AddHoverEffect(closeBtn, Colors.Danger, Colors.DangerHover, Colors.DangerPressed, windowMaid)
    AddHoverEffect(confirmYesBtn, Colors.Danger, Colors.DangerHover, nil, windowMaid)
    AddHoverEffect(confirmNoBtn, Color3.fromRGB(60, 60, 60), Color3.fromRGB(80, 80, 80), nil, windowMaid)
    
    -- Close Button
    windowMaid:Add(closeBtn.MouseButton1Click:Connect(function()
        confirmOverlay.Visible = true
        confirmOverlay.BackgroundTransparency = 1
        Tween(confirmOverlay, {BackgroundTransparency = 0.5}, TWEEN_INFO_FAST)
        confirmModal.Size = UDim2.new(0, 0, 0, 0)
        Tween(confirmModal, {Size = UDim2.new(0, 350, 0, 170)}, TWEEN_INFO_BACK)
    end))
    
    windowMaid:Add(confirmYesBtn.MouseButton1Click:Connect(function()
        local closeTween = Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, TWEEN_INFO_BACK)
        closeTween.Completed:Wait()
        windowMaid:Cleanup()
    end))
    
    windowMaid:Add(confirmNoBtn.MouseButton1Click:Connect(function()
        local closeTween = Tween(confirmModal, {Size = UDim2.new(0, 0, 0, 0)}, TWEEN_INFO_BACK_FAST)
        Tween(confirmOverlay, {BackgroundTransparency = 1}, TWEEN_INFO_NORMAL)
        closeTween.Completed:Wait()
        confirmOverlay.Visible = false
    end))
    
    -- Minimize Button
    windowMaid:Add(minimizeBtn.MouseButton1Click:Connect(function()
        local minimizeTween = Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, TWEEN_INFO_BACK_FAST)
        minimizeTween.Completed:Wait()
        mainFrame.Visible = false
        loaderIcon.Visible = true
        
        loaderConnection = RunService.RenderStepped:Connect(function()
            loaderRotation = (loaderRotation + 2) % 360
            loaderIcon.Rotation = loaderRotation
        end)
        
        Tween(loaderIcon, {Size = UDim2.new(0, 80, 0, 80)}, TWEEN_INFO_BACK_FAST)
    end))
    
    windowMaid:Add(loaderIcon.MouseButton1Click:Connect(function()
        if loaderConnection then
            loaderConnection:Disconnect()
            loaderConnection = nil
        end
        
        local loaderTween = Tween(loaderIcon, {Size = UDim2.new(0, 0, 0, 0)}, TWEEN_INFO_BACK_FAST)
        loaderTween.Completed:Wait()
        loaderIcon.Visible = false
        loaderIcon.Rotation = 0
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        Tween(mainFrame, {Size = defaultSize}, TWEEN_INFO_BACK)
    end))
    
    AddHoverEffect(loaderIcon, Colors.DarkBackground, Color3.fromRGB(40, 40, 40), nil, windowMaid)
    
    MakeDraggable(mainFrame, titleBar, backgroundOverlay, windowMaid)
    MakeResizable(mainFrame, minSize, windowMaid)
    
    -- ═══════════════════════════════════════════════════════════
    -- WINDOW OBJECT
    -- ═══════════════════════════════════════════════════════════
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        OpenDropdowns = {},
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        _maid = windowMaid
    }
    
    function Window:CloseAllDropdowns(except)
        for dropdown, closeFunc in pairs(self.OpenDropdowns) do
            if dropdown ~= except then
                closeFunc()
            end
        end
    end
    
    function Window:Destroy()
        if loaderConnection then
            loaderConnection:Disconnect()
            loaderConnection = nil
        end
        
        for _, tween in ipairs(activeTweens) do
            tween:Cancel()
        end
        activeTweens = {}
        
        windowMaid:Cleanup()
    end
    
    -- ═══════════════════════════════════════════════════════════
    -- MAKE TAB FUNCTION (FIXED: Each Tab has own ScrollingFrame)
    -- ═══════════════════════════════════════════════════════════
    function Window:MakeTab(options)
        options = options or {}
        local tabName = options.Name or "Tab"
        local tabIcon = options.Icon or ""
        
        local tabMaid = Maid.new()
        windowMaid:Add(tabMaid)
        
        -- Tab Button
        local tabButton = CreateInstance("TextButton", {
            Size = UDim2.new(1, 0, 0, GetResponsiveSize(55, 1.1)),
            BackgroundColor3 = Colors.TabNormal,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            ClipsDescendants = false,
            ZIndex = ZIndexLayers.TabButton,
            Parent = tabsContainer
        })
        
        CreateInstance("UICorner", {
            CornerRadius = UDim.new(0, 8),
            Parent = tabButton
        })
        
        local activeIndicator = CreateInstance("Frame", {
            Size = UDim2.new(0, 0, 0, 40),
            Position = UDim2.new(0, -5, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Colors.Accent,
            BorderSizePixel = 0,
            ZIndex = ZIndexLayers.TabIndicator,
            Parent = tabButton
        })
        
        CreateInstance("UICorner", {
            CornerRadius = UDim.new(1, 0),
            Parent = activeIndicator
        })
        
        local iconOffset = 15
        if tabIcon ~= "" then
            CreateInstance("ImageLabel", {
                Size = UDim2.new(0, 32, 0, 32),
                Position = UDim2.new(0, 18, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                Image = tabIcon,
                ScaleType = Enum.ScaleType.Fit,
                ZIndex = ZIndexLayers.TabLabel,
                Parent = tabButton
            })
            iconOffset = 58
        end
        
        CreateInstance("TextLabel", {
            Size = UDim2.new(1, -iconOffset - 10, 1, 0),
            Position = UDim2.new(0, iconOffset, 0, 0),
            BackgroundTransparency = 1,
            Text = tabName,
            TextColor3 = Colors.TextSecondary,
            TextSize = GetResponsiveSize(14, 1.1),
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            ZIndex = ZIndexLayers.TabLabel,
            Parent = tabButton
        })
        
        -- ✅ FIXED: ScrollingFrame for each Tab
        local tabScrollFrame = CreateInstance("ScrollingFrame", {
            Name = tabName .. "_ScrollFrame",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 6,
            ScrollBarImageColor3 = Colors.Border,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            ClipsDescendants = true,
            ZIndex = ZIndexLayers.Content,
            Parent = contentArea
        })
        
        CreateInstance("UIPadding", {
            PaddingTop = UDim.new(0, 15),
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 15),
            PaddingBottom = UDim.new(0, 15),
            Parent = tabScrollFrame
        })
        
        local tabLayout = CreateInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10),
            Parent = tabScrollFrame
        })
        
        -- ✅ Each Tab manages its own CanvasSize
        tabMaid:Add(tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 30)
        end))
        
        -- Tab Click Handler
        tabMaid:Add(tabButton.MouseButton1Click:Connect(function()
            local previousTab = Window.CurrentTab
            
            if previousTab and previousTab ~= tabName then
                for _, tab in pairs(Window.Tabs) do
                    if tab.Name == previousTab then
                        Tween(tab.Button, {BackgroundColor3 = Colors.TabNormal}, TWEEN_INFO_FAST)
                        tab.ScrollFrame.Visible = false
                        Tween(tab.ActiveIndicator, {
                            Size = UDim2.new(0, 0, 0, 40),
                            Position = UDim2.new(0, -5, 0.5, 0)
                        }, TWEEN_INFO_BACK_FAST)
                        break
                    end
                end
            end
            
            Tween(tabButton, {BackgroundColor3 = Colors.TabActive}, TWEEN_INFO_FAST)
            tabScrollFrame.Visible = true
            
            Tween(activeIndicator, {
                Size = UDim2.new(0, 5, 0, 40),
                Position = UDim2.new(0, 0, 0.5, 0)
            }, TWEEN_INFO_BACK)
            
            Window.CurrentTab = tabName
        end))
        
        AddHoverEffect(tabButton, Colors.TabNormal, Colors.TabHover, nil, tabMaid)
        
        local Tab = {
            Name = tabName,
            Button = tabButton,
            ScrollFrame = tabScrollFrame,
            Layout = tabLayout,
            ActiveIndicator = activeIndicator,
            Elements = {},
            _maid = tabMaid
        }
        
        -- Auto-select first tab
        if #Window.Tabs == 0 then
            tabButton.BackgroundColor3 = Colors.TabActive
            tabScrollFrame.Visible = true
            activeIndicator.Size = UDim2.new(0, 5, 0, 40)
            activeIndicator.Position = UDim2.new(0, 0, 0.5, 0)
            Window.CurrentTab = tabName
        end
        
        table.insert(Window.Tabs, Tab)
        
        -- ═══════════════════════════════════════════════════════
        -- CREATE ELEMENT CONTAINER (DRY Principle)
        -- ═══════════════════════════════════════════════════════
        local function CreateElementContainer(height, useAutoSize)
            local container = CreateInstance("Frame", {
                Size = useAutoSize and UDim2.new(1, 0, 0, 0) or UDim2.new(1, 0, 0, height),
                AutomaticSize = useAutoSize and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
                BackgroundColor3 = Colors.LightBackground,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                Parent = tabScrollFrame
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = container
            })
            
            CreateInstance("UIStroke", {
                Color = Colors.BorderDark,
                Thickness = 1,
                Transparency = 0.7,
                Parent = container
            })
            
            CreateInstance("UIPadding", {
                PaddingAll = UDim.new(0, 15),
                Parent = container
            })
            
            table.insert(Tab.Elements, container)
            return container
        end
        
        -- ═══════════════════════════════════════════════════════
        -- ADD PARAGRAPH (With Update Methods)
        -- ═══════════════════════════════════════════════════════
        function Tab:AddParagraph(options)
            options = options or {}
            local title = options.Title or "Paragraph"
            local text = options.Text or "No text provided"
            
            local container = CreateElementContainer(0, true)
            
            local titleLabel = CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 22),
                BackgroundTransparency = 1,
                Text = "📝 " .. title,
                TextColor3 = Colors.Text,
                TextSize = GetResponsiveSize(15, 1.1),
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = container
            })
            
            local textLabel = CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 28),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = text,
                TextColor3 = Colors.TextSecondary,
                TextSize = GetResponsiveSize(13, 1.1),
                Font = Enum.Font.Gotham,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                Parent = container
            })
            
            local paragraphObj = {
                Container = container,
                SetTitle = function(self, newTitle)
                    titleLabel.Text = "📝 " .. newTitle
                end,
                SetText = function(self, newText)
                    textLabel.Text = newText
                end,
                Destroy = function(self)
                    container:Destroy()
                end
            }
            
            return paragraphObj
        end
        
        -- ═══════════════════════════════════════════════════════
        -- ADD BUTTON (With Error Handling)
        -- ═══════════════════════════════════════════════════════
        function Tab:AddButton(options)
            options = options or {}
            local title = options.Title or "Button"
            local text = options.Text or "Click Me"
            local icon = options.Icon or ""
            local callback = options.Callback or function() end
            
            local container = CreateElementContainer(90, false)
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 22),
                BackgroundTransparency = 1,
                Text = "🔘 " .. title,
                TextColor3 = Colors.Text,
                TextSize = GetResponsiveSize(15, 1.1),
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = container
            })
            
            local button = CreateInstance("TextButton", {
                Size = UDim2.new(1, 0, 0, 40),
                Position = UDim2.new(0, 0, 0, 35),
                BackgroundColor3 = Colors.ButtonPrimary,
                Text = text,
                TextColor3 = Colors.Text,
                TextSize = GetResponsiveSize(14, 1.1),
                Font = Enum.Font.GothamBold,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = button
            })
            
            if icon ~= "" then
                CreateInstance("ImageLabel", {
                    Size = UDim2.new(0, 24, 0, 24),
                    Position = UDim2.new(1, -30, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundTransparency = 1,
                    Image = icon,
                    Parent = button
                })
            end
            
            tabMaid:Add(button.MouseButton1Click:Connect(function()
                local pressTween = Tween(button, {Size = UDim2.new(0.98, 0, 0, 38)}, TWEEN_INFO_FAST)
                pressTween.Completed:Wait()
                Tween(button, {Size = UDim2.new(1, 0, 0, 40)}, TWEEN_INFO_FAST)
                
                SafeCallback(callback)
            end))
            
            AddHoverEffect(button, Colors.ButtonPrimary, Colors.ButtonHover, Colors.ButtonPressed, tabMaid)
            
            local buttonObj = {
                Container = container,
                SetText = function(self, newText)
                    button.Text = newText
                end,
                Destroy = function(self)
                    container:Destroy()
                end
            }
            
            return buttonObj
        end
        
        -- ═══════════════════════════════════════════════════════
        -- ADD TOGGLE (With Update Methods)
        -- ═══════════════════════════════════════════════════════
        function Tab:AddToggle(options)
            options = options or {}
            local title = options.Title or "Toggle"
            local text = options.Text or "Toggle Option"
            local default = options.Default or false
            local callback = options.Callback or function() end
            
            local toggled = default
            
            local container = CreateElementContainer(80, false)
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 22),
                BackgroundTransparency = 1,
                Text = "🔄 " .. title,
                TextColor3 = Colors.Text,
                TextSize = GetResponsiveSize(15, 1.1),
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(0.65, 0, 0, 35),
                Position = UDim2.new(0, 0, 0, 35),
                BackgroundTransparency = 1,
                Text = text,
                TextColor3 = Colors.TextSecondary,
                TextSize = GetResponsiveSize(13, 1.1),
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                TextWrapped = true,
                Parent = container
            })
            
            local toggleTrack = CreateInstance("TextButton", {
                Size = UDim2.new(0, 56, 0, 30),
                Position = UDim2.new(1, -56, 0, 42),
                BackgroundColor3 = toggled and Colors.Success or Colors.SliderBg,
                Text = "",
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = toggleTrack
            })
            
            local toggleKnob = CreateInstance("Frame", {
                Size = UDim2.new(0, 24, 0, 24),
                Position = toggled and UDim2.new(1, -27, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Colors.White,
                Parent = toggleTrack
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = toggleKnob
            })
            
            CreateInstance("UIStroke", {
                Color = Colors.TextSecondary,
                Thickness = 1.5,
                Parent = toggleKnob
            })
            
            local function updateToggle(value)
                if toggled ~= value then
                    toggled = value
                    
                    if toggled then
                        Tween(toggleTrack, {BackgroundColor3 = Colors.Success}, TWEEN_INFO_NORMAL)
                        Tween(toggleKnob, {Position = UDim2.new(1, -27, 0.5, 0)}, TWEEN_INFO_NORMAL)
                    else
                        Tween(toggleTrack, {BackgroundColor3 = Colors.SliderBg}, TWEEN_INFO_NORMAL)
                        Tween(toggleKnob, {Position = UDim2.new(0, 3, 0.5, 0)}, TWEEN_INFO_NORMAL)
                    end
                    
                    SafeCallback(callback, value)
                end
            end
            
            tabMaid:Add(toggleTrack.MouseButton1Click:Connect(function()
                updateToggle(not toggled)
            end))
            
            local toggleObj = {
                Container = container,
                Value = toggled,
                Set = updateToggle,
                Destroy = function(self)
                    container:Destroy()
                end
            }
            
            return toggleObj
        end
        
        -- ═══════════════════════════════════════════════════════
        -- ADD DROPDOWN (With State Management)
        -- ═══════════════════════════════════════════════════════
        function Tab:AddDropdown(options)
            options = options or {}
            local title = options.Title or "Dropdown"
            local text = options.Text or "Select an option"
            local items = options.Items or {"Option 1", "Option 2", "Option 3"}
            local callback = options.Callback or function() end
            
            local selectedItem = text
            local isOpen = false
            
            local container = CreateElementContainer(90, false)
            container.ClipsDescendants = false
            container.ZIndex = 1
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 22),
                BackgroundTransparency = 1,
                Text = "📋 " .. title,
                TextColor3 = Colors.Text,
                TextSize = GetResponsiveSize(15, 1.1),
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = container
            })
            
            local dropdownButton = CreateInstance("TextButton", {
                Size = UDim2.new(1, 0, 0, 40),
                Position = UDim2.new(0, 0, 0, 35),
                BackgroundColor3 = Colors.SliderBg,
                Text = "",
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = dropdownButton
            })
            
            local dropdownLabel = CreateInstance("TextLabel", {
                Size = UDim2.new(1, -40, 1, 0),
                Position = UDim2.new(0, 15, 0, 0),
                BackgroundTransparency = 1,
                Text = selectedItem,
                TextColor3 = Colors.Text,
                TextSize = GetResponsiveSize(13, 1.1),
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Parent = dropdownButton
            })
            
            local arrowIcon = CreateInstance("TextLabel", {
                Size = UDim2.new(0, 30, 1, 0),
                Position = UDim2.new(1, -30, 0, 0),
                BackgroundTransparency = 1,
                Text = "▼",
                TextColor3 = Colors.TextSecondary,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                Parent = dropdownButton
            })
            
            local dropdownList = CreateInstance("ScrollingFrame", {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 80),
                BackgroundColor3 = Color3.fromRGB(50, 50, 50),
                BorderSizePixel = 0,
                ScrollBarThickness = 4,
                ScrollBarImageColor3 = Color3.fromRGB(70, 70, 70),
                Visible = false,
                ZIndex = ZIndexLayers.DropdownList,
                ClipsDescendants = true,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = dropdownList
            })
            
            CreateInstance("UIStroke", {
                Color = Color3.fromRGB(80, 80, 80),
                Thickness = 2,
                Parent = dropdownList
            })
            
            local listLayout = CreateInstance("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 3),
                Parent = dropdownList
            })
            
            CreateInstance("UIPadding", {
                PaddingAll = UDim.new(0, 5),
                Parent = dropdownList
            })
            
            tabMaid:Add(listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                dropdownList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
            end))
            
            local function closeDropdown()
                isOpen = false
                local closeTween = Tween(dropdownList, {Size = UDim2.new(1, 0, 0, 0)}, TWEEN_INFO_NORMAL)
                Tween(arrowIcon, {Rotation = 0}, TWEEN_INFO_NORMAL)
                closeTween.Completed:Wait()
                dropdownList.Visible = false
                Window.OpenDropdowns[dropdownButton] = nil
            end
            
            for i, item in ipairs(items) do
                local itemButton = CreateInstance("TextButton", {
                    Size = UDim2.new(1, -10, 0, 35),
                    BackgroundColor3 = Colors.SliderBg,
                    Text = "",
                    ZIndex = ZIndexLayers.DropdownItem,
                    Parent = dropdownList
                })
                
                CreateInstance("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = itemButton
                })
                
                CreateInstance("TextLabel", {
                    Size = UDim2.new(1, -10, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = item,
                    TextColor3 = Colors.Text,
                    TextSize = GetResponsiveSize(12, 1.1),
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = ZIndexLayers.DropdownItem + 1,
                    Parent = itemButton
                })
                
                tabMaid:Add(itemButton.MouseButton1Click:Connect(function()
                    selectedItem = item
                    dropdownLabel.Text = selectedItem
                    closeDropdown()
                    SafeCallback(callback, item)
                end))
                
                AddHoverEffect(itemButton, Colors.SliderBg, Color3.fromRGB(80, 80, 80), nil, tabMaid)
            end
            
            tabMaid:Add(dropdownButton.MouseButton1Click:Connect(function()
                if not isOpen then
                    Window:CloseAllDropdowns(dropdownButton)
                    isOpen = true
                    dropdownList.Visible = true
                    local maxHeight = math.min(#items * 38, 160)
                    Tween(dropdownList, {Size = UDim2.new(1, 0, 0, maxHeight)}, TWEEN_INFO_BACK_FAST)
                    Tween(arrowIcon, {Rotation = 180}, TWEEN_INFO_NORMAL)
                    Window.OpenDropdowns[dropdownButton] = closeDropdown
                else
                    closeDropdown()
                end
            end))
            
            AddHoverEffect(dropdownButton, Colors.SliderBg, Color3.fromRGB(75, 75, 75), nil, tabMaid)
            
            return container
        end
        
        -- ═══════════════════════════════════════════════════════
        -- ADD SLIDER (With Increment & Fixed Memory Leak)
        -- ═══════════════════════════════════════════════════════
        function Tab:AddSlider(options)
            options = options or {}
            local title = options.Title or "Slider"
            local min = options.Min or 0
            local max = options.Max or 100
            local default = options.Default or 50
            local increment = options.Increment or 1
            local callback = options.Callback or function() end
            
            local container = CreateElementContainer(95, false)
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, -70, 0, 22),
                BackgroundTransparency = 1,
                Text = "🎚️ " .. title,
                TextColor3 = Colors.Text,
                TextSize = GetResponsiveSize(15, 1.1),
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = container
            })
            
            local valueLabel = CreateInstance("TextLabel", {
                Size = UDim2.new(0, 60, 0, 28),
                Position = UDim2.new(1, -60, 0, 0),
                BackgroundColor3 = Colors.SliderBg,
                Text = tostring(default),
                TextColor3 = Colors.Text,
                TextSize = GetResponsiveSize(14, 1.1),
                Font = Enum.Font.GothamBold,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 6),
                Parent = valueLabel
            })
            
            local sliderTrack = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 8),
                Position = UDim2.new(0, 0, 0, 50),
                BackgroundColor3 = Colors.SliderBg,
                BorderSizePixel = 0,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = sliderTrack
            })
            
            local sliderFill = CreateInstance("Frame", {
                Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                BackgroundColor3 = Colors.Accent,
                BorderSizePixel = 0,
                Parent = sliderTrack
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = sliderFill
            })
            
            local sliderKnob = CreateInstance("TextButton", {
                Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new((default - min) / (max - min), -10, 0.5, -10),
                BackgroundColor3 = Colors.White,
                BorderSizePixel = 0,
                Text = "",
                Parent = sliderTrack
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = sliderKnob
            })
            
            CreateInstance("UIStroke", {
                Color = Colors.TextSecondary,
                Thickness = 2,
                Parent = sliderKnob
            })
            
            local dragConnection
            
            local function updateSlider(relative)
                local rawValue = min + (max - min) * relative
                
                local value
                if increment >= 1 then
                    value = math.floor(rawValue / increment + 0.5) * increment
                else
                    local decimalPlaces = #tostring(increment):match("%.(%d+)") or 0
                    value = math.floor(rawValue / increment + 0.5) * increment
                    value = tonumber(string.format("%." .. decimalPlaces .. "f", value))
                end
                
                value = math.clamp(value, min, max)
                
                sliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
                sliderKnob.Position = UDim2.new((value - min) / (max - min), -10, 0.5, -10)
                valueLabel.Text = tostring(value)
                
                SafeCallback(callback, value)
            end
            
            local function startDragging(inputType)
                dragConnection = UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == inputType then
                        local relative = math.clamp((input.Position.X - sliderTrack.AbsolutePosition.X) / sliderTrack.AbsoluteSize.X, 0, 1)
                        updateSlider(relative)
                    end
                end)
            end
            
            tabMaid:Add(sliderKnob.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    startDragging(input.UserInputType)
                end
            end))
            
            tabMaid:Add(sliderTrack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    startDragging(input.UserInputType)
                end
            end))
            
            tabMaid:Add(UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    if dragConnection then
                        dragConnection:Disconnect()
                        dragConnection = nil
                    end
                end
            end))
            
            AddHoverEffect(sliderKnob, Colors.White, Color3.fromRGB(230, 230, 230), nil, tabMaid)
            
            local sliderObj = {
                Container = container,
                SetValue = function(self, value)
                    local relative = (value - min) / (max - min)
                    updateSlider(relative)
                end,
                Destroy = function(self)
                    container:Destroy()
                end
            }
            
            return sliderObj
        end
        
        return Tab
    end
    
    -- Entrance Animation
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    Tween(mainFrame, {Size = defaultSize}, TWEEN_INFO_BACK)
    
    return Window
end

return DrakthonLib
