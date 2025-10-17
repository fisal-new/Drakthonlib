(Keywords don't Care)
Drakthonlib is a powerful, feature-rich, and easy-to-use Graphical User Interface (GUI) library for Roblox, written in Luau. It is designed to enable developers to rapidly create clean, modern, and interactive user interfaces for their projects, scripts, or exploits.

With a focus on simplicity and a rich component set, Drakthonlib abstracts away the complexities of Roblox's UI elements, providing a streamlined and developer-friendly API.

Features
Modern, Draggable Windows: Create multiple, independent windows that users can move around the screen.
Extensive Component Library: A wide variety of elements to build any UI you need:
Buttons
Toggles (Switches)
Sliders
Labels
Dropdown Menus
Text Input Boxes
Advanced Color Pickers
Hierarchical Organization: Use Folders to group and organize elements within a window for a clean and structured layout.
Robust Theming System: Easily customize the look and feel of your entire UI with a single line of code. Comes with 10 pre-built themes.
Built-in Notification System: Display temporary, non-intrusive notifications to the user.
Developer-Friendly API: A simple, consistent, and chainable API that is easy to learn and master.
Installation
To use Drakthonlib in your script, you must load it from its source using loadstring and game:HttpGet.

Lua

local Drakthonlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/fisal-new/Drakthonlib/refs/heads/main/Lib.lua"))()
Quick Start
Here is a basic example to get you up and running in less than a minute. This code creates a window with a button and a toggle.

Lua

-- Load the library
local Drakthonlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/fisal-new/Drakthonlib/refs/heads/main/Lib.lua"))()

-- Create a new window with the title "My UI"
local Window = Drakthonlib:CreateWindow("My UI")

-- Add a button that shows a notification when clicked
Window:CreateButton("Click for Notification", function()
    Drakthonlib:Notify("Button Clicked!", "You have successfully clicked the button.", 5)
end)

-- Add a toggle to enable or disable a feature
Window:CreateToggle("Enable Feature", false, function(value)
    -- This function is called every time the toggle's state changes
    if value then
        print("Feature has been enabled.")
    else
        print("Feature has been disabled.")
    end
end)
Theming
Drakthonlib includes a powerful theming system to instantly change the appearance of all UI elements. You can set the theme before creating any windows.

Drakthonlib:SetTheme(themeName)
Sets the active theme for all subsequently created UI elements.

themeName (string): The name of the theme to apply. Must be one of the available theme names.
Example:

Lua

local Drakthonlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/fisal-new/Drakthonlib/refs/heads/main/Lib.lua"))()

-- Set the theme to 'Dracula' before creating any windows
Drakthonlib:SetTheme("Dracula")

local Window = Drakthonlib:CreateWindow("Dracula Themed UI")
Window:CreateButton("I'm a Dracula Button", function() end)
Available Themes
Here is a complete list of all built-in themes you can use with Drakthonlib:SetTheme().

"Default" (The default dark theme)
"Dark" (An alternative dark theme)
"Light" (A clean light-mode theme)
"Dracula" (A popular purple-based dark theme)
"Solarized" (A low-contrast theme for comfort)
"Nord" (A cold, arctic-inspired dark theme)
"Monokai" (A classic high-contrast dark theme)
"Material" (A theme inspired by Google's Material Design)
"Midnight" (A deep blue and dark theme)
"Red" (A red and black-focused theme)
API Reference
This section provides a detailed reference for every function available in Drakthonlib.

Core Functions
These are global functions on the main Drakthonlib object.

Drakthonlib:CreateWindow(name)
Creates a new, draggable window. This is the entry point for creating any UI.

Parameters:
name (string): The text to display in the window's title bar.
Returns:
Window (table): A window object that you can add elements to.
Drakthonlib:Notify(title, text, duration)
Displays a notification on the bottom-right of the screen.

Parameters:
title (string): The bolded title of the notification.
text (string): The main content of the notification.
duration (number, optional, default: 5): The time in seconds for the notification to be visible.
Drakthonlib:SetTheme(themeName)
Sets the global theme for the UI. See the Theming section for more details.

Window / Folder Methods
These methods can be called on objects returned by CreateWindow and CreateFolder.

Window:CreateFolder(name)
Creates a collapsible folder within the window to help organize elements.

Parameters:
name (string): The name of the folder.
Returns:
Folder (table): A folder object that you can add elements to, just like a window.
Lua

local MyFolder = Window:CreateFolder("Player Settings")
-- You can now add elements to the folder
MyFolder:CreateSlider("WalkSpeed", 16, 100, 16, function() end)
Window:CreateButton(name, callback)
Creates a clickable button.

Parameters:
name (string): The text displayed on the button.
callback (function): The function to execute when the button is clicked.
Lua

Window:CreateButton("Reset Character", function()
    game.Players.LocalPlayer:LoadCharacter()
end)
Window:CreateToggle(name, default, callback)
Creates a toggle switch (checkbox).

Parameters:
name (string): The label for the toggle.
default (boolean): The initial state of the toggle (true for on, false for off).
callback (function(value)): The function executed when the state changes. It receives the new state as a boolean argument (value).
Lua

Window:CreateToggle("Infinite Jump", false, function(isEnabled)
    _G.InfiniteJump = isEnabled -- Example of setting a global variable
    print("Infinite Jump is now:", isEnabled)
end)
Window:CreateSlider(name, min, max, default, callback)
Creates a slider for selecting a numerical value within a range.

Parameters:
name (string): The label for the slider.
min (number): The minimum possible value of the slider.
max (number): The maximum possible value of the slider.
default (number): The initial value of the slider.
callback (function(value)): The function executed when the slider's value changes. It receives the new value as an integer argument (value).
Lua

Window:CreateSlider("Field of View", 70, 120, 80, function(fov)
    game.Workspace.CurrentCamera.FieldOfView = fov
end)
Window:CreateLabel(text)
Creates a simple, non-interactive text label. Useful for instructions or titles.

Parameters:
text (string): The text to be displayed.
Lua

Window:CreateLabel("--- Visual Settings ---")
Window:CreateDropdown(name, list, callback)
Creates a dropdown menu for selecting one option from a list.

Parameters:
name (string): The label for the dropdown.
list (table): An array of strings representing the options in the dropdown.
callback (function(option)): The function executed when an option is selected. It receives the selected option as a string argument (option).
Lua

local weatherOptions = {"Clear", "Rainy", "Foggy"}
Window:CreateDropdown("Weather", weatherOptions, function(selectedWeather)
    print("Selected weather:", selectedWeather)
    -- Add logic to change game weather here
end)
Window:CreateTextbox(name, default, callback)
Creates a text input box.

Parameters:
name (string): The label for the textbox.
default (string): The default placeholder text in the box.
callback (function(text)): The function executed when the user presses Enter after typing. It receives the entered text as a string argument (text).
Lua

Window:CreateTextbox("Player Name", "Enter a name...", function(playerName)
    local target = game.Players:FindFirstChild(playerName)
    if target then
        Drakthonlib:Notify("Player Found", target.Name .. " is in the game.", 4)
    else
        Drakthonlib:Notify("Error", "Player not found.", 4)
    end
end)
Window:ColorPicker(name, default, callback)
Creates an advanced color picker with hue, saturation, and value controls.

Parameters:
name (string): The label for the color picker.
default (Color3): The initial color value (e.g., Color3.new(1, 0, 0) for red).
callback (function(color)): The function executed when the color is changed. It receives the new color as a Color3 argument (color).
Lua

local defaultColor = game.Lighting.Sky.SkyboxBkColor
Window:ColorPicker("Sky Color", defaultColor, function(newColor)
    game.Lighting.Sky.SkyboxBkColor = newColor
end)
Comprehensive Example
This example demonstrates a more complex use case, combining folders, various components, and interaction with the game world.

Lua

--[[
    Comprehensive Drakthonlib Example
]]

-- Load the library
local Drakthonlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/fisal-new/Drakthonlib/refs/heads/main/Lib.lua"))()

-- Set a custom theme
Drakthonlib:SetTheme("Nord")

-- Create the main window
local Main = Drakthonlib:CreateWindow("Drakthonlib Demo Panel")

-- ===================================
-- Player Modifications Folder
-- ===================================
local PlayerFolder = Main:CreateFolder("Local Player")

PlayerFolder:CreateSlider("WalkSpeed", 16, 200, 16, function(value)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = value
    end
end)

PlayerFolder:CreateSlider("JumpPower", 50, 250, 50, function(value)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = value
    end
end)

PlayerFolder:CreateButton("Reset Character", function()
    game.Players.LocalPlayer:LoadCharacter()
    Drakthonlib:Notify("Action", "Character has been reset.", 3)
end)


-- ===================================
-- World Modifications Folder
-- ===================================
local WorldFolder = Main:CreateFolder("World & Lighting")

WorldFolder:CreateLabel("Lighting Controls:")

WorldFolder:CreateSlider("Clock Time", 0, 24, 14, function(value)
    game.Lighting.ClockTime = value
end)

WorldFolder:CreateSlider("Brightness", 0, 5, 2, function(value)
    game.Lighting.Brightness = value
end)

WorldFolder:ColorPicker("Ambient Color", game.Lighting.Ambient, function(color)
    game.Lighting.Ambient = color
end)

-- ===================================
-- Misc Folder
-- ===================================
local MiscFolder = Main:CreateFolder("Miscellaneous")

MiscFolder:CreateDropdown("Teleport to Player", {"Player1", "Player2", "None"}, function(option)
    if option ~= "None" then
        -- In a real script, you would get a list of actual players
        Drakthonlib:Notify("Teleport", "Attempting to teleport to " .. option, 4)
    end
end)

MiscFolder:CreateTextbox("Custom Notify", "Enter text...", function(text)
    Drakthonlib:Notify("Custom Notification", text, 5)
end)
Author
Developed by fisal-new.
