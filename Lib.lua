--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║                     DRAKTHON UI LIBRARY                      ║
    ║                    مكتبة واجهات احترافية                     ║
    ║              Coded by: AI Assistant for Roblox               ║
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

local function Tween(object, properties, duration, easingStyle, easingDirection)
    easingStyle = easingStyle or Enum.EasingStyle.Quad
    easingDirection = easingDirection or Enum.EasingDirection.Out
    duration = duration or 0.3
    
    local tweenInfo = TweenInfo.new(duration, easingStyle, easingDirection)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

local function MakeDraggable(frame, dragHandle)
    local dragging = false
    local dragInput, mousePos, framePos
    
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            
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
            local delta = input.Position - mousePos
            local newPos = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
            frame.Position = newPos
        end
    end)
end

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
    
    local resizing = false
    local startPos, startSize
    
    resizeButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            startPos = input.Position
            startSize = frame.AbsoluteSize
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    resizing = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or 
           input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - startPos
            local newWidth = math.max(minSize.X, startSize.X + delta.X)
            local newHeight = math.max(minSize.Y, startSize.Y + delta.Y)
            
            frame.Size = UDim2.new(0, newWidth, 0, newHeight)
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
    local defaultSize = options.DefaultSize or UDim2.new(0.6, 0, 0.6, 0)
    local minSize = options.MinSize or Vector2.new(400, 300)
    local loaderImage = options.LoaderImage or "rbxassetid://6031097225"
    
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
    -- MAIN WINDOW FRAME
    -- ═══════════════════════════════════════════════════════════
    local mainFrame = CreateInstance("Frame", {
        Name = "MainWindow",
        Size = defaultSize,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(33, 33, 33),
        BorderSizePixel = 0,
        ClipsDescendants = true,
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
        Parent = mainFrame
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = titleBar
    })
    
    -- Cover bottom corners
    CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 15),
        Position = UDim2.new(0, 0, 1, -15),
        BackgroundColor3 = Color3.fromRGB(28, 28, 28),
        BorderSizePixel = 0,
        Parent = titleBar
    })
    
    -- Title Text
    CreateInstance("TextLabel", {
        Size = UDim2.new(1, -120, 1, 0),
        Position = UDim2.new(0, 20, 0, 0),
        BackgroundTransparency = 1,
        Text = "🌙 " .. windowName,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
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
        Size = UDim2.new(0, 65, 0, 65),
        Position = UDim2.new(0, 25, 1, -90),
        BackgroundColor3 = Color3.fromRGB(28, 28, 28),
        Image = loaderImage,
        ScaleType = Enum.ScaleType.Fit,
        Visible = false,
        Parent = screenGui
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 15),
        Parent = loaderIcon
    })
    
    CreateInstance("UIStroke", {
        Color = Color3.fromRGB(80, 80, 80),
        Thickness = 2.5,
        Parent = loaderIcon
    })
    
    -- Loader animation
    local loaderRotation = 0
    RunService.RenderStepped:Connect(function()
        if loaderIcon.Visible then
            loaderRotation = (loaderRotation + 2) % 360
            loaderIcon.Rotation = loaderRotation
        end
    end)
    
    -- ═══════════════════════════════════════════════════════════
    -- CONFIRMATION MODAL
    -- ═══════════════════════════════════════════════════════════
    local confirmModal = CreateInstance("Frame", {
        Size = UDim2.new(0, 350, 0, 170),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 200,
        Parent = screenGui
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = confirmModal
    })
    
    CreateInstance("UIStroke", {
        Color = Color3.fromRGB(100, 100, 100),
        Thickness = 2,
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
        Parent = confirmModal
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = confirmNoBtn
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- SIDEBAR (NAVIGATION)
    -- ═══════════════════════════════════════════════════════════
    local sidebar = CreateInstance("Frame", {
        Size = UDim2.new(0.25, 0, 1, -45),
        Position = UDim2.new(0, 0, 0, 45),
        BackgroundColor3 = Color3.fromRGB(26, 26, 26),
        BorderSizePixel = 0,
        Parent = mainFrame
    })
    
    -- Tabs Container
    local tabsContainer = CreateInstance("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, -105),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Color3.fromRGB(55, 55, 55),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Parent = sidebar
    })
    
    local tabsLayout = CreateInstance("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6),
        Parent = tabsContainer
    })
    
    CreateInstance("UIPadding", {
        PaddingTop = UDim.new(0, 12),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        Parent = tabsContainer
    })
    
    tabsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabsContainer.CanvasSize = UDim2.new(0, 0, 0, tabsLayout.AbsoluteContentSize.Y + 20)
    end)
    
    -- User Profile
    local userProfile = CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 95),
        Position = UDim2.new(0, 0, 1, -95),
        BackgroundColor3 = Color3.fromRGB(22, 22, 22),
        BorderSizePixel = 0,
        Parent = sidebar
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = userProfile
    })
    
    local avatarImage = CreateInstance("ImageLabel", {
        Size = UDim2.new(0, 55, 0, 55),
        Position = UDim2.new(0.5, 0, 0, 8),
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = Color3.fromRGB(55, 55, 55),
        Image = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150),
        Parent = userProfile
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = avatarImage
    })
    
    CreateInstance("UIStroke", {
        Color = Color3.fromRGB(80, 80, 80),
        Thickness = 2,
        Parent = avatarImage
    })
    
    CreateInstance("TextLabel", {
        Size = UDim2.new(1, -10, 0, 16),
        Position = UDim2.new(0, 5, 0, 68),
        BackgroundTransparency = 1,
        Text = Player.Name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = userProfile
    })
    
    -- ═══════════════════════════════════════════════════════════
    -- CONTENT AREA
    -- ═══════════════════════════════════════════════════════════
    local contentArea = CreateInstance("ScrollingFrame", {
        Size = UDim2.new(0.75, 0, 1, -45),
        Position = UDim2.new(0.25, 0, 0, 45),
        BackgroundColor3 = Color3.fromRGB(33, 33, 33),
        BorderSizePixel = 0,
        ScrollBarThickness = 6,
        ScrollBarImageColor3 = Color3.fromRGB(55, 55, 55),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Parent = mainFrame
    })
    
    local contentLayout = CreateInstance("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 10),
        Parent = contentArea
    })
    
    CreateInstance("UIPadding", {
        PaddingTop = UDim.new(0, 15),
        PaddingLeft = UDim.new(0, 15),
        PaddingRight = UDim.new(0, 15),
        PaddingBottom = UDim.new(0, 15),
        Parent = contentArea
    })
    
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        contentArea.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 30)
    end)
    
    -- ═══════════════════════════════════════════════════════════
    -- BUTTON INTERACTIONS
    -- ═══════════════════════════════════════════════════════════
    AddHoverEffect(minimizeBtn, Color3.fromRGB(55, 55, 55), Color3.fromRGB(75, 75, 75), Color3.fromRGB(90, 90, 90))
    AddHoverEffect(closeBtn, Color3.fromRGB(190, 50, 50), Color3.fromRGB(220, 70, 70), Color3.fromRGB(240, 90, 90))
    AddHoverEffect(confirmYesBtn, Color3.fromRGB(190, 50, 50), Color3.fromRGB(220, 70, 70))
    AddHoverEffect(confirmNoBtn, Color3.fromRGB(60, 60, 60), Color3.fromRGB(80, 80, 80))
    
    -- Close Button
    closeBtn.MouseButton1Click:Connect(function()
        confirmModal.Visible = true
        confirmModal.Size = UDim2.new(0, 0, 0, 0)
        Tween(confirmModal, {Size = UDim2.new(0, 350, 0, 170)}, 0.4, Enum.EasingStyle.Back)
    end)
    
    confirmYesBtn.MouseButton1Click:Connect(function()
        Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.4, Enum.EasingStyle.Back)
        wait(0.4)
        screenGui:Destroy()
    end)
    
    confirmNoBtn.MouseButton1Click:Connect(function()
        Tween(confirmModal, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        confirmModal.Visible = false
    end)
    
    -- Minimize Button
    minimizeBtn.MouseButton1Click:Connect(function()
        Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        mainFrame.Visible = false
        loaderIcon.Visible = true
        Tween(loaderIcon, {Size = UDim2.new(0, 75, 0, 75)}, 0.3, Enum.EasingStyle.Back)
    end)
    
    loaderIcon.MouseButton1Click:Connect(function()
        Tween(loaderIcon, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        loaderIcon.Visible = false
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        Tween(mainFrame, {Size = defaultSize}, 0.4, Enum.EasingStyle.Back)
    end)
    
    AddHoverEffect(loaderIcon, Color3.fromRGB(28, 28, 28), Color3.fromRGB(40, 40, 40))
    
    -- Make draggable and resizable
    MakeDraggable(mainFrame, titleBar)
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
        
        -- Tab Button
        local tabButton = CreateInstance("TextButton", {
            Size = UDim2.new(1, 0, 0, 50),
            BackgroundColor3 = Color3.fromRGB(33, 33, 33),
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            Parent = tabsContainer
        })
        
        CreateInstance("UICorner", {
            CornerRadius = UDim.new(0, 8),
            Parent = tabButton
        })
        
        -- Icon
        if tabIcon ~= "" then
            CreateInstance("ImageLabel", {
                Size = UDim2.new(0, 28, 0, 28),
                Position = UDim2.new(0, 12, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                Image = tabIcon,
                ScaleType = Enum.ScaleType.Fit,
                Parent = tabButton
            })
        end
        
        -- Label
        CreateInstance("TextLabel", {
            Size = UDim2.new(1, -50, 1, 0),
            Position = UDim2.new(0, 45, 0, 0),
            BackgroundTransparency = 1,
            Text = tabName,
            TextColor3 = Color3.fromRGB(200, 200, 200),
            TextSize = 14,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = tabButton
        })
        
        -- Tab Container
        local tabContainer = CreateInstance("Frame", {
            Name = tabName .. "_Container",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Visible = false,
            LayoutOrder = #Window.Tabs + 1,
            Parent = contentArea
        })
        
        CreateInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10),
            Parent = tabContainer
        })
        
        -- Tab Selection
        tabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                Tween(tab.Button, {BackgroundColor3 = Color3.fromRGB(33, 33, 33)}, 0.2)
                tab.Container.Visible = false
            end
            
            Tween(tabButton, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.2)
            tabContainer.Visible = true
            Window.CurrentTab = tabName
        end)
        
        AddHoverEffect(tabButton, Color3.fromRGB(33, 33, 33), Color3.fromRGB(44, 44, 44))
        
        -- Tab Object
        local Tab = {
            Name = tabName,
            Button = tabButton,
            Container = tabContainer,
            Elements = {}
        }
        
        -- Auto-select first tab
        if #Window.Tabs == 0 then
            tabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            tabContainer.Visible = true
            Window.CurrentTab = tabName
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
            
            table.insert(Tab.Elements, container)
            return container
        end
        
        -- ═══════════════════════════════════════════════════════
        -- ADD BUTTON
        -- ═══════════════════════════════════════════════════════
        function Tab:AddButton(options)
            options = options or {}
            local title = options.Title or "Button"
            local text = options.Text or "Click Me"
            local icon = options.Icon or ""
            local callback = options.Callback or function() end
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 90),
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
                Tween(button, {Size = UDim2.new(0.98, 0, 0, 38)}, 0.1)
                wait(0.1)
                Tween(button, {Size = UDim2.new(1, 0, 0, 40)}, 0.1)
                
                spawn(function()
                    pcall(callback)
                end)
            end)
            
            AddHoverEffect(button, Color3.fromRGB(60, 120, 200), Color3.fromRGB(80, 140, 220), Color3.fromRGB(50, 110, 190))
            
            table.insert(Tab.Elements, container)
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
                Size = UDim2.new(1, 0, 0, 80),
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
            
            -- Toggle Switch
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
                    Tween(toggleTrack, {BackgroundColor3 = Color3.fromRGB(80, 200, 120)}, 0.3)
                    Tween(toggleKnob, {Position = UDim2.new(1, -27, 0.5, 0)}, 0.3, Enum.EasingStyle.Quad)
                else
                    Tween(toggleTrack, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.3)
                    Tween(toggleKnob, {Position = UDim2.new(0, 3, 0.5, 0)}, 0.3, Enum.EasingStyle.Quad)
                end
                
                spawn(function()
                    pcall(function()
                        callback(toggled)
                    end)
                end)
            end)
            
            table.insert(Tab.Elements, container)
            return container
        end
        
        -- ═══════════════════════════════════════════════════════
        -- ADD DROPDOWN
        -- ═══════════════════════════════════════════════════════
        function Tab:AddDropdown(options)
            options = options or {}
            local title = options.Title or "Dropdown"
            local text = options.Text or "Select an option"
            local items = options.Items or {"Option 1", "Option 2", "Option 3"}
            local callback = options.Callback or function() end
            
            local selectedItem = text
            local isOpen = false
            
            local container = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 90),
                BackgroundColor3 = Color3.fromRGB(44, 44, 44),
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                Parent = tabContainer,
                ClipsDescendants = false,
                ZIndex = 1
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
            
            -- Dropdown List
            local dropdownList = CreateInstance("ScrollingFrame", {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 80),
                BackgroundColor3 = Color3.fromRGB(50, 50, 50),
                BorderSizePixel = 0,
                ScrollBarThickness = 4,
                ScrollBarImageColor3 = Color3.fromRGB(70, 70, 70),
                Visible = false,
                ZIndex = 50,
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
            
            -- Create items
            for i, item in ipairs(items) do
                local itemButton = CreateInstance("TextButton", {
                    Size = UDim2.new(1, -10, 0, 35),
                    BackgroundColor3 = Color3.fromRGB(60, 60, 60),
                    Text = "",
                    ZIndex = 51,
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
                    ZIndex = 52,
                    Parent = itemButton
                })
                
                itemButton.MouseButton1Click:Connect(function()
                    selectedItem = item
                    dropdownLabel.Text = selectedItem
                    
                    isOpen = false
                    Tween(dropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
                    Tween(arrowIcon, {Rotation = 0}, 0.3)
                    wait(0.3)
                    dropdownList.Visible = false
                    
                    spawn(function()
                        pcall(function()
                            callback(item)
                        end)
                    end)
                end)
                
                AddHoverEffect(itemButton, Color3.fromRGB(60, 60, 60), Color3.fromRGB(80, 80, 80))
            end
            
            -- Toggle dropdown
            dropdownButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                
                if isOpen then
                    dropdownList.Visible = true
                    local maxHeight = math.min(#items * 38, 160)
                    Tween(dropdownList, {Size = UDim2.new(1, 0, 0, maxHeight)}, 0.3, Enum.EasingStyle.Back)
                    Tween(arrowIcon, {Rotation = 180}, 0.3)
                else
                    Tween(dropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
                    Tween(arrowIcon, {Rotation = 0}, 0.3)
                    wait(0.3)
                    dropdownList.Visible = false
                end
            end)
            
            AddHoverEffect(dropdownButton, Color3.fromRGB(60, 60, 60), Color3.fromRGB(75, 75, 75))
            
            table.insert(Tab.Elements, container)
            return container
        end
        
        return Tab
    end
    
    -- Entrance Animation
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    Tween(mainFrame, {Size = defaultSize}, 0.5, Enum.EasingStyle.Back)
    
    return Window
end

return DrakthonLib
