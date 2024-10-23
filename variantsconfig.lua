local MOD = RegisterMod("Character Based Isaac", 1)
local modconfig = {}

apollyonVariants = {
    "Classic Apollyon",
    "Stone Winged Apollyon"
}

azazelVariants = {
    "Classic Azazel",
    "Dark Winged Azazel",
    "Repented Azazel"
}

local judasVariants = {
    "Classic Judas",
    "Dark Judas"
}

local lazarusVariants = {
    "Classic Lazarus",
    "Lazarus Risen"
}

modconfig.selectedApollyonVariant = 1
modconfig.selectedAzazelVariant = 1
modconfig.selectedJudasVariant = 1
modconfig.selectedLazarusVariant = 1

modconfig.replaceGuardianAngelsForCain = true
modconfig.replaceGuardianAngelsForLilith = true
modconfig.replaceGuardianAngelsForJacob = true

function modconfig.AddModConfigMenu()
    if ModConfigMenu == nil then
        return
    end

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type=ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function()
            return modconfig.selectedApollyonVariant
        end,
        Display = function()
            return "Apollyon variant: " .. apollyonVariants[modconfig.selectedApollyonVariant]
        end,
        OnChange = function(value)
            modconfig.selectedApollyonVariant = value
        end,
        Info = {"Choose the variant of Isaac boss being replaced by Apollyon"},
        Minimum = 1,
        Maximum = #apollyonVariants,
        Default = 1            
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type=ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function()
            return modconfig.selectedAzazelVariant
        end,
        Display = function()
            return "Azazel variant: " .. azazelVariants[modconfig.selectedAzazelVariant]
        end,
        OnChange = function(value)
            modconfig.selectedAzazelVariant = value
        end,
        Info = {"Choose the variant of Isaac boss being replaced by Azazel"},
        Minimum = 1,
        Maximum = #azazelVariants,
        Default = 1            
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type=ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function()
            return modconfig.selectedJudasVariant
        end,
        Display = function()
            return "Judas variant: " .. judasVariants[modconfig.selectedJudasVariant]
        end,
        OnChange = function(value)
            modconfig.selectedJudasVariant = value
        end,
        Info = {"Choose the variant of Isaac boss being replaced by Judas"},
        Minimum = 1,
        Maximum = #judasVariants,
        Default = 1            
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type=ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function()
            return modconfig.selectedLazarusVariant
        end,
        Display = function()
            return "Lazarus variant: " .. judasVariants[modconfig.selectedLazarusVariant]
        end,
        OnChange = function(value)
            modconfig.selectedLazarusVariant = value
        end,
        Info = {"Choose the variant of Isaac boss being replaced by Lazarus"},
        Minimum = 1,
        Maximum = #lazarusVariants,
        Default = 1            
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
            return modconfig.replaceGuardianAngelsForCain
        end,
        Display = function()
            return "Replace Guardian Angels with Abel " .. (modconfig.replaceGuardianAngelsForCain and "On" or "Off")
        end,
        OnChange = function(value)
            modconfig.replaceGuardianAngelsForCain = value
        end,
        Info = {"Should Guardian Angels be replaced with Abel during Cain fight?"}
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
            return modconfig.replaceGuardianAngelsForLilith
        end,
        Display = function()
            return "Replace Guardian Angels with Incubus " .. (modconfig.replaceGuardianAngelsForLilith and "On" or "Off")
        end,
        OnChange = function(value)
            modconfig.replaceGuardianAngelsForLilith = value
        end,
        Info = {"Should Guardian Angels be replaced with Incubus during Lilith fight?"}
    })

    ModConfigMenu.AddSetting("Better Unique Isaac Fight", {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
            return modconfig.replaceGuardianAngelsForJacob
        end,
        Display = function()
            return "Replace Guardian Angels with Esau Jr " .. (modconfig.replaceGuardianAngelsForJacob and "On" or "Off")
        end,
        OnChange = function(value)
            modconfig.replaceGuardianAngelsForJacob = value
        end,
        Info = {"Should Guardian Angels be replaced with Esau Jr during Jacob fight?"}
    })
end

function modconfig.getSelectedApollyonVariant()
    return apollyonVariants[modconfig.selectedApollyonVariant]
end

function modconfig.getSelectedAzazelVariant()
    return azazelVariants[modconfig.selectedAzazelVariant]
end

function modconfig.getSelectedJudasVariant()
    return judasVariants[modconfig.selectedJudasVariant]
end

function modconfig.getSelectedLazarusVariant()
    return lazarusVariants[modconfig.selectedLazarusVariant]
end

return modconfig