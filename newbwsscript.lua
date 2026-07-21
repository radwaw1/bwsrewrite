local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Shity Script of doom & despair",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Shity Script of doom & despair",
   LoadingSubtitle = "by aaaaaaaa",
   ShowText = "script", -- for mobile users to unhide Rayfield, change if you'd like
   Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

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

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Name Tags",
    LoadingTitle = "NameTags Module",
    LoadingSubtitle = "Converted from Vape",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "NameTagsConfig",
        FileName = "Settings"
    }
})

local Tab = Window:CreateTab("Name Tags", 4483362458)

-- ==================== VARIABLES ====================
local Strings, Sizes, Reference = {}, {}, {}
local Folder = Instance.new('Folder')
Folder.Parent = game:GetService("CoreGui") -- Change to vape.gui if preferred

local methodused = "Normal"

local Targets, Color, Background, Stroke, DisplayName, Health
local Distance, Scale, FontOption, Teammates, DrawingToggle
local DistanceCheck, DistanceLimit

-- ==================== CORE FUNCTIONS (Unchanged) ====================

local Added = {
    Normal = function(ent)
        if not Targets.CurrentValue and ent.Player then return end
        if not TargetsNPCs.CurrentValue and ent.NPC then return end -- assuming you have NPC toggle
        if Teammates.CurrentValue and (not ent.Targetable) and (not ent.Friend) then return end

        Strings[ent] = ent.Player and whitelist:tag(ent.Player, true, true)..(DisplayName.CurrentValue and ent.Player.DisplayName or ent.Player.Name) or ent.Character.Name

        if Health.CurrentValue then
            local healthColor = Color3.fromHSV(math.clamp(ent.Health / ent.MaxHealth, 0, 1) / 2.5, 0.89, 0.75)
            Strings[ent] = Strings[ent]..' <font color="rgb('..math.floor(healthColor.R*255)..','..math.floor(healthColor.G*255)..','..math.floor(healthColor.B*255)..')">'..math.round(ent.Health)..'</font>'
        end

        if Distance.CurrentValue then
            Strings[ent] = '<font color="rgb(85, 255, 85)">[</font><font color="rgb(255, 255, 255)">%s</font><font color="rgb(85, 255, 85)">]</font> '..Strings[ent]
        end

        local nametag = Instance.new('TextLabel')
        nametag.TextSize = 14 * Scale.CurrentValue
        nametag.FontFace = FontOption.CurrentValue
        local size = getfontsize(removeTags(Strings[ent]), nametag.TextSize, nametag.FontFace, Vector2.new(100000, 100000))
        nametag.Name = ent.Player and ent.Player.Name or ent.Character.Name
        nametag.Size = UDim2.fromOffset(size.X + 8, size.Y + 7)
        nametag.AnchorPoint = Vector2.new(0.5, 1)
        nametag.BackgroundColor3 = Color3.new()
        nametag.BackgroundTransparency = Background.CurrentValue
        nametag.TextStrokeTransparency = Stroke.CurrentValue
        nametag.BorderSizePixel = 0
        nametag.Visible = false
        nametag.Text = Strings[ent]
        nametag.TextColor3 = entitylib.getEntityColor(ent) or Color3.fromHSV(Color.Hue, Color.Sat, Color.Value)
        nametag.RichText = true
        nametag.Parent = Folder
        Reference[ent] = nametag
    end,

    Drawing = function(ent)
        if not Targets.CurrentValue and ent.Player then return end
        if not TargetsNPCs.CurrentValue and ent.NPC then return end
        if Teammates.CurrentValue and (not ent.Targetable) and (not ent.Friend) then return end

        local nametag = {}
        nametag.BG = Drawing.new('Square')
        nametag.BG.Filled = true
        nametag.BG.Transparency = 1 - Background.CurrentValue
        nametag.BG.Color = Color3.new()
        nametag.BG.ZIndex = 1

        nametag.Text = Drawing.new('Text')
        nametag.Text.Size = 15 * Scale.CurrentValue
        nametag.Text.Font = 0
        nametag.Text.ZIndex = 2

        Strings[ent] = ent.Player and whitelist:tag(ent.Player, true)..(DisplayName.CurrentValue and ent.Player.DisplayName or ent.Player.Name) or ent.Character.Name

        if Health.CurrentValue then
            Strings[ent] = Strings[ent]..' '..math.round(ent.Health)
        end

        if Distance.CurrentValue then
            Strings[ent] = '[%s] '..Strings[ent]
        end

        nametag.Text.Text = Strings[ent]
        nametag.Text.Color = entitylib.getEntityColor(ent) or Color3.fromHSV(Color.Hue, Color.Sat, Color.Value)
        nametag.BG.Size = Vector2.new(nametag.Text.TextBounds.X + 8, nametag.Text.TextBounds.Y + 7)
        Reference[ent] = nametag
    end
}

local Removed = {
    Normal = function(ent)
        local v = Reference[ent]
        if v then
            Reference[ent] = nil
            Strings[ent] = nil
            Sizes[ent] = nil
            v:Destroy()
        end
    end,
    Drawing = function(ent)
        local v = Reference[ent]
        if v then
            Reference[ent] = nil
            Strings[ent] = nil
            Sizes[ent] = nil
            for _, obj in v do
                pcall(function()
                    obj.Visible = false
                    obj:Remove()
                end)
            end
        end
    end
}

local Updated = {
    Normal = function(ent)
        local nametag = Reference[ent]
        if nametag then
            Sizes[ent] = nil
            Strings[ent] = ent.Player and whitelist:tag(ent.Player, true, true)..(DisplayName.CurrentValue and ent.Player.DisplayName or ent.Player.Name) or ent.Character.Name

            if Health.CurrentValue then
                local color = Color3.fromHSV(math.clamp(ent.Health / ent.MaxHealth, 0, 1) / 2.5, 0.89, 0.75)
                Strings[ent] = Strings[ent]..' <font color="rgb('..math.floor(color.R*255)..','..math.floor(color.G*255)..','..math.floor(color.B*255)..')">'..math.round(ent.Health)..'</font>'
            end

            if Distance.CurrentValue then
                Strings[ent] = '<font color="rgb(85, 255, 85)">[</font><font color="rgb(255, 255, 255)">%s</font><font color="rgb(85, 255, 85)">]</font> '..Strings[ent]
            end

            local size = getfontsize(removeTags(Strings[ent]), nametag.TextSize, nametag.FontFace, Vector2.new(100000, 100000))
            nametag.Size = UDim2.fromOffset(size.X + 8, size.Y + 7)
            nametag.Text = Strings[ent]
        end
    end,
    Drawing = function(ent)
        local nametag = Reference[ent]
        if nametag then
            Sizes[ent] = nil
            Strings[ent] = ent.Player and whitelist:tag(ent.Player, true)..(DisplayName.CurrentValue and ent.Player.DisplayName or ent.Player.Name) or ent.Character.Name

            if Health.CurrentValue then
                Strings[ent] = Strings[ent]..' '..math.round(ent.Health)
            end

            if Distance.CurrentValue then
                Strings[ent] = '[%s] '..Strings[ent]
                nametag.Text.Text = entitylib.isAlive and string.format(Strings[ent], math.floor((entitylib.character.RootPart.Position - ent.RootPart.Position).Magnitude)) or Strings[ent]
            else
                nametag.Text.Text = Strings[ent]
            end

            nametag.BG.Size = Vector2.new(nametag.Text.TextBounds.X + 8, nametag.Text.TextBounds.Y + 7)
            nametag.Text.Color = entitylib.getEntityColor(ent) or Color3.fromHSV(Color.Hue, Color.Sat, Color.Value)
        end
    end
}

local ColorFunc = {
    Normal = function(hue, sat, val)
        local color = Color3.fromHSV(hue, sat, val)
        for i, v in Reference do
            v.TextColor3 = entitylib.getEntityColor(i) or color
        end
    end,
    Drawing = function(hue, sat, val)
        local color = Color3.fromHSV(hue, sat, val)
        for i, v in Reference do
            v.Text.Color = entitylib.getEntityColor(i) or color
        end
    end
}

local Loop = {
    Normal = function()
        for ent, nametag in Reference do
            if DistanceCheck.CurrentValue then
                local distance = entitylib.isAlive and (entitylib.character.RootPart.Position - ent.RootPart.Position).Magnitude or math.huge
                if distance < DistanceLimit.CurrentMin or distance > DistanceLimit.CurrentMax then
                    nametag.Visible = false
                    continue
                end
            end

            local headPos, headVis = gameCamera:WorldToViewportPoint(ent.RootPart.Position + Vector3.new(0, ent.HipHeight + 1, 0))
            nametag.Visible = headVis
            if not headVis then continue end

            if Distance.CurrentValue then
                local mag = entitylib.isAlive and math.floor((entitylib.character.RootPart.Position - ent.RootPart.Position).Magnitude) or 0
                if Sizes[ent] ~= mag then
                    nametag.Text = string.format(Strings[ent], mag)
                    local size = getfontsize(removeTags(nametag.Text), nametag.TextSize, nametag.FontFace, Vector2.new(100000, 100000))
                    nametag.Size = UDim2.fromOffset(size.X + 8, size.Y + 7)
                    Sizes[ent] = mag
                end
            end
            nametag.Position = UDim2.fromOffset(headPos.X, headPos.Y)
        end
    end,

    Drawing = function()
        for ent, nametag in Reference do
            if DistanceCheck.CurrentValue then
                local distance = entitylib.isAlive and (entitylib.character.RootPart.Position - ent.RootPart.Position).Magnitude or math.huge
                if distance < DistanceLimit.CurrentMin or distance > DistanceLimit.CurrentMax then
                    nametag.Text.Visible = false
                    nametag.BG.Visible = false
                    continue
                end
            end

            local headPos, headVis = gameCamera:WorldToViewportPoint(ent.RootPart.Position + Vector3.new(0, ent.HipHeight + 1, 0))
            nametag.Text.Visible = headVis
            nametag.BG.Visible = headVis
            if not headVis then continue end

            if Distance.CurrentValue then
                local mag = entitylib.isAlive and math.floor((entitylib.character.RootPart.Position - ent.RootPart.Position).Magnitude) or 0
                if Sizes[ent] ~= mag then
                    nametag.Text.Text = string.format(Strings[ent], mag)
                    nametag.BG.Size = Vector2.new(nametag.Text.TextBounds.X + 8, nametag.Text.TextBounds.Y + 7)
                    Sizes[ent] = mag
                end
            end
            nametag.BG.Position = Vector2.new(headPos.X - (nametag.BG.Size.X / 2), headPos.Y - nametag.BG.Size.Y)
            nametag.Text.Position = nametag.BG.Position + Vector2.new(4, 3)
        end
    end
}

-- ==================== RAYFIELD UI ====================

local NameTagsToggle = Tab:CreateToggle({
    Name = "Name Tags",
    CurrentValue = false,
    Flag = "NameTags_Enabled",
    Callback = function(Value)
        if Value then
            methodused = DrawingToggle.CurrentValue and "Drawing" or "Normal"
            
            -- Entity Removed
            Tab:Clean(entitylib.Events.EntityRemoved:Connect(Removed[methodused]))
            
            -- Entity Added
            for _, v in entitylib.List do
                if Reference[v] then Removed[methodused](v) end
                Added[methodused](v)
            end
            Tab:Clean(entitylib.Events.EntityAdded:Connect(function(ent)
                if Reference[ent] then Removed[methodused](ent) end
                Added[methodused](ent)
            end))

            -- Entity Updated
            Tab:Clean(entitylib.Events.EntityUpdated:Connect(Updated[methodused]))
            for _, v in entitylib.List do
                Updated[methodused](v)
            end

            -- Color Update
            Tab:Clean(vape.Categories.Friends.ColorUpdate.Event:Connect(function()
                if ColorFunc[methodused] then
                    ColorFunc[methodused](Color.Hue, Color.Sat, Color.Value)
                end
            end))

            -- Render Loop
            Tab:Clean(runService.RenderStepped:Connect(Loop[methodused]))
        else
            for i in Reference do
                Removed[methodused](i)
            end
        end
    end
})

Targets = Tab:CreateToggle({
    Name = "Target Players",
    CurrentValue = true,
    Flag = "NameTags_Players",
    Callback = function() if NameTagsToggle.CurrentValue then NameTagsToggle:Set(false) NameTagsToggle:Set(true) end end
})

local TargetsNPCs = Tab:CreateToggle({
    Name = "Target NPCs",
    CurrentValue = true,
    Flag = "NameTags_NPCs",
    Callback = function() if NameTagsToggle.CurrentValue then NameTagsToggle:Set(false) NameTagsToggle:Set(true) end end
})

FontOption = Tab:CreateDropdown({
    Name = "Font",
    Options = {"SourceSans", "Gotham", "Arial", "Roboto"}, -- adjust as needed
    CurrentOption = {"SourceSans"},
    Flag = "NameTags_Font",
    Callback = function() if NameTagsToggle.CurrentValue then NameTagsToggle:Set(false) NameTagsToggle:Set(true) end end
})

Color = Tab:CreateColorPicker({
    Name = "Player Color",
    Color = Color3.fromRGB(255, 255, 255),
    Flag = "NameTags_Color",
    Callback = function(Value)
        local h, s, v = Color3.toHSV(Value)
        Color.Hue, Color.Sat, Color.Value = h, s, v
        if NameTagsToggle.CurrentValue and ColorFunc[methodused] then
            ColorFunc[methodused](h, s, v)
        end
    end
})

Scale = Tab:CreateSlider({
    Name = "Scale",
    Range = {0.1, 1.5},
    Increment = 0.1,
    CurrentValue = 1,
    Flag = "NameTags_Scale",
    Callback = function() if NameTagsToggle.CurrentValue then NameTagsToggle:Set(false) NameTagsToggle:Set(true) end end
})

Background = Tab:CreateSlider({
    Name = "Background Transparency",
    Range = {0, 1},
    Increment = 0.1,
    CurrentValue = 0.5,
    Flag = "NameTags_BGTransparency",
    Callback = function() if NameTagsToggle.CurrentValue then NameTagsToggle:Set(false) NameTagsToggle:Set(true) end end
})

Stroke = Tab:CreateSlider({
    Name = "Stroke Transparency",
    Range = {0, 1},
    Increment = 0.1,
    CurrentValue = 1,
    Flag = "NameTags_StrokeTransparency",
    Callback = function() if NameTagsToggle.CurrentValue then NameTagsToggle:Set(false) NameTagsToggle:Set(true) end end
})

Health = Tab:CreateToggle({
    Name = "Show Health",
    CurrentValue = false,
    Flag = "NameTags_Health",
    Callback = function() if NameTagsToggle.CurrentValue then NameTagsToggle:Set(false) NameTagsToggle:Set(true) end end
})

Distance = Tab:CreateToggle({
    Name = "Show Distance",
    CurrentValue = false,
    Flag = "NameTags_Distance",
    Callback = function() if NameTagsToggle.CurrentValue then NameTagsToggle:Set(false) NameTagsToggle:Set(true) end end
})

DisplayName = Tab:CreateToggle({
    Name = "Use DisplayName",
    CurrentValue = true,
    Flag = "NameTags_DisplayName",
    Callback = function() if NameTagsToggle.CurrentValue then NameTagsToggle:Set(false) NameTagsToggle:Set(true) end end
})

Teammates = Tab:CreateToggle({
    Name = "Priority Only",
    CurrentValue = true,
    Flag = "NameTags_PriorityOnly",
    Callback = function() if NameTagsToggle.CurrentValue then NameTagsToggle:Set(false) NameTagsToggle:Set(true) end end
})

DrawingToggle = Tab:CreateToggle({
    Name = "Use Drawing API",
    CurrentValue = false,
    Flag = "NameTags_Drawing",
    Callback = function() if NameTagsToggle.CurrentValue then NameTagsToggle:Set(false) NameTagsToggle:Set(true) end end
})

DistanceCheck = Tab:CreateToggle({
    Name = "Distance Check",
    CurrentValue = false,
    Flag = "NameTags_DistanceCheck",
    Callback = function(Value)
        if DistanceLimit then DistanceLimit:SetVisibility(Value) end
    end
})

DistanceLimit = Tab:CreateTwoSlider({
    Name = "Player Distance",
    Range = {0, 256},
    CurrentMin = 0,
    CurrentMax = 64,
    Flag = "NameTags_DistanceLimit"
})

Rayfield:LoadConfiguration()