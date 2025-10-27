local betterUniqueIsaacFight = RegisterMod("Better Unique Isaac Fight", 1)
local spawnedCorpse = {}
local SaveState = {}
local json = require("json")
local modConfig = require("mod_config")

modConfig:AddModConfigMenu()

function betterUniqueIsaacFight:OnFrame()
	local player = Isaac.GetPlayer(0)
	for _, entity in pairs(Isaac.GetRoomEntities()) do
		local sprite = entity:GetSprite()
		if entity.Type == 102 and entity.Variant == 0 then
			betterUniqueIsaacFight:replaceIsaac(player,sprite)
		end
		if entity.Type == EntityType.ENTITY_BABY and entity.Variant == 1 and #Isaac.FindByType(102, 0, -1, false, true) >= 1 then
			if (player:GetPlayerType() == PlayerType.PLAYER_CAIN or player:GetPlayerType() == PlayerType.PLAYER_CAIN_B) and modConfig.Options.replaceAngelicBabyForChar.Cain then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/Cain/abel.png")
				sprite:LoadGraphics()
			elseif (player:GetPlayerType() == PlayerType.PLAYER_LILITH or player:GetPlayerType() == PlayerType.PLAYER_LILITH_B) and modConfig.Options.replaceAngelicBabyForChar.Lilith then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/Lilith/incubus.png")
				sprite:LoadGraphics()
			elseif (player:GetPlayerType() == PlayerType.PLAYER_JACOB or player:GetPlayerType() == PlayerType.PLAYER_JACOB_B or player:GetPlayerType() == PlayerType.PLAYER_JACOB2_B) and modConfig.Options.replaceAngelicBabyForChar.Jacob then
				sprite:ReplaceSpritesheet(0, "gfx/dudes/Jacob/esaujr.png")
				sprite:LoadGraphics()
			end
		end
	end
end

--- @param player EntityPlayer
--- @param sprite Sprite
function betterUniqueIsaacFight:replaceIsaac(player, sprite)
	local spritePath = "gfx/dudes/" .. player:GetName() .. "/boss_075_isaac.png"
	sprite:ReplaceSpritesheet(0, spritePath)
	sprite:LoadGraphics()
end

--- @param npc EntityType
function betterUniqueIsaacFight:initVars(npc)
	spawnedCorpse = {}
end

--- @param npc EntityType
function betterUniqueIsaacFight:YO(npc)
	local playertype = Isaac.GetPlayer(0):GetPlayerType()
	if not npc or npc.Variant ~= 0 then
		return
	end

	local sprite = npc:GetSprite()

	if sprite:IsFinished("2Evolve") and not spawnedCorpse[npc.Index] then
		if playertype == 10 or playertype == 16 or playertype == 17 or playertype == 35 or playertype == 31 then
			local newCorpse = Isaac.Spawn(102, 0, 1, npc.Position, Vector(0.0, 0.0), npc)
			betterUniqueIsaacFight:animateCorpse(newCorpse)
			spawnedCorpse[npc.Index] = newCorpse
		end
	end
end

function betterUniqueIsaacFight:animateCorpse(corpse)
	corpse:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
	corpse:AddEntityFlags(EntityFlag.FLAG_NO_TARGET)
	corpse.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE

	local sprite = corpse:GetSprite()
	sprite:Play("2EvolveDead")
end

--- method for killing Isaac's body for The Lost and The Soul
--- @param npc EntityType
function betterUniqueIsaacFight:killMyCorpse(npc)
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

--- save config to data directory
function betterUniqueIsaacFight:saveModData()
	betterUniqueIsaacFight:SaveData(json.encode(modConfig.Options))
end

--- Load data from file
function betterUniqueIsaacFight:LoadModData()
	if betterUniqueIsaacFight:HasData() then
		local modOptions = json.decode(betterUniqueIsaacFight:LoadData())
		modConfig.Options = modOptions
	end
end


--- fixes for invisible characters
function betterUniqueIsaacFight:returnJudasVariantPath()
	return "gfx/dudes/Judas/" .. noSpace(modConfig.getSelectedJudasVariant())  .. "/boss_075_isaac.png"
end

function betterUniqueIsaacFight:returnAzazelVariantPath()
	return "gfx/dudes/Azazel/" .. noSpace(modConfig.getSelectedAzazelVariant())  .. "/boss_075_isaac.png"
end

function betterUniqueIsaacFight:returnLazarusVariantPath()
	return "gfx/dudes/Lazarus/" .. noSpace(modConfig.getSelectedLazarusVariant())  .. "/boss_075_isaac.png"
end

function betterUniqueIsaacFight:returnApollyonVariantPath()
	return "gfx/dudes/Apollyon/" .. noSpace(modConfig.getSelectedApollyonVariant())  .. "/boss_075_isaac.png"
end

function noSpace(str)
	return string.gsub(str, "%s+", "")
end

betterUniqueIsaacFight:AddCallback(ModCallbacks.MC_POST_NPC_INIT, betterUniqueIsaacFight.initVars, EntityType.ENTITY_ISAAC)
betterUniqueIsaacFight:AddCallback(ModCallbacks.MC_NPC_UPDATE, betterUniqueIsaacFight.YO, EntityType.ENTITY_ISAAC)
betterUniqueIsaacFight:AddCallback(ModCallbacks.MC_POST_UPDATE, betterUniqueIsaacFight.OnFrame)
betterUniqueIsaacFight:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, betterUniqueIsaacFight.killMyCorpse, EntityType.ENTITY_ISAAC)
betterUniqueIsaacFight:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, betterUniqueIsaacFight.saveModData)
betterUniqueIsaacFight:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, betterUniqueIsaacFight.LoadModData)