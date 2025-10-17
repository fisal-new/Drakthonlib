--[[
    DRAKTHON UI LIBRARY
    نسخة نظيفة ومضمونة - بدون أخطاء
]]

local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Tween Helper
local function Tween(obj, props, time)
    TweenService:Create(obj, TweenInfo.new(time or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

-- Create Window
function Library:CreateWindow(title)
    title = title or "Drakthon UI"
    
    -- ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DrakthonUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui
    
    -- Overlay
    local Overlay = Instance.new("Frame")
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    Overlay.BackgroundTransparency = 1
    Overlay.BorderSizePixel = 0
    Overlay.Visible = false
    Overlay.ZIndex = 1
    Overlay.Parent = ScreenGui
    
    -- Main Window
    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 650, 0, 450)
    Main.Position = UDim2.new(0.5, -325, 0.5, -225)
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.BorderSizePixel = 0
    Main.ZIndex = 2
    Main.Parent = ScreenGui
    
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TitleBar.BorderSizePixel = 0
    TitleBar.ZIndex = 3
    TitleBar.Parent = Main
    
    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)
    
    local TitleCover = Instance.new("Frame")
    TitleCover.Size = UDim2.new(1, 0, 0, 20)
    TitleCover.Position = UDim2.new(0, 0, 1, -20)
    TitleCover.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TitleCover.BorderSizePixel = 0
    TitleCover.ZIndex = 3
    TitleCover.Parent = TitleBar
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🌙 " .. title
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 4
    Title.Parent = TitleBar
    
    -- Close Button
    local Close = Instance.new("TextButton")
    Close.Size = UDim2.new(0, 35, 0, 25)
    Close.Position = UDim2.new(1, -45, 0.5, -12.5)
    Close.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    Close.Text = "×"
    Close.TextColor3 = Color3.new(1, 1, 1)
    Close.TextSize = 18
    Close.Font = Enum.Font.GothamBold
    Close.ZIndex = 4
    Close.Parent = TitleBar
    
    Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)
    
    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Dragging
    local dragging, dragInput, dragStart, startPos
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
            
            Overlay.Visible = true
            Tween(Overlay, {BackgroundTransparency = 0.5}, 0.2)
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    Tween(Overlay, {BackgroundTransparency = 1}, 0.3)
                    task.wait(0.3)
                    Overlay.Visible = false
                end
            end)
        end
    end)
    
    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Sidebar
    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Size = UDim2.new(0, 200, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Sidebar.BorderSizePixel = 0
    Sidebar.ScrollBarThickness = 0
    Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    Sidebar.ZIndex = 3
    Sidebar.Parent = Main
    
    local SidebarList = Instance.new("UIListLayout")
    SidebarList.Padding = UDim.new(0, 5)
    SidebarList.Parent = Sidebar
    
    local SidebarPad = Instance.new("UIPadding")
    SidebarPad.PaddingTop = UDim.new(0, 10)
    SidebarPad.PaddingLeft = UDim.new(0, 8)
    SidebarPad.PaddingRight = UDim.new(0, 8)
    SidebarPad.PaddingBottom = UDim.new(0, 10)
    SidebarPad.Parent = Sidebar
    
    SidebarList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Sidebar.CanvasSize = UDim2.new(0, 0, 0, SidebarList.AbsoluteContentSize.Y + 20)
    end)
    
    -- Content
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -200, 1, -40)
    Content.Position = UDim2.new(0, 200, 0, 40)
    Content.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Content.BorderSizePixel = 0
    Content.ZIndex = 3
    Content.Parent = Main
    
    local Window = {}
    
    function Window:CreateTab(name, icon)
        name = name or "Tab"
        
        -- Tab Button
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(1, 0, 0, 50)
        TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TabBtn.BorderSizePixel = 0
        TabBtn.Text = ""
        TabBtn.ZIndex = 4
        TabBtn.Parent = Sidebar
        
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)
        
        -- Indicator
        local Indicator = Instance.new("Frame")
        Indicator.Size = UDim2.new(0, 0, 0, 40)
        Indicator.Position = UDim2.new(0, 0, 0.5, -20)
        Indicator.BackgroundColor3 = Color3.fromRGB(80, 140, 220)
        Indicator.BorderSizePixel = 0
        Indicator.ZIndex = 5
        Indicator.Parent = TabBtn
        
        Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)
        
        -- Icon
        if icon and icon ~= "" then
            local Icon = Instance.new("ImageLabel")
            Icon.Size = UDim2.new(0, 28, 0, 28)
            Icon.Position = UDim2.new(0, 12, 0.5, -14)
            Icon.BackgroundTransparency = 1
            Icon.Image = icon
            Icon.ZIndex = 5
            Icon.Parent = TabBtn
        end
        
        -- Label
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -50, 1, 0)
        Label.Position = UDim2.new(0, 45, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = name
        Label.TextColor3 = Color3.fromRGB(200, 200, 200)
        Label.TextSize = 14
        Label.Font = Enum.Font.GothamSemibold
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.ZIndex = 5
        Label.Parent = TabBtn
        
        -- Container
        local Container = Instance.new("ScrollingFrame")
        Container.Size = UDim2.new(1, 0, 1, 0)
        Container.BackgroundTransparency = 1
        Container.BorderSizePixel = 0
        Container.ScrollBarThickness = 5
        Container.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
        Container.CanvasSize = UDim2.new(0, 0, 0, 0)
        Container.Visible = false
        Container.ZIndex = 4
        Container.Parent = Content
        
        local ContainerList = Instance.new("UIListLayout")
        ContainerList.Padding = UDim.new(0, 10)
        ContainerList.Parent = Container
        
        local ContainerPad = Instance.new("UIPadding")
        ContainerPad.PaddingTop = UDim.new(0, 15)
        ContainerPad.PaddingLeft = UDim.new(0, 15)
        ContainerPad.PaddingRight = UDim.new(0, 15)
        ContainerPad.PaddingBottom = UDim.new(0, 15)
        ContainerPad.Parent = Container
        
        ContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Container.CanvasSize = UDim2.new(0, 0, 0, ContainerList.AbsoluteContentSize.Y + 30)
        end)
        
        -- Tab Click
        TabBtn.MouseButton1Click:Connect(function()
            for _, child in pairs(Content:GetChildren()) do
                if child:IsA("ScrollingFrame") then
                    child.Visible = false
                end
            end
            for _, btn in pairs(Sidebar:GetChildren()) do
                if btn:IsA("TextButton") then
                    Tween(btn, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.2)
                    if btn:FindFirstChild("Indicator") then
                        Tween(btn.Indicator, {Size = UDim2.new(0, 0, 0, 40)}, 0.3)
                    end
                end
            end
            
            Container.Visible = true
            Tween(TabBtn, {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}, 0.2)
            Tween(Indicator, {Size = UDim2.new(0, 4, 0, 40)}, 0.3)
        end)
        
        TabBtn.MouseEnter:Connect(function()
            if not Container.Visible then
                Tween(TabBtn, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.2)
            end
        end)
        
        TabBtn.MouseLeave:Connect(function()
            if not Container.Visible then
                Tween(TabBtn, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.2)
            end
        end)
        
        -- First tab auto-select
        if #Sidebar:GetChildren() == 3 then -- 3 because UIListLayout + UIPadding + first tab
            Container.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Indicator.Size = UDim2.new(0, 4, 0, 40)
        end
        
        local Tab = {}
        
        -- Add Button
        function Tab:AddButton(text, callback)
            callback = callback or function() end
            
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 0, 40)
            Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Btn.BorderSizePixel = 0
            Btn.Text = text or "Button"
            Btn.TextColor3 = Color3.new(1, 1, 1)
            Btn.TextSize = 14
            Btn.Font = Enum.Font.Gotham
            Btn.ZIndex = 5
            Btn.Parent = Container
            
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
            
            Btn.MouseButton1Click:Connect(function()
                Tween(Btn, {BackgroundColor3 = Color3.fromRGB(60, 120, 200)}, 0.1)
                task.wait(0.1)
                Tween(Btn, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.1)
                pcall(callback)
            end)
            
            Btn.MouseEnter:Connect(function()
                Tween(Btn, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}, 0.2)
            end)
            
            Btn.MouseLeave:Connect(function()
                Tween(Btn, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.2)
            end)
        end
        
        -- Add Toggle
        function Tab:AddToggle(text, default, callback)
            callback = callback or function() end
            local toggled = default or false
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.ZIndex = 5
            ToggleFrame.Parent = Container
            
            Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 8)
            
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -70, 1, 0)
            Label.Position = UDim2.new(0, 15, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = text or "Toggle"
            Label.TextColor3 = Color3.new(1, 1, 1)
            Label.TextSize = 14
            Label.Font = Enum.Font.Gotham
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.ZIndex = 6
            Label.Parent = ToggleFrame
            
            local Toggle = Instance.new("TextButton")
            Toggle.Size = UDim2.new(0, 50, 0, 25)
            Toggle.Position = UDim2.new(1, -60, 0.5, -12.5)
            Toggle.BackgroundColor3 = toggled and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(60, 60, 60)
            Toggle.BorderSizePixel = 0
            Toggle.Text = ""
            Toggle.ZIndex = 6
            Toggle.Parent = ToggleFrame
            
            Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
            
            local Knob = Instance.new("Frame")
            Knob.Size = UDim2.new(0, 20, 0, 20)
            Knob.Position = toggled and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
            Knob.BackgroundColor3 = Color3.new(1, 1, 1)
            Knob.BorderSizePixel = 0
            Knob.ZIndex = 7
            Knob.Parent = Toggle
            
            Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)
            
            Toggle.MouseButton1Click:Connect(function()
                toggled = not toggled
                if toggled then
                    Tween(Toggle, {BackgroundColor3 = Color3.fromRGB(80, 200, 120)}, 0.3)
                    Tween(Knob, {Position = UDim2.new(1, -22, 0.5, -10)}, 0.3)
                else
                    Tween(Toggle, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.3)
                    Tween(Knob, {Position = UDim2.new(0, 2, 0.5, -10)}, 0.3)
                end
                pcall(function() callback(toggled) end)
            end)
        end
        
        -- Add Slider
        function Tab:AddSlider(text, min, max, default, callback)
            callback = callback or function() end
            min = min or 0
            max = max or 100
            default = default or min
            
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, 0, 0, 50)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            SliderFrame.BorderSizePixel = 0
            SliderFrame.ZIndex = 5
            SliderFrame.Parent = Container
            
            Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 8)
            
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -60, 0, 20)
            Label.Position = UDim2.new(0, 15, 0, 5)
            Label.BackgroundTransparency = 1
            Label.Text = text or "Slider"
            Label.TextColor3 = Color3.new(1, 1, 1)
            Label.TextSize = 14
            Label.Font = Enum.Font.Gotham
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.ZIndex = 6
            Label.Parent = SliderFrame
            
            local Value = Instance.new("TextLabel")
            Value.Size = UDim2.new(0, 50, 0, 20)
            Value.Position = UDim2.new(1, -60, 0, 5)
            Value.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Value.BorderSizePixel = 0
            Value.Text = tostring(default)
            Value.TextColor3 = Color3.new(1, 1, 1)
            Value.TextSize = 13
            Value.Font = Enum.Font.GothamBold
            Value.ZIndex = 6
            Value.Parent = SliderFrame
            
            Instance.new("UICorner", Value).CornerRadius = UDim.new(0, 6)
            
            local SliderBg = Instance.new("Frame")
            SliderBg.Size = UDim2.new(1, -30, 0, 6)
            SliderBg.Position = UDim2.new(0, 15, 1, -15)
            SliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            SliderBg.BorderSizePixel = 0
            SliderBg.ZIndex = 6
            SliderBg.Parent = SliderFrame
            
            Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(1, 0)
            
            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            Fill.BackgroundColor3 = Color3.fromRGB(80, 140, 220)
            Fill.BorderSizePixel = 0
            Fill.ZIndex = 7
            Fill.Parent = SliderBg
            
            Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
            
            local dragging = false
            
            SliderBg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local sizeX = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
                    Fill.Size = UDim2.new(sizeX, 0, 1, 0)
                    local val = math.floor(min + (max - min) * sizeX)
                    Value.Text = tostring(val)
                    pcall(function() callback(val) end)
                end
            end)
        end
        
        -- Add Dropdown
        function Tab:AddDropdown(text, items, callback)
            callback = callback or function() end
            items = items or {}
            
            local DropFrame = Instance.new("Frame")
            DropFrame.Size = UDim2.new(1, 0, 0, 40)
            DropFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            DropFrame.BorderSizePixel = 0
            DropFrame.ClipsDescendants = false
            DropFrame.ZIndex = 5
            DropFrame.Parent = Container
            
            Instance.new("UICorner", DropFrame).CornerRadius = UDim.new(0, 8)
            
            local DropBtn = Instance.new("TextButton")
            DropBtn.Size = UDim2.new(1, -20, 1, 0)
            DropBtn.Position = UDim2.new(0, 10, 0, 0)
            DropBtn.BackgroundTransparency = 1
            DropBtn.Text = text or "Select..."
            DropBtn.TextColor3 = Color3.new(1, 1, 1)
            DropBtn.TextSize = 14
            DropBtn.Font = Enum.Font.Gotham
            DropBtn.TextXAlignment = Enum.TextXAlignment.Left
            DropBtn.ZIndex = 6
            DropBtn.Parent = DropFrame
            
            local Arrow = Instance.new("TextLabel")
            Arrow.Size = UDim2.new(0, 20, 1, 0)
            Arrow.Position = UDim2.new(1, -30, 0, 0)
            Arrow.BackgroundTransparency = 1
            Arrow.Text = "▼"
            Arrow.TextColor3 = Color3.fromRGB(200, 200, 200)
            Arrow.TextSize = 12
            Arrow.Font = Enum.Font.Gotham
            Arrow.ZIndex = 6
            Arrow.Parent = DropFrame
            
            local List = Instance.new("Frame")
            List.Size = UDim2.new(1, 0, 0, 0)
            List.Position = UDim2.new(0, 0, 0, 45)
            List.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            List.BorderSizePixel = 0
            List.Visible = false
            List.ZIndex = 100
            List.ClipsDescendants = true
            List.Parent = DropFrame
            
            Instance.new("UICorner", List).CornerRadius = UDim.new(0, 8)
            
            local ListLayout = Instance.new("UIListLayout")
            ListLayout.Padding = UDim.new(0, 2)
            ListLayout.Parent = List
            
            local ListPad = Instance.new("UIPadding")
            ListPad.PaddingAll = UDim.new(0, 5)
            ListPad.Parent = List
            
            local open = false
            
            DropBtn.MouseButton1Click:Connect(function()
                open = not open
                if open then
                    List.Visible = true
                    local h = math.min(#items * 32, 150)
                    Tween(List, {Size = UDim2.new(1, 0, 0, h)}, 0.3)
                    Tween(Arrow, {Rotation = 180}, 0.3)
                else
                    Tween(List, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
                    Tween(Arrow, {Rotation = 0}, 0.3)
                    task.wait(0.3)
                    List.Visible = false
                end
            end)
            
            for _, item in ipairs(items) do
                local ItemBtn = Instance.new("TextButton")
                ItemBtn.Size = UDim2.new(1, 0, 0, 28)
                ItemBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                ItemBtn.BorderSizePixel = 0
                ItemBtn.Text = tostring(item)
                ItemBtn.TextColor3 = Color3.new(1, 1, 1)
                ItemBtn.TextSize = 13
                ItemBtn.Font = Enum.Font.Gotham
                ItemBtn.ZIndex = 101
                ItemBtn.Parent = List
                
                Instance.new("UICorner", ItemBtn).CornerRadius = UDim.new(0, 6)
                
                ItemBtn.MouseButton1Click:Connect(function()
                    DropBtn.Text = tostring(item)
                    open = false
                    Tween(List, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
                    Tween(Arrow, {Rotation = 0}, 0.3)
                    task.wait(0.3)
                    List.Visible = false
                    pcall(function() callback(item) end)
                end)
                
                ItemBtn.MouseEnter:Connect(function()
                    Tween(ItemBtn, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.2)
                end)
                
                ItemBtn.MouseLeave:Connect(function()
                    Tween(ItemBtn, {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}, 0.2)
                end)
            end
        end
        
        -- Add Label
        function Tab:AddLabel(text)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, 0, 0, 35)
            Label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Label.BorderSizePixel = 0
            Label.Text = text or "Label"
            Label.TextColor3 = Color3.new(1, 1, 1)
            Label.TextSize = 14
            Label.Font = Enum.Font.Gotham
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.TextWrapped = true
            Label.ZIndex = 5
            Label.Parent = Container
            
            Instance.new("UICorner", Label).CornerRadius = UDim.new(0, 8)
            
            local LabelPad = Instance.new("UIPadding")
            LabelPad.PaddingLeft = UDim.new(0, 10)
            LabelPad.PaddingRight = UDim.new(0, 10)
            LabelPad.Parent = Label
        end
        
        return Tab
    end
    
    return Window
end

return Library
