--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║            DRAKTHON UI LIBRARY - SIMPLE & CLEAN              ║
    ║                  نسخة بسيطة وتعمل 100%                      ║
    ╚══════════════════════════════════════════════════════════════╝
]]

local Library = {}

-- Services
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Helper Functions
local function Tween(obj, props, time)
    TweenService:Create(obj, TweenInfo.new(time or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

-- Main Library Function
function Library:CreateWindow(title)
    title = title or "Drakthon UI"
    
    -- Screen GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DrakthonUI"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = Player.PlayerGui
    
    -- Background Overlay (للخلفية المتحركة)
    local Overlay = Instance.new("Frame")
    Overlay.Name = "Overlay"
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Overlay.BackgroundTransparency = 1
    Overlay.BorderSizePixel = 0
    Overlay.Visible = false
    Overlay.Parent = ScreenGui
    
    -- Main Frame
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = UDim2.new(0, 600, 0, 400)
    Main.Position = UDim2.new(0.5, -300, 0.5, -200)
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = Main
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = Main
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 10)
    TitleCorner.Parent = TitleBar
    
    local TitleCover = Instance.new("Frame")
    TitleCover.Size = UDim2.new(1, 0, 0, 20)
    TitleCover.Position = UDim2.new(0, 0, 1, -20)
    TitleCover.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TitleCover.BorderSizePixel = 0
    TitleCover.Parent = TitleBar
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -100, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "🌙 " .. title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleBar
    
    -- Close Button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 35, 0, 25)
    CloseBtn.Position = UDim2.new(1, -45, 0.5, -12.5)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseBtn.Text = "×"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 18
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = TitleBar
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Dragging
    local dragging, dragInput, dragStart, startPos
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
            
            -- Show overlay
            Overlay.Visible = true
            Tween(Overlay, {BackgroundTransparency = 0.5}, 0.2)
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    Tween(Overlay, {BackgroundTransparency = 1}, 0.3)
                    wait(0.3)
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
    
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 180, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main
    
    local TabList = Instance.new("UIListLayout")
    TabList.Padding = UDim.new(0, 5)
    TabList.Parent = Sidebar
    
    local SidebarPadding = Instance.new("UIPadding")
    SidebarPadding.PaddingTop = UDim.new(0, 10)
    SidebarPadding.PaddingLeft = UDim.new(0, 8)
    SidebarPadding.PaddingRight = UDim.new(0, 8)
    SidebarPadding.Parent = Sidebar
    
    -- Content Area
    local Content = Instance.new("Frame")
    Content.Name = "Content"
    Content.Size = UDim2.new(1, -180, 1, -40)
    Content.Position = UDim2.new(0, 180, 0, 40)
    Content.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Content.BorderSizePixel = 0
    Content.Parent = Main
    
    -- Window Object
    local Window = {
        Tabs = {},
        CurrentTab = nil
    }
    
    function Window:CreateTab(name, icon)
        name = name or "Tab"
        icon = icon or ""
        
        -- Tab Button
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = name
        TabBtn.Size = UDim2.new(1, 0, 0, 50)
        TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TabBtn.BorderSizePixel = 0
        TabBtn.Text = ""
        TabBtn.AutoButtonColor = false
        TabBtn.Parent = Sidebar
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Parent = TabBtn
        
        -- Tab Icon
        if icon ~= "" then
            local TabIcon = Instance.new("ImageLabel")
            TabIcon.Size = UDim2.new(0, 28, 0, 28)
            TabIcon.Position = UDim2.new(0, 12, 0.5, -14)
            TabIcon.BackgroundTransparency = 1
            TabIcon.Image = icon
            TabIcon.Parent = TabBtn
        end
        
        -- Tab Label
        local TabLabel = Instance.new("TextLabel")
        TabLabel.Size = UDim2.new(1, -50, 1, 0)
        TabLabel.Position = UDim2.new(0, 45, 0, 0)
        TabLabel.BackgroundTransparency = 1
        TabLabel.Text = name
        TabLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabLabel.TextSize = 14
        TabLabel.Font = Enum.Font.GothamSemibold
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        TabLabel.Parent = TabBtn
        
        -- Active Indicator
        local Indicator = Instance.new("Frame")
        Indicator.Name = "Indicator"
        Indicator.Size = UDim2.new(0, 0, 0, 40)
        Indicator.Position = UDim2.new(0, 0, 0.5, -20)
        Indicator.BackgroundColor3 = Color3.fromRGB(80, 140, 220)
        Indicator.BorderSizePixel = 0
        Indicator.Parent = TabBtn
        
        local IndicatorCorner = Instance.new("UICorner")
        IndicatorCorner.CornerRadius = UDim.new(1, 0)
        IndicatorCorner.Parent = Indicator
        
        -- Tab Container
        local TabContainer = Instance.new("ScrollingFrame")
        TabContainer.Name = name .. "Container"
        TabContainer.Size = UDim2.new(1, 0, 1, 0)
        TabContainer.BackgroundTransparency = 1
        TabContainer.BorderSizePixel = 0
        TabContainer.ScrollBarThickness = 4
        TabContainer.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
        TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabContainer.Visible = false
        TabContainer.Parent = Content
        
        local ContainerPadding = Instance.new("UIPadding")
        ContainerPadding.PaddingTop = UDim.new(0, 15)
        ContainerPadding.PaddingLeft = UDim.new(0, 15)
        ContainerPadding.PaddingRight = UDim.new(0, 15)
        ContainerPadding.PaddingBottom = UDim.new(0, 15)
        ContainerPadding.Parent = TabContainer
        
        local ContainerList = Instance.new("UIListLayout")
        ContainerList.Padding = UDim.new(0, 10)
        ContainerList.Parent = TabContainer
        
        -- Tab Selection
        TabBtn.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab.Container.Visible = false
                Tween(tab.Button, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.2)
                Tween(tab.Indicator, {Size = UDim2.new(0, 0, 0, 40)}, 0.3)
            end
            
            TabContainer.Visible = true
            Tween(TabBtn, {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}, 0.2)
            Tween(Indicator, {Size = UDim2.new(0, 4, 0, 40)}, 0.3)
        end)
        
        -- Hover Effect
        TabBtn.MouseEnter:Connect(function()
            if TabContainer.Visible == false then
                Tween(TabBtn, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.2)
            end
        end)
        
        TabBtn.MouseLeave:Connect(function()
            if TabContainer.Visible == false then
                Tween(TabBtn, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.2)
            end
        end)
        
        -- Tab Object
        local Tab = {
            Name = name,
            Button = TabBtn,
            Container = TabContainer,
            Indicator = Indicator
        }
        
        table.insert(Window.Tabs, Tab)
        
        -- Auto select first tab
        if #Window.Tabs == 1 then
            TabContainer.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Indicator.Size = UDim2.new(0, 4, 0, 40)
        end
        
        -- TAB FUNCTIONS
        
        function Tab:AddButton(text, callback)
            local ButtonFrame = Instance.new("Frame")
            ButtonFrame.Size = UDim2.new(1, 0, 0, 40)
            ButtonFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.Parent = TabContainer
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 8)
            BtnCorner.Parent = ButtonFrame
            
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 1, 0)
            Btn.BackgroundTransparency = 1
            Btn.Text = text or "Button"
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.TextSize = 14
            Btn.Font = Enum.Font.Gotham
            Btn.Parent = ButtonFrame
            
            Btn.MouseButton1Click:Connect(function()
                Tween(ButtonFrame, {BackgroundColor3 = Color3.fromRGB(60, 120, 200)}, 0.1)
                wait(0.1)
                Tween(ButtonFrame, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.1)
                if callback then
                    pcall(callback)
                end
            end)
            
            Btn.MouseEnter:Connect(function()
                Tween(ButtonFrame, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}, 0.2)
            end)
            
            Btn.MouseLeave:Connect(function()
                Tween(ButtonFrame, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.2)
            end)
        end
        
        function Tab:AddToggle(text, default, callback)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabContainer
            
            local TCorner = Instance.new("UICorner")
            TCorner.CornerRadius = UDim.new(0, 8)
            TCorner.Parent = ToggleFrame
            
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -70, 1, 0)
            Label.Position = UDim2.new(0, 15, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = text or "Toggle"
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 14
            Label.Font = Enum.Font.Gotham
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = ToggleFrame
            
            local toggled = default or false
            
            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Size = UDim2.new(0, 50, 0, 25)
            ToggleBtn.Position = UDim2.new(1, -60, 0.5, -12.5)
            ToggleBtn.BackgroundColor3 = toggled and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(60, 60, 60)
            ToggleBtn.Text = ""
            ToggleBtn.Parent = ToggleFrame
            
            local TBCorner = Instance.new("UICorner")
            TBCorner.CornerRadius = UDim.new(1, 0)
            TBCorner.Parent = ToggleBtn
            
            local Knob = Instance.new("Frame")
            Knob.Size = UDim2.new(0, 20, 0, 20)
            Knob.Position = toggled and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
            Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Knob.Parent = ToggleBtn
            
            local KnobCorner = Instance.new("UICorner")
            KnobCorner.CornerRadius = UDim.new(1, 0)
            KnobCorner.Parent = Knob
            
            ToggleBtn.MouseButton1Click:Connect(function()
                toggled = not toggled
                if toggled then
                    Tween(ToggleBtn, {BackgroundColor3 = Color3.fromRGB(80, 200, 120)}, 0.3)
                    Tween(Knob, {Position = UDim2.new(1, -22, 0.5, -10)}, 0.3)
                else
                    Tween(ToggleBtn, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.3)
                    Tween(Knob, {Position = UDim2.new(0, 2, 0.5, -10)}, 0.3)
                end
                if callback then
                    pcall(function() callback(toggled) end)
                end
            end)
        end
        
        function Tab:AddSlider(text, min, max, default, callback)
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, 0, 0, 50)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Parent = TabContainer
            
            local SCorner = Instance.new("UICorner")
            SCorner.CornerRadius = UDim.new(0, 8)
            SCorner.Parent = SliderFrame
            
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -60, 0, 20)
            Label.Position = UDim2.new(0, 15, 0, 5)
            Label.BackgroundTransparency = 1
            Label.Text = text or "Slider"
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 14
            Label.Font = Enum.Font.Gotham
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = SliderFrame
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Size = UDim2.new(0, 50, 0, 20)
            ValueLabel.Position = UDim2.new(1, -60, 0, 5)
            ValueLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            ValueLabel.Text = tostring(default or min)
            ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ValueLabel.TextSize = 13
            ValueLabel.Font = Enum.Font.GothamBold
            ValueLabel.Parent = SliderFrame
            
            local VCorner = Instance.new("UICorner")
            VCorner.CornerRadius = UDim.new(0, 6)
            VCorner.Parent = ValueLabel
            
            local SliderBar = Instance.new("Frame")
            SliderBar.Size = UDim2.new(1, -30, 0, 6)
            SliderBar.Position = UDim2.new(0, 15, 1, -15)
            SliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            SliderBar.BorderSizePixel = 0
            SliderBar.Parent = SliderFrame
            
            local BarCorner = Instance.new("UICorner")
            BarCorner.CornerRadius = UDim.new(1, 0)
            BarCorner.Parent = SliderBar
            
            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            Fill.BackgroundColor3 = Color3.fromRGB(80, 140, 220)
            Fill.BorderSizePixel = 0
            Fill.Parent = SliderBar
            
            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(1, 0)
            FillCorner.Parent = Fill
            
            local Dragging = false
            
            SliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true
                end
            end)
            
            UIS.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = false
                end
            end)
            
            UIS.InputChanged:Connect(function(input)
                if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    Fill.Size = UDim2.new(pos, 0, 1, 0)
                    local value = math.floor(min + (max - min) * pos)
                    ValueLabel.Text = tostring(value)
                    if callback then
                        pcall(function() callback(value) end)
                    end
                end
            end)
        end
        
        function Tab:AddDropdown(text, items, callback)
            local DropFrame = Instance.new("Frame")
            DropFrame.Size = UDim2.new(1, 0, 0, 40)
            DropFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            DropFrame.BorderSizePixel = 0
            DropFrame.ClipsDescendants = false
            DropFrame.Parent = TabContainer
            
            local DCorner = Instance.new("UICorner")
            DCorner.CornerRadius = UDim.new(0, 8)
            DCorner.Parent = DropFrame
            
            local DropBtn = Instance.new("TextButton")
            DropBtn.Size = UDim2.new(1, -20, 1, 0)
            DropBtn.Position = UDim2.new(0, 10, 0, 0)
            DropBtn.BackgroundTransparency = 1
            DropBtn.Text = text or "Select..."
            DropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropBtn.TextSize = 14
            DropBtn.Font = Enum.Font.Gotham
            DropBtn.TextXAlignment = Enum.TextXAlignment.Left
            DropBtn.Parent = DropFrame
            
            local Arrow = Instance.new("TextLabel")
            Arrow.Size = UDim2.new(0, 20, 1, 0)
            Arrow.Position = UDim2.new(1, -30, 0, 0)
            Arrow.BackgroundTransparency = 1
            Arrow.Text = "▼"
            Arrow.TextColor3 = Color3.fromRGB(200, 200, 200)
            Arrow.TextSize = 12
            Arrow.Font = Enum.Font.Gotham
            Arrow.Parent = DropFrame
            
            local List = Instance.new("Frame")
            List.Size = UDim2.new(1, 0, 0, 0)
            List.Position = UDim2.new(0, 0, 0, 45)
            List.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            List.BorderSizePixel = 0
            List.Visible = false
            List.ZIndex = 10
            List.Parent = DropFrame
            
            local LCorner = Instance.new("UICorner")
            LCorner.CornerRadius = UDim.new(0, 8)
            LCorner.Parent = List
            
            local ListLayout = Instance.new("UIListLayout")
            ListLayout.Padding = UDim.new(0, 2)
            ListLayout.Parent = List
            
            local ListPad = Instance.new("UIPadding")
            ListPad.PaddingAll = UDim.new(0, 5)
            ListPad.Parent = List
            
            local isOpen = false
            
            DropBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    List.Visible = true
                    Tween(List, {Size = UDim2.new(1, 0, 0, math.min(#items * 32, 150))}, 0.3)
                    Tween(Arrow, {Rotation = 180}, 0.3)
                else
                    Tween(List, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
                    Tween(Arrow, {Rotation = 0}, 0.3)
                    wait(0.3)
                    List.Visible = false
                end
            end)
            
            for _, item in ipairs(items or {}) do
                local ItemBtn = Instance.new("TextButton")
                ItemBtn.Size = UDim2.new(1, 0, 0, 28)
                ItemBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                ItemBtn.Text = item
                ItemBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                ItemBtn.TextSize = 13
                ItemBtn.Font = Enum.Font.Gotham
                ItemBtn.Parent = List
                
                local ICorner = Instance.new("UICorner")
                ICorner.CornerRadius = UDim.new(0, 6)
                ICorner.Parent = ItemBtn
                
                ItemBtn.MouseButton1Click:Connect(function()
                    DropBtn.Text = item
                    isOpen = false
                    Tween(List, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
                    Tween(Arrow, {Rotation = 0}, 0.3)
                    wait(0.3)
                    List.Visible = false
                    if callback then
                        pcall(function() callback(item) end)
                    end
                end)
                
                ItemBtn.MouseEnter:Connect(function()
                    Tween(ItemBtn, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.2)
                end)
                
                ItemBtn.MouseLeave:Connect(function()
                    Tween(ItemBtn, {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}, 0.2)
                end)
            end
        end
        
        function Tab:AddLabel(text)
            local LabelFrame = Instance.new("Frame")
            LabelFrame.Size = UDim2.new(1, 0, 0, 35)
            LabelFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            LabelFrame.BorderSizePixel = 0
            LabelFrame.Parent = TabContainer
            
            local LCorner = Instance.new("UICorner")
            LCorner.CornerRadius = UDim.new(0, 8)
            LCorner.Parent = LabelFrame
            
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -20, 1, 0)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = text or "Label"
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 14
            Label.Font = Enum.Font.Gotham
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.TextWrapped = true
            Label.Parent = LabelFrame
        end
        
        return Tab
    end
    
    return Window
end

return Library
