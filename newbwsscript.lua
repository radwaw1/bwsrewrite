local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

local window = Rayfield:CreateWindow({
    name = "shitty script of doom & despair",
    subtitle = "by aaaaaaaa",
    theme = "cobalt",
    configuration = {
        autoSave = true,
        autoLoad = true,
        customFolder = "shittyscriptV3",
        fileName = "shittyscriptV3config",
    },
})

local Home = window:CreateTab({ name = "Home", icon = 93364949241311 })
local Blatant = window:CreateTab({ name = "Blatant", icon = 93364949241311 })

Home:CreateButton({
    name = "Blatant",
    callback = function()
        tab:Select(Blatant)
    end,
})

Blatant:CreateToggle({
    name = "Auto Sprint",
    callback = function(value)
        print("Auto Sprint:", value)
    end,
})