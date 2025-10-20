local Drakthon = loadstring(game:HttpGet("https://raw.githubusercontent.com/fisal-new/Drakthonlib/refs/heads/main/libV2"))()

local Window = Drakthon:CreateWindow({
    Title = "My Hub",
    SubTitle = "premium v2",
    Icon = "rbxassetid://8508980527",
    LoadingEnabled = true,
    ConfigName = "MyHub_Config",
    AutoLoad = true
})

local HomeTab = Window:CreateTab({
    Name = "Home",
    Icon = "rbxassetid://8508980527"
})

HomeTab:AddParagraph({
    Title = "sup",
    Content = "yo thanks for using this. just mess around with the settings and see what works. everything saves automatically so dont worry"
})

HomeTab:AddDivider("info")

HomeTab:AddParagraph({
    Title = "version",
    Content = "v1.5 - updated today\neverything should work fine\nif something breaks just rejoin"
})

HomeTab:AddDivider()

HomeTab:AddButton({
    Title = "test",
    Description = "see if its working",
    Callback = function()
        print("yup its working")
        print("ur username: " .. game.Players.LocalPlayer.Name)
    end
})

HomeTab:AddButton({
    Title = "player info",
    Description = "show ur account stuff",
    Callback = function()
        local plr = game.Players.LocalPlayer
        print("name: " .. plr.Name)
        print("display: " .. plr.DisplayName)
        print("id: " .. plr.UserId)
        print("age: " .. plr.AccountAge .. " days")
    end
})

HomeTab:AddButton({
    Title = "rejoin",
    Description = "rejoin this server",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
    end
})

HomeTab:AddButton({
    Title = "server hop",
    Description = "find another server",
    Callback = function()
        pcall(function()
            local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
            if servers and servers.data then
                for _, v in pairs(servers.data) do
                    if v.id ~= game.JobId then
                        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id)
                        break
                    end
                end
            end
        end)
    end
})

local PlayerTab = Window:CreateTab({
    Name = "Player",
    Icon = "rbxassetid://8508980527"
})

PlayerTab:AddParagraph({
    Title = "movement",
    Content = "change ur speed and jump and stuff"
})

PlayerTab:AddDivider()

PlayerTab:AddSlider({
    Title = "speed",
    Description = "walk speed (16 is normal)",
    Min = 16,
    Max = 500,
    Default = 16,
    Flag = "speed",
    Callback = function(val)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = val
        end
    end
})

PlayerTab:AddSlider({
    Title = "jump",
    Description = "jump power (50 is normal)",
    Min = 50,
    Max = 500,
    Default = 50,
    Flag = "jump",
    Callback = function(val)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = val
        end
    end
})

PlayerTab:AddSlider({
    Title = "gravity",
    Description = "workspace gravity (196 is normal)",
    Min = 0,
    Max = 196,
    Default = 196,
    Flag = "grav",
    Callback = function(val)
        workspace.Gravity = val
    end
})

PlayerTab:AddDivider()

local infjump = false
PlayerTab:AddToggle({
    Title = "infinite jump",
    Description = "jump in air",
    Default = false,
    Flag = "infjump",
    Callback = function(val)
        infjump = val
    end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infjump then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end
end)

local noclip = false
PlayerTab:AddToggle({
    Title = "noclip",
    Description = "walk through walls",
    Default = false,
    Flag = "noclip",
    Callback = function(val)
        noclip = val
    end
})

game:GetService("RunService").Stepped:Connect(function()
    if noclip then
        local char = game.Players.LocalPlayer.Character
        if char then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end
end)

local flying = false
local flyspeed = 50

PlayerTab:AddToggle({
    Title = "fly",
    Description = "WASD to move, space/shift up/down",
    Default = false,
    Flag = "fly",
    Callback = function(val)
        flying = val
        local plr = game.Players.LocalPlayer
        local char = plr.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        
        if val and root then
            local bg = Instance.new("BodyGyro")
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = root.CFrame
            bg.Parent = root
            
            local bv = Instance.new("BodyVelocity")
            bv.velocity = Vector3.new(0, 0, 0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Parent = root
            
            spawn(function()
                while flying and root do
                    local cam = workspace.CurrentCamera
                    local dir = Vector3.new()
                    
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                        dir = dir + cam.CFrame.LookVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                        dir = dir - cam.CFrame.LookVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                        dir = dir + cam.CFrame.RightVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                        dir = dir - cam.CFrame.RightVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                        dir = dir + Vector3.new(0, 1, 0)
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
                        dir = dir - Vector3.new(0, 1, 0)
                    end
                    
                    if dir.Magnitude > 0 then
                        bv.velocity = dir.Unit * flyspeed
                        bg.cframe = cam.CFrame
                    else
                        bv.velocity = Vector3.new(0, 0, 0)
                    end
                    wait()
                end
                bg:Destroy()
                bv:Destroy()
            end)
        else
            for _, v in pairs(root:GetChildren()) do
                if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then
                    v:Destroy()
                end
            end
        end
    end
})

PlayerTab:AddSlider({
    Title = "fly speed",
    Min = 10,
    Max = 200,
    Default = 50,
    Flag = "flyspd",
    Callback = function(val)
        flyspeed = val
    end
})

PlayerTab:AddButton({
    Title = "reset",
    Description = "kill urself lol",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.Health = 0
        end
    end
})

local CombatTab = Window:CreateTab({
    Name = "Combat",
    Icon = "rbxassetid://8508980527"
})

CombatTab:AddParagraph({
    Title = "aimbot",
    Content = "combat stuff. might not work in every game"
})

local aimbot = false
CombatTab:AddToggle({
    Title = "aimbot",
    Description = "auto aim",
    Default = false,
    Flag = "aim",
    Callback = function(val)
        aimbot = val
    end
})

local teamcheck = true
CombatTab:AddToggle({
    Title = "team check",
    Description = "dont aim at teammates",
    Default = true,
    Flag = "team",
    Callback = function(val)
        teamcheck = val
    end
})

local vischeck = true
CombatTab:AddToggle({
    Title = "visibility check",
    Description = "only aim at visible",
    Default = true,
    Flag = "vis",
    Callback = function(val)
        vischeck = val
    end
})

local fov = 200
CombatTab:AddSlider({
    Title = "fov",
    Description = "aimbot range",
    Min = 50,
    Max = 500,
    Default = 200,
    Increment = 10,
    Flag = "fov",
    Callback = function(val)
        fov = val
    end
})

local smooth = 0.5
CombatTab:AddSlider({
    Title = "smoothness",
    Description = "lower = smoother",
    Min = 0.1,
    Max = 1,
    Default = 0.5,
    Increment = 0.1,
    Flag = "smooth",
    Callback = function(val)
        smooth = val
    end
})

local part = "Head"
CombatTab:AddDropdown({
    Title = "target",
    Description = "aim at which part",
    Options = {"Head", "Torso", "HumanoidRootPart"},
    Default = "Head",
    Flag = "part",
    Callback = function(val)
        part = val
    end
})

local function getclosest()
    local plr = game.Players.LocalPlayer
    local cam = workspace.CurrentCamera
    local closest = nil
    local shortest = fov
    
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= plr and v.Character and v.Character:FindFirstChild(part) then
            if teamcheck and v.Team == plr.Team then continue end
            
            local p = v.Character[part]
            
            if vischeck then
                local ray = Ray.new(cam.CFrame.Position, (p.Position - cam.CFrame.Position).Unit * 500)
                local hit = workspace:FindPartOnRayWithIgnoreList(ray, {plr.Character})
                if hit and not hit:IsDescendantOf(v.Character) then continue end
            end
            
            local screen = cam:WorldToViewportPoint(p.Position)
            local mouse = game:GetService("UserInputService"):GetMouseLocation()
            local dist = (Vector2.new(screen.X, screen.Y) - mouse).Magnitude
            
            if dist < shortest then
                closest = v
                shortest = dist
            end
        end
    end
    return closest
end

game:GetService("RunService").RenderStepped:Connect(function()
    if aimbot then
        local target = getclosest()
        if target and target.Character and target.Character:FindFirstChild(part) then
            local cam = workspace.CurrentCamera
            local pos = target.Character[part].Position
            local campos = cam.CFrame.Position
            cam.CFrame = cam.CFrame:Lerp(CFrame.new(campos, pos), smooth)
        end
    end
end)

local killaura = false
local range = 20

CombatTab:AddToggle({
    Title = "kill aura",
    Description = "auto attack nearby",
    Default = false,
    Flag = "ka",
    Callback = function(val)
        killaura = val
    end
})

CombatTab:AddSlider({
    Title = "range",
    Min = 5,
    Max = 50,
    Default = 20,
    Flag = "range",
    Callback = function(val)
        range = val
    end
})

local VisualsTab = Window:CreateTab({
    Name = "Visuals",
    Icon = "rbxassetid://8508980527"
})

VisualsTab:AddParagraph({
    Title = "esp",
    Content = "see players through walls and stuff"
})

local esp = false
VisualsTab:AddToggle({
    Title = "esp",
    Description = "wallhack",
    Default = false,
    Flag = "esp",
    Callback = function(val)
        esp = val
        if not val then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v.Character and v.Character:FindFirstChild("Head") then
                    for _, obj in pairs(v.Character.Head:GetChildren()) do
                        if obj.Name == "ESP" then obj:Destroy() end
                    end
                end
            end
        end
    end
})

local names = true
local dist = true
local hp = true

VisualsTab:AddToggle({
    Title = "names",
    Default = true,
    Flag = "names",
    Callback = function(val) names = val end
})

VisualsTab:AddToggle({
    Title = "distance",
    Default = true,
    Flag = "dist",
    Callback = function(val) dist = val end
})

VisualsTab:AddToggle({
    Title = "health",
    Default = true,
    Flag = "hp",
    Callback = function(val) hp = val end
})

local maxdist = 1000
VisualsTab:AddSlider({
    Title = "max distance",
    Min = 100,
    Max = 5000,
    Default = 1000,
    Increment = 50,
    Flag = "maxdist",
    Callback = function(val)
        maxdist = val
    end
})

local function makeesp(plr)
    if plr == game.Players.LocalPlayer then return end
    
    local function add(char)
        if not char or not char:FindFirstChild("Head") then return end
        for _, v in pairs(char.Head:GetChildren()) do
            if v.Name == "ESP" then v:Destroy() end
        end
        
        local bill = Instance.new("BillboardGui")
        bill.Name = "ESP"
        bill.Parent = char.Head
        bill.AlwaysOnTop = true
        bill.Size = UDim2.new(0, 100, 0, 50)
        bill.StudsOffset = Vector3.new(0, 2, 0)
        
        local txt = Instance.new("TextLabel")
        txt.Parent = bill
        txt.Size = UDim2.new(1, 0, 1, 0)
        txt.BackgroundTransparency = 1
        txt.TextColor3 = Color3.new(1, 1, 1)
        txt.TextStrokeTransparency = 0.5
        txt.Font = Enum.Font.GothamBold
        txt.TextSize = 14
        
        game:GetService("RunService").RenderStepped:Connect(function()
            if not esp or not char:FindFirstChild("Head") then
                if bill then bill:Destroy() end
                return
            end
            
            local me = game.Players.LocalPlayer.Character
            if not me or not me:FindFirstChild("HumanoidRootPart") then return end
            
            local d = (me.HumanoidRootPart.Position - char.Head.Position).Magnitude
            
            if d > maxdist then
                bill.Enabled = false
                return
            else
                bill.Enabled = true
            end
            
            local t = ""
            if names then t = t .. plr.Name .. "\n" end
            if dist then t = t .. math.floor(d) .. "m\n" end
            if hp and char:FindFirstChild("Humanoid") then
                t = t .. math.floor(char.Humanoid.Health) .. "HP"
            end
            txt.Text = t
        end)
    end
    
    if plr.Character then add(plr.Character) end
    plr.CharacterAdded:Connect(function(char) wait(0.5) add(char) end)
end

for _, v in pairs(game.Players:GetPlayers()) do makeesp(v) end
game.Players.PlayerAdded:Connect(makeesp)

local fb = false
VisualsTab:AddToggle({
    Title = "fullbright",
    Description = "see everything",
    Default = false,
    Flag = "fb",
    Callback = function(val)
        fb = val
        local light = game:GetService("Lighting")
        if val then
            light.Brightness = 2
            light.ClockTime = 14
            light.FogEnd = 100000
            light.GlobalShadows = false
        else
            light.Brightness = 1
            light.ClockTime = 12
            light.FogEnd = 100000
            light.GlobalShadows = true
        end
    end
})

VisualsTab:AddSlider({
    Title = "fov",
    Description = "camera fov",
    Min = 70,
    Max = 120,
    Default = 70,
    Flag = "camfov",
    Callback = function(val)
        workspace.CurrentCamera.FieldOfView = val
    end
})

local TpTab = Window:CreateTab({
    Name = "Teleport",
    Icon = "rbxassetid://8508980527"
})

TpTab:AddParagraph({
    Title = "tp",
    Content = "teleport to players or coords"
})

TpTab:AddInput({
    Title = "player name",
    Placeholder = "username",
    Flag = "tpname",
    Callback = function(txt)
        local target = game.Players:FindFirstChild(txt)
        local me = game.Players.LocalPlayer
        if target and target.Character and me.Character then
            me.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
        end
    end
})

TpTab:AddButton({
    Title = "spawn",
    Description = "tp to spawn",
    Callback = function()
        local me = game.Players.LocalPlayer
        if me.Character then
            me.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
        end
    end
})

TpTab:AddButton({
    Title = "random",
    Description = "random location",
    Callback = function()
        local me = game.Players.LocalPlayer
        if me.Character then
            local x = math.random(-500, 500)
            local z = math.random(-500, 500)
            me.Character.HumanoidRootPart.CFrame = CFrame.new(x, 50, z)
        end
    end
})

local tpx = 0
local tpy = 50
local tpz = 0

TpTab:AddInput({
    Title = "x",
    Default = "0",
    Flag = "x",
    Callback = function(txt) tpx = tonumber(txt) or 0 end
})

TpTab:AddInput({
    Title = "y",
    Default = "50",
    Flag = "y",
    Callback = function(txt) tpy = tonumber(txt) or 50 end
})

TpTab:AddInput({
    Title = "z",
    Default = "0",
    Flag = "z",
    Callback = function(txt) tpz = tonumber(txt) or 0 end
})

TpTab:AddButton({
    Title = "go",
    Description = "tp to coords",
    Callback = function()
        local me = game.Players.LocalPlayer
        if me.Character then
            me.Character.HumanoidRootPart.CFrame = CFrame.new(tpx, tpy, tpz)
        end
    end
})

local MiscTab = Window:CreateTab({
    Name = "Misc",
    Icon = "rbxassetid://8508980527"
})

MiscTab:AddParagraph({
    Title = "misc",
    Content = "random useful stuff"
})

MiscTab:AddToggle({
    Title = "anti afk",
    Description = "no kick",
    Default = false,
    Flag = "afk",
    Callback = function(val)
        if val then
            local vu = game:GetService("VirtualUser")
            game.Players.LocalPlayer.Idled:Connect(function()
                vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                wait(1)
                vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        end
    end
})

MiscTab:AddButton({
    Title = "remove textures",
    Description = "fps boost",
    Callback = function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Texture") or v:IsA("Decal") then
                v:Destroy()
            end
        end
    end
})

local farm = false
MiscTab:AddToggle({
    Title = "auto farm",
    Description = "collect stuff",
    Default = false,
    Flag = "farm",
    Callback = function(val) farm = val end
})

local farmspd = 50
MiscTab:AddSlider({
    Title = "speed",
    Min = 10,
    Max = 100,
    Default = 50,
    Flag = "farmspd",
    Callback = function(val) farmspd = val end
})

local target = "Both"
MiscTab:AddDropdown({
    Title = "target",
    Options = {"Coins", "Chests", "Both"},
    Default = "Both",
    Flag = "target",
    Callback = function(val) target = val end
})

local msg = ""
MiscTab:AddInput({
    Title = "message",
    Placeholder = "chat msg",
    Flag = "msg",
    Callback = function(txt) msg = txt end
})

MiscTab:AddButton({
    Title = "send",
    Description = "send msg in chat",
    Callback = function()
        if msg ~= "" then
            pcall(function()
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
            end)
        end
    end
})

MiscTab:AddButton({
    Title = "game info",
    Callback = function()
        print("game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
        print("place id: " .. game.PlaceId)
        print("job id: " .. game.JobId)
        print("players: " .. #game.Players:GetPlayers())
    end
})

MiscTab:AddButton({
    Title = "copy job id",
    Callback = function()
        setclipboard(game.JobId)
    end
})

local SettingsTab = Window:CreateTab({
    Name = "Settings",
    Icon = "rbxassetid://8508980527"
})

SettingsTab:AddParagraph({
    Title = "settings",
    Content = "save and load ur config"
})

SettingsTab:AddButton({
    Title = "save",
    Description = "save settings",
    Callback = function()
        Window:SaveConfig()
        print("saved")
    end
})

SettingsTab:AddButton({
    Title = "load",
    Description = "load settings",
    Callback = function()
        Window:LoadConfig()
        print("loaded")
    end
})

SettingsTab:AddToggle({
    Title = "auto save",
    Default = true,
    Flag = "autosave",
    Callback = function(val)
        print("auto save: " .. tostring(val))
    end
})

SettingsTab:AddParagraph({
    Title = "about",
    Content = "v1.5\nDrakthon v3.4.0\nupdated today"
})

SettingsTab:AddButton({
    Title = "close ui",
    Description = "destroy",
    Callback = function()
        for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
            pcall(function()
                if v.ClassName == "ScreenGui" then v:Destroy() end
            end)
        end
        if gethui then
            for _, v in pairs(gethui():GetChildren()) do
                pcall(function() v:Destroy() end)
            end
        end
    end
})

print("loaded")
print("have fun")

spawn(function()
    while wait(120) do
        pcall(function()
            Window:SaveConfig()
            print("auto saved")
        end)
    end
end)
