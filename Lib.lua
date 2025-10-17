--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║                  DRAKTHON UI LIBRARY V5.0                    ║
    ║           مكتبة واجهات احترافية - حجم مثالي                  ║
    ║        ✅ إصلاح التحريك + فتح تلقائي + Loader مخصص         ║
    ╚══════════════════════════════════════════════════════════════╝
]]

local DrakthonLib = {}

-- ═══════════════════════════════════════════════════════════════
-- THEME SYSTEM
-- ═══════════════════════════════════════════════════════════════
local Theme = {
    Background = Color3.fromRGB(20, 20, 25),
    Secondary = Color3.fromRGB(25, 25, 30),
    Tertiary = Color3.fromRGB(30, 30, 35),
    
    Accent = Color3.fromRGB(88, 101, 242),
    AccentHover = Color3.fromRGB(108, 121, 255),
    AccentPressed = Color3.fromRGB(68, 81, 222),
    
    TextPrimary = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 190),
    TextMuted = Color3.fromRGB(140, 140, 150),
    
    ElementBackground = Color3.fromRGB(35, 35, 40),
    ElementBorder = Color3.fromRGB(45, 45, 50),
    
    Success = Color3.fromRGB(67, 181, 129),
    Warning = Color3.fromRGB(250, 166, 26),
    Error = Color3.fromRGB(240, 71, 71),
    
    ToggleOn = Color3.fromRGB(67, 181, 129),
    ToggleOff = Color3.fromRGB(50, 50, 55),
}

-- ═══════════════════════════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════════════════════════
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ═══════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

local function CreateInstance(className, properties)
    local instance = Instance.new(className)
    for property, value in pairs(properties) do
        if property ~= "Parent" then
            pcall(function()
                instance[property] = value
            end)
        end
    end
    if properties.Parent then
        instance.Parent = properties.Parent
    end
    return instance
end

local function Tween(object, properties, duration, easingStyle, easingDirection)
    easingStyle = easingStyle or Enum.EasingStyle.Quad
    easingDirection = easingDirection or Enum.EasingDirection.Out
    duration = duration or 0.3
    
    local tweenInfo = TweenInfo.new(duration, easingStyle, easingDirection)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

-- إصلاح دالة السحب - منع "الطيران"
local function MakeDraggable(frame, dragHandle)
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        if dragging then
            local delta = input.Position - dragStart
            local newPosition = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
            frame.Position = newPosition
        end
    end
    
    dragHandle.InputBegan:Connect(function(input)
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
    
    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

local function AddHoverEffect(button, normalColor, hoverColor, pressedColor)
    button.MouseEnter:Connect(function()
        Tween(button, {BackgroundColor3 = hoverColor}, 0.2)
    end)
    
    button.MouseLeave:Connect(function()
        Tween(button, {BackgroundColor3 = normalColor}, 0.2)
    end)
    
    if pressedColor then
        button.MouseButton1Down:Connect(function()
            Tween(button, {BackgroundColor3 = pressedColor}, 0.1)
        end)
        
        button.MouseButton1Up:Connect(function()
            Tween(button, {BackgroundColor3 = hoverColor}, 0.1)
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════
-- MAIN WINDOW FUNCTION
-- ═══════════════════════════════════════════════════════════════

function DrakthonLib:MakeWindow(options)
    options = options or {}
    local windowName = options.Name or "Drakthon Library"
    local loaderImage = options.LoaderImage or "rbxassetid://11422155687"
    local loaderImage2 = options.LoaderImage2 or "rbxassetid://679392" -- الصورة الثانية
    
    -- حجم مثالي مثل السكربتات العالمية
    local defaultSize = UDim2.new(0, 550, 0, 350)
    
    -- ═══════════════════════════════════════════════════════════
    -- CREATE SCREEN GUI
    -- ═══════════════════════════════════════════════════════════
    local screenGui = CreateInstance("ScreenGui", {
        Name = "DrakthonLib_" .. tick(),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true,
        Parent = PlayerGui
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- LOADER ICON - صورة فقط بدون نص
    -- ═══════════════════════════════════════════════════════════
    local loaderIcon = CreateInstance("ImageButton", {
        Name = "LoaderIcon",
        Size = UDim2.new(0, 70, 0, 70),
        Position = UDim2.new(0, 20, 1, -90),
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = Theme.Secondary,
        Image = loaderImage,
        ScaleType = Enum.ScaleType.Fit,
        Visible = false,
        ZIndex = 100,
        Parent = screenGui
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = loaderIcon
    })
    
    CreateInstance("UIStroke", {
        Color = Theme.ElementBorder,
        Thickness = 1.5,
        Transparency = 0.3,
        Parent = loaderIcon
    })
    
    CreateInstance("UIPadding", {
        PaddingAll = UDim.new(0, 5),
        Parent = loaderIcon
    })
    
    MakeDraggable(loaderIcon, loaderIcon)
    
    -- ═══════════════════════════════════════════════════════════
    -- MAIN WINDOW FRAME
    -- ═══════════════════════════════════════════════════════════
    local mainFrame = CreateInstance("Frame", {
        Name = "MainWindow",
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Visible = true,
        ZIndex = 2,
        Parent = screenGui
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = mainFrame
    })
    
    CreateInstance("UIStroke", {
        Color = Theme.ElementBorder,
        Thickness = 1.5,
        Transparency = 0.5,
        Parent = mainFrame
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- TITLE BAR
    -- ═══════════════════════════════════════════════════════════
    local titleBar = CreateInstance("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = mainFrame
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = titleBar
    })
    
    CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 15),
        Position = UDim2.new(0, 0, 1, -15),
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = titleBar
    })
    
    -- عنوان الواجهة
    CreateInstance("TextLabel", {
        Size = UDim2.new(1, -120, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = "🌙 " .. windowName,
        TextColor3 = Theme.TextPrimary,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 4,
        Parent = titleBar
    })
    
    -- صورة مخصصة في التايتل بار
    CreateInstance("ImageLabel", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -150, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        Image = "rbxassetid://" .. loaderImage2,
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 4,
        Parent = titleBar
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- CONTROL BUTTONS
    -- ═══════════════════════════════════════════════════════════
    local minimizeBtn = CreateInstance("TextButton", {
        Size = UDim2.new(0, 35, 0, 26),
        Position = UDim2.new(1, -85, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.ElementBackground,
        Text = "—",
        TextColor3 = Theme.TextPrimary,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        ZIndex = 4,
        Parent = titleBar
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = minimizeBtn
    })
    
    local closeBtn = CreateInstance("TextButton", {
        Size = UDim2.new(0, 35, 0, 26),
        Position = UDim2.new(1, -42, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.Error,
        Text = "✕",
        TextColor3 = Theme.TextPrimary,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        ZIndex = 4,
        Parent = titleBar
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = closeBtn
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- CONFIRMATION MODAL
    -- ═══════════════════════════════════════════════════════════
    local confirmOverlay = CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 150,
        Parent = mainFrame
    })
    
    local confirmModal = CreateInstance("Frame", {
        Size = UDim2.new(0, 320, 0, 160),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.Tertiary,
        BorderSizePixel = 0,
        ZIndex = 200,
        Parent = confirmOverlay
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = confirmModal
    })
    
    CreateInstance("UIStroke", {
        Color = Theme.Error,
        Thickness = 2,
        Parent = confirmModal
    })
    
    CreateInstance("TextLabel", {
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 12),
        BackgroundTransparency = 1,
        Text = "⚠️ تحذير",
        TextColor3 = Theme.Warning,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 201,
        Parent = confirmModal
    })
    
    CreateInstance("TextLabel", {
        Size = UDim2.new(1, -30, 0, 45),
        Position = UDim2.new(0, 15, 0, 48),
        BackgroundTransparency = 1,
        Text = "هل أنت متأكد أنك تريد إغلاق الواجهة؟",
        TextColor3 = Theme.TextSecondary,
        TextSize = 13,
        Font = Enum.Font.Gotham,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Top,
        ZIndex = 201,
        Parent = confirmModal
    })
    
    local confirmYesBtn = CreateInstance("TextButton", {
        Size = UDim2.new(0, 130, 0, 36),
        Position = UDim2.new(0.5, -138, 1, -45),
        BackgroundColor3 = Theme.Error,
        Text = "✓ نعم",
        TextColor3 = Theme.TextPrimary,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        ZIndex = 201,
        Parent = confirmModal
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = confirmYesBtn
    })
    
    local confirmNoBtn = CreateInstance("TextButton", {
        Size = UDim2.new(0, 130, 0, 36),
        Position = UDim2.new(0.5, 8, 1, -45),
        BackgroundColor3 = Theme.ElementBackground,
        Text = "✕ لا",
        TextColor3 = Theme.TextPrimary,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        ZIndex = 201,
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
        Size = UDim2.new(0, 165, 1, -40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = mainFrame
    })
    
    local tabsContainer = CreateInstance("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.ElementBorder,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ZIndex = 4,
        Parent = sidebar
    })
    
    local tabsLayout = CreateInstance("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6),
        Parent = tabsContainer
    })
    
    CreateInstance("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 10),
        Parent = tabsContainer
    })
    
    tabsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabsContainer.CanvasSize = UDim2.new(0, 0, 0, tabsLayout.AbsoluteContentSize.Y + 20)
    end)
    
    -- ═══════════════════════════════════════════════════════════
    -- CONTENT AREA
    -- ═══════════════════════════════════════════════════════════
    local contentArea = CreateInstance("Frame", {
        Name = "ContentArea",
        Size = UDim2.new(1, -165, 1, -40),
        Position = UDim2.new(0, 165, 0, 40),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 3,
        Parent = mainFrame
    })
    
    local contentScroll = CreateInstance("ScrollingFrame", {
        Name = "ContentScroll",
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 5,
        ScrollBarImageColor3 = Theme.ElementBorder,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ClipsDescendants = true,
        ZIndex = 4,
        Parent = contentArea
    })
    
    CreateInstance("UIPadding", {
        PaddingTop = UDim.new(0, 12),
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12),
        PaddingBottom = UDim.new(0, 12),
        Parent = contentScroll
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- BUTTON INTERACTIONS
    -- ═══════════════════════════════════════════════════════════
    AddHoverEffect(minimizeBtn, Theme.ElementBackground, Theme.Tertiary, Theme.ElementBorder)
    AddHoverEffect(closeBtn, Theme.Error, Color3.fromRGB(255, 91, 91), Color3.fromRGB(220, 51, 51))
    AddHoverEffect(confirmYesBtn, Theme.Error, Color3.fromRGB(255, 91, 91))
    AddHoverEffect(confirmNoBtn, Theme.ElementBackground, Theme.Tertiary)
    AddHoverEffect(loaderIcon, Theme.Secondary, Theme.Tertiary)
    
    closeBtn.MouseButton1Click:Connect(function()
        confirmOverlay.Visible = true
        confirmModal.Size = UDim2.new(0, 0, 0, 0)
        Tween(confirmModal, {Size = UDim2.new(0, 320, 0, 160)}, 0.4, Enum.EasingStyle.Back)
    end)
    
    confirmYesBtn.MouseButton1Click:Connect(function()
        Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.4, Enum.EasingStyle.Back)
        wait(0.4)
        screenGui:Destroy()
    end)
    
    confirmNoBtn.MouseButton1Click:Connect(function()
        Tween(confirmModal, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        confirmOverlay.Visible = false
    end)
    
    minimizeBtn.MouseButton1Click:Connect(function()
        Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        mainFrame.Visible = false
        loaderIcon.Visible = true
        Tween(loaderIcon, {Size = UDim2.new(0, 70, 0, 70)}, 0.3, Enum.EasingStyle.Back)
    end)
    
    loaderIcon.MouseButton1Click:Connect(function()
        Tween(loaderIcon, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        loaderIcon.Visible = false
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        Tween(mainFrame, {Size = defaultSize}, 0.4, Enum.EasingStyle.Back)
    end)
    
    MakeDraggable(mainFrame, titleBar)
    
    -- ═══════════════════════════════════════════════════════════
    -- WINDOW OBJECT
    -- ═══════════════════════════════════════════════════════════
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        ContentScroll = contentScroll
    }
    
    -- ═══════════════════════════════════════════════════════════
    -- MAKE TAB FUNCTION
    -- ═══════════════════════════════════════════════════════════
    function Window:MakeTab(options)
        options = options or {}
        local tabName = options.Name or "Tab"
        local tabIcon = options.Icon or ""
        
        local tabButton = CreateInstance("TextButton", {
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundColor3 = Theme.ElementBackground,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            ClipsDescendants = false,
            ZIndex = 5,
            Parent = tabsContainer
        })
        
        CreateInstance("UICorner", {
            CornerRadius = UDim.new(0, 8),
            Parent = tabButton
        })
        
        local activeIndicator = CreateInstance("Frame", {
            Size = UDim2.new(0, 0, 0, 35),
            Position = UDim2.new(0, -5, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
            ZIndex = 6,
            Parent = tabButton
        })
        
        CreateInstance("UICorner", {
            CornerRadius = UDim.new(1, 0),
            Parent = activeIndicator
        })
        
        local iconOffset = 12
        if tabIcon ~= "" then
            CreateInstance("ImageLabel", {
                Size = UDim2.new(0, 28, 0, 28),
                Position = UDim2.new(0, 14, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                Image = tabIcon,
                ScaleType = Enum.ScaleType.Fit,
                ZIndex = 7,
                Parent = tabButton
            })
            iconOffset = 50
        end
        
        CreateInstance("TextLabel", {
            Size = UDim2.new(1, -iconOffset - 8, 1, 0),
            Position = UDim2.new(0, iconOffset, 0, 0),
            BackgroundTransparency = 1,
            Text = tabName,
            TextColor3 = Theme.TextSecondary,
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            ZIndex = 7,
            Parent = tabButton
        })
        
        local tabContainer = CreateInstance("Frame", {
            Name = tabName .. "_Container",
            Size = UDim2.new(1, -24, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Visible = false,
            BorderSizePixel = 0,
            ClipsDescendants = false,
            ZIndex = 5,
            Parent = contentScroll
        })
        
        local tabLayout = CreateInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10),
            Parent = tabContainer
        })
        
        local function updateCanvasSize()
            task.wait(0.05)
            local contentSize = tabLayout.AbsoluteContentSize.Y
            contentScroll.CanvasSize = UDim2.new(0, 0, 0, contentSize + 30)
        end
        
        tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)
        
        tabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                Tween(tab.Button, {BackgroundColor3 = Theme.ElementBackground}, 0.2)
                tab.Container.Visible = false
                Tween(tab.ActiveIndicator, {
                    Size = UDim2.new(0, 0, 0, 35),
                    Position = UDim2.new(0, -5, 0.5, 0)
                }, 0.3, Enum.EasingStyle.Back)
            end
            
            Tween(tabButton, {BackgroundColor3 = Theme.Tertiary}, 0.2)
            tabContainer.Visible = true
            
            Tween(activeIndicator, {
                Size = UDim2.new(0, 4, 0, 35),
                Position = UDim2.new(0, 0, 0.5, 0)
            }, 0.4, Enum.EasingStyle.Back)
            
            Window.CurrentTab = tabName
            updateCanvasSize()
        end)
        
        AddHoverEffect(tabButton, Theme.ElementBackground, Theme.Tertiary)
        
        local Tab = {
            Name = tabName,
            Button = tabButton,
            Container = tabContainer,
            ActiveIndicator = activeIndicator,
            Elements = {},
            UpdateCanvas = updateCanvasSize
        }
        
        if #Window.Tabs == 0 then
            tabButton.BackgroundColor3 = Theme.Tertiary
            tabContainer.Visible = true
            activeIndicator.Size = UDim2.new(0, 4, 0, 35)
            activeIndicator.Position = UDim2.new(0, 0, 0.5, 0)
            Window.CurrentTab = tabName
            updateCanvasSize()
        end
        
        table.insert(Window.Tabs, Tab)
        
        -- ═══════════════════════════════════════════════════════
        -- ADD PARAGRAPH
        -- ═══════════════════════════════════════════════════════
        function Tab:AddParagraph(options)
            options = options or {}
            local title = options.Title or "Paragraph"
            local text = options.Text or "No text provided"
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                Visible = true,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = container
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.ElementBorder,
                Thickness = 1,
                Transparency = 0.7,
                Parent = container
            })
            
            CreateInstance("UIPadding", {
                PaddingAll = UDim.new(0, 12),
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = "📝 " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 25),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = text,
                TextColor3 = Theme.TextSecondary,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            table.insert(Tab.Elements, container)
            Tab.UpdateCanvas()
            return container
        end
        
        -- ═══════════════════════════════════════════════════════
        -- ADD BUTTON
        -- ═══════════════════════════════════════════════════════
        function Tab:AddButton(options)
            options = options or {}
            local title = options.Title or "Button"
            local text = options.Text or "Click Me"
            local callback = options.Callback or function() end
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 80),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                Visible = true,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = container
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.ElementBorder,
                Thickness = 1,
                Transparency = 0.7,
                Parent = container
            })
            
            CreateInstance("UIPadding", {
                PaddingAll = UDim.new(0, 12),
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = "🔘 " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            local button = CreateInstance("TextButton", {
                Size = UDim2.new(1, 0, 0, 36),
                Position = UDim2.new(0, 0, 0, 32),
                BackgroundColor3 = Theme.Accent,
                Text = text,
                TextColor3 = Theme.TextPrimary,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 7),
                Parent = button
            })
            
            button.MouseButton1Click:Connect(function()
                Tween(button, {Size = UDim2.new(0.98, 0, 0, 34)}, 0.1)
                wait(0.1)
                Tween(button, {Size = UDim2.new(1, 0, 0, 36)}, 0.1)
                
                spawn(function()
                    pcall(callback)
                end)
            end)
            
            AddHoverEffect(button, Theme.Accent, Theme.AccentHover, Theme.AccentPressed)
            
            table.insert(Tab.Elements, container)
            Tab.UpdateCanvas()
            return container
        end
        
        -- ═══════════════════════════════════════════════════════
        -- ADD TOGGLE
        -- ═══════════════════════════════════════════════════════
        function Tab:AddToggle(options)
            options = options or {}
            local title = options.Title or "Toggle"
            local text = options.Text or "Toggle Option"
            local default = options.Default or false
            local callback = options.Callback or function() end
            
            local toggled = default
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 72),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                Visible = true,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = container
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.ElementBorder,
                Thickness = 1,
                Transparency = 0.7,
                Parent = container
            })
            
            CreateInstance("UIPadding", {
                PaddingAll = UDim.new(0, 12),
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = "🔄 " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(0.62, 0, 0, 30),
                Position = UDim2.new(0, 0, 0, 32),
                BackgroundTransparency = 1,
                Text = text,
                TextColor3 = Theme.TextSecondary,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                TextWrapped = true,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            local toggleTrack = CreateInstance("TextButton", {
                Size = UDim2.new(0, 50, 0, 26),
                Position = UDim2.new(1, -50, 0, 38),
                BackgroundColor3 = toggled and Theme.ToggleOn or Theme.ToggleOff,
                Text = "",
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = toggleTrack
            })
            
            local toggleKnob = CreateInstance("Frame", {
                Size = UDim2.new(0, 20, 0, 20),
                Position = toggled and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Theme.TextPrimary,
                ZIndex = 8,
                Parent = toggleTrack
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = toggleKnob
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.TextSecondary,
                Thickness = 1.5,
                Parent = toggleKnob
            })
            
            toggleTrack.MouseButton1Click:Connect(function()
                toggled = not toggled
                
                if toggled then
                    Tween(toggleTrack, {BackgroundColor3 = Theme.ToggleOn}, 0.3)
                    Tween(toggleKnob, {Position = UDim2.new(1, -23, 0.5, 0)}, 0.3, Enum.EasingStyle.Quad)
                else
                    Tween(toggleTrack, {BackgroundColor3 = Theme.ToggleOff}, 0.3)
                    Tween(toggleKnob, {Position = UDim2.new(0, 3, 0.5, 0)}, 0.3, Enum.EasingStyle.Quad)
                end
                
                spawn(function()
                    pcall(function()
                        callback(toggled)
                    end)
                end)
            end)
            
            table.insert(Tab.Elements, container)
            Tab.UpdateCanvas()
            return container
        end
        
        -- ═══════════════════════════════════════════════════════
        -- ADD SLIDER
        -- ═══════════════════════════════════════════════════════
        function Tab:AddSlider(options)
            options = options or {}
            local title = options.Title or "Slider"
            local min = options.Min or 0
            local max = options.Max or 100
            local default = options.Default or 50
            local callback = options.Callback or function() end
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 85),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                Visible = true,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = container
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.ElementBorder,
                Thickness = 1,
                Transparency = 0.7,
                Parent = container
            })
            
            CreateInstance("UIPadding", {
                PaddingAll = UDim.new(0, 12),
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, -60, 0, 20),
                BackgroundTransparency = 1,
                Text = "🎚️ " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            local valueLabel = CreateInstance("TextLabel", {
                Size = UDim2.new(0, 55, 0, 24),
                Position = UDim2.new(1, -55, 0, 0),
                BackgroundColor3 = Theme.Tertiary,
                Text = tostring(default),
                TextColor3 = Theme.TextPrimary,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 6),
                Parent = valueLabel
            })
            
            local sliderTrack = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 7),
                Position = UDim2.new(0, 0, 0, 45),
                BackgroundColor3 = Theme.Tertiary,
                BorderSizePixel = 0,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = sliderTrack
            })
            
            local sliderFill = CreateInstance("Frame", {
                Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                BackgroundColor3 = Theme.Accent,
                BorderSizePixel = 0,
                ZIndex = 8,
                Parent = sliderTrack
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = sliderFill
            })
            
            local sliderKnob = CreateInstance("TextButton", {
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new((default - min) / (max - min), -9, 0.5, -9),
                BackgroundColor3 = Theme.TextPrimary,
                BorderSizePixel = 0,
                Text = "",
                Visible = true,
                ZIndex = 9,
                Parent = sliderTrack
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = sliderKnob
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.Accent,
                Thickness = 2,
                Parent = sliderKnob
            })
            
            local dragging = false
            
            sliderKnob.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)
            
            sliderTrack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
                   input.UserInputType == Enum.UserInputType.Touch) then
                    local mousePos = input.Position.X
                    local trackPos = sliderTrack.AbsolutePosition.X
                    local trackSize = sliderTrack.AbsoluteSize.X
                    local relative = math.clamp((mousePos - trackPos) / trackSize, 0, 1)
                    local value = math.floor(min + (max - min) * relative)
                    
                    sliderFill.Size = UDim2.new(relative, 0, 1, 0)
                    sliderKnob.Position = UDim2.new(relative, -9, 0.5, -9)
                    valueLabel.Text = tostring(value)
                    
                    spawn(function()
                        pcall(function()
                            callback(value)
                        end)
                    end)
                end
            end)
            
            AddHoverEffect(sliderKnob, Theme.TextPrimary, Theme.TextSecondary)
            
            table.insert(Tab.Elements, container)
            Tab.UpdateCanvas()
            return container
        end
        
        -- ═══════════════════════════════════════════════════════
        -- ADD TEXTBOX
        -- ═══════════════════════════════════════════════════════
        function Tab:AddTextBox(options)
            options = options or {}
            local title = options.Title or "TextBox"
            local placeholder = options.Placeholder or "اكتب هنا..."
            local default = options.Default or ""
            local callback = options.Callback or function() end
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 80),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                Visible = true,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = container
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.ElementBorder,
                Thickness = 1,
                Transparency = 0.7,
                Parent = container
            })
            
            CreateInstance("UIPadding", {
                PaddingAll = UDim.new(0, 12),
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = "✏️ " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            local textBox = CreateInstance("TextBox", {
                Size = UDim2.new(1, 0, 0, 36),
                Position = UDim2.new(0, 0, 0, 32),
                BackgroundColor3 = Theme.Tertiary,
                PlaceholderText = placeholder,
                PlaceholderColor3 = Theme.TextMuted,
                Text = default,
                TextColor3 = Theme.TextPrimary,
                TextSize = 13,
                Font = Enum.Font.Gotham,
                ClearTextOnFocus = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 7),
                Parent = textBox
            })
            
            CreateInstance("UIPadding", {
                PaddingLeft = UDim.new(0, 10),
                PaddingRight = UDim.new(0, 10),
                Parent = textBox
            })
            
            local textBoxStroke = CreateInstance("UIStroke", {
                Color = Theme.ElementBorder,
                Thickness = 1.5,
                Transparency = 0.5,
                Parent = textBox
            })
            
            textBox.Focused:Connect(function()
                Tween(textBoxStroke, {Color = Theme.Accent, Transparency = 0}, 0.2)
            end)
            
            textBox.FocusLost:Connect(function(enterPressed)
                Tween(textBoxStroke, {Color = Theme.ElementBorder, Transparency = 0.5}, 0.2)
                
                if enterPressed then
                    spawn(function()
                        pcall(function()
                            callback(textBox.Text)
                        end)
                    end)
                end
            end)
            
            table.insert(Tab.Elements, container)
            Tab.UpdateCanvas()
            return textBox
        end
        
        -- ═══════════════════════════════════════════════════════
        -- ADD DROPDOWN
        -- ═══════════════════════════════════════════════════════
        function Tab:AddDropdown(options)
            options = options or {}
            local title = options.Title or "Dropdown"
            local text = options.Text or "اختر خياراً"
            local items = options.Items or {"Option 1", "Option 2", "Option 3"}
            local callback = options.Callback or function() end
            
            local selectedItem = text
            local isOpen = false
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 80),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                Visible = true,
                ClipsDescendants = false,
                ZIndex = 6,
                Parent = tabContainer
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 8),
                Parent = container
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.ElementBorder,
                Thickness = 1,
                Transparency = 0.7,
                Parent = container
            })
            
            CreateInstance("UIPadding", {
                PaddingAll = UDim.new(0, 12),
                Parent = container
            })
            
            CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = "📋 " .. title,
                TextColor3 = Theme.TextPrimary,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            local dropdownButton = CreateInstance("TextButton", {
                Size = UDim2.new(1, 0, 0, 36),
                Position = UDim2.new(0, 0, 0, 32),
                BackgroundColor3 = Theme.Tertiary,
                Text = "",
                Visible = true,
                ZIndex = 7,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 7),
                Parent = dropdownButton
            })
            
            local dropdownLabel = CreateInstance("TextLabel", {
                Size = UDim2.new(1, -35, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Text = selectedItem,
                TextColor3 = Theme.TextPrimary,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Visible = true,
                ZIndex = 8,
                Parent = dropdownButton
            })
            
            local arrowIcon = CreateInstance("TextLabel", {
                Size = UDim2.new(0, 25, 1, 0),
                Position = UDim2.new(1, -25, 0, 0),
                BackgroundTransparency = 1,
                Text = "▼",
                TextColor3 = Theme.TextSecondary,
                TextSize = 11,
                Font = Enum.Font.Gotham,
                Visible = true,
                ZIndex = 8,
                Parent = dropdownButton
            })
            
            local dropdownList = CreateInstance("ScrollingFrame", {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 73),
                BackgroundColor3 = Theme.Tertiary,
                BorderSizePixel = 0,
                ScrollBarThickness = 4,
                ScrollBarImageColor3 = Theme.ElementBorder,
                Visible = false,
                ZIndex = 100,
                ClipsDescendants = true,
                Parent = container
            })
            
            CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 7),
                Parent = dropdownList
            })
            
            CreateInstance("UIStroke", {
                Color = Theme.Accent,
                Thickness = 1.5,
                Parent = dropdownList
            })
            
            local listLayout = CreateInstance("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 2),
                Parent = dropdownList
            })
            
            CreateInstance("UIPadding", {
                PaddingAll = UDim.new(0, 4),
                Parent = dropdownList
            })
            
            listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                dropdownList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 8)
            end)
            
            for i, item in ipairs(items) do
                local itemButton = CreateInstance("TextButton", {
                    Size = UDim2.new(1, -8, 0, 32),
                    BackgroundColor3 = Theme.ElementBackground,
                    Text = "",
                    ZIndex = 101,
                    Parent = dropdownList
                })
                
                CreateInstance("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = itemButton
                })
                
                CreateInstance("TextLabel", {
                    Size = UDim2.new(1, -10, 1, 0),
                    Position = UDim2.new(0, 8, 0, 0),
                    BackgroundTransparency = 1,
                    Text = item,
                    TextColor3 = Theme.TextPrimary,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = 102,
                    Parent = itemButton
                })
                
                itemButton.MouseButton1Click:Connect(function()
                    selectedItem = item
                    dropdownLabel.Text = selectedItem
                    
                    isOpen = false
                    
                    Tween(container, {Size = UDim2.new(1, 0, 0, 80)}, 0.3)
                    Tween(dropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
                    Tween(arrowIcon, {Rotation = 0}, 0.3)
                    
                    wait(0.3)
                    dropdownList.Visible = false
                    Tab.UpdateCanvas()
                    
                    spawn(function()
                        pcall(function()
                            callback(item)
                        end)
                    end)
                end)
                
                AddHoverEffect(itemButton, Theme.ElementBackground, Theme.ElementBorder)
            end
            
            dropdownButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                
                if isOpen then
                    dropdownList.Visible = true
                    local maxHeight = math.min(#items * 34, 140)
                    
                    Tween(container, {Size = UDim2.new(1, 0, 0, 80 + maxHeight + 8)}, 0.3, Enum.EasingStyle.Back)
                    Tween(dropdownList, {Size = UDim2.new(1, 0, 0, maxHeight)}, 0.3, Enum.EasingStyle.Back)
                    Tween(arrowIcon, {Rotation = 180}, 0.3)
                    
                    task.wait(0.3)
                    Tab.UpdateCanvas()
                else
                    Tween(container, {Size = UDim2.new(1, 0, 0, 80)}, 0.3)
                    Tween(dropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
                    Tween(arrowIcon, {Rotation = 0}, 0.3)
                    
                    wait(0.3)
                    dropdownList.Visible = false
                    Tab.UpdateCanvas()
                end
            end)
            
            AddHoverEffect(dropdownButton, Theme.Tertiary, Theme.ElementBorder)
            
            table.insert(Tab.Elements, container)
            Tab.UpdateCanvas()
            return container
        end
        
        return Tab
    end
    
    -- فتح الواجهة مباشرة
    Tween(mainFrame, {Size = defaultSize}, 0.5, Enum.EasingStyle.Back)
    
    return Window
end

return DrakthonLib
