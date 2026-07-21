local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local player = game:GetService("Players").LocalPlayer
local nametagBillboards = {}

local Window = Rayfield:CreateWindow({
   Name = "Shity Script of doom & despair",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Shity Script of doom & despair",
   LoadingSubtitle = "by aaaaaaaa",
   ShowText = "script", -- for mobile users to unhide Rayfield, change if you'd like
   Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = Enum.KeyCode.RightShift, -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from emitting warnings when the script has a version mismatch with the interface.

   -- ScriptID = "sid_xxxxxxxxxxxx", -- Your Script ID from developer.sirius.menu — enables analytics, managed keys, and script hosting

   ConfigurationSaving = {
      Enabled = true,
      FolderName = bwsscript, -- Create a custom folder for your hub/game
      FileName = "bwsscript"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include Discord.gg/. E.g. Discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the Discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "shitty script of doom & despair",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique, as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"aaaaaaaa", 'Ocnea', 'baboz334'} -- List of keys that the system will accept, can be RAW file links (pastebin, github, etc.) or simple strings ("hello", "key22")
   }
})

local Blatant = Window:CreateTab("Blatant") -- Title, Image
local Inventory = Window:CreateTab("Inventory")
local Kits = Window:CreateTab("Kits")
local Render = Window:CreateTab("Render")
local Utility = Window:CreateTab("Utility")
local World = Window:CreateTab("World")
local Legit = Window:CreateTab("Legit")
local Misc = Window:CreateTab("Misc")

local NameTags = Render:CreateButton({
    Name = "Nametags",

    local player = game:GetService("Players").LocalPlayer
    local nametagBillboards = {}

    local function createNametag(plr)
        local char = plr.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end

        if nametagBillboards[plr] then
            nametagBillboards[plr]:Destroy()
        end

        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 220, 0, 70)
        billboard.StudsOffset = Vector3.new(0, 4.5, 0)
        billboard.AlwaysOnTop = true
        billboard.Adornee = char.HumanoidRootPart
        billboard.Parent = char

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1,0,1,0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = plr.TeamColor.Color
        textLabel.TextStrokeTransparency = 0.5
        textLabel.TextStrokeColor3 = Color3.new(0,0,0)
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextSize = 15
        textLabel.Text = string.format("%s\n%.1f studs\n%d%% HP", plr.Name, 0, 100)
        textLabel.Parent = billboard

        nametagBillboards[plr] = billboard
    end

    Callback = function()
        for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
            if plr == player then continue end
            createNametag(plr)
        end

        -- Handle respawns
        for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
            if plr == player then continue end
            plr.CharacterAdded:Connect(function()
                task.wait(0.5)
                createNametag(plr)
            end)
        end

        -- Update loop
        task.spawn(function()
            while Nametags.Enabled do
                for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
                    if plr == player then continue end

                    local char = plr.Character
                    if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then
                        if nametagBillboards[plr] then
                            nametagBillboards[plr]:Destroy()
                            nametagBillboards[plr] = nil
                        end
                        continue
                    end

                    local root = char.HumanoidRootPart
                    local hum = char.Humanoid

                    if nametagBillboards[plr] then
                        local distance = (root.Position - (player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position or Vector3.new())).Magnitude
                        local healthPercent = math.floor((hum.Health / hum.MaxHealth) * 100)

                        nametagBillboards[plr].TextLabel.Text = string.format(
                            "%s\n%.1f studs\n%d%% HP", 
                            plr.Name,
                            distance,
                            healthPercent
                        )
                    end
                end

                task.wait(0.1)
            end
        end)
    end,
})

Rayfield:LoadConfiguration()