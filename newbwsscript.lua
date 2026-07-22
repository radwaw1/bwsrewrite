local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Window = Rayfield:CreateWindow({
    name = "shitty script of doom & despair",
    subtitle = "V3.001",
    theme = "Cobalt",

    configuration = {
        autoSave = true,
        autoLoad = true,
        customFolder = "shittyscriptV3",
        fileName = "shittyscriptV3config",
    }
})

-- Tabs
local Home = Window:CreateTab({
    name = "Home",
    icon = 93364949241311
})

local Blatant = Window:CreateTab({
    name = "Blatant"
})

local Render = Window:CreateTab({
    name = "Render"
})

-- Home
Home:CreateButton({
    name = "Self-Destruct",
    callback = function()
        Window:Unload()
    end
})

Home:CreateButton({
    name = "Reset character",
    callback = function()
        game.Players.LocalPlayer.Character:BreakJoints()
    end,
})

--------------------------------------------------
-- Blatant
--------------------------------------------------

local SpeedEnabled = false
local WalkSpeed = 23
local DefaultWalkSpeed = 16

local function GetHumanoid()
    local character = LocalPlayer.Character
    if character then
        return character:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

local function UpdateWalkSpeed()
    local humanoid = GetHumanoid()
    if not humanoid then return end
    
    if SpeedEnabled then
        humanoid.WalkSpeed = WalkSpeed
    else
        humanoid.WalkSpeed = DefaultWalkSpeed
    end
end

-- Handle character respawns
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5) -- Small delay to let Humanoid load
    UpdateWalkSpeed()
end)

-- Initial character if already loaded
if LocalPlayer.Character then
    task.wait(0.5)
    UpdateWalkSpeed()
end

-- Toggle
Blatant:CreateToggle({
    name = "Speed",
    CurrentValue = false,
    Flag = "Speed",

    Callback = function(Value)
        SpeedEnabled = Value
        UpdateWalkSpeed()
    end
})

-- Slider
Blatant:CreateSlider({
    name = "WalkSpeed",
    Range = {0, 200},
    Increment = 1,
    CurrentValue = WalkSpeed,
    Flag = "WalkSpeed",

    Callback = function(Value)
        WalkSpeed = Value
        UpdateWalkSpeed()  -- This is the key fix
    end
})

local BlatantGrid = Blatant:CreateGroup()

local Left = BlatantGrid:CreateGroup({
    direction = "column"
})

local Right = BlatantGrid:CreateGroup({
    direction = "column"
})

Left:CreateToggle({
    name = "Spider"
})

Right:CreateToggle({
    name = "Spinbot"
})

--------------------------------------------------
-- Render
--------------------------------------------------

local RenderGrid = Render:CreateGroup()

local RenderLeft = RenderGrid:CreateGroup({
    direction = "column"
})

local RenderRight = RenderGrid:CreateGroup({
    direction = "column"
})

RenderLeft:CreateToggle({
    name = "Aimbot"
})

RenderLeft:CreateToggle({
    name = "Triggerbot"
})

RenderRight:CreateToggle({
    name = "ESP"
})

RenderRight:CreateToggle({
    name = "Tracers"
})
