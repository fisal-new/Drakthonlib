--[[
    ════════════════════════════════════════════════════════════════════════════
    🎨 Drakthon Theme System V2.1
    GitHub: https://github.com/fisal-new/Drakthonlib/blob/main/Theme.lua
    ════════════════════════════════════════════════════════════════════════════
]]

local ThemeManager = {
    CurrentTheme = "Ocean",
    Elements = {},
    Themes = {}
}

--[[
    ════════════════════════════════════════════════════════════════════════════
    📦 ALL THEMES
    ════════════════════════════════════════════════════════════════════════════
]]

ThemeManager.Themes = {
    Default = {
        Name = "Default",
        BG = Color3.fromRGB(15, 15, 20),
        BG2 = Color3.fromRGB(20, 20, 28),
        BG3 = Color3.fromRGB(25, 25, 35),
        Accent = Color3.fromRGB(138, 43, 226),
        Accent2 = Color3.fromRGB(75, 0, 130),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(180, 180, 190),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Ocean = {
        Name = "Ocean",
        BG = Color3.fromRGB(12, 18, 28),
        BG2 = Color3.fromRGB(16, 23, 36),
        BG3 = Color3.fromRGB(20, 28, 44),
        Accent = Color3.fromRGB(0, 149, 255),
        Accent2 = Color3.fromRGB(0, 119, 204),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(160, 180, 200),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Crimson = {
        Name = "Crimson",
        BG = Color3.fromRGB(18, 12, 15),
        BG2 = Color3.fromRGB(25, 16, 20),
        BG3 = Color3.fromRGB(32, 20, 26),
        Accent = Color3.fromRGB(220, 20, 60),
        Accent2 = Color3.fromRGB(178, 16, 48),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(200, 180, 190),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Emerald = {
        Name = "Emerald",
        BG = Color3.fromRGB(12, 20, 15),
        BG2 = Color3.fromRGB(16, 26, 20),
        BG3 = Color3.fromRGB(20, 32, 25),
        Accent = Color3.fromRGB(46, 204, 113),
        Accent2 = Color3.fromRGB(39, 174, 96),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(180, 200, 190),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Dark = {
        Name = "Dark",
        BG = Color3.fromRGB(10, 10, 10),
        BG2 = Color3.fromRGB(15, 15, 15),
        BG3 = Color3.fromRGB(20, 20, 20),
        Accent = Color3.fromRGB(100, 100, 100),
        Accent2 = Color3.fromRGB(80, 80, 80),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(180, 180, 180),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Light = {
        Name = "Light",
        BG = Color3.fromRGB(240, 242, 245),
        BG2 = Color3.fromRGB(255, 255, 255),
        BG3 = Color3.fromRGB(230, 235, 240),
        Accent = Color3.fromRGB(88, 101, 242),
        Accent2 = Color3.fromRGB(71, 82, 196),
        Text = Color3.fromRGB(30, 30, 30),
        Text2 = Color3.fromRGB(80, 80, 80),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Sunset = {
        Name = "Sunset",
        BG = Color3.fromRGB(20, 15, 18),
        BG2 = Color3.fromRGB(28, 20, 25),
        BG3 = Color3.fromRGB(35, 25, 30),
        Accent = Color3.fromRGB(255, 94, 77),
        Accent2 = Color3.fromRGB(255, 121, 63),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(200, 180, 190),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Aqua = {
        Name = "Aqua",
        BG = Color3.fromRGB(12, 20, 20),
        BG2 = Color3.fromRGB(16, 26, 26),
        BG3 = Color3.fromRGB(20, 32, 32),
        Accent = Color3.fromRGB(26, 188, 156),
        Accent2 = Color3.fromRGB(22, 160, 133),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(180, 200, 200),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Purple = {
        Name = "Purple",
        BG = Color3.fromRGB(18, 12, 25),
        BG2 = Color3.fromRGB(24, 16, 33),
        BG3 = Color3.fromRGB(30, 20, 41),
        Accent = Color3.fromRGB(155, 89, 182),
        Accent2 = Color3.fromRGB(142, 68, 173),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(200, 180, 210),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Cherry = {
        Name = "Cherry",
        BG = Color3.fromRGB(20, 12, 15),
        BG2 = Color3.fromRGB(28, 16, 21),
        BG3 = Color3.fromRGB(35, 20, 27),
        Accent = Color3.fromRGB(255, 82, 82),
        Accent2 = Color3.fromRGB(255, 56, 56),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(200, 180, 190),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Midnight = {
        Name = "Midnight",
        BG = Color3.fromRGB(8, 8, 12),
        BG2 = Color3.fromRGB(12, 12, 18),
        BG3 = Color3.fromRGB(16, 16, 24),
        Accent = Color3.fromRGB(56, 103, 214),
        Accent2 = Color3.fromRGB(38, 70, 146),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(160, 170, 190),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Forest = {
        Name = "Forest",
        BG = Color3.fromRGB(10, 15, 10),
        BG2 = Color3.fromRGB(15, 22, 15),
        BG3 = Color3.fromRGB(20, 28, 20),
        Accent = Color3.fromRGB(34, 139, 34),
        Accent2 = Color3.fromRGB(0, 100, 0),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(180, 200, 180),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    }
}

--[[
    ════════════════════════════════════════════════════════════════════════════
    🔧 THEME FUNCTIONS
    ════════════════════════════════════════════════════════════════════════════
]]

function ThemeManager:GetColor(colorName)
    local theme = self.Themes[self.CurrentTheme]
    return theme and theme[colorName] or Color3.fromRGB(255, 255, 255)
end

function ThemeManager:Set(themeName)
    if not self.Themes[themeName] then 
        warn("❌ Theme '" .. themeName .. "' not found!")
        return false 
    end
    
    self.CurrentTheme = themeName
    self:UpdateAllElements()
    print("✅ Theme changed to: " .. themeName)
    return true
end

function ThemeManager:Get()
    return self.CurrentTheme
end

function ThemeManager:List()
    local list = {}
    for name, _ in pairs(self.Themes) do
        table.insert(list, name)
    end
    table.sort(list)
    return list
end

function ThemeManager:Random()
    local themes = self:List()
    local randomTheme = themes[math.random(1, #themes)]
    self:Set(randomTheme)
    return randomTheme
end

function ThemeManager:Register(element, colorType, colorName)
    if not element then return end
    
    table.insert(self.Elements, {
        Element = element,
        Type = colorType,
        ColorName = colorName
    })
    
    -- Apply color immediately
    self:UpdateElement(element, colorType, colorName)
end

function ThemeManager:UpdateElement(element, colorType, colorName)
    if not element or not element.Parent then return end
    
    pcall(function()
        local color = self:GetColor(colorName)
        
        if colorType == "Color" or colorType == "BackgroundColor3" then
            element.BackgroundColor3 = color
        elseif colorType == "TextColor" or colorType == "TextColor3" then
            element.TextColor3 = color
        elseif colorType == "ImageColor" or colorType == "ImageColor3" then
            element.ImageColor3 = color
        elseif colorType == "Gradient" then
            element.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, self:GetColor("Accent")),
                ColorSequenceKeypoint.new(1, self:GetColor("Accent2"))
            }
        end
    end)
end

function ThemeManager:UpdateAllElements()
    for i, data in ipairs(self.Elements) do
        if data.Element and data.Element.Parent then
            self:UpdateElement(data.Element, data.Type, data.ColorName)
        else
            -- Remove dead elements
            table.remove(self.Elements, i)
        end
    end
end

function ThemeManager:Gradient()
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, self:GetColor("Accent")),
        ColorSequenceKeypoint.new(1, self:GetColor("Accent2"))
    }
    self:Register(gradient, "Gradient", "Accent")
    return gradient
end

-- Shorthand Functions
function ThemeManager.BG() return ThemeManager:GetColor("BG") end
function ThemeManager.BG2() return ThemeManager:GetColor("BG2") end
function ThemeManager.BG3() return ThemeManager:GetColor("BG3") end
function ThemeManager.Accent() return ThemeManager:GetColor("Accent") end
function ThemeManager.Accent2() return ThemeManager:GetColor("Accent2") end
function ThemeManager.Text() return ThemeManager:GetColor("Text") end
function ThemeManager.Text2() return ThemeManager:GetColor("Text2") end
function ThemeManager.Green() return ThemeManager:GetColor("Green") end
function ThemeManager.Red() return ThemeManager:GetColor("Red") end
function ThemeManager.Yellow() return ThemeManager:GetColor("Yellow") end
function ThemeManager.Blue() return ThemeManager:GetColor("Blue") end

return ThemeManager
