--// DrakthonLib V2.0 - Compact UI (60% Smaller) + Logo Support
local DrakthonLib = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local function Tween(obj, props, duration, style, direction)
    return TweenService:Create(obj, TweenInfo.new(duration or 0.2, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out), props)
end

local Themes = {
    DarkTheme = {Color3.fromRGB(64,64,64), Color3.fromRGB(0,0,0), Color3.fromRGB(0,0,0), Color3.fromRGB(255,255,255), Color3.fromRGB(20,20,20)},
    LightTheme = {Color3.fromRGB(150,150,150), Color3.fromRGB(255,255,255), Color3.fromRGB(200,200,200), Color3.fromRGB(0,0,0), Color3.fromRGB(224,224,224)},
    BloodTheme = {Color3.fromRGB(227,27,27), Color3.fromRGB(10,10,10), Color3.fromRGB(5,5,5), Color3.fromRGB(255,255,255), Color3.fromRGB(20,20,20)},
    GrapeTheme = {Color3.fromRGB(166,71,214), Color3.fromRGB(64,50,71), Color3.fromRGB(36,28,41), Color3.fromRGB(255,255,255), Color3.fromRGB(74,58,84)},
    Ocean = {Color3.fromRGB(86,76,251), Color3.fromRGB(26,32,58), Color3.fromRGB(38,45,71), Color3.fromRGB(200,200,200), Color3.fromRGB(38,45,71)},
    Midnight = {Color3.fromRGB(26,189,158), Color3.fromRGB(44,62,82), Color3.fromRGB(57,81,105), Color3.fromRGB(255,255,255), Color3.fromRGB(52,74,95)},
    Sentinel = {Color3.fromRGB(230,35,69), Color3.fromRGB(32,32,32), Color3.fromRGB(24,24,24), Color3.fromRGB(119,209,138), Color3.fromRGB(24,24,24)},
    Synapse = {Color3.fromRGB(46,48,43), Color3.fromRGB(13,15,12), Color3.fromRGB(36,38,35), Color3.fromRGB(152,99,53), Color3.fromRGB(24,24,24)},
    Serpent = {Color3.fromRGB(0,166,58), Color3.fromRGB(31,41,43), Color3.fromRGB(22,29,31), Color3.fromRGB(255,255,255), Color3.fromRGB(22,29,31)},
    Drakthon = {Color3.fromRGB(138,43,226), Color3.fromRGB(15,15,20), Color3.fromRGB(20,20,28), Color3.fromRGB(255,255,255), Color3.fromRGB(25,25,35)}
}

local LibName = "DrakthonLib_"..math.random(1000,9999)

function DrakthonLib:ToggleUI()
    CoreGui[LibName].Enabled = not CoreGui[LibName].Enabled
end

local function MakeDraggable(frame, parent)
    local dragging, dragInput, mousePos, framePos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

local function Ripple(btn)
    local ms = Players.LocalPlayer:GetMouse()
    local circle = Instance.new("ImageLabel")
    circle.Parent = btn
    circle.BackgroundTransparency = 1
    circle.Image = "http://www.roblox.com/asset/?id=4560909609"
    circle.ImageColor3 = Color3.fromRGB(255,255,255)
    circle.ImageTransparency = 0.6
    local x, y = ms.X - btn.AbsolutePosition.X, ms.Y - btn.AbsolutePosition.Y
    circle.Position = UDim2.new(0, x, 0, y)
    local size = math.max(btn.AbsoluteSize.X, btn.AbsoluteSize.Y) * 1.5
    circle:TweenSizeAndPosition(UDim2.new(0,size,0,size), UDim2.new(0.5,-size/2,0.5,-size/2), 'Out', 'Quad', 0.35, true)
    for i = 1, 10 do circle.ImageTransparency = circle.ImageTransparency + 0.05 task.wait(0.035) end
    circle:Destroy()
end

function DrakthonLib.CreateLib(title, theme, logoConfig)
    title = title or "DrakthonLib"
    logoConfig = logoConfig or {}
    local themeColors = type(theme) == "string" and Themes[theme] or theme or Themes.Drakthon
    if type(themeColors) == "table" and #themeColors == 5 then
        themeColors = {
            SchemeColor = themeColors[1], 
            Background = themeColors[2], 
            Header = themeColors[3], 
            TextColor = themeColors[4], 
            ElementColor = themeColors[5]
        }
    end
    
    for _,v in pairs(CoreGui:GetChildren()) do 
        if v.Name:match("DrakthonLib_") then v:Destroy() end 
    end

    -- الأبعاد الجديدة (مصغرة 60%)
    local MainWidth = 310  -- كان 525
    local MainHeight = 190 -- كان 318
    local HeaderHeight = 18 -- كان 29
    local SidebarWidth = 90 -- كان 149
    local SidebarHeight = 172 -- كان 289
    local PageWidth = 210 -- كان 360
    local PageHeight = 162 -- كان 269
    local ElementWidth = 210 -- كان 352
    local ElementHeight = 20 -- كان 33
    local TabButtonHeight = 17 -- كان 28

    local GUI = Instance.new("ScreenGui")
    GUI.Name = LibName
    GUI.Parent = CoreGui
    GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    GUI.ResetOnSpawn = false

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = GUI
    Main.BackgroundColor3 = themeColors.Background
    Main.ClipsDescendants = true
    Main.Position = UDim2.new(0.5, -MainWidth/2, 0.5, -MainHeight/2)
    Main.Size = UDim2.new(0, MainWidth, 0, MainHeight)
    local MainCorner = Instance.new("UICorner", Main)
    MainCorner.CornerRadius = UDim.new(0, 6)

    -- إضافة ظل للواجهة
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = Main
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0, -15, 0, -15)
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://6014261993"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.7
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(99, 99, 99, 99)

    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Parent = Main
    Header.BackgroundColor3 = themeColors.Header
    Header.Size = UDim2.new(0, MainWidth, 0, HeaderHeight)
    local HeaderCorner = Instance.new("UICorner", Header)
    HeaderCorner.CornerRadius = UDim.new(0, 6)
    
    local HeaderCover = Instance.new("Frame")
    HeaderCover.Parent = Header
    HeaderCover.BackgroundColor3 = themeColors.Header
    HeaderCover.BorderSizePixel = 0
    HeaderCover.Position = UDim2.new(0, 0, 0.65, 0)
    HeaderCover.Size = UDim2.new(1, 0, 0, 8)

    -- Logo Support
    local LogoFrame = Instance.new("Frame")
    LogoFrame.Name = "LogoFrame"
    LogoFrame.Parent = Header
    LogoFrame.BackgroundTransparency = 1
    LogoFrame.Position = UDim2.new(0, 5, 0, 0)
    LogoFrame.Size = UDim2.new(0, HeaderHeight, 0, HeaderHeight)
    LogoFrame.Visible = false

    if logoConfig.ImageId then
        LogoFrame.Visible = true
        local LogoImage = Instance.new("ImageLabel")
        LogoImage.Parent = LogoFrame
        LogoImage.BackgroundTransparency = 1
        LogoImage.Size = UDim2.new(1, -2, 1, -2)
        LogoImage.Position = UDim2.new(0, 1, 0, 1)
        LogoImage.Image = logoConfig.ImageId
        LogoImage.ImageColor3 = logoConfig.ImageColor or Color3.fromRGB(255,255,255)
        LogoImage.ScaleType = logoConfig.ScaleType or Enum.ScaleType.Fit
        if logoConfig.ImageRectOffset then
            LogoImage.ImageRectOffset = logoConfig.ImageRectOffset
        end
        if logoConfig.ImageRectSize then
            LogoImage.ImageRectSize = logoConfig.ImageRectSize
        end
        if logoConfig.Rounded then
            Instance.new("UICorner", LogoImage).CornerRadius = UDim.new(1, 0)
        end
    end

    local Title = Instance.new("TextLabel")
    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, logoConfig.ImageId and (HeaderHeight + 5) or 8, 0, 0)
    Title.Size = UDim2.new(1, logoConfig.ImageId and -(HeaderHeight + 60) or -60, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = themeColors.TextColor
    Title.TextSize = 11
    Title.RichText = true
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextTruncate = Enum.TextTruncate.AtEnd

    local Close = Instance.new("ImageButton")
    Close.Parent = Header
    Close.BackgroundTransparency = 1
    Close.Position = UDim2.new(1, -20, 0, 0)
    Close.Size = UDim2.new(0, HeaderHeight, 0, HeaderHeight)
    Close.Image = "rbxassetid://3926305904"
    Close.ImageColor3 = Color3.fromRGB(255, 85, 85)
    Close.ImageRectOffset = Vector2.new(284, 4)
    Close.ImageRectSize = Vector2.new(24, 24)
    Close.MouseButton1Click:Connect(function()
        Tween(Close, {ImageTransparency = 1}, 0.1):Play()
        task.wait(0.1)
        Tween(Main, {
            Size = UDim2.new(0,0,0,0), 
            Position = UDim2.new(0, Main.AbsolutePosition.X + Main.AbsoluteSize.X/2, 0, Main.AbsolutePosition.Y + Main.AbsoluteSize.Y/2)
        }, 0.15):Play()
        Tween(Shadow, {ImageTransparency = 1}, 0.15):Play()
        task.wait(0.2)
        GUI:Destroy()
    end)

    -- Minimize Button
    local Minimize = Instance.new("ImageButton")
    Minimize.Parent = Header
    Minimize.BackgroundTransparency = 1
    Minimize.Position = UDim2.new(1, -38, 0, 0)
    Minimize.Size = UDim2.new(0, HeaderHeight, 0, HeaderHeight)
    Minimize.Image = "rbxassetid://3926305904"
    Minimize.ImageColor3 = Color3.fromRGB(255, 200, 85)
    Minimize.ImageRectOffset = Vector2.new(884, 284)
    Minimize.ImageRectSize = Vector2.new(36, 36)
    local minimized = false
    Minimize.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Tween(Main, {Size = UDim2.new(0, MainWidth, 0, HeaderHeight)}, 0.2):Play()
        else
            Tween(Main, {Size = UDim2.new(0, MainWidth, 0, MainHeight)}, 0.2):Play()
        end
    end)

    MakeDraggable(Header, Main)

    local Sidebar = Instance.new("Frame")
    Sidebar.Parent = Main
    Sidebar.BackgroundColor3 = themeColors.Header
    Sidebar.Position = UDim2.new(0, 0, 0, HeaderHeight)
    Sidebar.Size = UDim2.new(0, SidebarWidth, 0, SidebarHeight)
    local SidebarCorner = Instance.new("UICorner", Sidebar)
    SidebarCorner.CornerRadius = UDim.new(0, 6)
    
    local SidebarCover = Instance.new("Frame")
    SidebarCover.Parent = Sidebar
    SidebarCover.BackgroundColor3 = themeColors.Header
    SidebarCover.BorderSizePixel = 0
    SidebarCover.Position = UDim2.new(1, -5, 0, 0)
    SidebarCover.Size = UDim2.new(0, 5, 1, 0)

    local SidebarCover2 = Instance.new("Frame")
    SidebarCover2.Parent = Sidebar
    SidebarCover2.BackgroundColor3 = themeColors.Header
    SidebarCover2.BorderSizePixel = 0
    SidebarCover2.Position = UDim2.new(0, 0, 0, 0)
    SidebarCover2.Size = UDim2.new(1, 0, 0, 5)

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Parent = Sidebar
    TabContainer.Active = true
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 3, 0, 3)
    TabContainer.Size = UDim2.new(1, -6, 1, -6)
    TabContainer.ScrollBarThickness = 3
    TabContainer.ScrollBarImageColor3 = themeColors.SchemeColor
    
    local TabList = Instance.new("UIListLayout", TabContainer)
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 2)

    local Pages = Instance.new("Frame")
    Pages.Parent = Main
    Pages.BackgroundTransparency = 1
    Pages.Position = UDim2.new(0, SidebarWidth, 0, HeaderHeight)
    Pages.Size = UDim2.new(0, PageWidth, 0, PageHeight)
    
    local PageFolder = Instance.new("Folder", Pages)

    local InfoContainer = Instance.new("Frame")
    InfoContainer.Parent = Main
    InfoContainer.BackgroundTransparency = 1
    InfoContainer.ClipsDescendants = true
    InfoContainer.Position = UDim2.new(0, SidebarWidth, 1, -15)
    InfoContainer.Size = UDim2.new(0, PageWidth, 0, 15)

    local BlurFrame = Instance.new("Frame")
    BlurFrame.Parent = Pages
    BlurFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    BlurFrame.BackgroundTransparency = 1
    BlurFrame.BorderSizePixel = 0
    BlurFrame.Size = UDim2.new(1, 0, 1, 0)
    BlurFrame.ZIndex = 999

    task.spawn(function()
        while GUI.Parent do
            Main.BackgroundColor3 = themeColors.Background
            Header.BackgroundColor3 = themeColors.Header
            Sidebar.BackgroundColor3 = themeColors.Header
            SidebarCover.BackgroundColor3 = themeColors.Header
            SidebarCover2.BackgroundColor3 = themeColors.Header
            HeaderCover.BackgroundColor3 = themeColors.Header
            Title.TextColor3 = themeColors.TextColor
            TabContainer.ScrollBarImageColor3 = themeColors.SchemeColor
            task.wait(0.1)
        end
    end)

    function DrakthonLib:ChangeColor(prop, color)
        if themeColors[prop] then themeColors[prop] = color end
    end

    function DrakthonLib:UpdateLogo(newLogoConfig)
        if newLogoConfig.ImageId then
            LogoFrame.Visible = true
            local LogoImage = LogoFrame:FindFirstChildOfClass("ImageLabel")
            if not LogoImage then
                LogoImage = Instance.new("ImageLabel")
                LogoImage.Parent = LogoFrame
                LogoImage.BackgroundTransparency = 1
                LogoImage.Size = UDim2.new(1, -2, 1, -2)
                LogoImage.Position = UDim2.new(0, 1, 0, 1)
                LogoImage.ScaleType = Enum.ScaleType.Fit
            end
            LogoImage.Image = newLogoConfig.ImageId
            if newLogoConfig.ImageColor then
                LogoImage.ImageColor3 = newLogoConfig.ImageColor
            end
            if newLogoConfig.ImageRectOffset then
                LogoImage.ImageRectOffset = newLogoConfig.ImageRectOffset
            end
            if newLogoConfig.ImageRectSize then
                LogoImage.ImageRectSize = newLogoConfig.ImageRectSize
            end
            Title.Position = UDim2.new(0, HeaderHeight + 5, 0, 0)
            Title.Size = UDim2.new(1, -(HeaderHeight + 60), 1, 0)
        else
            LogoFrame.Visible = false
            Title.Position = UDim2.new(0, 8, 0, 0)
            Title.Size = UDim2.new(1, -60, 1, 0)
        end
    end

    local Tabs = {}
    local firstTab = true

    function Tabs:NewTab(tabName)
        tabName = tabName or "Tab"
        
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = tabName.."TabButton"
        TabBtn.Parent = TabContainer
        TabBtn.BackgroundColor3 = themeColors.SchemeColor
        TabBtn.Size = UDim2.new(1, 0, 0, TabButtonHeight)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.Text = tabName
        TabBtn.TextColor3 = themeColors.TextColor
        TabBtn.TextSize = 10
        TabBtn.BackgroundTransparency = 1
        TabBtn.TextTruncate = Enum.TextTruncate.AtEnd
        local TabCorner = Instance.new("UICorner", TabBtn)
        TabCorner.CornerRadius = UDim.new(0, 4)

        local Page = Instance.new("ScrollingFrame")
        Page.Name = "Page"
        Page.Parent = PageFolder
        Page.Active = true
        Page.BackgroundColor3 = themeColors.Background
        Page.BorderSizePixel = 0
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.ScrollBarThickness = 3
        Page.Visible = false
        Page.ScrollBarImageColor3 = themeColors.SchemeColor
        
        local PageList = Instance.new("UIListLayout", Page)
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Padding = UDim.new(0, 3)

        local function UpdatePageSize()
            local contentSize = PageList.AbsoluteContentSize
            Tween(Page, {CanvasSize = UDim2.new(0, contentSize.X, 0, contentSize.Y)}, 0.15):Play()
            Tween(TabContainer, {CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y)}, 0.15):Play()
        end

        if firstTab then
            firstTab = false
            Page.Visible = true
            TabBtn.BackgroundTransparency = 0
            UpdatePageSize()
        end

        Page.ChildAdded:Connect(UpdatePageSize)
        Page.ChildRemoved:Connect(UpdatePageSize)

        TabBtn.MouseButton1Click:Connect(function()
            for _,p in pairs(PageFolder:GetChildren()) do p.Visible = false end
            Page.Visible = true
            for _,t in pairs(TabContainer:GetChildren()) do
                if t:IsA("TextButton") then
                    Tween(t, {BackgroundTransparency = 1}, 0.2):Play()
                end
            end
            Tween(TabBtn, {BackgroundTransparency = 0}, 0.2):Play()
            UpdatePageSize()
        end)

        local tabHover = false
        TabBtn.MouseEnter:Connect(function()
            if TabBtn.BackgroundTransparency == 1 then
                Tween(TabBtn, {BackgroundColor3 = Color3.fromRGB(
                    themeColors.SchemeColor.r*255*0.8, 
                    themeColors.SchemeColor.g*255*0.8, 
                    themeColors.SchemeColor.b*255*0.8
                )}, 0.2):Play()
                tabHover = true
            end
        end)

        TabBtn.MouseLeave:Connect(function()
            if tabHover then
                Tween(TabBtn, {BackgroundColor3 = themeColors.SchemeColor}, 0.2):Play()
                tabHover = false
            end
        end)

        task.spawn(function()
            while Page.Parent do
                Page.BackgroundColor3 = themeColors.Background
                Page.ScrollBarImageColor3 = themeColors.SchemeColor
                if not tabHover then
                    TabBtn.BackgroundColor3 = themeColors.SchemeColor
                end
                TabBtn.TextColor3 = themeColors.TextColor
                task.wait(0.1)
            end
        end)

        local Sections = {}
        local focusing = false
        local viewDe = false

        function Sections:NewSection(secName, hidden)
            secName = secName or "Section"
            hidden = hidden or false
            
            local SecFrame = Instance.new("Frame")
            SecFrame.Name = "sectionFrame"
            SecFrame.Parent = Page
            SecFrame.BackgroundColor3 = themeColors.Background
            SecFrame.BorderSizePixel = 0
            
            local SecList = Instance.new("UIListLayout", SecFrame)
            SecList.SortOrder = Enum.SortOrder.LayoutOrder
            SecList.Padding = UDim.new(0, 2)

            local SecHead = Instance.new("Frame")
            SecHead.Name = "sectionHead"
            SecHead.Parent = SecFrame
            SecHead.BackgroundColor3 = themeColors.SchemeColor
            SecHead.Size = UDim2.new(0, ElementWidth, 0, ElementHeight)
            SecHead.Visible = not hidden
            local SecHeadCorner = Instance.new("UICorner", SecHead)
            SecHeadCorner.CornerRadius = UDim.new(0, 4)

            local SecName = Instance.new("TextLabel")
            SecName.Parent = SecHead
            SecName.BackgroundTransparency = 1
            SecName.Position = UDim2.new(0, 5, 0, 0)
            SecName.Size = UDim2.new(1, -10, 1, 0)
            SecName.Font = Enum.Font.GothamBold
            SecName.Text = secName
            SecName.RichText = true
            SecName.TextColor3 = themeColors.TextColor
            SecName.TextSize = 10
            SecName.TextXAlignment = Enum.TextXAlignment.Left
            SecName.TextTruncate = Enum.TextTruncate.AtEnd
               
            local SecInners = Instance.new("Frame")
            SecInners.Parent = SecFrame
            SecInners.BackgroundTransparency = 1
            
            local SecElemList = Instance.new("UIListLayout", SecInners)
            SecElemList.SortOrder = Enum.SortOrder.LayoutOrder
            SecElemList.Padding = UDim.new(0, 2)

            task.spawn(function()
                while SecFrame.Parent do
                    SecFrame.BackgroundColor3 = themeColors.Background
                    SecHead.BackgroundColor3 = themeColors.SchemeColor
                    SecName.TextColor3 = themeColors.TextColor
                    task.wait(0.1)
                end
            end)

            local function UpdateSecSize()
                SecInners.Size = UDim2.new(1, 0, 0, SecElemList.AbsoluteContentSize.Y)
                SecFrame.Size = UDim2.new(0, ElementWidth, 0, SecList.AbsoluteContentSize.Y)
                UpdatePageSize()
            end
            
            UpdateSecSize()
            
            local SecFuncs = {}
            
            function SecFuncs:UpdateSection(newName)
                SecName.Text = newName
            end

            local Elements = {}
            
            function Elements:NewButton(btnText, btnInfo, callback)
                local BtnFunc = {}
                btnText = btnText or "Button"
                btnInfo = btnInfo or "Button info"
                callback = callback or function() end

                local Btn = Instance.new("TextButton")
                Btn.Parent = SecInners
                Btn.BackgroundColor3 = themeColors.ElementColor
                Btn.ClipsDescendants = true
                Btn.Size = UDim2.new(0, ElementWidth, 0, ElementHeight)
                Btn.AutoButtonColor = false
                Btn.Font = Enum.Font.Gotham
                Btn.Text = ""
                Btn.TextSize = 9
                local BtnCorner = Instance.new("UICorner", Btn)
                BtnCorner.CornerRadius = UDim.new(0, 4)

                local Icon = Instance.new("ImageLabel")
                Icon.Parent = Btn
                Icon.BackgroundTransparency = 1
                Icon.Position = UDim2.new(0, 3, 0.5, -8)
                Icon.Size = UDim2.new(0, 14, 0, 14)
                Icon.Image = "rbxassetid://3926305904"
                Icon.ImageColor3 = themeColors.SchemeColor
                Icon.ImageRectOffset = Vector2.new(84, 204)
                Icon.ImageRectSize = Vector2.new(36, 36)

                local Label = Instance.new("TextLabel")
                Label.Parent = Btn
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, 20, 0, 0)
                Label.Size = UDim2.new(1, -40, 1, 0)
                Label.Font = Enum.Font.GothamSemibold
                Label.Text = btnText
                Label.RichText = true
                Label.TextColor3 = themeColors.TextColor
                Label.TextSize = 9
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextTruncate = Enum.TextTruncate.AtEnd

                local ViewBtn = Instance.new("ImageButton")
                ViewBtn.Parent = Btn
                ViewBtn.BackgroundTransparency = 1
                ViewBtn.Position = UDim2.new(1, -18, 0.5, -7)
                ViewBtn.Size = UDim2.new(0, 14, 0, 14)
                ViewBtn.ZIndex = 2
                ViewBtn.Image = "rbxassetid://3926305904"
                ViewBtn.ImageColor3 = themeColors.SchemeColor
                ViewBtn.ImageRectOffset = Vector2.new(764, 764)
                ViewBtn.ImageRectSize = Vector2.new(36, 36)

                local Tip = Instance.new("TextLabel")
                Tip.Parent = InfoContainer
                Tip.BackgroundColor3 = Color3.fromRGB(themeColors.SchemeColor.r*255-14, themeColors.SchemeColor.g*255-17, themeColors.SchemeColor.b*255-13)
                Tip.Position = UDim2.new(0, 0, 2, 0)
                Tip.Size = UDim2.new(1, 0, 1, 0)
                Tip.ZIndex = 9
                Tip.Font = Enum.Font.Gotham
                Tip.Text = "  "..btnInfo
                Tip.RichText = true
                Tip.TextColor3 = themeColors.TextColor
                Tip.TextSize = 8
                Tip.TextXAlignment = Enum.TextXAlignment.Left
                Tip.TextTruncate = Enum.TextTruncate.AtEnd
                local TipCorner = Instance.new("UICorner", Tip)
                TipCorner.CornerRadius = UDim.new(0, 4)

                UpdateSecSize()

                Btn.MouseButton1Click:Connect(function()
                    if not focusing then
                        pcall(callback)
                        Ripple(Btn)
                    else
                        for _,v in pairs(InfoContainer:GetChildren()) do 
                            Tween(v, {Position = UDim2.new(0,0,2,0)}, 0.2):Play() 
                        end
                        focusing = false
                        Tween(BlurFrame, {BackgroundTransparency = 1}, 0.2):Play()
                    end
                end)
                
                local hovering = false
                Btn.MouseEnter:Connect(function()
                    if not focusing then
                        Tween(Btn, {BackgroundColor3 = Color3.fromRGB(
                            themeColors.ElementColor.r*255+15, 
                            themeColors.ElementColor.g*255+15, 
                            themeColors.ElementColor.b*255+15
                        )}, 0.1):Play()
                        hovering = true
                    end
                end)
                
                Btn.MouseLeave:Connect(function()
                    if not focusing then 
                        Tween(Btn, {BackgroundColor3 = themeColors.ElementColor}, 0.1):Play()
                        hovering = false
                    end
                end)
                
                ViewBtn.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for _,v in pairs(InfoContainer:GetChildren()) do
                            if v ~= Tip then Tween(v, {Position = UDim2.new(0,0,2,0)}, 0.2):Play() end
                        end
                        Tween(Tip, {Position = UDim2.new(0,0,0,0)}, 0.2):Play()
                        Tween(BlurFrame, {BackgroundTransparency = 0.5}, 0.2):Play()
                        task.wait(2)
                        focusing = false
                        Tween(Tip, {Position = UDim2.new(0,0,2,0)}, 0.2):Play()
                        Tween(BlurFrame, {BackgroundTransparency = 1}, 0.2):Play()
                        viewDe = false
                    end
                end)
                
                task.spawn(function()
                    while Btn.Parent do
                        if not hovering then Btn.BackgroundColor3 = themeColors.ElementColor end
                        ViewBtn.ImageColor3 = themeColors.SchemeColor
                        Tip.BackgroundColor3 = Color3.fromRGB(themeColors.SchemeColor.r*255-14, themeColors.SchemeColor.g*255-17, themeColors.SchemeColor.b*255-13)
                        Tip.TextColor3 = themeColors.TextColor
                        Icon.ImageColor3 = themeColors.SchemeColor
                        Label.TextColor3 = themeColors.TextColor
                        task.wait(0.1)
                    end
                end)
                
                function BtnFunc:UpdateButton(newText)
                    Label.Text = newText
                end
                
                return BtnFunc
            end

            function Elements:NewLabel(labelText)
                local LabelFunc = {}
                
                local Label = Instance.new("TextLabel")
                Label.Parent = SecInners
                Label.BackgroundColor3 = themeColors.SchemeColor
                Label.BorderSizePixel = 0
                Label.Size = UDim2.new(0, ElementWidth, 0, ElementHeight)
                Label.Font = Enum.Font.Gotham
                Label.Text = "  "..labelText
                Label.RichText = true
                Label.TextColor3 = themeColors.TextColor
                Label.TextSize = 9
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextTruncate = Enum.TextTruncate.AtEnd
                local LabelCorner = Instance.new("UICorner", Label)
                LabelCorner.CornerRadius = UDim.new(0, 4)

                task.spawn(function()
                    while Label.Parent do
                        Label.BackgroundColor3 = themeColors.SchemeColor
                        Label.TextColor3 = themeColors.TextColor
                        task.wait(0.1)
                    end
                end)
                
                UpdateSecSize()
                
                function LabelFunc:UpdateLabel(newText)
                    Label.Text = "  "..newText
                end	
                
                return LabelFunc
            end

            function Elements:NewToggle(togText, togInfo, callback)
                local TogFunc = {}
                togText = togText or "Toggle"
                togInfo = togInfo or "Toggle info"
                callback = callback or function() end
                local toggled = false

                local Tog = Instance.new("TextButton")
                Tog.Parent = SecInners
                Tog.BackgroundColor3 = themeColors.ElementColor
                Tog.ClipsDescendants = true
                Tog.Size = UDim2.new(0, ElementWidth, 0, ElementHeight)
                Tog.AutoButtonColor = false
                Tog.Text = ""
                local TogCorner = Instance.new("UICorner", Tog)
                TogCorner.CornerRadius = UDim.new(0, 4)

                local IconOff = Instance.new("ImageLabel")
                IconOff.Parent = Tog
                IconOff.BackgroundTransparency = 1
                IconOff.Position = UDim2.new(0, 3, 0.5, -8)
                IconOff.Size = UDim2.new(0, 14, 0, 14)
                IconOff.Image = "rbxassetid://3926309567"
                IconOff.ImageColor3 = themeColors.SchemeColor
                IconOff.ImageRectOffset = Vector2.new(628, 420)
                IconOff.ImageRectSize = Vector2.new(48, 48)

                local IconOn = Instance.new("ImageLabel")
                IconOn.Parent = Tog
                IconOn.BackgroundTransparency = 1
                IconOn.Position = UDim2.new(0, 3, 0.5, -8)
                IconOn.Size = UDim2.new(0, 14, 0, 14)
                IconOn.Image = "rbxassetid://3926309567"
                IconOn.ImageColor3 = themeColors.SchemeColor
                IconOn.ImageRectOffset = Vector2.new(784, 420)
                IconOn.ImageRectSize = Vector2.new(48, 48)
                IconOn.ImageTransparency = 1

                local Label = Instance.new("TextLabel")
                Label.Parent = Tog
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, 20, 0, 0)
                Label.Size = UDim2.new(1, -40, 1, 0)
                Label.Font = Enum.Font.GothamSemibold
                Label.Text = togText
                Label.RichText = true
                Label.TextColor3 = themeColors.TextColor
                Label.TextSize = 9
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextTruncate = Enum.TextTruncate.AtEnd

                local ViewBtn = Instance.new("ImageButton")
                ViewBtn.Parent = Tog
                ViewBtn.BackgroundTransparency = 1
                ViewBtn.Position = UDim2.new(1, -18, 0.5, -7)
                ViewBtn.Size = UDim2.new(0, 14, 0, 14)
                ViewBtn.ZIndex = 2
                ViewBtn.Image = "rbxassetid://3926305904"
                ViewBtn.ImageColor3 = themeColors.SchemeColor
                ViewBtn.ImageRectOffset = Vector2.new(764, 764)
                ViewBtn.ImageRectSize = Vector2.new(36, 36)

                local Tip = Instance.new("TextLabel")
                Tip.Parent = InfoContainer
                Tip.BackgroundColor3 = Color3.fromRGB(themeColors.SchemeColor.r*255-14, themeColors.SchemeColor.g*255-17, themeColors.SchemeColor.b*255-13)
                Tip.Position = UDim2.new(0, 0, 2, 0)
                Tip.Size = UDim2.new(1, 0, 1, 0)
                Tip.ZIndex = 9
                Tip.Font = Enum.Font.Gotham
                Tip.Text = "  "..togInfo
                Tip.RichText = true
                Tip.TextColor3 = themeColors.TextColor
                Tip.TextSize = 8
                Tip.TextXAlignment = Enum.TextXAlignment.Left
                Tip.TextTruncate = Enum.TextTruncate.AtEnd
                local TipCorner = Instance.new("UICorner", Tip)
                TipCorner.CornerRadius = UDim.new(0, 4)

                UpdateSecSize()

                Tog.MouseButton1Click:Connect(function()
                    if not focusing then
                        toggled = not toggled
                        Tween(IconOn, {ImageTransparency = toggled and 0 or 1}, 0.11):Play()
                        Ripple(Tog)
                        pcall(callback, toggled)
                    else
                        for _,v in pairs(InfoContainer:GetChildren()) do 
                            Tween(v, {Position = UDim2.new(0,0,2,0)}, 0.2):Play() 
                        end
                        focusing = false
                        Tween(BlurFrame, {BackgroundTransparency = 1}, 0.2):Play()
                    end
                end)

                local hovering = false
                Tog.MouseEnter:Connect(function()
                    if not focusing then
                        Tween(Tog, {BackgroundColor3 = Color3.fromRGB(
                            themeColors.ElementColor.r*255+15, 
                            themeColors.ElementColor.g*255+15, 
                            themeColors.ElementColor.b*255+15
                        )}, 0.1):Play()
                        hovering = true
                    end
                end)
                
                Tog.MouseLeave:Connect(function()
                    if not focusing then 
                        Tween(Tog, {BackgroundColor3 = themeColors.ElementColor}, 0.1):Play()
                        hovering = false
                    end
                end)

                ViewBtn.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for _,v in pairs(InfoContainer:GetChildren()) do
                            if v ~= Tip then Tween(v, {Position = UDim2.new(0,0,2,0)}, 0.2):Play() end
                        end
                        Tween(Tip, {Position = UDim2.new(0,0,0,0)}, 0.2):Play()
                        Tween(BlurFrame, {BackgroundTransparency = 0.5}, 0.2):Play()
                        task.wait(2)
                        focusing = false
                        Tween(Tip, {Position = UDim2.new(0,0,2,0)}, 0.2):Play()
                        Tween(BlurFrame, {BackgroundTransparency = 1}, 0.2):Play()
                        viewDe = false
                    end
                end)

                task.spawn(function()
                    while Tog.Parent do
                        if not hovering then Tog.BackgroundColor3 = themeColors.ElementColor end
                        IconOff.ImageColor3 = themeColors.SchemeColor
                        IconOn.ImageColor3 = themeColors.SchemeColor
                        Label.TextColor3 = themeColors.TextColor
                        ViewBtn.ImageColor3 = themeColors.SchemeColor
                        Tip.BackgroundColor3 = Color3.fromRGB(themeColors.SchemeColor.r*255-14, themeColors.SchemeColor.g*255-17, themeColors.SchemeColor.b*255-13)
                        Tip.TextColor3 = themeColors.TextColor
                        task.wait(0.1)
                    end
                end)

                function TogFunc:UpdateToggle(newText, state)
                    if newText then Label.Text = newText end
                    if state ~= nil then
                        toggled = state
                        Tween(IconOn, {ImageTransparency = state and 0 or 1}, 0.11):Play()
                        pcall(callback, toggled)
                    end
                end

                return TogFunc
            end

            function Elements:NewSlider(sliderText, sliderInfo, maxVal, minVal, callback)
                sliderText = sliderText or "Slider"
                sliderInfo = sliderInfo or "Slider info"
                maxVal = maxVal or 500
                minVal = minVal or 0
                callback = callback or function() end

                local Slider = Instance.new("TextButton")
                Slider.Parent = SecInners
                Slider.BackgroundColor3 = themeColors.ElementColor
                Slider.ClipsDescendants = true
                Slider.Size = UDim2.new(0, ElementWidth, 0, ElementHeight)
                Slider.AutoButtonColor = false
                Slider.Text = ""
                local SliderCorner = Instance.new("UICorner", Slider)
                SliderCorner.CornerRadius = UDim.new(0, 4)

                local Icon = Instance.new("ImageLabel")
                Icon.Parent = Slider
                Icon.BackgroundTransparency = 1
                Icon.Position = UDim2.new(0, 3, 0.5, -8)
                Icon.Size = UDim2.new(0, 14, 0, 14)
                Icon.Image = "rbxassetid://3926307971"
                Icon.ImageColor3 = themeColors.SchemeColor
                Icon.ImageRectOffset = Vector2.new(404, 164)
                Icon.ImageRectSize = Vector2.new(36, 36)

                local Label = Instance.new("TextLabel")
                Label.Parent = Slider
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, 20, 0, 0)
                Label.Size = UDim2.new(0, 80, 1, 0)
                Label.Font = Enum.Font.GothamSemibold
                Label.Text = sliderText
                Label.RichText = true
                Label.TextColor3 = themeColors.TextColor
                Label.TextSize = 9
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextTruncate = Enum.TextTruncate.AtEnd

                local ValueLabel = Instance.new("TextLabel")
                ValueLabel.Parent = Slider
                ValueLabel.BackgroundTransparency = 1
                ValueLabel.Position = UDim2.new(0, 100, 0, 0)
                ValueLabel.Size = UDim2.new(0, 30, 1, 0)
                ValueLabel.Font = Enum.Font.GothamBold
                ValueLabel.Text = minVal
                ValueLabel.TextColor3 = themeColors.SchemeColor
                ValueLabel.TextSize = 8
                ValueLabel.TextTransparency = 1
                ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

                local SliderBtn = Instance.new("TextButton")
                SliderBtn.Parent = Slider
                SliderBtn.BackgroundColor3 = Color3.fromRGB(themeColors.ElementColor.r*255+10, themeColors.ElementColor.g*255+10, themeColors.ElementColor.b*255+10)
                SliderBtn.Position = UDim2.new(0, 135, 0.5, -2)
                SliderBtn.Size = UDim2.new(0, 70, 0, 4)
                SliderBtn.AutoButtonColor = false
                SliderBtn.Text = ""
                local SliderBtnCorner = Instance.new("UICorner", SliderBtn)
                SliderBtnCorner.CornerRadius = UDim.new(1, 0)

                local SliderDrag = Instance.new("Frame")
                SliderDrag.Parent = SliderBtn
                SliderDrag.BackgroundColor3 = themeColors.SchemeColor
                SliderDrag.BorderSizePixel = 0
                SliderDrag.Size = UDim2.new(0, 0, 1, 0)
                local SliderDragCorner = Instance.new("UICorner", SliderDrag)
                SliderDragCorner.CornerRadius = UDim.new(1, 0)

                local ViewBtn = Instance.new("ImageButton")
                ViewBtn.Parent = Slider
                ViewBtn.BackgroundTransparency = 1
                ViewBtn.Position = UDim2.new(1, -18, 0.5, -7)
                ViewBtn.Size = UDim2.new(0, 14, 0, 14)
                ViewBtn.ZIndex = 2
                ViewBtn.Image = "rbxassetid://3926305904"
                ViewBtn.ImageColor3 = themeColors.SchemeColor
                ViewBtn.ImageRectOffset = Vector2.new(764, 764)
                ViewBtn.ImageRectSize = Vector2.new(36, 36)

                local Tip = Instance.new("TextLabel")
                Tip.Parent = InfoContainer
                Tip.BackgroundColor3 = Color3.fromRGB(themeColors.SchemeColor.r*255-14, themeColors.SchemeColor.g*255-17, themeColors.SchemeColor.b*255-13)
                Tip.Position = UDim2.new(0, 0, 2, 0)
                Tip.Size = UDim2.new(1, 0, 1, 0)
                Tip.ZIndex = 9
                Tip.Font = Enum.Font.Gotham
                Tip.Text = "  "..sliderInfo
                Tip.RichText = true
                Tip.TextColor3 = themeColors.TextColor
                Tip.TextSize = 8
                Tip.TextXAlignment = Enum.TextXAlignment.Left
                Tip.TextTruncate = Enum.TextTruncate.AtEnd
                local TipCorner = Instance.new("UICorner", Tip)
                TipCorner.CornerRadius = UDim.new(0, 4)

                UpdateSecSize()

                local mouse = Players.LocalPlayer:GetMouse()
                local hovering = false

                Slider.MouseEnter:Connect(function()
                    if not focusing then
                        Tween(Slider, {BackgroundColor3 = Color3.fromRGB(
                            themeColors.ElementColor.r*255+15, 
                            themeColors.ElementColor.g*255+15, 
                            themeColors.ElementColor.b*255+15
                        )}, 0.1):Play()
                        hovering = true
                    end
                end)
                
                Slider.MouseLeave:Connect(function()
                    if not focusing then
                        Tween(Slider, {BackgroundColor3 = themeColors.ElementColor}, 0.1):Play()
                        hovering = false
                    end
                end)

                SliderBtn.MouseButton1Down:Connect(function()
                    if not focusing then
                        Tween(ValueLabel, {TextTransparency = 0}, 0.1):Play()
                        local moveConnection, releaseConnection
                        
                        local function update()
                            local value = math.floor(((maxVal - minVal) / 70) * SliderDrag.AbsoluteSize.X + minVal)
                            ValueLabel.Text = value
                            pcall(callback, value)
                            SliderDrag:TweenSize(UDim2.new(0, math.clamp(mouse.X - SliderDrag.AbsolutePosition.X, 0, 70), 1, 0), "InOut", "Linear", 0.05, true)
                        end
                        
                        update()
                        
                        moveConnection = mouse.Move:Connect(update)
                        releaseConnection = UserInputService.InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                update()
                                Tween(ValueLabel, {TextTransparency = 1}, 0.1):Play()
                                moveConnection:Disconnect()
                                releaseConnection:Disconnect()
                            end
                        end)
                    else
                        for _,v in pairs(InfoContainer:GetChildren()) do 
                            Tween(v, {Position = UDim2.new(0,0,2,0)}, 0.2):Play() 
                        end
                        focusing = false
                        Tween(BlurFrame, {BackgroundTransparency = 1}, 0.2):Play()
                    end
                end)

                ViewBtn.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for _,v in pairs(InfoContainer:GetChildren()) do
                            if v ~= Tip then Tween(v, {Position = UDim2.new(0,0,2,0)}, 0.2):Play() end
                        end
                        Tween(Tip, {Position = UDim2.new(0,0,0,0)}, 0.2):Play()
                        Tween(BlurFrame, {BackgroundTransparency = 0.5}, 0.2):Play()
                        task.wait(2)
                        focusing = false
                        Tween(Tip, {Position = UDim2.new(0,0,2,0)}, 0.2):Play()
                        Tween(BlurFrame, {BackgroundTransparency = 1}, 0.2):Play()
                        viewDe = false
                    end
                end)

                task.spawn(function()
                    while Slider.Parent do
                        if not hovering then Slider.BackgroundColor3 = themeColors.ElementColor end
                        Tip.TextColor3 = themeColors.TextColor
                        Tip.BackgroundColor3 = Color3.fromRGB(themeColors.SchemeColor.r*255-14, themeColors.SchemeColor.g*255-17, themeColors.SchemeColor.b*255-13)
                        ValueLabel.TextColor3 = themeColors.SchemeColor
                        Icon.ImageColor3 = themeColors.SchemeColor
                        Label.TextColor3 = themeColors.TextColor
                        ViewBtn.ImageColor3 = themeColors.SchemeColor
                        SliderBtn.BackgroundColor3 = Color3.fromRGB(themeColors.ElementColor.r*255+10, themeColors.ElementColor.g*255+10, themeColors.ElementColor.b*255+10)
                        SliderDrag.BackgroundColor3 = themeColors.SchemeColor
                        task.wait(0.1)
                    end
                end)
            end

            function Elements:NewTextBox(txtText, txtInfo, callback)
                txtText = txtText or "Textbox"
                txtInfo = txtInfo or "Textbox info"
                callback = callback or function() end

                local TxtBox = Instance.new("TextButton")
                TxtBox.Parent = SecInners
                TxtBox.BackgroundColor3 = themeColors.ElementColor
                TxtBox.ClipsDescendants = true
                TxtBox.Size = UDim2.new(0, ElementWidth, 0, ElementHeight)
                TxtBox.AutoButtonColor = false
                TxtBox.Text = ""
                local TxtBoxCorner = Instance.new("UICorner", TxtBox)
                TxtBoxCorner.CornerRadius = UDim.new(0, 4)

                local Icon = Instance.new("ImageLabel")
                Icon.Parent = TxtBox
                Icon.BackgroundTransparency = 1
                Icon.Position = UDim2.new(0, 3, 0.5, -8)
                Icon.Size = UDim2.new(0, 14, 0, 14)
                Icon.Image = "rbxassetid://3926305904"
                Icon.ImageColor3 = themeColors.SchemeColor
                Icon.ImageRectOffset = Vector2.new(324, 604)
                Icon.ImageRectSize = Vector2.new(36, 36)

                local Label = Instance.new("TextLabel")
                Label.Parent = TxtBox
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, 20, 0, 0)
                Label.Size = UDim2.new(0, 80, 1, 0)
                Label.Font = Enum.Font.GothamSemibold
                Label.Text = txtText
                Label.RichText = true
                Label.TextColor3 = themeColors.TextColor
                Label.TextSize = 9
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextTruncate = Enum.TextTruncate.AtEnd

                local Input = Instance.new("TextBox")
                Input.Parent = TxtBox
                Input.BackgroundColor3 = Color3.fromRGB(themeColors.ElementColor.r*255-10, themeColors.ElementColor.g*255-10, themeColors.ElementColor.b*255-10)
                Input.Position = UDim2.new(0, 105, 0.5, -6)
                Input.Size = UDim2.new(0, 80, 0, 12)
                Input.ZIndex = 99
                Input.ClearTextOnFocus = false
                Input.Font = Enum.Font.Gotham
                Input.PlaceholderColor3 = Color3.fromRGB(themeColors.SchemeColor.r*255-30, themeColors.SchemeColor.g*255-30, themeColors.SchemeColor.b*255-30)
                Input.PlaceholderText = "Type..."
                Input.Text = ""
                Input.TextColor3 = themeColors.SchemeColor
                Input.TextSize = 8
                local InputCorner = Instance.new("UICorner", Input)
                InputCorner.CornerRadius = UDim.new(0, 3)

                local ViewBtn = Instance.new("ImageButton")
                ViewBtn.Parent = TxtBox
                ViewBtn.BackgroundTransparency = 1
                ViewBtn.Position = UDim2.new(1, -18, 0.5, -7)
                ViewBtn.Size = UDim2.new(0, 14, 0, 14)
                ViewBtn.ZIndex = 2
                ViewBtn.Image = "rbxassetid://3926305904"
                ViewBtn.ImageColor3 = themeColors.SchemeColor
                ViewBtn.ImageRectOffset = Vector2.new(764, 764)
                ViewBtn.ImageRectSize = Vector2.new(36, 36)

                local Tip = Instance.new("TextLabel")
                Tip.Parent = InfoContainer
                Tip.BackgroundColor3 = Color3.fromRGB(themeColors.SchemeColor.r*255-14, themeColors.SchemeColor.g*255-17, themeColors.SchemeColor.b*255-13)
                Tip.Position = UDim2.new(0, 0, 2, 0)
                Tip.Size = UDim2.new(1, 0, 1, 0)
                Tip.ZIndex = 9
                Tip.Font = Enum.Font.Gotham
                Tip.Text = "  "..txtInfo
                Tip.RichText = true
                Tip.TextColor3 = themeColors.TextColor
                Tip.TextSize = 8
                Tip.TextXAlignment = Enum.TextXAlignment.Left
                Tip.TextTruncate = Enum.TextTruncate.AtEnd
                local TipCorner = Instance.new("UICorner", Tip)
                TipCorner.CornerRadius = UDim.new(0, 4)

                UpdateSecSize()

                local hovering = false
                TxtBox.MouseEnter:Connect(function()
                    if not focusing then
                        Tween(TxtBox, {BackgroundColor3 = Color3.fromRGB(
                            themeColors.ElementColor.r*255+15, 
                            themeColors.ElementColor.g*255+15, 
                            themeColors.ElementColor.b*255+15
                        )}, 0.1):Play()
                        hovering = true
                    end
                end)
                
                TxtBox.MouseLeave:Connect(function()
                    if not focusing then
                        Tween(TxtBox, {BackgroundColor3 = themeColors.ElementColor}, 0.1):Play()
                        hovering = false
                    end
                end)

                TxtBox.MouseButton1Click:Connect(function()
                    if focusing then
                        for _,v in pairs(InfoContainer:GetChildren()) do 
                            Tween(v, {Position = UDim2.new(0,0,2,0)}, 0.2):Play() 
                        end
                        focusing = false
                        Tween(BlurFrame, {BackgroundTransparency = 1}, 0.2):Play()
                    end
                end)

                Input.FocusLost:Connect(function(enterPressed)
                    if focusing then
                        for _,v in pairs(InfoContainer:GetChildren()) do 
                            Tween(v, {Position = UDim2.new(0,0,2,0)}, 0.2):Play() 
                        end
                        focusing = false
                        Tween(BlurFrame, {BackgroundTransparency = 1}, 0.2):Play()
                    end
                    if enterPressed then
                        pcall(callback, Input.Text)
                        task.wait(0.18)
                        Input.Text = ""
                    end
                end)

                ViewBtn.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for _,v in pairs(InfoContainer:GetChildren()) do
                            if v ~= Tip then Tween(v, {Position = UDim2.new(0,0,2,0)}, 0.2):Play() end
                        end
                        Tween(Tip, {Position = UDim2.new(0,0,0,0)}, 0.2):Play()
                        Tween(BlurFrame, {BackgroundTransparency = 0.5}, 0.2):Play()
                        task.wait(2)
                        focusing = false
                        Tween(Tip, {Position = UDim2.new(0,0,2,0)}, 0.2):Play()
                        Tween(BlurFrame, {BackgroundTransparency = 1}, 0.2):Play()
                        viewDe = false
                    end
                end)

                task.spawn(function()
                    while TxtBox.Parent do
                        if not hovering then TxtBox.BackgroundColor3 = themeColors.ElementColor end
                        Input.BackgroundColor3 = Color3.fromRGB(themeColors.ElementColor.r*255-10, themeColors.ElementColor.g*255-10, themeColors.ElementColor.b*255-10)
                        ViewBtn.ImageColor3 = themeColors.SchemeColor
                        Tip.BackgroundColor3 = Color3.fromRGB(themeColors.SchemeColor.r*255-14, themeColors.SchemeColor.g*255-17, themeColors.SchemeColor.b*255-13)
                        Tip.TextColor3 = themeColors.TextColor
                        Icon.ImageColor3 = themeColors.SchemeColor
                        Label.TextColor3 = themeColors.TextColor
                        Input.PlaceholderColor3 = Color3.fromRGB(themeColors.SchemeColor.r*255-30, themeColors.SchemeColor.g*255-30, themeColors.SchemeColor.b*255-30)
                        Input.TextColor3 = themeColors.SchemeColor
                        task.wait(0.1)
                    end
                end)
            end

            function Elements:NewKeybind(keyText, keyInfo, defaultKey, callback)
                keyText = keyText or "Keybind"
                keyInfo = keyInfo or "Keybind info"
                defaultKey = defaultKey or Enum.KeyCode.F
                callback = callback or function() end
                local currentKey = defaultKey.Name

                local Keybind = Instance.new("TextButton")
                Keybind.Parent = SecInners
                Keybind.BackgroundColor3 = themeColors.ElementColor
                Keybind.ClipsDescendants = true
                Keybind.Size = UDim2.new(0, ElementWidth, 0, ElementHeight)
                Keybind.AutoButtonColor = false
                Keybind.Text = ""
                local KeybindCorner = Instance.new("UICorner", Keybind)
                KeybindCorner.CornerRadius = UDim.new(0, 4)

                local Icon = Instance.new("ImageLabel")
                Icon.Parent = Keybind
                Icon.BackgroundTransparency = 1
                Icon.Position = UDim2.new(0, 3, 0.5, -8)
                Icon.Size = UDim2.new(0, 14, 0, 14)
                Icon.Image = "rbxassetid://3926305904"
                Icon.ImageColor3 = themeColors.SchemeColor
                Icon.ImageRectOffset = Vector2.new(364, 284)
                Icon.ImageRectSize = Vector2.new(36, 36)

                local Label = Instance.new("TextLabel")
                Label.Parent = Keybind
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, 20, 0, 0)
                Label.Size = UDim2.new(0, 120, 1, 0)
                Label.Font = Enum.Font.GothamSemibold
                Label.Text = keyText
                Label.RichText = true
                Label.TextColor3 = themeColors.TextColor
                Label.TextSize = 9
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextTruncate = Enum.TextTruncate.AtEnd

                local KeyLabel = Instance.new("TextLabel")
                KeyLabel.Parent = Keybind
                KeyLabel.BackgroundTransparency = 1
                KeyLabel.Position = UDim2.new(0, 145, 0, 0)
                KeyLabel.Size = UDim2.new(0, 40, 1, 0)
                KeyLabel.Font = Enum.Font.GothamBold
                KeyLabel.Text = currentKey
                KeyLabel.TextColor3 = themeColors.SchemeColor
                KeyLabel.TextSize = 8
                KeyLabel.TextXAlignment = Enum.TextXAlignment.Right
                KeyLabel.TextTruncate = Enum.TextTruncate.AtEnd

                local ViewBtn = Instance.new("ImageButton")
                ViewBtn.Parent = Keybind
                ViewBtn.BackgroundTransparency = 1
                ViewBtn.Position = UDim2.new(1, -18, 0.5, -7)
                ViewBtn.Size = UDim2.new(0, 14, 0, 14)
                ViewBtn.ZIndex = 2
                ViewBtn.Image = "rbxassetid://3926305904"
                ViewBtn.ImageColor3 = themeColors.SchemeColor
                ViewBtn.ImageRectOffset = Vector2.new(764, 764)
                ViewBtn.ImageRectSize = Vector2.new(36, 36)

                local Tip = Instance.new("TextLabel")
                Tip.Parent = InfoContainer
                Tip.BackgroundColor3 = Color3.fromRGB(themeColors.SchemeColor.r*255-14, themeColors.SchemeColor.g*255-17, themeColors.SchemeColor.b*255-13)
                Tip.Position = UDim2.new(0, 0, 2, 0)
                Tip.Size = UDim2.new(1, 0, 1, 0)
                Tip.ZIndex = 9
                Tip.Font = Enum.Font.Gotham
                Tip.Text = "  "..keyInfo
                Tip.RichText = true
                Tip.TextColor3 = themeColors.TextColor
                Tip.TextSize = 8
                Tip.TextXAlignment = Enum.TextXAlignment.Left
                Tip.TextTruncate = Enum.TextTruncate.AtEnd
                local TipCorner = Instance.new("UICorner", Tip)
                TipCorner.CornerRadius = UDim.new(0, 4)

                UpdateSecSize()

                Keybind.MouseButton1Click:Connect(function()
                    if not focusing then
                        KeyLabel.Text = "..."
                        local input = UserInputService.InputBegan:Wait()
                        if input.KeyCode.Name ~= "Unknown" then
                            currentKey = input.KeyCode.Name
                            KeyLabel.Text = currentKey
                        else
                            KeyLabel.Text = currentKey
                        end
                        Ripple(Keybind)
                    else
                        for _,v in pairs(InfoContainer:GetChildren()) do 
                            Tween(v, {Position = UDim2.new(0,0,2,0)}, 0.2):Play() 
                        end
                        focusing = false
                        Tween(BlurFrame, {BackgroundTransparency = 1}, 0.2):Play()
                    end
                end)

                UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if not gameProcessed and input.KeyCode.Name == currentKey then
                        pcall(callback)
                    end
                end)

                local hovering = false
                Keybind.MouseEnter:Connect(function()
                    if not focusing then
                        Tween(Keybind, {BackgroundColor3 = Color3.fromRGB(
                            themeColors.ElementColor.r*255+15, 
                            themeColors.ElementColor.g*255+15, 
                            themeColors.ElementColor.b*255+15
                        )}, 0.1):Play()
                        hovering = true
                    end
                end)
                
                Keybind.MouseLeave:Connect(function()
                    if not focusing then
                        Tween(Keybind, {BackgroundColor3 = themeColors.ElementColor}, 0.1):Play()
                        hovering = false
                    end
                end)

                ViewBtn.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for _,v in pairs(InfoContainer:GetChildren()) do
                            if v ~= Tip then Tween(v, {Position = UDim2.new(0,0,2,0)}, 0.2):Play() end
                        end
                        Tween(Tip, {Position = UDim2.new(0,0,0,0)}, 0.2):Play()
                        Tween(BlurFrame, {BackgroundTransparency = 0.5}, 0.2):Play()
                        task.wait(2)
                        focusing = false
                        Tween(Tip, {Position = UDim2.new(0,0,2,0)}, 0.2):Play()
                        Tween(BlurFrame, {BackgroundTransparency = 1}, 0.2):Play()
                        viewDe = false
                    end
                end)

                task.spawn(function()
                    while Keybind.Parent do
                        if not hovering then Keybind.BackgroundColor3 = themeColors.ElementColor end
                        KeyLabel.TextColor3 = themeColors.SchemeColor
                        Icon.ImageColor3 = themeColors.SchemeColor
                        ViewBtn.ImageColor3 = themeColors.SchemeColor
                        Label.TextColor3 = themeColors.TextColor
                        Tip.TextColor3 = themeColors.TextColor
                        Tip.BackgroundColor3 = Color3.fromRGB(themeColors.SchemeColor.r*255-14, themeColors.SchemeColor.g*255-17, themeColors.SchemeColor.b*255-13)
                        task.wait(0.1)
                    end
                end)
            end

            function Elements:NewDropdown(dropText, dropInfo, options, callback)
                local DropFunc = {}
                dropText = dropText or "Dropdown"
                dropInfo = dropInfo or "Dropdown info"
                options = options or {}
                callback = callback or function() end
                local opened = false

                local Drop = Instance.new("Frame")
                Drop.Parent = SecInners
                Drop.BackgroundTransparency = 1
                Drop.ClipsDescendants = true
                Drop.Size = UDim2.new(0, ElementWidth, 0, ElementHeight)

                local DropList = Instance.new("UIListLayout", Drop)
                DropList.SortOrder = Enum.SortOrder.LayoutOrder
                DropList.Padding = UDim.new(0, 2)

                local DropBtn = Instance.new("TextButton")
                DropBtn.Parent = Drop
                DropBtn.BackgroundColor3 = themeColors.ElementColor
                DropBtn.Size = UDim2.new(0, ElementWidth, 0, ElementHeight)
                DropBtn.AutoButtonColor = false
                DropBtn.Text = ""
                local DropBtnCorner = Instance.new("UICorner", DropBtn)
                DropBtnCorner.CornerRadius = UDim.new(0, 4)

                local Icon = Instance.new("ImageLabel")
                Icon.Parent = DropBtn
                Icon.BackgroundTransparency = 1
                Icon.Position = UDim2.new(0, 3, 0.5, -8)
                Icon.Size = UDim2.new(0, 14, 0, 14)
                Icon.Image = "rbxassetid://3926305904"
                Icon.ImageColor3 = themeColors.SchemeColor
                Icon.ImageRectOffset = Vector2.new(644, 364)
                Icon.ImageRectSize = Vector2.new(36, 36)

                local Label = Instance.new("TextLabel")
                Label.Parent = DropBtn
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, 20, 0, 0)
                Label.Size = UDim2.new(1, -40, 1, 0)
                Label.Font = Enum.Font.GothamSemibold
                Label.Text = dropText
                Label.RichText = true
                Label.TextColor3 = themeColors.TextColor
                Label.TextSize = 9
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextTruncate = Enum.TextTruncate.AtEnd

                local ViewBtn = Instance.new("ImageButton")
                ViewBtn.Parent = DropBtn
                ViewBtn.BackgroundTransparency = 1
                ViewBtn.Position = UDim2.new(1, -18, 0.5, -7)
                ViewBtn.Size = UDim2.new(0, 14, 0, 14)
                ViewBtn.ZIndex = 2
                ViewBtn.Image = "rbxassetid://3926305904"
                ViewBtn.ImageColor3 = themeColors.SchemeColor
                ViewBtn.ImageRectOffset = Vector2.new(764, 764)
                ViewBtn.ImageRectSize = Vector2.new(36, 36)

                local Tip = Instance.new("TextLabel")
                Tip.Parent = InfoContainer
                Tip.BackgroundColor3 = Color3.fromRGB(themeColors.SchemeColor.r*255-14, themeColors.SchemeColor.g*255-17, themeColors.SchemeColor.b*255-13)
                Tip.Position = UDim2.new(0, 0, 2, 0)
                Tip.Size = UDim2.new(1, 0, 1, 0)
                Tip.ZIndex = 9
                Tip.Font = Enum.Font.Gotham
                Tip.Text = "  "..dropInfo
                Tip.RichText = true
                Tip.TextColor3 = themeColors.TextColor
                Tip.TextSize = 8
                Tip.TextXAlignment = Enum.TextXAlignment.Left
                Tip.TextTruncate = Enum.TextTruncate.AtEnd
                local TipCorner = Instance.new("UICorner", Tip)
                TipCorner.CornerRadius = UDim.new(0, 4)

                UpdateSecSize()

                local function CreateOption(optText)
                    local Opt = Instance.new("TextButton")
                    Opt.Name = "Option"
                    Opt.Parent = Drop
                    Opt.BackgroundColor3 = themeColors.ElementColor
                    Opt.Size = UDim2.new(0, ElementWidth, 0, ElementHeight)
                    Opt.AutoButtonColor = false
                    Opt.Font = Enum.Font.Gotham
                    Opt.Text = "  "..optText
                    Opt.TextColor3 = Color3.fromRGB(themeColors.TextColor.r*255-20, themeColors.TextColor.g*255-20, themeColors.TextColor.b*255-20)
                    Opt.TextSize = 8
                    Opt.TextXAlignment = Enum.TextXAlignment.Left
                    Opt.TextTruncate = Enum.TextTruncate.AtEnd
                    local OptCorner = Instance.new("UICorner", Opt)
                    OptCorner.CornerRadius = UDim.new(0, 4)

                    Opt.MouseButton1Click:Connect(function()
                        if not focusing then
                            opened = false
                            Label.Text = optText
                            Drop:TweenSize(UDim2.new(0, ElementWidth, 0, ElementHeight), 'InOut', 'Linear', 0.08)
                            task.wait(0.1)
                            UpdateSecSize()
                            Ripple(Opt)
                            pcall(callback, optText)
                        else
                            for _,v in pairs(InfoContainer:GetChildren()) do 
                                Tween(v, {Position = UDim2.new(0,0,2,0)}, 0.2):Play() 
                            end
                            focusing = false
                            Tween(BlurFrame, {BackgroundTransparency = 1}, 0.2):Play()
                        end
                    end)

                    local optHover = false
                    Opt.MouseEnter:Connect(function()
                        if not focusing then
                            Tween(Opt, {BackgroundColor3 = Color3.fromRGB(
                                themeColors.ElementColor.r*255+15, 
                                themeColors.ElementColor.g*255+15, 
                                themeColors.ElementColor.b*255+15
                            )}, 0.1):Play()
                            optHover = true
                        end
                    end)
                    
                    Opt.MouseLeave:Connect(function()
                        if not focusing then
                            Tween(Opt, {BackgroundColor3 = themeColors.ElementColor}, 0.1):Play()
                            optHover = false
                        end
                    end)

                    task.spawn(function()
                        while Opt.Parent do
                            if not optHover then Opt.BackgroundColor3 = themeColors.ElementColor end
                            Opt.TextColor3 = Color3.fromRGB(themeColors.TextColor.r*255-20, themeColors.TextColor.g*255-20, themeColors.TextColor.b*255-20)
                            task.wait(0.1)
                        end
                    end)
                end

                for _,opt in pairs(options) do CreateOption(opt) end

                DropBtn.MouseButton1Click:Connect(function()
                    if not focusing then
                        opened = not opened
                        Drop:TweenSize(UDim2.new(0, ElementWidth, 0, opened and DropList.AbsoluteContentSize.Y or ElementHeight), 'InOut', 'Linear', 0.08)
                        task.wait(0.1)
                        UpdateSecSize()
                        Ripple(DropBtn)
                    else
                        for _,v in pairs(InfoContainer:GetChildren()) do 
                            Tween(v, {Position = UDim2.new(0,0,2,0)}, 0.2):Play() 
                        end
                        focusing = false
                        Tween(BlurFrame, {BackgroundTransparency = 1}, 0.2):Play()
                    end
                end)

                local hovering = false
                DropBtn.MouseEnter:Connect(function()
                    if not focusing then
                        Tween(DropBtn, {BackgroundColor3 = Color3.fromRGB(
                            themeColors.ElementColor.r*255+15, 
                            themeColors.ElementColor.g*255+15, 
                            themeColors.ElementColor.b*255+15
                        )}, 0.1):Play()
                        hovering = true
                    end
                end)
                
                DropBtn.MouseLeave:Connect(function()
                    if not focusing then
                        Tween(DropBtn, {BackgroundColor3 = themeColors.ElementColor}, 0.1):Play()
                        hovering = false
                    end
                end)

                ViewBtn.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for _,v in pairs(InfoContainer:GetChildren()) do
                            if v ~= Tip then Tween(v, {Position = UDim2.new(0,0,2,0)}, 0.2):Play() end
                        end
                        Tween(Tip, {Position = UDim2.new(0,0,0,0)}, 0.2):Play()
                        Tween(BlurFrame, {BackgroundTransparency = 0.5}, 0.2):Play()
                        task.wait(2)
                        focusing = false
                        Tween(Tip, {Position = UDim2.new(0,0,2,0)}, 0.2):Play()
                        Tween(BlurFrame, {BackgroundTransparency = 1}, 0.2):Play()
                        viewDe = false
                    end
                end)

                task.spawn(function()
                    while Drop.Parent do
                        if not hovering then DropBtn.BackgroundColor3 = themeColors.ElementColor end
                        Icon.ImageColor3 = themeColors.SchemeColor
                        Label.TextColor3 = themeColors.TextColor
                        ViewBtn.ImageColor3 = themeColors.SchemeColor
                        Tip.BackgroundColor3 = Color3.fromRGB(themeColors.SchemeColor.r*255-14, themeColors.SchemeColor.g*255-17, themeColors.SchemeColor.b*255-13)
                        Tip.TextColor3 = themeColors.TextColor
                        task.wait(0.1)
                    end
                end)

                function DropFunc:Refresh(newOptions)
                    for _,v in pairs(Drop:GetChildren()) do 
                        if v.Name == "Option" then v:Destroy() end 
                    end
                    for _,opt in pairs(newOptions) do CreateOption(opt) end
                    if opened then
                        Drop:TweenSize(UDim2.new(0, ElementWidth, 0, DropList.AbsoluteContentSize.Y), 'InOut', 'Linear', 0.08)
                        task.wait(0.1)
                    end
                    UpdateSecSize()
                end

                return DropFunc
            end

            function Elements:NewColorPicker(colText, colInfo, defColor, callback)
                colText = colText or "ColorPicker"
                colInfo = colInfo or "Pick a color"
                defColor = defColor or Color3.fromRGB(255,255,255)
                callback = callback or function() end
                
                local h,s,v = Color3.toHSV(defColor)
                local colorOpened = false

                local ColorPicker = Instance.new("TextButton")
                ColorPicker.Parent = SecInners
                ColorPicker.BackgroundTransparency = 1
                ColorPicker.ClipsDescendants = true
                ColorPicker.Size = UDim2.new(0, ElementWidth, 0, ElementHeight)
                ColorPicker.AutoButtonColor = false
                ColorPicker.Text = ""

                local CPList = Instance.new("UIListLayout", ColorPicker)
                CPList.SortOrder = Enum.SortOrder.LayoutOrder
                CPList.Padding = UDim.new(0, 2)

                local CPHeader = Instance.new("Frame")
                CPHeader.Parent = ColorPicker
                CPHeader.BackgroundColor3 = themeColors.ElementColor
                CPHeader.Size = UDim2.new(0, ElementWidth, 0, ElementHeight)
                local CPHeaderCorner = Instance.new("UICorner", CPHeader)
                CPHeaderCorner.CornerRadius = UDim.new(0, 4)

                local Icon = Instance.new("ImageLabel")
                Icon.Parent = CPHeader
                Icon.BackgroundTransparency = 1
                Icon.Position = UDim2.new(0, 3, 0.5, -8)
                Icon.Size = UDim2.new(0, 14, 0, 14)
                Icon.Image = "rbxassetid://3926305904"
                Icon.ImageColor3 = themeColors.SchemeColor
                Icon.ImageRectOffset = Vector2.new(44, 964)
                Icon.ImageRectSize = Vector2.new(36, 36)

                local Label = Instance.new("TextLabel")
                Label.Parent = CPHeader
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, 20, 0, 0)
                Label.Size = UDim2.new(1, -55, 1, 0)
                Label.Font = Enum.Font.GothamSemibold
                Label.Text = colText
                Label.RichText = true
                Label.TextColor3 = themeColors.TextColor
                Label.TextSize = 9
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextTruncate = Enum.TextTruncate.AtEnd

                local ColorDisplay = Instance.new("Frame")
                ColorDisplay.Parent = CPHeader
                ColorDisplay.BackgroundColor3 = defColor
                ColorDisplay.Position = UDim2.new(1, -32, 0.5, -6)
                ColorDisplay.Size = UDim2.new(0, 26, 0, 12)
                local ColorDisplayCorner = Instance.new("UICorner", ColorDisplay)
                ColorDisplayCorner.CornerRadius = UDim.new(0, 3)

                local ViewBtn = Instance.new("ImageButton")
                ViewBtn.Parent = CPHeader
                ViewBtn.BackgroundTransparency = 1
                ViewBtn.Position = UDim2.new(1, -18, 0.5, -7)
                ViewBtn.Size = UDim2.new(0, 14, 0, 14)
                ViewBtn.ZIndex = 2
                ViewBtn.Image = "rbxassetid://3926305904"
                ViewBtn.ImageColor3 = themeColors.SchemeColor
                ViewBtn.ImageRectOffset = Vector2.new(764, 764)
                ViewBtn.ImageRectSize = Vector2.new(36, 36)

                local Tip = Instance.new("TextLabel")
                Tip.Parent = InfoContainer
                Tip.BackgroundColor3 = Color3.fromRGB(themeColors.SchemeColor.r*255-14, themeColors.SchemeColor.g*255-17, themeColors.SchemeColor.b*255-13)
                Tip.Position = UDim2.new(0, 0, 2, 0)
                Tip.Size = UDim2.new(1, 0, 1, 0)
                Tip.ZIndex = 9
                Tip.Font = Enum.Font.Gotham
                Tip.Text = "  "..colInfo
                Tip.RichText = true
                Tip.TextColor3 = themeColors.TextColor
                Tip.TextSize = 8
                Tip.TextXAlignment = Enum.TextXAlignment.Left
                Tip.TextTruncate = Enum.TextTruncate.AtEnd
                local TipCorner = Instance.new("UICorner", Tip)
                TipCorner.CornerRadius = UDim.new(0, 4)

                local CPInners = Instance.new("Frame")
                CPInners.Parent = ColorPicker
                CPInners.BackgroundColor3 = themeColors.ElementColor
                CPInners.Size = UDim2.new(0, ElementWidth, 0, 60)
                local CPInnersCorner = Instance.new("UICorner", CPInners)
                CPInnersCorner.CornerRadius = UDim.new(0, 4)

                local RGB = Instance.new("ImageButton")
                RGB.Parent = CPInners
                RGB.BackgroundTransparency = 1
                RGB.Position = UDim2.new(0, 3, 0, 3)
                RGB.Size = UDim2.new(0, 130, 0, 54)
                RGB.Image = "http://www.roblox.com/asset/?id=6523286724"
                local RGBCorner = Instance.new("UICorner", RGB)
                RGBCorner.CornerRadius = UDim.new(0, 3)

                local RGBCursor = Instance.new("ImageLabel")
                RGBCursor.Parent = RGB
                RGBCursor.BackgroundTransparency = 1
                RGBCursor.Size = UDim2.new(0, 8, 0, 8)
                RGBCursor.Image = "rbxassetid://3926309567"
                RGBCursor.ImageColor3 = Color3.fromRGB(0,0,0)
                RGBCursor.ImageRectOffset = Vector2.new(628, 420)
                RGBCursor.ImageRectSize = Vector2.new(48, 48)

                local Darkness = Instance.new("ImageButton")
                Darkness.Parent = CPInners
                Darkness.BackgroundTransparency = 1
                Darkness.Position = UDim2.new(0, 138, 0, 3)
                Darkness.Size = UDim2.new(0, 12, 0, 54)
                Darkness.Image = "http://www.roblox.com/asset/?id=6523291212"
                local DarknessCorner = Instance.new("UICorner", Darkness)
                DarknessCorner.CornerRadius = UDim.new(0, 3)

                local DarkCursor = Instance.new("ImageLabel")
                DarkCursor.Parent = Darkness
                DarkCursor.AnchorPoint = Vector2.new(0.5, 0)
                DarkCursor.BackgroundTransparency = 1
                DarkCursor.Size = UDim2.new(0, 8, 0, 8)
                DarkCursor.Image = "rbxassetid://3926309567"
                DarkCursor.ImageColor3 = Color3.fromRGB(0,0,0)
                DarkCursor.ImageRectOffset = Vector2.new(628, 420)
                DarkCursor.ImageRectSize = Vector2.new(48, 48)

                local Rainbow = Instance.new("TextButton")
                Rainbow.Parent = CPInners
                Rainbow.BackgroundTransparency = 1
                Rainbow.Position = UDim2.new(0, 155, 0, 3)
                Rainbow.Size = UDim2.new(0, 50, 0, 14)
                Rainbow.Font = Enum.Font.Gotham
                Rainbow.Text = "Rainbow"
                Rainbow.TextColor3 = themeColors.TextColor
                Rainbow.TextSize = 8
                Rainbow.TextXAlignment = Enum.TextXAlignment.Left

                local RainbowOff = Instance.new("ImageLabel")
                RainbowOff.Parent = Rainbow
                RainbowOff.BackgroundTransparency = 1
                RainbowOff.Size = UDim2.new(0, 14, 0, 14)
                RainbowOff.Image = "rbxassetid://3926309567"
                RainbowOff.ImageColor3 = themeColors.SchemeColor
                RainbowOff.ImageRectOffset = Vector2.new(628, 420)
                RainbowOff.ImageRectSize = Vector2.new(48, 48)

                local RainbowOn = Instance.new("ImageLabel")
                RainbowOn.Parent = Rainbow
                RainbowOn.BackgroundTransparency = 1
                RainbowOn.Size = UDim2.new(0, 14, 0, 14)
                RainbowOn.Image = "rbxassetid://3926309567"
                RainbowOn.ImageColor3 = themeColors.SchemeColor
                RainbowOn.ImageRectOffset = Vector2.new(784, 420)
                RainbowOn.ImageRectSize = Vector2.new(48, 48)
                RainbowOn.ImageTransparency = 1

                UpdateSecSize()

                local mouse = Players.LocalPlayer:GetMouse()
                local pickingRGB = false
                local pickingDark = false
                local color = {h,s,v}
                local rainbow = false
                local rainbowConn

                local function zigzag(x) return math.acos(math.cos(x*math.pi))/math.pi end

                local function updateColor()
                    if pickingRGB then
                        local x = math.clamp(mouse.X - RGB.AbsolutePosition.X, 0, RGB.AbsoluteSize.X)
                        local y = math.clamp(mouse.Y - RGB.AbsolutePosition.Y, 0, RGB.AbsoluteSize.Y)
                        RGBCursor.Position = UDim2.new(0, x-4, 0, y-4)
                        color = {1-x/RGB.AbsoluteSize.X, 1-y/RGB.AbsoluteSize.Y, color[3]}
                        local realColor = Color3.fromHSV(color[1], color[2], color[3])
                        ColorDisplay.BackgroundColor3 = realColor
                        pcall(callback, realColor)
                    end
                    if pickingDark then
                        local y = math.clamp(mouse.Y - Darkness.AbsolutePosition.Y, 0, Darkness.AbsoluteSize.Y)
                        DarkCursor.Position = UDim2.new(0.5, 0, 0, y-4)
                        color = {color[1], color[2], 1-y/Darkness.AbsoluteSize.Y}
                        local realColor = Color3.fromHSV(color[1], color[2], color[3])
                        ColorDisplay.BackgroundColor3 = realColor
                        pcall(callback, realColor)
                    end
                end

                mouse.Move:Connect(updateColor)
                RGB.MouseButton1Down:Connect(function() pickingRGB = true end)
                Darkness.MouseButton1Down:Connect(function() pickingDark = true end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        pickingRGB = false
                        pickingDark = false
                    end
                end)

                Rainbow.MouseButton1Click:Connect(function()
                    rainbow = not rainbow
                    Tween(RainbowOn, {ImageTransparency = rainbow and 0 or 1}, 0.1):Play()
                    if rainbow then
                        local counter = 0
                        rainbowConn = RunService.RenderStepped:Connect(function()
                            color = {zigzag(counter), 1, 1}
                            RGBCursor.Position = UDim2.new(color[1], -4, color[2]-1, -4)
                            local realColor = Color3.fromHSV(color[1], color[2], color[3])
                            ColorDisplay.BackgroundColor3 = realColor
                            pcall(callback, realColor)
                            counter = counter + 0.01
                        end)
                    else
                        if rainbowConn then rainbowConn:Disconnect() end
                    end
                end)

                ColorPicker.MouseButton1Click:Connect(function()
                    if not focusing then
                        colorOpened = not colorOpened
                        ColorPicker:TweenSize(UDim2.new(0, ElementWidth, 0, colorOpened and (ElementHeight + 60 + 2) or ElementHeight), 'InOut', 'Linear', 0.08)
                        task.wait(0.1)
                        UpdateSecSize()
                        Ripple(CPHeader)
                    else
                        for _,v in pairs(InfoContainer:GetChildren()) do 
                            Tween(v, {Position = UDim2.new(0,0,2,0)}, 0.2):Play() 
                        end
                        focusing = false
                        Tween(BlurFrame, {BackgroundTransparency = 1}, 0.2):Play()
                    end
                end)

                local hovering = false
                CPHeader.MouseEnter:Connect(function()
                    if not focusing then
                        Tween(CPHeader, {BackgroundColor3 = Color3.fromRGB(
                            themeColors.ElementColor.r*255+15, 
                            themeColors.ElementColor.g*255+15, 
                            themeColors.ElementColor.b*255+15
                        )}, 0.1):Play()
                        hovering = true
                    end
                end)
                
                CPHeader.MouseLeave:Connect(function()
                    if not focusing then
                        Tween(CPHeader, {BackgroundColor3 = themeColors.ElementColor}, 0.1):Play()
                        hovering = false
                    end
                end)

                ViewBtn.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for _,v in pairs(InfoContainer:GetChildren()) do
                            if v ~= Tip then Tween(v, {Position = UDim2.new(0,0,2,0)}, 0.2):Play() end
                        end
                        Tween(Tip, {Position = UDim2.new(0,0,0,0)}, 0.2):Play()
                        Tween(BlurFrame, {BackgroundTransparency = 0.5}, 0.2):Play()
                        task.wait(2)
                        focusing = false
                        Tween(Tip, {Position = UDim2.new(0,0,2,0)}, 0.2):Play()
                        Tween(BlurFrame, {BackgroundTransparency = 1}, 0.2):Play()
                        viewDe = false
                    end
                end)

                task.spawn(function()
                    while ColorPicker.Parent do
                        if not hovering then CPHeader.BackgroundColor3 = themeColors.ElementColor end
                        CPInners.BackgroundColor3 = themeColors.ElementColor
                        Icon.ImageColor3 = themeColors.SchemeColor
                        Label.TextColor3 = themeColors.TextColor
                        ViewBtn.ImageColor3 = themeColors.SchemeColor
                        Rainbow.TextColor3 = themeColors.TextColor
                        RainbowOff.ImageColor3 = themeColors.SchemeColor
                        RainbowOn.ImageColor3 = themeColors.SchemeColor
                        Tip.BackgroundColor3 = Color3.fromRGB(themeColors.SchemeColor.r*255-14, themeColors.SchemeColor.g*255-17, themeColors.SchemeColor.b*255-13)
                        Tip.TextColor3 = themeColors.TextColor
                        task.wait(0.1)
                    end
                end)
            end

            SecFuncs.Elements = Elements
            return setmetatable(SecFuncs, {__index = Elements})
        end
        return Sections
    end  
    return Tabs
end

return DrakthonLib
