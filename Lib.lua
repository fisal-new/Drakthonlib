--// DrakthonLib - Original Design + Responsive + Logo Support
local DrakthonLib = {}

local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")

local Utility = {}
local Objects = {}

function DrakthonLib:DraggingEnabled(frame, parent)
    parent = parent or frame
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

function Utility:TweenObject(obj, properties, duration, ...)
    tween:Create(obj, tweeninfo(duration, ...), properties):Play()
end

local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(32, 32, 38)
}

local themeStyles = {
    DarkTheme = {
        SchemeColor = Color3.fromRGB(64, 64, 64),
        Background = Color3.fromRGB(0, 0, 0),
        Header = Color3.fromRGB(0, 0, 0),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(20, 20, 20)
    },
    LightTheme = {
        SchemeColor = Color3.fromRGB(150, 150, 150),
        Background = Color3.fromRGB(255,255,255),
        Header = Color3.fromRGB(200, 200, 200),
        TextColor = Color3.fromRGB(0,0,0),
        ElementColor = Color3.fromRGB(224, 224, 224)
    },
    BloodTheme = {
        SchemeColor = Color3.fromRGB(227, 27, 27),
        Background = Color3.fromRGB(10, 10, 10),
        Header = Color3.fromRGB(5, 5, 5),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(20, 20, 20)
    },
    GrapeTheme = {
        SchemeColor = Color3.fromRGB(166, 71, 214),
        Background = Color3.fromRGB(64, 50, 71),
        Header = Color3.fromRGB(36, 28, 41),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(74, 58, 84)
    },
    Ocean = {
        SchemeColor = Color3.fromRGB(86, 76, 251),
        Background = Color3.fromRGB(26, 32, 58),
        Header = Color3.fromRGB(38, 45, 71),
        TextColor = Color3.fromRGB(200, 200, 200),
        ElementColor = Color3.fromRGB(38, 45, 71)
    },
    Midnight = {
        SchemeColor = Color3.fromRGB(26, 189, 158),
        Background = Color3.fromRGB(44, 62, 82),
        Header = Color3.fromRGB(57, 81, 105),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(52, 74, 95)
    },
    Sentinel = {
        SchemeColor = Color3.fromRGB(230, 35, 69),
        Background = Color3.fromRGB(32, 32, 32),
        Header = Color3.fromRGB(24, 24, 24),
        TextColor = Color3.fromRGB(119, 209, 138),
        ElementColor = Color3.fromRGB(24, 24, 24)
    },
    Synapse = {
        SchemeColor = Color3.fromRGB(46, 48, 43),
        Background = Color3.fromRGB(13, 15, 12),
        Header = Color3.fromRGB(36, 38, 35),
        TextColor = Color3.fromRGB(152, 99, 53),
        ElementColor = Color3.fromRGB(24, 24, 24)
    },
    Serpent = {
        SchemeColor = Color3.fromRGB(0, 166, 58),
        Background = Color3.fromRGB(31, 41, 43),
        Header = Color3.fromRGB(22, 29, 31),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(22, 29, 31)
    },
    Drakthon = {
        SchemeColor = Color3.fromRGB(138, 43, 226),
        Background = Color3.fromRGB(15, 15, 20),
        Header = Color3.fromRGB(20, 20, 28),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(25, 25, 35)
    }
}

local SettingsT = {}
local Name = "DrakthonConfig.JSON"

pcall(function()
    if not pcall(function() readfile(Name) end) then
        writefile(Name, game:service'HttpService':JSONEncode(SettingsT))
    end
    Settings = game:service'HttpService':JSONDecode(readfile(Name))
end)

local LibName = "DrakthonLib_"..tostring(math.random(1000, 9999))

function DrakthonLib:ToggleUI()
    if game.CoreGui[LibName].Enabled then
        game.CoreGui[LibName].Enabled = false
    else
        game.CoreGui[LibName].Enabled = true
    end
end

function DrakthonLib.CreateLib(kavName, themeList, logoConfig)
    kavName = kavName or "DrakthonLib"
    logoConfig = logoConfig or {}
    
    if not themeList then
        themeList = themes
    end
    if themeList == "DarkTheme" then
        themeList = themeStyles.DarkTheme
    elseif themeList == "LightTheme" then
        themeList = themeStyles.LightTheme
    elseif themeList == "BloodTheme" then
        themeList = themeStyles.BloodTheme
    elseif themeList == "GrapeTheme" then
        themeList = themeStyles.GrapeTheme
    elseif themeList == "Ocean" then
        themeList = themeStyles.Ocean
    elseif themeList == "Midnight" then
        themeList = themeStyles.Midnight
    elseif themeList == "Sentinel" then
        themeList = themeStyles.Sentinel
    elseif themeList == "Synapse" then
        themeList = themeStyles.Synapse
    elseif themeList == "Serpent" then
        themeList = themeStyles.Serpent
    elseif themeList == "Drakthon" then
        themeList = themeStyles.Drakthon
    else
        if type(themeList) == "table" then
            themeList.SchemeColor = themeList.SchemeColor or Color3.fromRGB(74, 99, 135)
            themeList.Background = themeList.Background or Color3.fromRGB(36, 37, 43)
            themeList.Header = themeList.Header or Color3.fromRGB(28, 29, 34)
            themeList.TextColor = themeList.TextColor or Color3.fromRGB(255,255,255)
            themeList.ElementColor = themeList.ElementColor or Color3.fromRGB(32, 32, 38)
        end
    end

    themeList = themeList or {}
    
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:match("DrakthonLib_") then
            v:Destroy()
        end
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local UIShadow = Instance.new("ImageLabel")
    local MainHeader = Instance.new("Frame")
    local headerCover = Instance.new("UICorner")
    local coverup = Instance.new("Frame")
    local LogoFrame = Instance.new("Frame")
    local title = Instance.new("TextLabel")
    local close = Instance.new("ImageButton")
    local MainSide = Instance.new("Frame")
    local sideCorner = Instance.new("UICorner")
    local coverup_2 = Instance.new("Frame")
    local tabFrames = Instance.new("Frame")
    local tabListing = Instance.new("UIListLayout")
    local pages = Instance.new("Frame")
    local Pages = Instance.new("Folder")
    local infoContainer = Instance.new("Frame")
    local blurFrame = Instance.new("Frame")

    DrakthonLib:DraggingEnabled(MainHeader, Main)

    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = LibName
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    -- الحجم الجديد: 60% من الشاشة بدلاً من أحجام ثابتة
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = themeList.Background
    Main.ClipsDescendants = true
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0.6, 0, 0.6, 0) -- 60% من حجم الشاشة
    
    -- UIAspectRatioConstraint للحفاظ على النسبة
    local AspectRatio = Instance.new("UIAspectRatioConstraint")
    AspectRatio.Parent = Main
    AspectRatio.AspectRatio = 1.65 -- نسبة 525:318
    
    -- الحد الأدنى والأقصى للحجم
    local MinSize = Instance.new("UISizeConstraint")
    MinSize.Parent = Main
    MinSize.MinSize = Vector2.new(400, 242)
    MinSize.MaxSize = Vector2.new(800, 485)

    MainCorner.CornerRadius = UDim.new(0, 6)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    -- إضافة Shadow للواجهة
    UIShadow.Name = "Shadow"
    UIShadow.Parent = Main
    UIShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    UIShadow.BackgroundTransparency = 1
    UIShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    UIShadow.Size = UDim2.new(1, 30, 1, 30)
    UIShadow.ZIndex = -1
    UIShadow.Image = "rbxassetid://6014261993"
    UIShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    UIShadow.ImageTransparency = 0.5
    UIShadow.ScaleType = Enum.ScaleType.Slice
    UIShadow.SliceCenter = Rect.new(99, 99, 99, 99)

    MainHeader.Name = "MainHeader"
    MainHeader.Parent = Main
    MainHeader.BackgroundColor3 = themeList.Header
    Objects[MainHeader] = "BackgroundColor3"
    MainHeader.Size = UDim2.new(1, 0, 0, 35)
    
    headerCover.CornerRadius = UDim.new(0, 6)
    headerCover.Name = "headerCover"
    headerCover.Parent = MainHeader

    coverup.Name = "coverup"
    coverup.Parent = MainHeader
    coverup.BackgroundColor3 = themeList.Header
    Objects[coverup] = "BackgroundColor3"
    coverup.BorderSizePixel = 0
    coverup.Position = UDim2.new(0, 0, 0.7, 0)
    coverup.Size = UDim2.new(1, 0, 0, 11)

    -- Logo Support
    LogoFrame.Name = "LogoFrame"
    LogoFrame.Parent = MainHeader
    LogoFrame.BackgroundTransparency = 1
    LogoFrame.Position = UDim2.new(0, 8, 0.5, 0)
    LogoFrame.AnchorPoint = Vector2.new(0, 0.5)
    LogoFrame.Size = UDim2.new(0, 25, 0, 25)
    LogoFrame.Visible = false

    if logoConfig.ImageId then
        LogoFrame.Visible = true
        local LogoImage = Instance.new("ImageLabel")
        LogoImage.Parent = LogoFrame
        LogoImage.BackgroundTransparency = 1
        LogoImage.Size = UDim2.new(1, 0, 1, 0)
        LogoImage.Image = logoConfig.ImageId
        LogoImage.ImageColor3 = logoConfig.ImageColor or themeList.SchemeColor
        LogoImage.ScaleType = logoConfig.ScaleType or Enum.ScaleType.Fit
        if logoConfig.ImageRectOffset then
            LogoImage.ImageRectOffset = logoConfig.ImageRectOffset
        end
        if logoConfig.ImageRectSize then
            LogoImage.ImageRectSize = logoConfig.ImageRectSize
        end
        if logoConfig.Rounded then
            local LogoCorner = Instance.new("UICorner")
            LogoCorner.CornerRadius = UDim.new(1, 0)
            LogoCorner.Parent = LogoImage
        end
    end

    title.Name = "title"
    title.Parent = MainHeader
    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1.000
    title.BorderSizePixel = 0
    title.Position = UDim2.new(0, logoConfig.ImageId and 40 or 12, 0.5, 0)
    title.AnchorPoint = Vector2.new(0, 0.5)
    title.Size = UDim2.new(1, logoConfig.ImageId and -95 or -70, 0, 20)
    title.Font = Enum.Font.GothamBold
    title.RichText = true
    title.Text = kavName
    title.TextColor3 = themeList.TextColor
    title.TextSize = 16.000
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextScaled = false
    title.TextWrapped = false
    title.TextTruncate = Enum.TextTruncate.AtEnd

    close.Name = "close"
    close.Parent = MainHeader
    close.BackgroundTransparency = 1.000
    close.Position = UDim2.new(1, -30, 0.5, 0)
    close.AnchorPoint = Vector2.new(0, 0.5)
    close.Size = UDim2.new(0, 24, 0, 24)
    close.ZIndex = 2
    close.Image = "rbxassetid://3926305904"
    close.ImageColor3 = Color3.fromRGB(255, 85, 85)
    close.ImageRectOffset = Vector2.new(284, 4)
    close.ImageRectSize = Vector2.new(24, 24)
    
    local closeHover = false
    close.MouseEnter:Connect(function()
        closeHover = true
        game.TweenService:Create(close, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(255, 50, 50)}):Play()
    end)
    close.MouseLeave:Connect(function()
        closeHover = false
        game.TweenService:Create(close, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(255, 85, 85)}):Play()
    end)
    
    close.MouseButton1Click:Connect(function()
        game.TweenService:Create(close, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            ImageTransparency = 1
        }):Play()
        task.wait()
        game.TweenService:Create(Main, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        game.TweenService:Create(UIShadow, TweenInfo.new(0.15), {ImageTransparency = 1}):Play()
        task.wait(0.2)
        ScreenGui:Destroy()
    end)

    MainSide.Name = "MainSide"
    MainSide.Parent = Main
    MainSide.BackgroundColor3 = themeList.Header
    Objects[MainSide] = "Header"
    MainSide.Position = UDim2.new(0, 0, 0, 35)
    MainSide.Size = UDim2.new(0.284, 0, 1, -35)

    sideCorner.CornerRadius = UDim.new(0, 6)
    sideCorner.Name = "sideCorner"
    sideCorner.Parent = MainSide

    coverup_2.Name = "coverup"
    coverup_2.Parent = MainSide
    coverup_2.BackgroundColor3 = themeList.Header
    Objects[coverup_2] = "Header"
    coverup_2.BorderSizePixel = 0
    coverup_2.Position = UDim2.new(1, -8, 0, 0)
    coverup_2.Size = UDim2.new(0, 8, 1, 0)

    tabFrames.Name = "tabFrames"
    tabFrames.Parent = MainSide
    tabFrames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabFrames.BackgroundTransparency = 1.000
    tabFrames.Position = UDim2.new(0.05, 0, 0.01, 0)
    tabFrames.Size = UDim2.new(0.9, 0, 0.98, 0)

    tabListing.Name = "tabListing"
    tabListing.Parent = tabFrames
    tabListing.SortOrder = Enum.SortOrder.LayoutOrder
    tabListing.Padding = UDim.new(0, 3)

    pages.Name = "pages"
    pages.Parent = Main
    pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    pages.BackgroundTransparency = 1.000
    pages.BorderSizePixel = 0
    pages.Position = UDim2.new(0.284, 5, 0, 35)
    pages.Size = UDim2.new(0.716, -5, 1, -50)

    Pages.Name = "Pages"
    Pages.Parent = pages

    infoContainer.Name = "infoContainer"
    infoContainer.Parent = Main
    infoContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    infoContainer.BackgroundTransparency = 1.000
    infoContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
    infoContainer.ClipsDescendants = true
    infoContainer.Position = UDim2.new(0.284, 5, 1, -40)
    infoContainer.Size = UDim2.new(0.716, -5, 0, 35)

    blurFrame.Name = "blurFrame"
    blurFrame.Parent = pages
    blurFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blurFrame.BackgroundTransparency = 1
    blurFrame.BorderSizePixel = 0
    blurFrame.Size = UDim2.new(1, 0, 1, 0)
    blurFrame.ZIndex = 999

    task.spawn(function()
        while task.wait(0.1) do
            if not ScreenGui.Parent then break end
            Main.BackgroundColor3 = themeList.Background
            MainHeader.BackgroundColor3 = themeList.Header
            MainSide.BackgroundColor3 = themeList.Header
            coverup_2.BackgroundColor3 = themeList.Header
            coverup.BackgroundColor3 = themeList.Header
            title.TextColor3 = themeList.TextColor
        end
    end)

    function DrakthonLib:ChangeColor(prope, color)
        if prope == "Background" then
            themeList.Background = color
        elseif prope == "SchemeColor" then
            themeList.SchemeColor = color
        elseif prope == "Header" then
            themeList.Header = color
        elseif prope == "TextColor" then
            themeList.TextColor = color
        elseif prope == "ElementColor" then
            themeList.ElementColor = color
        end
    end

    function DrakthonLib:UpdateLogo(newLogoConfig)
        if newLogoConfig.ImageId then
            LogoFrame.Visible = true
            local LogoImage = LogoFrame:FindFirstChildOfClass("ImageLabel")
            if not LogoImage then
                LogoImage = Instance.new("ImageLabel")
                LogoImage.Parent = LogoFrame
                LogoImage.BackgroundTransparency = 1
                LogoImage.Size = UDim2.new(1, 0, 1, 0)
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
            title.Position = UDim2.new(0, 40, 0.5, 0)
            title.Size = UDim2.new(1, -95, 0, 20)
        else
            LogoFrame.Visible = false
            title.Position = UDim2.new(0, 12, 0.5, 0)
            title.Size = UDim2.new(1, -70, 0, 20)
        end
    end

    local Tabs = {}
    local first = true

    function Tabs:NewTab(tabName)
        tabName = tabName or "Tab"
        local tabButton = Instance.new("TextButton")
        local UICorner = Instance.new("UICorner")
        local page = Instance.new("ScrollingFrame")
        local pageListing = Instance.new("UIListLayout")

        local function UpdateSize()
            local cS = pageListing.AbsoluteContentSize
            game.TweenService:Create(page, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                CanvasSize = UDim2.new(0, cS.X, 0, cS.Y)
            }):Play()
        end

        page.Name = "Page"
        page.Parent = Pages
        page.Active = true
        page.BackgroundColor3 = themeList.Background
        page.BorderSizePixel = 0
        page.Size = UDim2.new(1, 0, 1, 0)
        page.ScrollBarThickness = 6
        page.Visible = false
        page.ScrollBarImageColor3 = themeList.SchemeColor

        pageListing.Name = "pageListing"
        pageListing.Parent = page
        pageListing.SortOrder = Enum.SortOrder.LayoutOrder
        pageListing.Padding = UDim.new(0, 8)

        tabButton.Name = tabName.."TabButton"
        tabButton.Parent = tabFrames
        tabButton.BackgroundColor3 = themeList.SchemeColor
        Objects[tabButton] = "SchemeColor"
        tabButton.Size = UDim2.new(1, 0, 0, 32)
        tabButton.AutoButtonColor = false
        tabButton.Font = Enum.Font.GothamSemibold
        tabButton.Text = tabName
        tabButton.TextColor3 = themeList.TextColor
        Objects[tabButton] = "TextColor3"
        tabButton.TextSize = 14.000
        tabButton.BackgroundTransparency = 1

        if first then
            first = false
            page.Visible = true
            tabButton.BackgroundTransparency = 0
            UpdateSize()
        else
            page.Visible = false
            tabButton.BackgroundTransparency = 1
        end

        UICorner.CornerRadius = UDim.new(0, 6)
        UICorner.Parent = tabButton
        table.insert(Tabs, tabName)

        UpdateSize()
        page.ChildAdded:Connect(UpdateSize)
        page.ChildRemoved:Connect(UpdateSize)

        local tabHover = false
        tabButton.MouseEnter:Connect(function()
            if tabButton.BackgroundTransparency == 1 then
                tabHover = true
                Utility:TweenObject(tabButton, {BackgroundColor3 = Color3.fromRGB(
                    math.clamp(themeList.SchemeColor.R * 255 * 0.8, 0, 255),
                    math.clamp(themeList.SchemeColor.G * 255 * 0.8, 0, 255),
                    math.clamp(themeList.SchemeColor.B * 255 * 0.8, 0, 255)
                )}, 0.2)
            end
        end)

        tabButton.MouseLeave:Connect(function()
            if tabHover then
                tabHover = false
                Utility:TweenObject(tabButton, {BackgroundColor3 = themeList.SchemeColor}, 0.2)
            end
        end)

        tabButton.MouseButton1Click:Connect(function()
            UpdateSize()
            for i, v in next, Pages:GetChildren() do
                v.Visible = false
            end
            page.Visible = true
            for i, v in next, tabFrames:GetChildren() do
                if v:IsA("TextButton") then
                    Utility:TweenObject(v, {BackgroundTransparency = 1}, 0.2)
                end
            end
            Utility:TweenObject(tabButton, {BackgroundTransparency = 0}, 0.2)
        end)

        local Sections = {}
        local focusing = false
        local viewDe = false

        task.spawn(function()
            while task.wait(0.1) do
                if not page.Parent then break end
                page.BackgroundColor3 = themeList.Background
                page.ScrollBarImageColor3 = themeList.SchemeColor
                if not tabHover then
                    tabButton.BackgroundColor3 = themeList.SchemeColor
                end
                tabButton.TextColor3 = themeList.TextColor
            end
        end)

        function Sections:NewSection(secName, hidden)
            secName = secName or "Section"
            local sectionFunctions = {}
            local modules = {}
            hidden = hidden or false
            
            local sectionFrame = Instance.new("Frame")
            local sectionlistoknvm = Instance.new("UIListLayout")
            local sectionHead = Instance.new("Frame")
            local sHeadCorner = Instance.new("UICorner")
            local sectionName = Instance.new("TextLabel")
            local sectionInners = Instance.new("Frame")
            local sectionElListing = Instance.new("UIListLayout")

            if hidden then
                sectionHead.Visible = false
            else
                sectionHead.Visible = true
            end

            sectionFrame.Name = "sectionFrame"
            sectionFrame.Parent = page
            sectionFrame.BackgroundColor3 = themeList.Background
            sectionFrame.BorderSizePixel = 0
            
            sectionlistoknvm.Name = "sectionlistoknvm"
            sectionlistoknvm.Parent = sectionFrame
            sectionlistoknvm.SortOrder = Enum.SortOrder.LayoutOrder
            sectionlistoknvm.Padding = UDim.new(0, 5)

            sectionHead.Name = "sectionHead"
            sectionHead.Parent = sectionFrame
            sectionHead.BackgroundColor3 = themeList.SchemeColor
            Objects[sectionHead] = "BackgroundColor3"
            sectionHead.Size = UDim2.new(1, 0, 0, 35)

            sHeadCorner.CornerRadius = UDim.new(0, 6)
            sHeadCorner.Name = "sHeadCorner"
            sHeadCorner.Parent = sectionHead

            sectionName.Name = "sectionName"
            sectionName.Parent = sectionHead
            sectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionName.BackgroundTransparency = 1.000
            sectionName.BorderColor3 = Color3.fromRGB(27, 42, 53)
            sectionName.Position = UDim2.new(0, 10, 0, 0)
            sectionName.Size = UDim2.new(1, -20, 1, 0)
            sectionName.Font = Enum.Font.GothamBold
            sectionName.Text = secName
            sectionName.RichText = true
            sectionName.TextColor3 = themeList.TextColor
            Objects[sectionName] = "TextColor3"
            sectionName.TextSize = 15.000
            sectionName.TextXAlignment = Enum.TextXAlignment.Left
               
            sectionInners.Name = "sectionInners"
            sectionInners.Parent = sectionFrame
            sectionInners.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionInners.BackgroundTransparency = 1.000

            sectionElListing.Name = "sectionElListing"
            sectionElListing.Parent = sectionInners
            sectionElListing.SortOrder = Enum.SortOrder.LayoutOrder
            sectionElListing.Padding = UDim.new(0, 5)

            task.spawn(function()
                while task.wait(0.1) do
                    if not sectionFrame.Parent then break end
                    sectionFrame.BackgroundColor3 = themeList.Background
                    sectionHead.BackgroundColor3 = themeList.SchemeColor
                    sectionName.TextColor3 = themeList.TextColor
                end
            end)

            local function updateSectionFrame()
                local innerSc = sectionElListing.AbsoluteContentSize
                sectionInners.Size = UDim2.new(1, 0, 0, innerSc.Y)
                local frameSc = sectionlistoknvm.AbsoluteContentSize
                sectionFrame.Size = UDim2.new(1, 0, 0, frameSc.Y)
            end
            
            updateSectionFrame()
            UpdateSize()
            
            function sectionFunctions:UpdateSection(newName)
                sectionName.Text = newName
            end

            local Elements = {}
            
            function Elements:NewButton(bname, tipINf, callback)
                showLogo = showLogo or true
                local ButtonFunction = {}
                tipINf = tipINf or "Tip: Clicking this nothing will happen!"
                bname = bname or "Click Me!"
                callback = callback or function() end

                local buttonElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local btnInfo = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local touch = Instance.new("ImageLabel")
                local Sample = Instance.new("ImageLabel")

                table.insert(modules, bname)

                buttonElement.Name = bname
                buttonElement.Parent = sectionInners
                buttonElement.BackgroundColor3 = themeList.ElementColor
                buttonElement.ClipsDescendants = true
                buttonElement.Size = UDim2.new(1, 0, 0, 35)
                buttonElement.AutoButtonColor = false
                buttonElement.Font = Enum.Font.SourceSans
                buttonElement.Text = ""
                buttonElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                buttonElement.TextSize = 14.000
                Objects[buttonElement] = "BackgroundColor3"

                UICorner.CornerRadius = UDim.new(0, 6)
                UICorner.Parent = buttonElement

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = buttonElement
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(1, -28, 0.5, 0)
                viewInfo.AnchorPoint = Vector2.new(0, 0.5)
                viewInfo.Size = UDim2.new(0, 24, 0, 24)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                Objects[viewInfo] = "ImageColor3"
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)

                Sample.Name = "Sample"
                Sample.Parent = buttonElement
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = themeList.SchemeColor
                Objects[Sample] = "ImageColor3"
                Sample.ImageTransparency = 0.600

                local moreInfo = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")

                moreInfo.Name = "TipMore"
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(
                    math.clamp(themeList.SchemeColor.R * 255 - 20, 0, 255),
                    math.clamp(themeList.SchemeColor.G * 255 - 20, 0, 255),
                    math.clamp(themeList.SchemeColor.B * 255 - 20, 0, 255)
                )
                moreInfo.Position = UDim2.new(0, 0, 2, 0)
                moreInfo.Size = UDim2.new(1, 0, 1, 0)
                moreInfo.ZIndex = 9
                moreInfo.Font = Enum.Font.Gotham
                moreInfo.Text = "  "..tipINf
                moreInfo.RichText = true
                moreInfo.TextColor3 = themeList.TextColor
                Objects[moreInfo] = "TextColor3"
                moreInfo.TextSize = 13.000
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left
                Objects[moreInfo] = "BackgroundColor3"
                moreInfo.TextTruncate = Enum.TextTruncate.AtEnd

                UICorner.CornerRadius = UDim.new(0, 6)
                UICorner.Parent = moreInfo

                touch.Name = "touch"
                touch.Parent = buttonElement
                touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                touch.BackgroundTransparency = 1.000
                touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
                touch.Position = UDim2.new(0, 8, 0.5, 0)
                touch.AnchorPoint = Vector2.new(0, 0.5)
                touch.Size = UDim2.new(0, 22, 0, 22)
                touch.Image = "rbxassetid://3926305904"
                touch.ImageColor3 = themeList.SchemeColor
                Objects[touch] = "SchemeColor"
                touch.ImageRectOffset = Vector2.new(84, 204)
                touch.ImageRectSize = Vector2.new(36, 36)
                touch.ImageTransparency = 0

                btnInfo.Name = "btnInfo"
                btnInfo.Parent = buttonElement
                btnInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                btnInfo.BackgroundTransparency = 1.000
                btnInfo.Position = UDim2.new(0, 35, 0.5, 0)
                btnInfo.AnchorPoint = Vector2.new(0, 0.5)
                btnInfo.Size = UDim2.new(1, -70, 0, 18)
                btnInfo.Font = Enum.Font.GothamSemibold
                btnInfo.Text = bname
                btnInfo.RichText = true
                btnInfo.TextColor3 = themeList.TextColor
                Objects[btnInfo] = "TextColor3"
                btnInfo.TextSize = 14.000
                btnInfo.TextXAlignment = Enum.TextXAlignment.Left
                btnInfo.TextTruncate = Enum.TextTruncate.AtEnd

                updateSectionFrame()
                UpdateSize()

                local ms = game.Players.LocalPlayer:GetMouse()
                local btn = buttonElement
                local sample = Sample

                btn.MouseButton1Click:Connect(function()
                    if not focusing then
                        pcall(callback)
                        local c = sample:Clone()
                        c.Parent = btn
                        local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                        c.Position = UDim2.new(0, x, 0, y)
                        local len, size = 0.35, nil
                        if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                            size = (btn.AbsoluteSize.X * 1.5)
                        else
                            size = (btn.AbsoluteSize.Y * 1.5)
                        end
                        c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                        for i = 1, 10 do
                            c.ImageTransparency = c.ImageTransparency + 0.05
                            task.wait(len / 12)
                        end
                        c:Destroy()
                    else
                        for i, v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0, 0, 2, 0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)
                
                local hovering = false
                btn.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            BackgroundColor3 = Color3.fromRGB(
                                math.clamp(themeList.ElementColor.R * 255 + 12, 0, 255),
                                math.clamp(themeList.ElementColor.G * 255 + 12, 0, 255),
                                math.clamp(themeList.ElementColor.B * 255 + 12, 0, 255)
                            )
                        }):Play()
                        hovering = true
                    end
                end)
                
                btn.MouseLeave:Connect(function()
                    if not focusing then 
                        game.TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            BackgroundColor3 = themeList.ElementColor
                        }):Play()
                        hovering = false
                    end
                end)
                
                viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i, v in next, infoContainer:GetChildren() do
                            if v ~= moreInfo then
                                Utility:TweenObject(v, {Position = UDim2.new(0, 0, 2, 0)}, 0.2)
                            end
                        end
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0, 0, 0, 0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                        Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
                        task.wait(2)
                        focusing = false
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0, 0, 2, 0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        task.wait()
                        viewDe = false
                    end
                end)
                
                task.spawn(function()
                    while task.wait(0.1) do
                        if not buttonElement.Parent then break end
                        if not hovering then
                            buttonElement.BackgroundColor3 = themeList.ElementColor
                        end
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        Sample.ImageColor3 = themeList.SchemeColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(
                            math.clamp(themeList.SchemeColor.R * 255 - 20, 0, 255),
                            math.clamp(themeList.SchemeColor.G * 255 - 20, 0, 255),
                            math.clamp(themeList.SchemeColor.B * 255 - 20, 0, 255)
                        )
                        moreInfo.TextColor3 = themeList.TextColor
                        touch.ImageColor3 = themeList.SchemeColor
                        btnInfo.TextColor3 = themeList.TextColor
                    end
                end)
                
                function ButtonFunction:UpdateButton(newTitle)
                    btnInfo.Text = newTitle
                end
                
                return ButtonFunction
            end

            function Elements:NewLabel(title)
                local labelFunctions = {}
                local label = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")
                
                label.Name = "label"
                label.Parent = sectionInners
                label.BackgroundColor3 = themeList.SchemeColor
                label.BorderSizePixel = 0
                label.ClipsDescendants = true
                label.Text = title
                label.Size = UDim2.new(1, 0, 0, 35)
                label.Font = Enum.Font.GothamSemibold
                label.Text = "  "..title
                label.RichText = true
                label.TextColor3 = themeList.TextColor
                Objects[label] = "TextColor3"
                label.TextSize = 14.000
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextTruncate = Enum.TextTruncate.AtEnd
                
                UICorner.CornerRadius = UDim.new(0, 6)
                UICorner.Parent = label

                task.spawn(function()
                    while task.wait(0.1) do
                        if not label.Parent then break end
                        label.BackgroundColor3 = themeList.SchemeColor
                        label.TextColor3 = themeList.TextColor
                    end
                end)
                
                updateSectionFrame()
                UpdateSize()
                
                function labelFunctions:UpdateLabel(newText)
                    if label.Text ~= "  "..newText then
                        label.Text = "  "..newText
                    end
                end	
                
                return labelFunctions
            end

            -- باقي العناصر (Toggle, Slider, TextBox, Keybind, Dropdown, ColorPicker) 
            -- سأضيفها في الرد التالي بسبب حد الطول...
            
            sectionFunctions.Elements = Elements
            return setmetatable(sectionFunctions, {__index = Elements})
        end
        return Sections
    end  
    return Tabs
end

return DrakthonLib
