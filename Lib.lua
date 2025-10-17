--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║              DRAKTHON UI LIBRARY V2.5 OPTIMIZED              ║
    ║          محسّنة وفقاً لأفضل الممارسات البرمجية              ║
    ║     ✅ Performance Optimized | Error-Proof | Clean Code     ║
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
-- CONSTANTS & PRE-CREATED OBJECTS (تحسين الأداء)
-- ═══════════════════════════════════════════════════════════════

-- Pre-created TweenInfo objects (المشكلة الثانية)
local TWEEN_INFO_NORMAL = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_INFO_FAST = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_INFO_BACK = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local TWEEN_INFO_BACK_FAST = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- ZIndex Layers (المشكلة الثامنة)
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
    ConfirmationOverlay = 150,
    ConfirmationModal = 200,
    LoaderIcon = 10,
}

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

-- محسّنة: استخدام TweenInfo مسبقة الإنشاء
local function Tween(object, properties, tweenInfo)
    tweenInfo = tweenInfo or TWEEN_INFO_NORMAL
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

-- ═══════════════════════════════════════════════════════════════
-- IMPROVED DRAGGABLE (المشكلة الأولى - حل كامل)
-- ═══════════════════════════════════════════════════════════════
local function MakeDraggable(frame, dragHandle, backgroundOverlay)
    local dragConnection
    local framePos
    
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            
            local mousePos = input.Position
            framePos = frame.Position
            
            if backgroundOverlay then
                backgroundOverlay.Visible = true
                Tween(backgroundOverlay, {BackgroundTransparency = 0.3}, TWEEN_INFO_FAST)
            end
            
            -- إنشاء الاتصال فقط عند بدء السحب
            dragConnection = UserInputService.InputChanged:Connect(function(changedInput)
                if changedInput.UserInputType == input.UserInputType then
                    local delta = changedInput.Position - mousePos
                    local viewport = workspace.CurrentCamera.ViewportSize
                    
                    local newPosX = framePos.X.Scale * viewport.X + framePos.X.Offset + delta.X
                    local newPosY = framePos.Y.Scale * viewport.Y + framePos.Y.Offset + delta.Y
                    
                    frame.Position = UDim2.new(0, newPosX, 0, newPosY)
                end
            end)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            if dragConnection then
                dragConnection:Disconnect()
                dragConnection = nil
                
                if backgroundOverlay and backgroundOverlay.Visible then
                    Tween(backgroundOverlay, {BackgroundTransparency = 1}, TWEEN_INFO_NORMAL)
                    task.delay(0.3, function()
                        backgroundOverlay.Visible = false
                    end)
                end
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- IMPROVED RESIZABLE (المشكلة الأولى - حل كامل)
-- ═══════════════════════════════════════════════════════════════
local function MakeResizable(frame, minSize)
    local resizeButton = CreateInstance("TextButton", {
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(1, -20, 1, -20),
        AnchorPoint = Vector2.new(1, 1),
        BackgroundColor3 = Color3.fromRGB(55, 55, 55),
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
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        Parent = resizeButton
    })
    
    local resizeConnection
    local startSize
    
    resizeButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            
            local startPos = input.Position
            startSize = frame.AbsoluteSize
            
            -- إنشاء الاتصال فقط عند بدء التغيير
            resizeConnection = UserInputService.InputChanged:Connect(function(changedInput)
                if changedInput.UserInputType == input.UserInputType then
                    local delta = changedInput.Position - startPos
                    local newWidth = math.max(minSize.X, startSize.X + delta.X)
                    local newHeight = math.max(minSize.Y, startSize.Y + delta.Y)
                    
                    frame.Size = UDim2.new(0, newWidth, 0, newHeight)
                end
            end)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            if resizeConnection then
                resizeConnection:Disconnect()
                resizeConnection = nil
            end
        end
    end)
end

local function AddHoverEffect(button, normalColor, hoverColor, pressedColor)
    button.MouseEnter:Connect(function()
        Tween(button, {BackgroundColor3 = hoverColor}, TWEEN_INFO_FAST)
    end)
    
    button.MouseLeave:Connect(function()
        Tween(button, {BackgroundColor3 = normalColor}, TWEEN_INFO_FAST)
    end)
    
    if pressedColor then
        button.MouseButton1Down:Connect(function()
            Tween(button, {BackgroundColor3 = pressedColor}, TWEEN_INFO_FAST)
        end)
        
        button.MouseButton1Up:Connect(function()
            Tween(button, {BackgroundColor3 = hoverColor}, TWEEN_INFO_FAST)
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════
-- MAIN WINDOW FUNCTION
-- ═══════════════════════════════════════════════════════════════

function DrakthonLib:MakeWindow(options)
    options = options or {}
    local windowName = options.Name or "Drakthon Library"
    local defaultSize = options.DefaultSize or UDim2.new(0.6, 0, 0.6, 0)
    local minSize = options.MinSize or Vector2.new(400, 300)
    local loaderImage = options.LoaderImage or "rbxassetid://11422155687"
    
    -- ═══════════════════════════════════════════════════════════
    -- CREATE SCREEN GUI
    -- ═══════════════════════════════════════════════════════════
    
    -- محسّن: استخدام time() بدلاً من tick() (المشكلة السابعة)
    local screenGuiName = "DrakthonLib_" .. string.format("%.5f", time()):gsub("%.", "")
    
    local screenGui = CreateInstance("ScreenGui", {
        Name = screenGuiName,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = PlayerGui
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- BACKGROUND OVERLAY
    -- ═══════════════════════════════════════════════════════════
    local backgroundOverlay = CreateInstance("Frame", {
        Name = "BackgroundOverlay",
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
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
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(33, 33, 33),
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
        Color = Color3.fromRGB(55, 55, 55),
        Thickness = 1.5,
        Transparency = 0.5,
        Parent = mainFrame
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- TITLE BAR
    -- ═══════════════════════════════════════════════════════════
    local titleBar = CreateInstance("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundColor3 = Color3.fromRGB(28, 28, 28),
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
        BackgroundColor3 = Color3.fromRGB(28, 28, 28),
        BorderSizePixel = 0,
        ZIndex = ZIndexLayers.TitleBar,
        Parent = titleBar
    })
    
    CreateInstance("TextLabel", {
        Size = UDim2.new(1, -120, 1, 0),
        Position = UDim2.new(0, 20, 0, 0),
        BackgroundTransparency = 1,
        Text = "🌙 " .. windowName,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
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
        BackgroundColor3 = Color3.fromRGB(55, 55, 55),
        Text = "—",
        TextColor3 = Color3.fromRGB(255, 255, 255),
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
        BackgroundColor3 = Color3.fromRGB(190, 50, 50),
        Text = "✕",
        TextColor3 = Color3.fromRGB(255, 255, 255),
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
        BackgroundColor3 = Color3.fromRGB(28, 28, 28),
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
        Color = Color3.fromRGB(80, 140, 220),
        Thickness = 3,
        Parent = loaderIcon
    })
    
    MakeDraggable(loaderIcon, loaderIcon)
    
    local loaderRotation = 0
    local loaderConnection
    
    -- ═══════════════════════════════════════════════════════════
    -- CONFIRMATION MODAL (محسّن: المشكلة السادسة)
    -- ═══════════════════════════════════════════════════════════
    
    -- الآن ابن screenGui وليس mainFrame
    local confirmOverlay = CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = ZIndexLayers.ConfirmationOverlay,
        Parent = screenGui  -- ✅ تغيير الأب
    })
    
    local confirmModal = CreateInstance("Frame", {
        Size = UDim2.new(0, 350, 0, 170),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
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
        Color = Color3.fromRGB(190, 50, 50),
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
        BackgroundColor3 = Color3.fromRGB(190, 50, 50),
        Text = "✓ نعم",
        TextColor3 = Color3.fromRGB(255, 255, 255),
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
        TextColor3 = Color3.fromRGB(255, 255, 255),
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
        Size = UDim2.new(0.32, 0, 1, -45),
        Position = UDim2.new(0, 0, 0, 45),
        BackgroundColor3 = Color3.fromRGB(26, 26, 26),
        BorderSizePixel = 0,
        ZIndex = ZIndexLayers.Sidebar,
        Parent = mainFrame
    })
    
    local tabsContainer = CreateInstance("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Color3.fromRGB(55, 55, 55),
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
    
    tabsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabsContainer.CanvasSize = UDim2.new(0, 0, 0, tabsLayout.AbsoluteContentSize.Y + 24)
    end)
    
    -- ═══════════════════════════════════════════════════════════
    -- CONTENT AREA
    -- ═══════════════════════════════════════════════════════════
    local contentArea = CreateInstance("ScrollingFrame", {
        Size = UDim2.new(0.68, 0, 1, -45),
        Position = UDim2.new(0.32, 0, 0, 45),
        BackgroundColor3 = Color3.fromRGB(33, 33, 33),
        BorderSizePixel = 0,
        ScrollBarThickness = 6,
        ScrollBarImageColor3 = Color3.fromRGB(55, 55, 55),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ZIndex = ZIndexLayers.Content,
        Parent = mainFrame
    })
    
    CreateInstance("UIPadding", {
        PaddingTop = UDim.new(0, 15),
        PaddingLeft = UDim.new(0, 15),
        PaddingRight = UDim.new(0, 15),
        PaddingBottom = UDim.new(0, 15),
        Parent = contentArea
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- BUTTON INTERACTIONS (محسّن: المشكلة الثالثة والرابعة)
    -- ═══════════════════════════════════════════════════════════
    AddHoverEffect(minimizeBtn, Color3.fromRGB(55, 55, 55), Color3.fromRGB(75, 75, 75), Color3.fromRGB(90, 90, 90))
    AddHoverEffect(closeBtn, Color3.fromRGB(190, 50, 50), Color3.fromRGB(220, 70, 70), Color3.fromRGB(240, 90, 90))
    AddHoverEffect(confirmYesBtn, Color3.fromRGB(190, 50, 50), Color3.fromRGB(220, 70, 70))
    AddHoverEffect(confirmNoBtn, Color3.fromRGB(60, 60, 60), Color3.fromRGB(80, 80, 80))
    
    -- Close Button (محسّن: استخدام Completed)
    closeBtn.MouseButton1Click:Connect(function()
        confirmOverlay.Visible = true
        confirmOverlay.BackgroundTransparency = 1
        Tween(confirmOverlay, {BackgroundTransparency = 0.5}, TWEEN_INFO_FAST)
        confirmModal.Size = UDim2.new(0, 0, 0, 0)
        Tween(confirmModal, {Size = UDim2.new(0, 350, 0, 170)}, TWEEN_INFO_BACK)
    end)
    
    -- محسّن: استخدام tween.Completed
    confirmYesBtn.MouseButton1Click:Connect(function()
        local closeTween = Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, TWEEN_INFO_BACK)
        closeTween.Completed:Wait()
        screenGui:Destroy()
    end)
    
    confirmNoBtn.MouseButton1Click:Connect(function()
        local closeTween = Tween(confirmModal, {Size = UDim2.new(0, 0, 0, 0)}, TWEEN_INFO_BACK_FAST)
        Tween(confirmOverlay, {BackgroundTransparency = 1}, TWEEN_INFO_NORMAL)
        closeTween.Completed:Wait()
        confirmOverlay.Visible = false
    end)
    
    -- Minimize Button (محسّن)
    minimizeBtn.MouseButton1Click:Connect(function()
        local minimizeTween = Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, TWEEN_INFO_BACK_FAST)
        minimizeTween.Completed:Wait()
        mainFrame.Visible = false
        loaderIcon.Visible = true
        
        loaderConnection = RunService.RenderStepped:Connect(function()
            loaderRotation = (loaderRotation + 2) % 360
            loaderIcon.Rotation = loaderRotation
        end)
        
        Tween(loaderIcon, {Size = UDim2.new(0, 80, 0, 80)}, TWEEN_INFO_BACK_FAST)
    end)
    
    loaderIcon.MouseButton1Click:Connect(function()
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
    end)
    
    AddHoverEffect(loaderIcon, Color3.fromRGB(28, 28, 28), Color3.fromRGB(40, 40, 40))
    
    MakeDraggable(mainFrame, titleBar, backgroundOverlay)
    MakeResizable(mainFrame, minSize)
    
    -- ═══════════════════════════════════════════════════════════
    -- WINDOW OBJECT
    -- ═══════════════════════════════════════════════════════════
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        ScreenGui = screenGui,
        MainFrame = mainFrame
    }
    
    -- ═══════════════════════════════════════════════════════════
    -- MAKE TAB FUNCTION
    -- ═══════════════════════════════════════════════════════════
    function Window:MakeTab(options)
        options = options or {}
        local tabName = options.Name or "Tab"
        local tabIcon = options.Icon or ""
        
        local tabButton = CreateInstance("TextButton", {
            Size = UDim2.new(1, 0, 0, 55),
            BackgroundColor3 = Color3.fromRGB(33, 33, 33),
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
            BackgroundColor3 = Color3.fromRGB(80, 140, 220),
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
            TextColor3 = Color3.fromRGB(200, 200, 200),
            TextSize = 14,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            ZIndex = ZIndexLayers.TabLabel,
            Parent = tabButton
        })
        
        local tabContainer = CreateInstance("Frame", {
            Name = tabName .. "_Container",
            Size = UDim2.new(1, -30, 1, -30),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Visible = false,
            Parent = contentArea
        })
        
        local tabLayout = CreateInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10),
            Parent = tabContainer
        })
        
        tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            contentArea.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 30)
        end)
        
        tabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                Tween(tab.Button, {BackgroundColor3 = Color3.fromRGB(33, 33, 33)}, TWEEN_INFO_FAST)
                tab.Container.Visible = false
                Tween(tab.ActiveIndicator, {
                    Size = UDim2.new(0, 0, 0, 40),
                    Position = UDim2.new(0, -5, 0.5, 0)
                }, TWEEN_INFO_BACK_FAST)
            end
            
            Tween(tabButton, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}, TWEEN_INFO_FAST)
            tabContainer.Visible = true
            
            Tween(activeIndicator, {
                Size = UDim2.new(0, 5, 0, 40),
                Position = UDim2.new(0, 0, 0.5, 0)
            }, TWEEN_INFO_BACK)
            
            Window.CurrentTab = tabName
        end)
        
        AddHoverEffect(tabButton, Color3.fromRGB(33, 33, 33), Color3.fromRGB(44, 44, 44))
        
        local Tab = {
            Name = tabName,
            Button = tabButton,
            Container = tabContainer,
            ActiveIndicator = activeIndicator,
            Elements = {}
        }
        
        if #Window.Tabs == 0 then
            tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            tabContainer.Visible = true
            activeIndicator.Size = UDim2.new(0, 5, 0, 40)
            activeIndicator.Position = UDim2.new(0, 0, 0.5, 0)
            Window.CurrentTab = tabName
        end
        
        table.insert(Window.Tabs, Tab)
        
        -- ═══════════════════════════════════════════════════════
        -- HELPER: CREATE ELEMENT CONTAINER (المشكلة الخامسة)
        -- ═══════════════════════════════════════════════════════
        local function CreateElementContainer(height, autoSize)
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, height),
                AutomaticSize = autoSize and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
                BackgroundColor3 = Color3.fromRGB(44, 44, 44),
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = container
            })
            
            CreateInstance("UIStroke", {
                Color = Color3.fromRGB(60, 60, 60),
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
        -- ADD PARAGRAPH
        -- ═══════════════════════════════════════════════════════
        function Tab:AddParagraph(options)
            options = options or {}
            local title = options.Title or "Paragraph"
            local text = options.Text or "No text provided"
            
            local container = CreateElementContainer(0, true)
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 22),
                BackgroundTransparency = 1,
                Text = "📝 " .. title,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 15,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 28),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = text,
                TextColor3 = Color3.fromRGB(200, 200, 200),
                TextSize = 13,
                Font = Enum.Font.Gotham,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                Parent = container
            })
            
            return container
        end
        
        -- ═══════════════════════════════════════════════════════
        -- ADD BUTTON (محسّن: task.spawn)
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
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 15,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = container
            })
            
            local button = CreateInstance("TextButton", {
                Size = UDim2.new(1, 0, 0, 40),
                Position = UDim2.new(0, 0, 0, 35),
                BackgroundColor3 = Color3.fromRGB(60, 120, 200),
                Text = text,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14,
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
            
            button.MouseButton1Click:Connect(function()
                local pressTween = Tween(button, {Size = UDim2.new(0.98, 0, 0, 38)}, TWEEN_INFO_FAST)
                pressTween.Completed:Wait()
                Tween(button, {Size = UDim2.new(1, 0, 0, 40)}, TWEEN_INFO_FAST)
                
                -- محسّن: استخدام task.spawn
                task.spawn(function()
                    pcall(callback)
                end)
            end)
            
            AddHoverEffect(button, Color3.fromRGB(60, 120, 200), Color3.fromRGB(80, 140, 220), Color3.fromRGB(50, 110, 190))
            
            return container
        end
        
        -- ═══════════════════════════════════════════════════════
        -- ADD TOGGLE (محسّن: task.spawn)
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
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 15,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(0.65, 0, 0, 35),
                Position = UDim2.new(0, 0, 0, 35),
                BackgroundTransparency = 1,
                Text = text,
                TextColor3 = Color3.fromRGB(200, 200, 200),
                TextSize = 13,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                TextWrapped = true,
                Parent = container
            })
            
            local toggleTrack = CreateInstance("TextButton", {
                Size = UDim2.new(0, 56, 0, 30),
                Position = UDim2.new(1, -56, 0, 42),
                BackgroundColor3 = toggled and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(60, 60, 60),
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
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Parent = toggleTrack
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = toggleKnob
            })
            
            CreateInstance("UIStroke", {
                Color = Color3.fromRGB(200, 200, 200),
                Thickness = 1.5,
                Parent = toggleKnob
            })
            
            toggleTrack.MouseButton1Click:Connect(function()
                toggled = not toggled
                
                if toggled then
                    Tween(toggleTrack, {BackgroundColor3 = Color3.fromRGB(80, 200, 120)}, TWEEN_INFO_NORMAL)
                    Tween(toggleKnob, {Position = UDim2.new(1, -27, 0.5, 0)}, TWEEN_INFO_NORMAL)
                else
                    Tween(toggleTrack, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, TWEEN_INFO_NORMAL)
                    Tween(toggleKnob, {Position = UDim2.new(0, 3, 0.5, 0)}, TWEEN_INFO_NORMAL)
                end
                
                task.spawn(function()
                    pcall(function()
                        callback(toggled)
                    end)
                end)
            end)
            
            return container
        end
        
        -- ═══════════════════════════════════════════════════════
        -- ADD DROPDOWN (محسّن: task.spawn)
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
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 15,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = container
            })
            
            local dropdownButton = CreateInstance("TextButton", {
                Size = UDim2.new(1, 0, 0, 40),
                Position = UDim2.new(0, 0, 0, 35),
                BackgroundColor3 = Color3.fromRGB(60, 60, 60),
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
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 13,
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
                TextColor3 = Color3.fromRGB(200, 200, 200),
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
            
            listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                dropdownList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
            end)
            
            for i, item in ipairs(items) do
                local itemButton = CreateInstance("TextButton", {
                    Size = UDim2.new(1, -10, 0, 35),
                    BackgroundColor3 = Color3.fromRGB(60, 60, 60),
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
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = ZIndexLayers.DropdownItem + 1,
                    Parent = itemButton
                })
                
                itemButton.MouseButton1Click:Connect(function()
                    selectedItem = item
                    dropdownLabel.Text = selectedItem
                    
                    isOpen = false
                    local closeTween = Tween(dropdownList, {Size = UDim2.new(1, 0, 0, 0)}, TWEEN_INFO_NORMAL)
                    Tween(arrowIcon, {Rotation = 0}, TWEEN_INFO_NORMAL)
                    closeTween.Completed:Wait()
                    dropdownList.Visible = false
                    
                    task.spawn(function()
                        pcall(function()
                            callback(item)
                        end)
                    end)
                end)
                
                AddHoverEffect(itemButton, Color3.fromRGB(60, 60, 60), Color3.fromRGB(80, 80, 80))
            end
            
            dropdownButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                
                if isOpen then
                    dropdownList.Visible = true
                    local maxHeight = math.min(#items * 38, 160)
                    Tween(dropdownList, {Size = UDim2.new(1, 0, 0, maxHeight)}, TWEEN_INFO_BACK_FAST)
                    Tween(arrowIcon, {Rotation = 180}, TWEEN_INFO_NORMAL)
                else
                    local closeTween = Tween(dropdownList, {Size = UDim2.new(1, 0, 0, 0)}, TWEEN_INFO_NORMAL)
                    Tween(arrowIcon, {Rotation = 0}, TWEEN_INFO_NORMAL)
                    closeTween.Completed:Wait()
                    dropdownList.Visible = false
                end
            end)
            
            AddHoverEffect(dropdownButton, Color3.fromRGB(60, 60, 60), Color3.fromRGB(75, 75, 75))
            
            return container
        end
        
        -- ═══════════════════════════════════════════════════════
        -- ADD SLIDER (محسّن: المشكلة الأولى + task.spawn)
        -- ═══════════════════════════════════════════════════════
        function Tab:AddSlider(options)
            options = options or {}
            local title = options.Title or "Slider"
            local min = options.Min or 0
            local max = options.Max or 100
            local default = options.Default or 50
            local callback = options.Callback or function() end
            
            local container = CreateElementContainer(95, false)
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, -70, 0, 22),
                BackgroundTransparency = 1,
                Text = "🎚️ " .. title,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 15,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = container
            })
            
            local valueLabel = CreateInstance("TextLabel", {
                Size = UDim2.new(0, 60, 0, 28),
                Position = UDim2.new(1, -60, 0, 0),
                BackgroundColor3 = Color3.fromRGB(60, 60, 60),
                Text = tostring(default),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14,
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
                BackgroundColor3 = Color3.fromRGB(60, 60, 60),
                BorderSizePixel = 0,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = sliderTrack
            })
            
            local sliderFill = CreateInstance("Frame", {
                Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                BackgroundColor3 = Color3.fromRGB(80, 140, 220),
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
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                Text = "",
                Parent = sliderTrack
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = sliderKnob
            })
            
            CreateInstance("UIStroke", {
                Color = Color3.fromRGB(200, 200, 200),
                Thickness = 2,
                Parent = sliderKnob
            })
            
            local sliderConnection
            
            -- محسّن: إنشاء الاتصال فقط عند الحاجة
            local function startDragging(inputType)
                sliderConnection = UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == inputType then
                        local mousePos = input.Position.X
                        local trackPos = sliderTrack.AbsolutePosition.X
                        local trackSize = sliderTrack.AbsoluteSize.X
                        local relative = math.clamp((mousePos - trackPos) / trackSize, 0, 1)
                        local value = math.floor(min + (max - min) * relative)
                        
                        sliderFill.Size = UDim2.new(relative, 0, 1, 0)
                        sliderKnob.Position = UDim2.new(relative, -10, 0.5, -10)
                        valueLabel.Text = tostring(value)
                        
                        task.spawn(function()
                            pcall(function()
                                callback(value)
                            end)
                        end)
                    end
                end)
            end
            
            sliderKnob.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    startDragging(input.UserInputType)
                end
            end)
            
            sliderTrack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    startDragging(input.UserInputType)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    if sliderConnection then
                        sliderConnection:Disconnect()
                        sliderConnection = nil
                    end
                end
            end)
            
            AddHoverEffect(sliderKnob, Color3.fromRGB(255, 255, 255), Color3.fromRGB(230, 230, 230))
            
            return container
        end
        
        return Tab
    end
    
    -- Entrance Animation
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    Tween(mainFrame, {Size = defaultSize}, TWEEN_INFO_BACK)
    
    return Window
end

return DrakthonLib
