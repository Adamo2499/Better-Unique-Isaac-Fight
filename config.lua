local MOD = RegisterMod("Character Based Isaac", 1)

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

modConfigOptions = {
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

function modConfigOptions.AddModConfigMenu()
    if ModConfigMenu == nil then
        return
    end

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type=ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function()
            return modConfigOptions.selectedVariant.Apollyon
        end,
        Display = function()
            return "Apollyon variant: " .. characterVariants["Apollyon"][modConfigOptions.selectedVariant.Apollyon]
        end,
        OnChange = function(value)
            modConfigOptions.selectedVariant.Apollyon = value
        end,
        Info = {"Choose the variant of Isaac boss being replaced by Apollyon"},
        Minimum = 1,
        Maximum = #characterVariants.Apollyon,
        Default = 1            
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type=ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function()
            return modConfigOptions.selectedVariant.Azazel
        end,
        Display = function()
            return "Azazel variant: " .. characterVariants["Azazel"][modConfigOptions.selectedVariant.Azazel]
        end,
        OnChange = function(value)
            modConfigOptions.selectedVariant.Azazel = value
        end,
        Info = {"Choose the variant of Isaac boss being replaced by Azazel"},
        Minimum = 1,
        Maximum = #characterVariants.Azazel,
        Default = 1            
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type=ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function()
            return modConfigOptions.selectedVariant.Judas
        end,
        Display = function()
            return "Judas variant: " .. characterVariants["Judas"][modConfigOptions.selectedVariant.Judas]
        end,
        OnChange = function(value)
            modConfigOptions.selectedVariant.Judas = value
        end,
        Info = {"Choose the variant of Isaac boss being replaced by Judas"},
        Minimum = 1,
        Maximum = #characterVariants.Judas,
        Default = 1            
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type=ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function()
            return modConfigOptions.selectedVariant.Lazarus
        end,
        Display = function()
            return "Lazarus variant: " .. characterVariants["Lazarus"][modConfigOptions.selectedVariant.Lazarus]
        end,
        OnChange = function(value)
            modConfigOptions.selectedVariant.Lazarus = value
        end,
        Info = {"Choose the variant of Isaac boss being replaced by Lazarus"},
        Minimum = 1,
        Maximum = #characterVariants.Lazarus,
        Default = 1            
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
            return modConfigOptions.replaceAngelicBabyForChar.Cain
        end,
        Display = function()
            return "Replace Angelic Babies with Abel " .. (modConfigOptions.replaceAngelicBabyForChar.Cain and "On" or "Off")
        end,
        OnChange = function(value)
            modConfigOptions.replaceAngelicBabyForChar.Cain = value
        end,
        Info = {"Should Angelic Babies be replaced with Abel during Cain fight?"}
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
            return modConfigOptions.replaceAngelicBabyForChar.Lilith
        end,
        Display = function()
            return "Replace Angelic Babies with Incubuses " .. (modConfigOptions.replaceAngelicBabyForChar.Lilith and "On" or "Off")
        end,
        OnChange = function(value)
            modConfigOptions.replaceAngelicBabyForChar.Lilith = value
        end,
        Info = {"Should Angelic Babies be replaced with Incubuses during Lilith fight?"}
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
            return modConfigOptions.replaceAngelicBabyForChar.Jacob
        end,
        Display = function()
            return "Replace Angelic Babies with Esau Jr " .. (modConfigOptions.replaceAngelicBabyForChar.Jacob and "On" or "Off")
        end,
        OnChange = function(value)
            modConfigOptions.replaceAngelicBabyForChar.Jacob = value
        end,
        Info = {"Should Angelic Babies be replaced with Esau Jr during Jacob fight?"}
    })
end

function modConfigOptions.getSelectedApollyonVariant()
    return characterVariants["Apollyon"][modConfigOptions.selectedVariant.Apollyon]
end

function modConfigOptions.getSelectedAzazelVariant()
    return characterVariants["Azazel"][modConfigOptions.selectedVariant.Azazel]
end

function modConfigOptions.getSelectedJudasVariant()
    return characterVariants["Judas"][modConfigOptions.selectedVariant.Judas]
end

function modConfigOptions.getSelectedLazarusVariant()
    return characterVariants["Lazarus"][modConfigOptions.selectedVariant.Lazarus]
end

return modConfigOptions