# Drakthonlib

A simple and powerful Roblox GUI library for creating hubs, menus, and more. Built to be easy to use with ready-to-go examples.

---

## Overview

Drakthonlib allows you to quickly make fully functional hubs with tabs, buttons, sliders, toggles, inputs, and more. Everything saves automatically, so you don't have to worry about configs. Perfect for beginners and advanced users alike.

---

## Features

- Create fully customizable windows
- Add tabs, buttons, sliders, toggles, and input fields
- Auto-save and load configs
- Full control over player movement (speed, jump, fly, noclip)
- Combat features: aimbot, kill aura, FOV, smoothness, and more
- Visuals: ESP, names, distance, health, fullbright
- Teleportation: to players, coordinates, spawn, or random locations
- Misc tools: anti-AFK, remove textures (FPS boost), auto farm, send chat messages

---

## Installation

Copy this snippet into your executor to load Drakthonlib:

```lua
local Drakthon = loadstring(game:HttpGet("https://raw.githubusercontent.com/fisal-new/Drakthonlib/main/libV2"))()
```

---

## Getting Started

Here's a quick example to get your hub running:

```lua
-- Load the library
local Drakthon = loadstring(game:HttpGet("https://raw.githubusercontent.com/fisal-new/Drakthonlib/main/libV2"))()

-- Create your main window
local Window = Drakthon:CreateWindow({
    Title = "My Hub",
    SubTitle = "Premium v2",
    Icon = "rbxassetid://8508980527",
    LoadingEnabled = true,
    ConfigName = "MyHub_Config",
    AutoLoad = true
})

-- Add a Home tab
local HomeTab = Window:CreateTab({ Name = "Home", Icon = "rbxassetid://8508980527" })
HomeTab:AddParagraph({
    Title = "Welcome",
    Content = "Thanks for using Drakthonlib! Everything saves automatically."
})

-- Add a Player tab with speed control
local PlayerTab = Window:CreateTab({ Name = "Player", Icon = "rbxassetid://8508980527" })
PlayerTab:AddSlider({
    Title = "Speed",
    Description = "Walk speed (16 is default)",
    Min = 16, Max = 500, Default = 16,
    Callback = function(val)
        local plr = game.Players.LocalPlayer
        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = val
        end
    end
})

-- Open the window
Window:Open()
```

> Tip: You can add tabs, sliders, toggles, buttons, and inputs easily. Check the `examples/` folder for more ready-to-use scripts.

---

## Join our Discord

Need help, updates, or want to hang out with the community? Click below:

[![Join Discord](https://img.shields.io/badge/Join%20Discord-Click%20Here-blue?style=for-the-badge&logo=discord)](https://discord.gg/W3VwkUj6kf)
