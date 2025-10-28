local modConfig = {}

local characterVariants = {
    Apollyon = {
        "Classic Apollyon",
        "Stone Winged Apollyon"
    },
    Azazel = {
        "Classic Azazel",
        "Dark Winged Azazel",
        "Repented Azazel"
    },
    Judas = {
        "Classic Judas",
        "Dark Judas"
    },
    Lazarus = {
        "Classic Lazarus",
        "Lazarus Risen`"
    }
}

modConfig.Options = {
    selectedVariant = {
        Apollyon = 1,
        Azazel = 1,
        Judas = 1,
        Lazarus = 1
    },
    replaceAngelicBabyForChar = {
        Cain = true,
        Lilith = true,
        Jacob = true
    }
}

function modConfig.AddModConfigMenu()
    if ModConfigMenu == nil then
        return
    end

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type=ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function()
            return modConfig.Options.selectedVariant.Apollyon
        end,
        Display = function()
            return "Apollyon variant: " .. characterVariants["Apollyon"][modConfig.Options.selectedVariant.Apollyon]
        end,
        OnChange = function(value)
            modConfig.Options.selectedVariant.Apollyon = value
        end,
        Info = {"Choose the variant of Isaac boss being replaced by Apollyon"},
        Minimum = 1,
        Maximum = #characterVariants.Apollyon,
        Default = 1            
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type=ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function()
            return modConfig.Options.selectedVariant.Azazel
        end,
        Display = function()
            return "Azazel variant: " .. characterVariants["Azazel"][modConfig.Options.selectedVariant.Azazel]
        end,
        OnChange = function(value)
            modConfig.Options.selectedVariant.Azazel = value
        end,
        Info = {"Choose the variant of Isaac boss being replaced by Azazel"},
        Minimum = 1,
        Maximum = #characterVariants.Azazel,
        Default = 1            
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type=ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function()
            return modConfig.Options.selectedVariant.Judas
        end,
        Display = function()
            return "Judas variant: " .. characterVariants["Judas"][modConfig.Options.selectedVariant.Judas]
        end,
        OnChange = function(value)
            modConfig.Options.selectedVariant.Judas = value
        end,
        Info = {"Choose the variant of Isaac boss being replaced by Judas"},
        Minimum = 1,
        Maximum = #characterVariants.Judas,
        Default = 1            
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type=ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function()
            return modConfig.Options.selectedVariant.Lazarus
        end,
        Display = function()
            return "Lazarus variant: " .. characterVariants["Lazarus"][modConfig.Options.selectedVariant.Lazarus]
        end,
        OnChange = function(value)
            modConfig.Options.selectedVariant.Lazarus = value
        end,
        Info = {"Choose the variant of Isaac boss being replaced by Lazarus"},
        Minimum = 1,
        Maximum = #characterVariants.Lazarus,
        Default = 1            
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
            return modConfig.Options.replaceAngelicBabyForChar.Cain
        end,
        Display = function()
            return "Replace Angelic Babies with Abel " .. (modConfig.Options.replaceAngelicBabyForChar.Cain and "On" or "Off")
        end,
        OnChange = function(value)
            modConfig.Options.replaceAngelicBabyForChar.Cain = value
        end,
        Info = {"Should Angelic Babies be replaced with Abel during Cain fight?"}
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
            return modConfig.Options.replaceAngelicBabyForChar.Lilith
        end,
        Display = function()
            return "Replace Angelic Babies with Incubuses " .. (modConfig.Options.replaceAngelicBabyForChar.Lilith and "On" or "Off")
        end,
        OnChange = function(value)
            modConfig.Options.replaceAngelicBabyForChar.Lilith = value
        end,
        Info = {"Should Angelic Babies be replaced with Incubuses during Lilith fight?"}
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
            return modConfig.Options.replaceAngelicBabyForChar.Jacob
        end,
        Display = function()
            return "Replace Angelic Babies with Esau Jr " .. (modConfig.Options.replaceAngelicBabyForChar.Jacob and "On" or "Off")
        end,
        OnChange = function(value)
            modConfig.Options.replaceAngelicBabyForChar.Jacob = value
        end,
        Info = {"Should Angelic Babies be replaced with Esau Jr during Jacob fight?"}
    })
end

--- @param characterName string
--- @return string
function modConfig.getSelectedVariantByCharName(characterName)
    local selectedVariant = ""
    if characterName == "Apollyon" then
        selectedVariant = characterVariants["Apollyon"][modConfig.Options.selectedVariant.Apollyon]
    elseif characterName == "Azazel" then
        selectedVariant = characterVariants["Azazel"][modConfig.Options.selectedVariant.Azazel]
    elseif characterName == "Judas" then
        selectedVariant = characterVariants["Judas"][modConfig.Options.selectedVariant.Judas]
    elseif characterName == "Lazarus" then
        selectedVariant = characterVariants["Lazarus"][modConfig.Options.selectedVariant.Lazarus]
    else
        selectedVariant = ""
    end
    return selectedVariant
end

return modConfig