--[[
    DrakthonLib v2.0
    مكتبة واجهات مستخدم متقدمة لـ Roblox
    تم التطوير والتحسين بالكامل
    GitHub: https://github.com/fisal-new/Drakthonlib
]]

if not game:IsLoaded() then
	game.Loaded:Wait() 
end

local DrakthonLib = {}

-- Services
local request = request or http_request or (syn and syn.request) or (http and http.request)
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- تحميل حماية الـ Instance
pcall(function()
    loadstring(request({
        Url = "https://raw.githubusercontent.com/cypherdh/Script-Library/main/InstanceProtect",
        Method = "GET"
    }).Body)()
end)

-- دالة توليد نص عشوائي
local function GenerateRandomString(length)
	local chars = "abcdefghijklmnopqrstuvwxyz"
	local result = ""
	for i = 1, length or math.random(8, 16) do
		local rand = math.random(1, #chars)
		result = result .. chars:sub(rand, rand)
	end
	return result
end

-- دالة إنشاء النافذة الرئيسية
function DrakthonLib:CreateWindow(name, version, icon)
	name = name or "DrakthonLib"
	version = version or "v2.0"
	icon = icon or 7733992358
	
	-- متغيرات محلية
	local CurrentPage = nil
	local MinimizeGui = false
	local AllPages = {}
	
	-- إنشاء العناصر
	local ScreenGui = Instance.new("ScreenGui")
	local Window = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local TitleBar = Instance.new("Frame")
	local Icon = Instance.new("ImageLabel")
	local MainTitle = Instance.new("TextLabel")
	local TitleUnderline = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")
	local Bar1 = Instance.new("Frame")
	local Bar2 = Instance.new("Frame")
	local CloseButton = Instance.new("ImageButton")
	local MinimizeButton = Instance.new("ImageButton")
	local Shadow = Instance.new("ImageLabel")

	-- إعدادات ScreenGui
	local RandomName = GenerateRandomString()
	if ProtectInstance then
		pcall(function() ProtectInstance(ScreenGui) end)
	end
	
	ScreenGui.Name = RandomName
	ScreenGui.Parent = CoreGui
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn = false

	-- إعدادات النافذة
	Window.Name = "DrakthonWindow"
	Window.Parent = ScreenGui
	Window.BackgroundColor3 = Color3.fromRGB(49, 49, 59)
	Window.Position = UDim2.new(0.5, -300, 0.5, -200)
	Window.Size = UDim2.new(0, 0, 0, 0)
	Window.ClipsDescendants = true
	Window.Active = true

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = Window

	-- شريط العنوان
	TitleBar.Name = "TitleBar"
	TitleBar.Parent = Window
	TitleBar.BackgroundTransparency = 1
	TitleBar.Size = UDim2.new(1, 0, 0, 30)

	Icon.Name = "Icon"
	Icon.Parent = TitleBar
	Icon.BackgroundTransparency = 1
	Icon.Position = UDim2.new(0, 6, 0, 6)
	Icon.Size = UDim2.new(0, 18, 0, 18)
	Icon.Image = "rbxassetid://" .. icon
	Icon.ImageColor3 = Color3.fromRGB(135, 255, 135)

	MainTitle.Name = "Title"
	MainTitle.Parent = TitleBar
	MainTitle.BackgroundTransparency = 1
	MainTitle.Position = UDim2.new(0, 30, 0, 1)
	MainTitle.Size = UDim2.new(1, -60, 1, 0)
	MainTitle.Font = Enum.Font.GothamBold
	MainTitle.Text = name .. " | " .. version
	MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	MainTitle.TextSize = 12
	MainTitle.TextXAlignment = Enum.TextXAlignment.Left

	TitleUnderline.Name = "TitleUnderline"
	TitleUnderline.Parent = TitleBar
	TitleUnderline.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
	TitleUnderline.BorderSizePixel = 0
	TitleUnderline.Position = UDim2.new(0, 0, 1, 0)
	TitleUnderline.Size = UDim2.new(1, 0, 0, 1)

	UIGradient.Parent = TitleUnderline

	Bar1.Name = "Bar1"
	Bar1.Parent = TitleUnderline
	Bar1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Bar1.BackgroundTransparency = 0.75
	Bar1.BorderSizePixel = 0
	Bar1.Position = UDim2.new(0, 6, 0, 0)
	Bar1.Size = UDim2.new(0, 18, 1, 0)

	Bar2.Name = "Bar2"
	Bar2.Parent = TitleUnderline
	Bar2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Bar2.BackgroundTransparency = 0.75
	Bar2.BorderSizePixel = 0
	Bar2.Position = UDim2.new(1, -24, 0, 0)
	Bar2.Size = UDim2.new(0, 18, 1, 0)

	-- زر الإغلاق
	CloseButton.Name = "Close"
	CloseButton.Parent = TitleBar
	CloseButton.BackgroundTransparency = 1
	CloseButton.Position = UDim2.new(1, -28, 0, 2)
	CloseButton.Size = UDim2.new(0, 25, 0, 25)
	CloseButton.Image = "rbxassetid://3926305904"
	CloseButton.ImageRectOffset = Vector2.new(284, 4)
	CloseButton.ImageRectSize = Vector2.new(24, 24)

	-- زر التصغير
	MinimizeButton.Name = "Minimize"
	MinimizeButton.Parent = TitleBar
	MinimizeButton.BackgroundTransparency = 1
	MinimizeButton.Position = UDim2.new(1, -52, 0, 2)
	MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
	MinimizeButton.Image = "rbxassetid://6035067836"

	-- الظل
	Shadow.Name = "Shadow"
	Shadow.Parent = Window
	Shadow.BackgroundTransparency = 1
	Shadow.Position = UDim2.new(0, -15, 0, -15)
	Shadow.Size = UDim2.new(1, 30, 1, 30)
	Shadow.Image = "rbxassetid://5761504593"
	Shadow.ImageColor3 = Color3.fromRGB(49, 49, 59)
	Shadow.ImageTransparency = 0.3
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(17, 17, 283, 283)

	-- وظيفة الإغلاق
	CloseButton.MouseButton1Click:Connect(function()
		TS:Create(Window, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 600, 0, 0)
		}):Play()
		task.wait(0.3)
		TS:Create(Window, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 0, 0, 0)
		}):Play()
		task.wait(0.3)
		ScreenGui:Destroy()
	end)

	-- وظيفة التصغير
	MinimizeButton.MouseButton1Click:Connect(function()
		MinimizeGui = not MinimizeGui
		
		if MinimizeGui then
			-- تصغير
			TS:Create(Window, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
				Size = UDim2.new(0, 600, 0, 32)
			}):Play()
			
			-- إخفاء جميع الصفحات
			for _, page in pairs(AllPages) do
				page.Visible = false
			end
			for _, child in pairs(Window:GetChildren()) do
				if child:IsA("Frame") and child.Name == "Tabs" then
					child.Visible = false
				end
			end
		else
			-- تكبير
			TS:Create(Window, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
				Size = UDim2.new(0, 600, 0, 400)
			}):Play()
			
			-- إظهار العناصر
			task.wait(0.25)
			for _, child in pairs(Window:GetChildren()) do
				if child:IsA("Frame") and child.Name == "Tabs" then
					child.Visible = true
				end
			end
			if CurrentPage then
				CurrentPage.Visible = true
			end
		end
	end)

	-- دالة السحب
	local function MakeDraggable(frame)
		local dragging = false
		local dragInput, startPos, startFramePos
		
		frame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:GetFocusedTextBox() == nil then
				dragging = true
				startPos = input.Position
				startFramePos = frame.Position
				
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)
		
		UIS.InputChanged:Connect(function(input)
			if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
				local delta = input.Position - startPos
				local newPos = UDim2.new(
					startFramePos.X.Scale,
					startFramePos.X.Offset + delta.X,
					startFramePos.Y.Scale,
					startFramePos.Y.Offset + delta.Y
				)
				TS:Create(frame, TweenInfo.new(0.1), {Position = newPos}):Play()
			end
		end)
	end

	MakeDraggable(Window)

	-- فتح النافذة
	TS:Create(Window, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = UDim2.new(0, 600, 0, 0)
	}):Play()
	task.wait(0.4)
	TS:Create(Window, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = UDim2.new(0, 600, 0, 400)
	}):Play()

	-- إنشاء التبويبات
	local Tabs = {}

	function Tabs:CreateTab(tabName)
		tabName = tabName or "Tab"
		
		local TabsFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local SectionLabel = Instance.new("TextLabel")
		local UIListLayout = Instance.new("UIListLayout")
		local Indicator = Instance.new("Frame")

		TabsFrame.Name = "Tabs"
		TabsFrame.Parent = Window
		TabsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
		TabsFrame.Position = UDim2.new(0, 5, 0, 36)
		TabsFrame.Size = UDim2.new(0, 140, 1, -41)

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = TabsFrame

		SectionLabel.Name = "SectionLabel"
		SectionLabel.Parent = TabsFrame
		SectionLabel.BackgroundTransparency = 1
		SectionLabel.Position = UDim2.new(0, 7, 0, 0)
		SectionLabel.Size = UDim2.new(1, -7, 0, 30)
		SectionLabel.Font = Enum.Font.GothamBold
		SectionLabel.Text = tabName
		SectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		SectionLabel.TextSize = 12
		SectionLabel.TextXAlignment = Enum.TextXAlignment.Left

		UIListLayout.Parent = TabsFrame
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 2)

		Indicator.Name = "Indicator"
		Indicator.Parent = TabsFrame
		Indicator.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
		Indicator.BorderSizePixel = 0
		Indicator.BackgroundTransparency = 1
		Indicator.Position = UDim2.new(0, -14, 0, 4)
		Indicator.Size = UDim2.new(0, 2, 1, -8)
		Indicator.Visible = false

		local Pages = {}

		function Pages:CreatePage(pageName)
			pageName = pageName or "Page"
			
			-- إنشاء الصفحة
			local Page = Instance.new("ScrollingFrame")
			local UICorner = Instance.new("UICorner")
			local UIListLayout = Instance.new("UIListLayout")
			local UIPadding = Instance.new("UIPadding")
			local SearchBar = Instance.new("Frame")
			local SearchUICorner = Instance.new("UICorner")
			local SearchIcon = Instance.new("ImageLabel")
			local SearchDivider = Instance.new("Frame")
			local SearchBox = Instance.new("TextBox")

			Page.Name = "Page"
			Page.Parent = Window
			Page.Active = true
			Page.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
			Page.BorderSizePixel = 0
			Page.Position = UDim2.new(0, 150, 0, 36)
			Page.Size = UDim2.new(1, -155, 1, -41)
			Page.ScrollBarThickness = 5
			Page.ScrollBarImageColor3 = Color3.fromRGB(135, 255, 135)
			Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
			Page.Visible = false
			Page.CanvasSize = UDim2.new(0, 0, 0, 0)

			table.insert(AllPages, Page)

			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Page

			UIListLayout.Parent = Page
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 4)

			UIPadding.Parent = Page
			UIPadding.PaddingBottom = UDim.new(0, 4)
			UIPadding.PaddingLeft = UDim.new(0, 4)
			UIPadding.PaddingRight = UDim.new(0, 4)
			UIPadding.PaddingTop = UDim.new(0, 4)

			-- شريط البحث
			SearchBar.Name = "SearchBar"
			SearchBar.Parent = Page
			SearchBar.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
			SearchBar.Size = UDim2.new(1, 0, 0, 30)

			SearchUICorner.CornerRadius = UDim.new(0, 4)
			SearchUICorner.Parent = SearchBar

			SearchIcon.Name = "SearchIcon"
			SearchIcon.Parent = SearchBar
			SearchIcon.BackgroundTransparency = 1
			SearchIcon.Position = UDim2.new(0, 6, 0, 6)
			SearchIcon.Size = UDim2.new(0, 18, 0, 18)
			SearchIcon.Image = "rbxassetid://10045418551"
			SearchIcon.ImageColor3 = Color3.fromRGB(135, 255, 135)

			SearchDivider.Name = "Divider"
			SearchDivider.Parent = SearchBar
			SearchDivider.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
			SearchDivider.Position = UDim2.new(0, 30, 0, 10)
			SearchDivider.Size = UDim2.new(0, 1, 1, -20)

			SearchBox.Name = "SearchBox"
			SearchBox.Parent = SearchBar
			SearchBox.BackgroundTransparency = 1
			SearchBox.Position = UDim2.new(0, 40, 0, 0)
			SearchBox.Size = UDim2.new(1, -40, 1, 0)
			SearchBox.Font = Enum.Font.Gotham
			SearchBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
			SearchBox.PlaceholderText = "ابحث هنا..."
			SearchBox.Text = ""
			SearchBox.TextColor3 = Color3.fromRGB(227, 225, 228)
			SearchBox.TextSize = 12
			SearchBox.TextXAlignment = Enum.TextXAlignment.Left

			-- وظيفة البحث
			local function UpdateSearch()
				local searchText = string.lower(SearchBox.Text)
				for _, section in pairs(Page:GetChildren()) do
					if section:IsA("Frame") and section.Name == "Section" then
						local container = section:FindFirstChild("SectionContainer")
						if container then
							for _, element in pairs(container:GetChildren()) do
								if element:IsA("Frame") then
									local shouldShow = searchText == ""
									
									if not shouldShow then
										local titleLabel = element:FindFirstChild("Title") or 
										                   element:FindFirstChild("LabelContent") or
										                   (element:FindFirstChild("Container") and element.Container:FindFirstChild("Title"))
										
										if titleLabel and titleLabel:IsA("TextLabel") then
											local itemText = string.lower(titleLabel.Text)
											shouldShow = string.find(itemText, searchText) ~= nil
										end
									end
									
									element.Visible = shouldShow
								end
							end
						end
					end
				end
			end

			SearchBox:GetPropertyChangedSignal("Text"):Connect(UpdateSearch)

			-- قسم العناصر
			local Section = Instance.new("Frame")
			local SectionUICorner = Instance.new("UICorner")
			local SectionContainer = Instance.new("Frame")
			local SectionHeader = Instance.new("Frame")
			local HeaderUICorner = Instance.new("UICorner")
			local HeaderGradient = Instance.new("UIGradient")
			local ContainerUICorner = Instance.new("UICorner")
			local ContainerPadding = Instance.new("UIPadding")
			local ContainerListLayout = Instance.new("UIListLayout")

			Section.Name = "Section"
			Section.Parent = Page
			Section.BackgroundTransparency = 1
			Section.Size = UDim2.new(1, 0, 0, 100)

			SectionUICorner.CornerRadius = UDim.new(0, 4)
			SectionUICorner.Parent = Section

			SectionContainer.Name = "SectionContainer"
			SectionContainer.Parent = Section
			SectionContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
			SectionContainer.BorderSizePixel = 0
			SectionContainer.ClipsDescendants = true
			SectionContainer.Position = UDim2.new(0, 0, 0, 0)
			SectionContainer.Size = UDim2.new(1, 0, 1, -1)

			SectionHeader.Name = "Header"
			SectionHeader.Parent = Section
			SectionHeader.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
			SectionHeader.BorderSizePixel = 0
			SectionHeader.Size = UDim2.new(1, 0, 0, 8)

			HeaderUICorner.CornerRadius = UDim.new(0, 4)
			HeaderUICorner.Parent = SectionHeader

			HeaderGradient.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 0.75),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(1, 0.75)
			}
			HeaderGradient.Parent = SectionHeader

			ContainerUICorner.CornerRadius = UDim.new(0, 4)
			ContainerUICorner.Parent = SectionContainer

			ContainerPadding.Parent = SectionContainer
			ContainerPadding.PaddingBottom = UDim.new(0, 4)
			ContainerPadding.PaddingLeft = UDim.new(0, 4)
			ContainerPadding.PaddingRight = UDim.new(0, 4)
			ContainerPadding.PaddingTop = UDim.new(0, 4)

			ContainerListLayout.Parent = SectionContainer
			ContainerListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			ContainerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ContainerListLayout.Padding = UDim.new(0, 4)

			-- تحديث حجم القسم تلقائياً
			local function UpdateSectionSize()
				local totalHeight = 8 -- Header height
				for _, child in pairs(SectionContainer:GetChildren()) do
					if child:IsA("Frame") and child.Visible then
						totalHeight = totalHeight + child.AbsoluteSize.Y + 4
					end
				end
				Section.Size = UDim2.new(1, 0, 0, totalHeight)
			end

			SectionContainer.ChildAdded:Connect(UpdateSectionSize)
			SectionContainer.ChildRemoved:Connect(UpdateSectionSize)

			-- زر الصفحة
			local PageButton = Instance.new("TextButton")
			PageButton.Name = "PageButton"
			PageButton.Parent = TabsFrame
			PageButton.BackgroundTransparency = 1
			PageButton.Size = UDim2.new(1, -14, 0, 20)
			PageButton.Font = Enum.Font.Gotham
			PageButton.Text = pageName
			PageButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			PageButton.TextSize = 12
			PageButton.TextTransparency = 0.5
			PageButton.TextXAlignment = Enum.TextXAlignment.Left

			PageButton.MouseButton1Click:Connect(function()
				-- إخفاء جميع الصفحات
				for _, p in pairs(AllPages) do
					p.Visible = false
				end
				
				-- إظهار الصفحة الحالية
				Page.Visible = true
				CurrentPage = Page
				
				-- تحديث المؤشر
				if not Indicator.Visible then
					Indicator.Visible = true
				end
				
				TS:Create(Indicator, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
				task.wait(0.1)
				TS:Create(Indicator, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
				Indicator.Parent = PageButton
				
				-- تحديث شفافية الأزرار
				for _, btn in pairs(TabsFrame:GetChildren()) do
					if btn:IsA("TextButton") and btn.Name == "PageButton" then
						TS:Create(btn, TweenInfo.new(0.3), {TextTransparency = 0.5}):Play()
					end
				end
				TS:Create(PageButton, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
			end)

			-- عناصر الصفحة
			local Elements = {}

			-- دالة إنشاء تأثير Ripple
			local function CreateRipple(button)
				button.ClipsDescendants = true
				
				button.MouseButton1Click:Connect(function()
					local ripple = Instance.new("ImageLabel")
					ripple.Name = "Ripple"
					ripple.Parent = button
					ripple.BackgroundTransparency = 1
					ripple.Image = "rbxassetid://4560909609"
					ripple.ImageColor3 = Color3.fromRGB(135, 255, 135)
					ripple.ImageTransparency = 0.6
					ripple.ZIndex = 10
					
					local mouse = Players.LocalPlayer:GetMouse()
					local x = mouse.X - button.AbsolutePosition.X
					local y = mouse.Y - button.AbsolutePosition.Y
					
					ripple.Position = UDim2.new(0, x, 0, y)
					
					local size = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2
					
					TS:Create(ripple, TweenInfo.new(0.5), {
						Size = UDim2.new(0, size, 0, size),
						Position = UDim2.new(0, x - size/2, 0, y - size/2),
						ImageTransparency = 1
					}):Play()
					
					task.wait(0.5)
					ripple:Destroy()
				end)
			end

			-- زر
			function Elements:CreateButton(buttonName, buttonDesc, callback)
				buttonName = buttonName or "Button"
				buttonDesc = buttonDesc or "Description"
				callback = callback or function() end
				
				local Button = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local Description = Instance.new("TextLabel")
				local Caller = Instance.new("TextButton")

				Button.Name = "Button"
				Button.Parent = SectionContainer
				Button.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
				Button.Size = UDim2.new(1, 0, 0, 40)

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Button

				Title.Name = "Title"
				Title.Parent = Button
				Title.BackgroundTransparency = 1
				Title.Position = UDim2.new(0, 7, 0, 1)
				Title.Size = UDim2.new(1, -7, 0.5, 0)
				Title.Font = Enum.Font.GothamBold
				Title.Text = buttonName
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextSize = 12
				Title.TextXAlignment = Enum.TextXAlignment.Left

				Description.Name = "Description"
				Description.Parent = Button
				Description.BackgroundTransparency = 1
				Description.Position = UDim2.new(0, 7, 0.5, -1)
				Description.Size = UDim2.new(1, -7, 0.5, 0)
				Description.Font = Enum.Font.Gotham
				Description.Text = buttonDesc
				Description.TextColor3 = Color3.fromRGB(159, 159, 159)
				Description.TextSize = 12
				Description.TextXAlignment = Enum.TextXAlignment.Left

				Caller.Name = "Caller"
				Caller.Parent = Button
				Caller.BackgroundTransparency = 0.99
				Caller.Size = UDim2.new(1, 0, 1, 0)
				Caller.Font = Enum.Font.Gotham
				Caller.Text = ""
				Caller.TextTransparency = 1

				CreateRipple(Caller)
				
				Caller.MouseButton1Click:Connect(function()
					pcall(callback)
				end)

				UpdateSectionSize()
				
				return {
					SetTitle = function(self, newTitle)
						Title.Text = newTitle
					end,
					SetDescription = function(self, newDesc)
						Description.Text = newDesc
					end
				}
			end

			-- تبديل (Toggle)
			function Elements:CreateToggle(toggleName, toggleDesc, default, callback)
				toggleName = toggleName or "Toggle"
				toggleDesc = toggleDesc or "Description"
				default = default or false
				callback = callback or function() end
				
				local toggled = default
				
				local Toggle = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local Description = Instance.new("TextLabel")
				local ToggleButton = Instance.new("TextButton")
				local Indicator = Instance.new("Frame")
				local IndicatorCorner = Instance.new("UICorner")
				local UIStroke = Instance.new("UIStroke")
				local Dot = Instance.new("Frame")
				local DotCorner = Instance.new("UICorner")

				Toggle.Name = "Toggle"
				Toggle.Parent = SectionContainer
				Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
				Toggle.Size = UDim2.new(1, 0, 0, 40)

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Toggle

				Title.Name = "Title"
				Title.Parent = Toggle
				Title.BackgroundTransparency = 1
				Title.Position = UDim2.new(0, 7, 0, 1)
				Title.Size = UDim2.new(1, -40, 0.5, 0)
				Title.Font = Enum.Font.GothamBold
				Title.Text = toggleName
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextSize = 12
				Title.TextXAlignment = Enum.TextXAlignment.Left

				Description.Name = "Description"
				Description.Parent = Toggle
				Description.BackgroundTransparency = 1
				Description.Position = UDim2.new(0, 7, 0.5, -1)
				Description.Size = UDim2.new(1, -40, 0.5, 0)
				Description.Font = Enum.Font.Gotham
				Description.Text = toggleDesc
				Description.TextColor3 = Color3.fromRGB(159, 159, 159)
				Description.TextSize = 12
				Description.TextXAlignment = Enum.TextXAlignment.Left

				Indicator.Name = "Indicator"
				Indicator.Parent = Toggle
				Indicator.BackgroundTransparency = 1
				Indicator.Position = UDim2.new(1, -29, 0, 11)
				Indicator.Size = UDim2.new(0, 18, 0, 18)

				IndicatorCorner.CornerRadius = UDim.new(0.5, 0)
				IndicatorCorner.Parent = Indicator

				UIStroke.Parent = Indicator
				UIStroke.Color = Color3.fromRGB(135, 255, 135)
				UIStroke.Thickness = 2

				Dot.Name = "Dot"
				Dot.Parent = Indicator
				Dot.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
				Dot.BackgroundTransparency = default and 0 or 1
				Dot.Position = UDim2.new(0, 2, 0, 2)
				Dot.Size = UDim2.new(1, -4, 1, -4)

				DotCorner.CornerRadius = UDim.new(0.5, 0)
				DotCorner.Parent = Dot

				ToggleButton.Name = "ToggleButton"
				ToggleButton.Parent = Toggle
				ToggleButton.BackgroundTransparency = 0.99
				ToggleButton.Position = UDim2.new(1, -29, 0, 11)
				ToggleButton.Size = UDim2.new(0, 18, 0, 18)
				ToggleButton.Text = ""

				ToggleButton.MouseButton1Click:Connect(function()
					toggled = not toggled
					
					TS:Create(Dot, TweenInfo.new(0.2), {
						BackgroundTransparency = toggled and 0 or 1
					}):Play()
					
					pcall(function()
						callback(toggled)
					end)
				end)

				UpdateSectionSize()
				
				return {
					SetState = function(self, state)
						toggled = state
						TS:Create(Dot, TweenInfo.new(0.2), {
							BackgroundTransparency = toggled and 0 or 1
						}):Play()
						pcall(function()
							callback(toggled)
						end)
					end,
					GetState = function(self)
						return toggled
					end
				}
			end

			-- سلايدر (Slider)
			function Elements:CreateSlider(sliderName, min, max, default, callback)
				sliderName = sliderName or "Slider"
				min = min or 0
				max = max or 100
				default = default or min
				callback = callback or function() end
				
				local currentValue = default
				local dragging = false
				
				local Slider = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local SliderTrack = Instance.new("Frame")
				local SliderFill = Instance.new("Frame")
				local SliderButton = Instance.new("TextButton")
				local ButtonCorner = Instance.new("UICorner")
				local ValueLabel = Instance.new("Frame")
				local ValueCorner = Instance.new("UICorner")
				local ValueText = Instance.new("TextLabel")

				Slider.Name = "Slider"
				Slider.Parent = SectionContainer
				Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
				Slider.Size = UDim2.new(1, 0, 0, 40)

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Slider

				Title.Name = "Title"
				Title.Parent = Slider
				Title.BackgroundTransparency = 1
				Title.Position = UDim2.new(0, 7, 0, 0)
				Title.Size = UDim2.new(1, -60, 0, 20)
				Title.Font = Enum.Font.GothamBold
				Title.Text = sliderName
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextSize = 12
				Title.TextXAlignment = Enum.TextXAlignment.Left

				SliderTrack.Name = "Track"
				SliderTrack.Parent = Slider
				SliderTrack.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
				SliderTrack.BorderSizePixel = 0
				SliderTrack.Position = UDim2.new(0, 7, 1, -10)
				SliderTrack.Size = UDim2.new(1, -14, 0, 2)

				SliderFill.Name = "Fill"
				SliderFill.Parent = SliderTrack
				SliderFill.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
				SliderFill.BorderSizePixel = 0
				SliderFill.Size = UDim2.new(0, 0, 1, 0)

				SliderButton.Name = "Button"
				SliderButton.Parent = SliderFill
				SliderButton.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
				SliderButton.Position = UDim2.new(1, -4, 0.5, -4)
				SliderButton.Size = UDim2.new(0, 8, 0, 8)
				SliderButton.Text = ""

				ButtonCorner.CornerRadius = UDim.new(1, 0)
				ButtonCorner.Parent = SliderButton

				ValueLabel.Name = "ValueLabel"
				ValueLabel.Parent = Slider
				ValueLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				ValueLabel.BackgroundTransparency = 0.7
				ValueLabel.Position = UDim2.new(1, -50, 0, 2)
				ValueLabel.Size = UDim2.new(0, 43, 0, 18)

				ValueCorner.CornerRadius = UDim.new(0, 4)
				ValueCorner.Parent = ValueLabel

				ValueText.Name = "ValueText"
				ValueText.Parent = ValueLabel
				ValueText.BackgroundTransparency = 1
				ValueText.Size = UDim2.new(1, 0, 1, 0)
				ValueText.Font = Enum.Font.Gotham
				ValueText.Text = tostring(default)
				ValueText.TextColor3 = Color3.fromRGB(227, 225, 228)
				ValueText.TextSize = 11

				local function UpdateSlider(input)
					local pos = math.clamp(
						(input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X,
						0, 1
					)
					
					currentValue = math.floor(min + (max - min) * pos)
					
					TS:Create(SliderFill, TweenInfo.new(0.1), {
						Size = UDim2.new(pos, 0, 1, 0)
					}):Play()
					
					ValueText.Text = tostring(currentValue)
					
					pcall(function()
						callback(currentValue)
					end)
				end

				SliderButton.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
					end
				end)

				SliderButton.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)

				UIS.InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						UpdateSlider(input)
					end
				end)

				SliderTrack.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						UpdateSlider(input)
					end
				end)

				-- تعيين القيمة الافتراضية
				local defaultPos = (default - min) / (max - min)
				SliderFill.Size = UDim2.new(defaultPos, 0, 1, 0)

				UpdateSectionSize()
				
				return {
					SetValue = function(self, value)
						currentValue = math.clamp(value, min, max)
						local pos = (currentValue - min) / (max - min)
						TS:Create(SliderFill, TweenInfo.new(0.2), {
							Size = UDim2.new(pos, 0, 1, 0)
						}):Play()
						ValueText.Text = tostring(currentValue)
						pcall(function()
							callback(currentValue)
						end)
					end,
					GetValue = function(self)
						return currentValue
					end
				}
			end

			-- صندوق نص (TextBox)
			function Elements:CreateTextBox(placeholder, icon, callback)
				placeholder = placeholder or "أدخل النص هنا..."
				icon = icon or 10045753138
				callback = callback or function() end
				
				local TextBoxFrame = Instance.new("Frame")
				local Footer = Instance.new("Frame")
				local FooterCorner = Instance.new("UICorner")
				local Container = Instance.new("Frame")
				local ContainerCorner = Instance.new("UICorner")
				local TextInput = Instance.new("TextBox")
				local Icon = Instance.new("ImageLabel")

				TextBoxFrame.Name = "TextBox"
				TextBoxFrame.Parent = SectionContainer
				TextBoxFrame.BackgroundTransparency = 1
				TextBoxFrame.Size = UDim2.new(1, 0, 0, 30)

				Footer.Name = "Footer"
				Footer.Parent = TextBoxFrame
				Footer.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
				Footer.BackgroundTransparency = 0.75
				Footer.Position = UDim2.new(0, 0, 1, -8)
				Footer.Size = UDim2.new(1, 0, 0, 8)

				FooterCorner.CornerRadius = UDim.new(0, 4)
				FooterCorner.Parent = Footer

				Container.Name = "Container"
				Container.Parent = TextBoxFrame
				Container.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
				Container.BorderSizePixel = 0
				Container.Size = UDim2.new(1, 0, 1, -1)

				ContainerCorner.CornerRadius = UDim.new(0, 4)
				ContainerCorner.Parent = Container

				TextInput.Name = "TextInput"
				TextInput.Parent = Container
				TextInput.BackgroundTransparency = 1
				TextInput.Position = UDim2.new(0, 30, 0, 0)
				TextInput.Size = UDim2.new(1, -30, 1, 0)
				TextInput.Font = Enum.Font.Gotham
				TextInput.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
				TextInput.PlaceholderText = placeholder
				TextInput.Text = ""
				TextInput.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextInput.TextSize = 12
				TextInput.TextXAlignment = Enum.TextXAlignment.Left

				Icon.Name = "Icon"
				Icon.Parent = Container
				Icon.BackgroundTransparency = 1
				Icon.Position = UDim2.new(0, 6, 0, 6)
				Icon.Size = UDim2.new(0, 18, 0, 18)
				Icon.Image = "rbxassetid://" .. icon
				Icon.ImageColor3 = Color3.fromRGB(135, 255, 135)

				TextInput.FocusLost:Connect(function(enterPressed)
					if enterPressed then
						pcall(function()
							callback(TextInput.Text)
						end)
					end
				end)

				UpdateSectionSize()
				
				return {
					SetText = function(self, text)
						TextInput.Text = text
					end,
					GetText = function(self)
						return TextInput.Text
					end,
					Clear = function(self)
						TextInput.Text = ""
					end
				}
			end

			-- اختصار لوحة المفاتيح (Keybind)
			function Elements:CreateKeybind(keybindName, defaultKey, callback)
				keybindName = keybindName or "Keybind"
				defaultKey = defaultKey or "None"
				callback = callback or function() end
				
				local currentKey = defaultKey
				local listening = false
				
				local Keybind = Instance.new("Frame")
				local Footer = Instance.new("Frame")
				local FooterCorner = Instance.new("UICorner")
				local Container = Instance.new("Frame")
				local ContainerCorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local KeyButton = Instance.new("TextButton")
				local KeyButtonCorner = Instance.new("UICorner")

				Keybind.Name = "Keybind"
				Keybind.Parent = SectionContainer
				Keybind.BackgroundTransparency = 1
				Keybind.Size = UDim2.new(1, 0, 0, 30)

				Footer.Name = "Footer"
				Footer.Parent = Keybind
				Footer.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
				Footer.BackgroundTransparency = 0.75
				Footer.Position = UDim2.new(0, 0, 1, -8)
				Footer.Size = UDim2.new(1, 0, 0, 8)

				FooterCorner.CornerRadius = UDim.new(0, 4)
				FooterCorner.Parent = Footer

				Container.Name = "Container"
				Container.Parent = Keybind
				Container.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
				Container.BorderSizePixel = 0
				Container.Size = UDim2.new(1, 0, 1, -1)

				ContainerCorner.CornerRadius = UDim.new(0, 4)
				ContainerCorner.Parent = Container

				Title.Name = "Title"
				Title.Parent = Container
				Title.BackgroundTransparency = 1
				Title.Position = UDim2.new(0, 7, 0, 0)
				Title.Size = UDim2.new(0, 100, 1, 0)
				Title.Font = Enum.Font.GothamBold
				Title.Text = keybindName
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextSize = 12
				Title.TextXAlignment = Enum.TextXAlignment.Left

				KeyButton.Name = "KeyButton"
				KeyButton.Parent = Container
				KeyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				KeyButton.BackgroundTransparency = 0.7
				KeyButton.Position = UDim2.new(1, -80, 0, 4)
				KeyButton.Size = UDim2.new(0, 72, 0, 22)
				KeyButton.Font = Enum.Font.Gotham
				KeyButton.Text = defaultKey
				KeyButton.TextColor3 = Color3.fromRGB(227, 225, 228)
				KeyButton.TextSize = 11

				KeyButtonCorner.CornerRadius = UDim.new(0, 4)
				KeyButtonCorner.Parent = KeyButton

				CreateRipple(KeyButton)

				KeyButton.MouseButton1Click:Connect(function()
					if not listening then
						listening = true
						KeyButton.Text = "..."
						
						local connection
						connection = UIS.InputBegan:Connect(function(input, gameProcessed)
							if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
								currentKey = input.KeyCode.Name
								KeyButton.Text = currentKey
								listening = false
								connection:Disconnect()
							end
						end)
					end
				end)

				UIS.InputBegan:Connect(function(input, gameProcessed)
					if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
						if input.KeyCode.Name == currentKey then
							pcall(callback)
						end
					end
				end)

				UpdateSectionSize()
				
				return {
					SetKey = function(self, key)
						currentKey = key
						KeyButton.Text = key
					end,
					GetKey = function(self)
						return currentKey
					end
				}
			end

			-- تسمية (Label)
			function Elements:CreateLabel(labelText)
				labelText = labelText or "Label"
				
				local Label = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Shadow = Instance.new("ImageLabel")
				local LabelContent = Instance.new("TextLabel")

				Label.Name = "Label"
				Label.Parent = SectionContainer
				Label.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
				Label.BackgroundTransparency = 0.5
				Label.Size = UDim2.new(1, 0, 0, 24)

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Label

				Shadow.Name = "Shadow"
				Shadow.Parent = Label
				Shadow.BackgroundTransparency = 1
				Shadow.Position = UDim2.new(0, -15, 0, -15)
				Shadow.Size = UDim2.new(1, 30, 1, 30)
				Shadow.Image = "rbxassetid://5761504593"
				Shadow.ImageColor3 = Color3.fromRGB(135, 255, 135)
				Shadow.ImageTransparency = 0.7
				Shadow.ScaleType = Enum.ScaleType.Slice
				Shadow.SliceCenter = Rect.new(17, 17, 283, 283)

				LabelContent.Name = "LabelContent"
				LabelContent.Parent = Label
				LabelContent.BackgroundTransparency = 1
				LabelContent.Position = UDim2.new(0, 7, 0, 0)
				LabelContent.Size = UDim2.new(1, -7, 1, 0)
				LabelContent.Font = Enum.Font.Gotham
				LabelContent.Text = labelText
				LabelContent.TextColor3 = Color3.fromRGB(255, 255, 255)
				LabelContent.TextSize = 12
				LabelContent.TextXAlignment = Enum.TextXAlignment.Left

				UpdateSectionSize()
				
				return {
					SetText = function(self, text)
						LabelContent.Text = text
					end
				}
			end

			return Elements
		end

		return Pages
	end

	return Tabs
end

-- إشعارات
function DrakthonLib:CreateNotification(title, message, duration, callback)
	title = title or "إشعار"
	message = message or "رسالة"
	duration = duration or 3
	callback = callback or function() end
	
	local Notification = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Shadow = Instance.new("ImageLabel")
	local TitleBar = Instance.new("Frame")
	local TitleBarCorner = Instance.new("UICorner")
	local TitleLabel = Instance.new("TextLabel")
	local Corners = Instance.new("Frame")
	local MessageLabel = Instance.new("TextLabel")
	local AcceptButton = Instance.new("Frame")
	local AcceptCorner = Instance.new("UICorner")
	local AcceptShadow = Instance.new("ImageLabel")
	local YesButton = Instance.new("ImageButton")
	local DeclineButton = Instance.new("Frame")
	local DeclineCorner = Instance.new("UICorner")
	local DeclineShadow = Instance.new("ImageLabel")
	local NoButton = Instance.new("ImageButton")

	Notification.Name = GenerateRandomString()
	Notification.Parent = CoreGui
	Notification.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Frame.Parent = Notification
	Frame.BackgroundColor3 = Color3.fromRGB(49, 49, 59)
	Frame.Position = UDim2.new(1.25, -390, 1, -100)
	Frame.Size = UDim2.new(0, 344, 0, 64)

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = Frame

	Shadow.Name = "Shadow"
	Shadow.Parent = Frame
	Shadow.BackgroundTransparency = 1
	Shadow.Position = UDim2.new(0, -15, 0, -15)
	Shadow.Size = UDim2.new(1, 30, 1, 30)
	Shadow.Image = "rbxassetid://5761504593"
	Shadow.ImageColor3 = Color3.fromRGB(135, 255, 135)
	Shadow.ImageTransparency = 0.3
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(17, 17, 283, 283)

	TitleBar.Name = "TitleBar"
	TitleBar.Parent = Frame
	TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
	TitleBar.Size = UDim2.new(1, 0, 0, 22)

	TitleBarCorner.CornerRadius = UDim.new(0, 4)
	TitleBarCorner.Parent = TitleBar

	TitleLabel.Name = "Title"
	TitleLabel.Parent = TitleBar
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Size = UDim2.new(1, 0, 1, 0)
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.Text = title
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextSize = 14

	Corners.Name = "Corners"
	Corners.Parent = TitleBar
	Corners.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
	Corners.Position = UDim2.new(0, 0, 0.8, 0)
	Corners.Size = UDim2.new(1, 0, 0, 6)

	MessageLabel.Parent = Frame
	MessageLabel.BackgroundTransparency = 1
	MessageLabel.Position = UDim2.new(0, 10, 0.35, 0)
	MessageLabel.Size = UDim2.new(1, -20, 0.65, -5)
	MessageLabel.Font = Enum.Font.Gotham
	MessageLabel.Text = message
	MessageLabel.TextColor3 = Color3.fromRGB(222, 222, 222)
	MessageLabel.TextSize = 12
	MessageLabel.TextWrapped = true
	MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
	MessageLabel.TextYAlignment = Enum.TextYAlignment.Top

	AcceptButton.Name = "Accept"
	AcceptButton.Parent = Frame
	AcceptButton.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
	AcceptButton.Position = UDim2.new(1.02, 0, 0, 0)
	AcceptButton.Size = UDim2.new(0, 33, 0, 28)

	AcceptCorner.CornerRadius = UDim.new(0, 4)
	AcceptCorner.Parent = AcceptButton

	AcceptShadow.Name = "Shadow"
	AcceptShadow.Parent = AcceptButton
	AcceptShadow.BackgroundTransparency = 1
	AcceptShadow.Position = UDim2.new(0, -15, 0, -15)
	AcceptShadow.Size = UDim2.new(1, 30, 1, 30)
	AcceptShadow.Image = "rbxassetid://5761504593"
	AcceptShadow.ImageColor3 = Color3.fromRGB(135, 255, 135)
	AcceptShadow.ImageTransparency = 0.3
	AcceptShadow.ScaleType = Enum.ScaleType.Slice
	AcceptShadow.SliceCenter = Rect.new(17, 17, 283, 283)

	YesButton.Name = "Yes"
	YesButton.Parent = AcceptButton
	YesButton.BackgroundTransparency = 1
	YesButton.Position = UDim2.new(0.1, 0, 0.1, 0)
	YesButton.Size = UDim2.new(0, 25, 0, 25)
	YesButton.Image = "rbxassetid://3926305904"
	YesButton.ImageColor3 = Color3.fromRGB(68, 255, 47)
	YesButton.ImageRectOffset = Vector2.new(644, 204)
	YesButton.ImageRectSize = Vector2.new(36, 36)

	DeclineButton.Name = "Decline"
	DeclineButton.Parent = Frame
	DeclineButton.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
	DeclineButton.Position = UDim2.new(1.02, 0, 0.56, 0)
	DeclineButton.Size = UDim2.new(0, 33, 0, 28)

	DeclineCorner.CornerRadius = UDim.new(0, 4)
	DeclineCorner.Parent = DeclineButton

	DeclineShadow.Name = "Shadow"
	DeclineShadow.Parent = DeclineButton
	DeclineShadow.BackgroundTransparency = 1
	DeclineShadow.Position = UDim2.new(0, -15, 0, -15)
	DeclineShadow.Size = UDim2.new(1, 30, 1, 30)
	DeclineShadow.Image = "rbxassetid://5761504593"
	DeclineShadow.ImageColor3 = Color3.fromRGB(135, 255, 135)
	DeclineShadow.ImageTransparency = 0.3
	DeclineShadow.ScaleType = Enum.ScaleType.Slice
	DeclineShadow.SliceCenter = Rect.new(17, 17, 283, 283)

	NoButton.Name = "No"
	NoButton.Parent = DeclineButton
	NoButton.BackgroundTransparency = 1
	NoButton.Position = UDim2.new(0.1, 0, 0.1, 0)
	NoButton.Size = UDim2.new(0, 25, 0, 25)
	NoButton.Image = "rbxassetid://3926305904"
	NoButton.ImageColor3 = Color3.fromRGB(255, 26, 26)
	NoButton.ImageRectOffset = Vector2.new(924, 724)
	NoButton.ImageRectSize = Vector2.new(36, 36)

	-- تحريك الإشعار
	TS:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.new(1, -390, 1, -100)
	}):Play()

	-- صوت
	pcall(function()
		local sound = Instance.new("Sound", game:GetService("SoundService"))
		sound.SoundId = "rbxassetid://1788243907"
		sound:Play()
		task.delay(2, function()
			sound:Destroy()
		end)
	end)

	local function Close(result)
		TS:Create(Frame, TweenInfo.new(0.3), {
			Position = UDim2.new(1.25, -390, 1, -100)
		}):Play()
		task.wait(0.3)
		Notification:Destroy()
		pcall(function()
			callback(result)
		end)
	end

	YesButton.MouseButton1Click:Connect(function()
		Close(true)
	end)

	NoButton.MouseButton1Click:Connect(function()
		Close(false)
	end)

	if duration > 0 then
		task.delay(duration, function()
			if Notification.Parent then
				Close(nil)
			end
		end)
	end
end

return DrakthonLib
