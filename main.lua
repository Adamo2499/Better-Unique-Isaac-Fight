local MOD = RegisterMod("Better Unique Isaac Fight", 1)
local spawnedCorpse = {}
local SaveState = {}
local json = require("json")
local modconfig = require("variantsconfig")
modconfig.AddModConfigMenu()

function MOD:OnFrame()
	local playertype = Isaac.GetPlayer(0):GetPlayerType()
	for _, entity in pairs(Isaac.GetRoomEntities()) do
		local sprite = entity:GetSprite()
		if entity.Type == 102 and entity.Variant == 0 then
			if playertype == PlayerType.PLAYER_MAGDALENE or playertype == PlayerType.PLAYER_MAGDALENE_B then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/Magdalene/boss_075_isaac.png")
				sprite:LoadGraphics()
			elseif playertype == PlayerType.PLAYER_CAIN or playertype == PlayerType.PLAYER_CAIN_B then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/Cain/boss_075_isaac.png")
				sprite:LoadGraphics()
			elseif playertype == PlayerType.PLAYER_JUDAS or playertype == PlayerType.PLAYER_JUDAS_B or playertype == PlayerType.PLAYER_BLACKJUDAS then
				sprite:ReplaceSpritesheet(0, MOD:returnJudasVariantPath())
				sprite:LoadGraphics()
			elseif playertype == PlayerType.PLAYER_BLUEBABY or playertype == PlayerType.PLAYER_BLUEBABY_B then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/BlueBaby/boss_075_isaac.png")
				sprite:LoadGraphics()
			elseif playertype == PlayerType.PLAYER_EVE or playertype == PlayerType.PLAYER_EVE_B then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/Eve/boss_075_isaac.png")
				sprite:LoadGraphics()
			elseif playertype == PlayerType.PLAYER_SAMSON or playertype == PlayerType.PLAYER_SAMSON_B then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/Samson/boss_075_isaac.png")
				sprite:LoadGraphics()
			elseif playertype == PlayerType.PLAYER_AZAZEL or playertype == PlayerType.PLAYER_AZAZEL_B then
				sprite:ReplaceSpritesheet(0, MOD:returnAzazelVariantPath())
				sprite:LoadGraphics()
			-- or PlayerType.PLAYER_LAZARUS2
			elseif playertype == PlayerType.PLAYER_LAZARUS or playertype == PlayerType.PLAYER_LAZARUS_B or playertype == PlayerType.PLAYER_LAZARUS2_B then
				-- Lazarus Risen is cut off because for some reason he replaces other characters above him
				sprite:ReplaceSpritesheet(0, MOD:returnLazarusVariantPath())
				sprite:LoadGraphics()
			elseif playertype == PlayerType.PLAYER_EDEN or playertype == PlayerType.PLAYER_EDEN_B then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/Eden/boss_075_isaac.png")
				sprite:LoadGraphics()
			elseif playertype == PlayerType.PLAYER_THELOST or playertype == PlayerType.PLAYER_THELOST_B then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/TheLost/boss_075_isaac.png")
				sprite:LoadGraphics()
			elseif playertype == PlayerType.PLAYER_LILITH or playertype == PlayerType.PLAYER_LILITH_B then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/Lilith/boss_075_isaac.png")
				sprite:LoadGraphics()
			elseif playertype == PlayerType.PLAYER_KEEPER or playertype == PlayerType.PLAYER_KEEPER_B then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/Keeper/boss_075_isaac.png")
				sprite:LoadGraphics()
			elseif playertype == PlayerType.PLAYER_APOLLYON or playertype == PlayerType.PLAYER_APOLLYON_B then
				print(MOD:returnApollyonVariantPath())
				sprite:ReplaceSpritesheet(0, MOD:returnApollyonVariantPath())
				sprite:LoadGraphics()
			elseif playertype == PlayerType.PLAYER_THEFORGOTTEN or playertype == PlayerType.PLAYER_THESOUL or playertype == PlayerType.PLAYER_THEFORGOTTEN_B then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/TheForgotten/boss_075_isaac.png")
				sprite:LoadGraphics()
			elseif playertype == PlayerType.PLAYER_BETHANY or playertype == PlayerType.PLAYER_BETHANY_B then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/Bethany/boss_075_isaac.png")
				sprite:LoadGraphics()
			elseif playertype == PlayerType.PLAYER_JACOB or playertype == PlayerType.PLAYER_JACOB_B or playertype == PlayerType.PLAYER_JACOB2_B then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/Jacob/boss_075_isaac.png")
				sprite:LoadGraphics()
			else
				sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/boss_075_isaac.png")
				sprite:LoadGraphics()
			end
		end
		if entity.Type == EntityType.ENTITY_BABY and entity.Variant == 1 and #Isaac.FindByType(102, 0, -1, false, true) >= 1 then
			if (playertype == PlayerType.PLAYER_CAIN or playertype == PlayerType.PLAYER_CAIN_B) and modconfig.replaceGuardianAngelsForCain then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/Cain/abel.png")
				sprite:LoadGraphics()
			elseif (playertype == PlayerType.PLAYER_LILITH or playertype == PlayerType.PLAYER_LILITH_B) and modconfig.replaceGuardianAngelsForLilith then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/Lilith/incubus.png")
				sprite:LoadGraphics()
			elseif (playertype == PlayerType.PLAYER_JACOB or playertype == PlayerType.PLAYER_JACOB_B or playertype == PlayerType.PLAYER_JACOB2_B) and modconfig.replaceGuardianAngelsForJacob then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/Jacob/esaujr.png")
				sprite:LoadGraphics()
			end
		end
	end
end

function MOD:initVars(npc)
	spawnedCorpse = {}
end

function MOD:YO(npc)
	local playertype = Isaac.GetPlayer(0):GetPlayerType()
	if not npc or npc.Variant ~= 0 then
		return
	end

	local sprite = npc:GetSprite()

	if sprite:IsFinished("2Evolve") and not spawnedCorpse[npc.Index] then
		if playertype == 10 or playertype == 16 or playertype == 17 or playertype == 35 or playertype == 31 then
			local newCorpse = Isaac.Spawn(102, 0, 1, npc.Position, Vector(0.0, 0.0), npc)
			MOD:animateCorpse(newCorpse)
			spawnedCorpse[npc.Index] = newCorpse
		end
	end
end

function MOD:animateCorpse(corpse)
	corpse:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
	corpse:AddEntityFlags(EntityFlag.FLAG_NO_TARGET)
	corpse.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE

	local sprite = corpse:GetSprite()
	sprite:Play("2EvolveDead")
end

function MOD:killMyCorpse(npc)
	local playertype = Isaac.GetPlayer(0):GetPlayerType()
	if not npc or npc.Variant ~= 0 then
		return
	end

	if spawnedCorpse[npc.Index] then
		if playertype == 10 or playertype == 31 then
			Isaac.Spawn(1000, 77, 0, spawnedCorpse[npc.Index].Position, Vector(0.0, 0.0), spawnedCorpse[npc.Index])
			Isaac.Spawn(1000, 16, 4, spawnedCorpse[npc.Index].Position, Vector(0.0, 0.0), spawnedCorpse[npc.Index])
		else
			Isaac.Spawn(1000, 1, 0, spawnedCorpse[npc.Index].Position, Vector(0.0, 0.0), spawnedCorpse[npc.Index])
		end
		spawnedCorpse[npc.Index]:Remove()
	end
end

-- save config to data directory
function MOD:saveModData()
	SaveState.selectedApollyonVariant = {}
	SaveState.selectedAzazelVariant = {}
	SaveState.selectedJudasVariant = {}
	SaveState.selectedLazarusVariant = {}
	SaveState.replaceGuardianAngelsForCain = {}
	SaveState.replaceGuardianAngelsForLilith = {}
	SaveState.replaceGuardianAngelsForJacob = {}

	for i,_ in pairs(modconfig) do
		SaveState.selectedApollyonVariant[tostring(i)] = modconfig[i]
	end

	for i,_ in pairs(modconfig) do
		SaveState.selectedAzazelVariant[tostring(i)] = modconfig[i]
	end

	for i,_ in pairs(modconfig) do
		SaveState.selectedJudasVariant[tostring(i)] = modconfig[i]
	end

	for i,_ in pairs(modconfig) do
		SaveState.selectedLazarusVariant[tostring(i)] = modconfig[i]
	end

	for i,_ in pairs(modconfig) do
		SaveState.replaceGuardianAngelsForCain[tostring(i)] = modconfig[i]
	end

	for i,_ in pairs(modconfig) do
		SaveState.replaceGuardianAngelsForLilith[tostring(i)] = modconfig[i]
	end

	for i,_ in pairs(modconfig) do
		SaveState.replaceGuardianAngelsForJacob[tostring(i)] = modconfig[i]
	end

	mod:SaveData(json.encode(SaveState))
end

-- Load data from file
function MOD:LoadModData()
	if MOD:HasData() then
		SaveState = json.decode(mod:LoadData())

		for i,_ in pairs(SaveState.selectedApollyonVariant) do
			modconfig[tostring[i]] = SaveState.selectedApollyonVariant[i]
		end

		for i,_ in pairs(SaveState.selectedAzazelVariant) do
			modconfig[tostring[i]] = SaveState.selectedAzazelVariant[i]
		end

		for i,_ in pairs(SaveState.selectedJudasVariant) do
			modconfig[tostring[i]] = SaveState.selectedJudasVariant[i]
		end

		for i,_ in pairs(SaveState.selectedLazarusVariant) do
			modconfig[tostring[i]] = SaveState.selectedLazarusVariant[i]
		end

		for i,_ in pairs(SaveState.replaceGuardianAngelsForCain) do
			modconfig[tostring[i]] = SaveState.replaceGuardianAngelsForCain[i]
		end

		for i,_ in pairs(SaveState.replaceGuardianAngelsForLilith) do
			modconfig[tostring[i]] = SaveState.replaceGuardianAngelsForLilith[i]
		end

		for i,_ in pairs(SaveState.replaceGuardianAngelsForJacob) do
			modconfig[tostring[i]] = SaveState.replaceGuardianAngelsForJacob[i]
		end
	end
end


--fixes for invisible characters
function MOD:returnJudasVariantPath()
	return "gfx/dudes/Judas/" .. noSpace(modconfig.getSelectedJudasVariant())  .. "/boss_075_isaac.png"
end

function MOD:returnAzazelVariantPath()
	return "gfx/dudes/Azazel/" .. noSpace(modconfig.getSelectedAzazelVariant())  .. "/boss_075_isaac.png"
end

function MOD:returnLazarusVariantPath()
	return "gfx/dudes/Lazarus/" .. noSpace(modconfig.getSelectedLazarusVariant())  .. "/boss_075_isaac.png"
end

function MOD:returnApollyonVariantPath()
	return "gfx/dudes/Apollyon/" .. noSpace(modconfig.getSelectedApollyonVariant())  .. "/boss_075_isaac.png"
end

function noSpace(str)

	local normalisedString = string.gsub(str, "%s+", "")
	return normalisedString
end

MOD:AddCallback(ModCallbacks.MC_POST_NPC_INIT, MOD.initVars, EntityType.ENTITY_ISAAC)
MOD:AddCallback(ModCallbacks.MC_NPC_UPDATE, MOD.YO, EntityType.ENTITY_ISAAC)
MOD:AddCallback(ModCallbacks.MC_POST_UPDATE, MOD.OnFrame)
MOD:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, MOD.killMyCorpse, EntityType.ENTITY_ISAAC)
MOD:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, MOD.saveModData)
MOD:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, MOD.LoadModData)