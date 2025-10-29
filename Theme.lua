--[[
    🎨 Drakthon Theme System V2
    Simple, Clean, Powerful
]]

local ThemeSystem = {}

-- 🎨 Built-in Themes
local Themes = {
    Default = {
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
        BG = Color3.fromRGB(10, 15, 25),
        BG2 = Color3.fromRGB(15, 20, 30),
        BG3 = Color3.fromRGB(20, 25, 35),
        Accent = Color3.fromRGB(0, 149, 255),
        Accent2 = Color3.fromRGB(0, 100, 200),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(180, 190, 200),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Crimson = {
        BG = Color3.fromRGB(20, 10, 10),
        BG2 = Color3.fromRGB(28, 15, 15),
        BG3 = Color3.fromRGB(35, 20, 20),
        Accent = Color3.fromRGB(220, 20, 60),
        Accent2 = Color3.fromRGB(150, 10, 40),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(200, 180, 180),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Emerald = {
        BG = Color3.fromRGB(10, 20, 15),
        BG2 = Color3.fromRGB(15, 25, 20),
        BG3 = Color3.fromRGB(20, 30, 25),
        Accent = Color3.fromRGB(46, 204, 113),
        Accent2 = Color3.fromRGB(30, 150, 80),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(180, 200, 190),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Dark = {
        BG = Color3.fromRGB(10, 10, 10),
        BG2 = Color3.fromRGB(18, 18, 18),
        BG3 = Color3.fromRGB(25, 25, 25),
        Accent = Color3.fromRGB(255, 255, 255),
        Accent2 = Color3.fromRGB(200, 200, 200),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(150, 150, 150),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Light = {
        BG = Color3.fromRGB(245, 245, 250),
        BG2 = Color3.fromRGB(235, 235, 240),
        BG3 = Color3.fromRGB(225, 225, 230),
        Accent = Color3.fromRGB(138, 43, 226),
        Accent2 = Color3.fromRGB(75, 0, 130),
        Text = Color3.fromRGB(30, 30, 35),
        Text2 = Color3.fromRGB(100, 100, 110),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Cherry = {
        BG = Color3.fromRGB(25, 15, 20),
        BG2 = Color3.fromRGB(30, 20, 25),
        BG3 = Color3.fromRGB(35, 25, 30),
        Accent = Color3.fromRGB(255, 105, 180),
        Accent2 = Color3.fromRGB(219, 39, 119),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(200, 180, 190),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Sunset = {
        BG = Color3.fromRGB(20, 15, 10),
        BG2 = Color3.fromRGB(25, 20, 15),
        BG3 = Color3.fromRGB(30, 25, 20),
        Accent = Color3.fromRGB(255, 140, 0),
        Accent2 = Color3.fromRGB(255, 69, 0),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(200, 190, 180),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Aqua = {
        BG = Color3.fromRGB(10, 20, 20),
        BG2 = Color3.fromRGB(15, 25, 25),
        BG3 = Color3.fromRGB(20, 30, 30),
        Accent = Color3.fromRGB(0, 255, 255),
        Accent2 = Color3.fromRGB(0, 150, 150),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(180, 200, 200),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Midnight = {
        BG = Color3.fromRGB(12, 8, 20),
        BG2 = Color3.fromRGB(18, 12, 28),
        BG3 = Color3.fromRGB(24, 16, 35),
        Accent = Color3.fromRGB(147, 51, 234),
        Accent2 = Color3.fromRGB(88, 28, 135),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(190, 180, 200),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Fire = {
        BG = Color3.fromRGB(20, 10, 5),
        BG2 = Color3.fromRGB(28, 15, 10),
        BG3 = Color3.fromRGB(35, 20, 15),
        Accent = Color3.fromRGB(255, 69, 0),
        Accent2 = Color3.fromRGB(220, 20, 60),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(200, 180, 170),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Matrix = {
        BG = Color3.fromRGB(5, 10, 5),
        BG2 = Color3.fromRGB(10, 15, 10),
        BG3 = Color3.fromRGB(15, 20, 15),
        Accent = Color3.fromRGB(0, 255, 65),
        Accent2 = Color3.fromRGB(0, 180, 45),
        Text = Color3.fromRGB(0, 255, 65),
        Text2 = Color3.fromRGB(0, 180, 45),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Rainbow = {
        BG = Color3.fromRGB(15, 15, 20),
        BG2 = Color3.fromRGB(20, 20, 28),
        BG3 = Color3.fromRGB(25, 25, 35),
        Accent = Color3.fromRGB(255, 0, 255),
        Accent2 = Color3.fromRGB(0, 255, 255),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(180, 180, 190),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Galaxy = {
        BG = Color3.fromRGB(8, 5, 15),
        BG2 = Color3.fromRGB(15, 10, 25),
        BG3 = Color3.fromRGB(20, 15, 30),
        Accent = Color3.fromRGB(138, 43, 226),
        Accent2 = Color3.fromRGB(75, 0, 130),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(180, 180, 200),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(138, 43, 226)
    },
    
    Grape = {
        BG = Color3.fromRGB(18, 10, 25),
        BG2 = Color3.fromRGB(25, 15, 35),
        BG3 = Color3.fromRGB(30, 20, 40),
        Accent = Color3.fromRGB(147, 51, 234),
        Accent2 = Color3.fromRGB(109, 40, 217),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(190, 180, 200),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(147, 51, 234)
    },
    
    Gold = {
        BG = Color3.fromRGB(20, 18, 10),
        BG2 = Color3.fromRGB(28, 25, 15),
        BG3 = Color3.fromRGB(35, 30, 20),
        Accent = Color3.fromRGB(255, 215, 0),
        Accent2 = Color3.fromRGB(218, 165, 32),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(200, 190, 180),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Rose = {
        BG = Color3.fromRGB(22, 12, 15),
        BG2 = Color3.fromRGB(30, 18, 22),
        BG3 = Color3.fromRGB(38, 24, 28),
        Accent = Color3.fromRGB(255, 20, 147),
        Accent2 = Color3.fromRGB(199, 21, 133),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(200, 180, 190),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    },
    
    Neon = {
        BG = Color3.fromRGB(8, 8, 12),
        BG2 = Color3.fromRGB(15, 15, 20),
        BG3 = Color3.fromRGB(22, 22, 28),
        Accent = Color3.fromRGB(0, 255, 127),
        Accent2 = Color3.fromRGB(57, 255, 20),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(180, 200, 190),
        Green = Color3.fromRGB(0, 255, 127),
        Red = Color3.fromRGB(255, 0, 127),
        Yellow = Color3.fromRGB(255, 255, 0),
        Blue = Color3.fromRGB(0, 191, 255)
    },
    
    Ice = {
        BG = Color3.fromRGB(12, 18, 22),
        BG2 = Color3.fromRGB(18, 25, 30),
        BG3 = Color3.fromRGB(24, 32, 38),
        Accent = Color3.fromRGB(135, 206, 250),
        Accent2 = Color3.fromRGB(70, 130, 180),
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(180, 200, 210),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(135, 206, 250)
    },
    
    Void = {
        BG = Color3.fromRGB(5, 5, 8),
        BG2 = Color3.fromRGB(10, 10, 15),
        BG3 = Color3.fromRGB(15, 15, 22),
        Accent = Color3.fromRGB(75, 0, 130),
        Accent2 = Color3.fromRGB(138, 43, 226),
        Text = Color3.fromRGB(200, 200, 220),
        Text2 = Color3.fromRGB(150, 150, 170),
        Green = Color3.fromRGB(46, 204, 113),
        Red = Color3.fromRGB(231, 76, 60),
        Yellow = Color3.fromRGB(241, 196, 15),
        Blue = Color3.fromRGB(52, 152, 219)
    }
}

-- Custom Themes Storage
local CustomThemes = {}

-- Current Theme
local Current = Themes.Default

-- Callbacks
local Callbacks = {}

-- Set Theme
function ThemeSystem.Set(name)
    local theme = Themes[name] or CustomThemes[name]
    if not theme then
        warn("[Theme] Not found: " .. tostring(name))
        return false
    end
    
    Current = theme
    
    for _, callback in ipairs(Callbacks) do
        task.spawn(callback, theme)
    end
    
    return true
end

-- Get Current Theme
function ThemeSystem.Get()
    return Current
end

-- Get Color
function ThemeSystem.Color(name)
    return Current[name] or Color3.new(1, 1, 1)
end

-- List Theme Names
function ThemeSystem.List()
    local list = {}
    for name in pairs(Themes) do
        table.insert(list, name)
    end
    for name in pairs(CustomThemes) do
        table.insert(list, name)
    end
    return list
end

-- Add Custom Theme
function ThemeSystem.Add(name, theme)
    if type(theme) ~= "table" then return false end
    
    -- Validate colors
    local required = {"BG", "BG2", "BG3", "Accent", "Accent2", "Text", "Text2", "Green", "Red", "Yellow", "Blue"}
    for _, key in ipairs(required) do
        if not theme[key] then
            warn("[Theme] Missing color: " .. key)
            return false
        end
    end
    
    CustomThemes[name] = theme
    return true
end

-- Remove Custom Theme
function ThemeSystem.Remove(name)
    if CustomThemes[name] then
        CustomThemes[name] = nil
        return true
    end
    return false
end

-- Random Theme
function ThemeSystem.Random()
    local list = ThemeSystem.List()
    local random = list[math.random(#list)]
    ThemeSystem.Set(random)
    return random
end

-- On Theme Change Callback
function ThemeSystem.OnChange(callback)
    if type(callback) == "function" then
        table.insert(Callbacks, callback)
    end
end

-- Create Gradient
function ThemeSystem.Gradient(reverse)
    local gradient = Instance.new("UIGradient")
    if reverse then
        gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Current.Accent2),
            ColorSequenceKeypoint.new(1, Current.Accent)
        }
    else
        gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Current.Accent),
            ColorSequenceKeypoint.new(1, Current.Accent2)
        }
    end
    return gradient
end

-- Quick Color Access
ThemeSystem.BG = function() return Current.BG end
ThemeSystem.BG2 = function() return Current.BG2 end
ThemeSystem.BG3 = function() return Current.BG3 end
ThemeSystem.Accent = function() return Current.Accent end
ThemeSystem.Accent2 = function() return Current.Accent2 end
ThemeSystem.Text = function() return Current.Text end
ThemeSystem.Text2 = function() return Current.Text2 end
ThemeSystem.Green = function() return Current.Green end
ThemeSystem.Red = function() return Current.Red end
ThemeSystem.Yellow = function() return Current.Yellow end
ThemeSystem.Blue = function() return Current.Blue end

-- Export
ThemeSystem.Themes = Themes
ThemeSystem.Custom = CustomThemes
ThemeSystem.Current = Current

return ThemeSystem
