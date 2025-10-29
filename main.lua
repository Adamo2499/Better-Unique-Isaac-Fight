local betterUniqueIsaacFight = RegisterMod("Better Unique Isaac Fight", 1)
local spawnedCorpse = {}
local json = require("json")
local modConfig = require("mod_config")

modConfig:AddModConfigMenu()

function betterUniqueIsaacFight:OnFrame()
	local player = Isaac.GetPlayer(0)
	for _, entity in pairs(Isaac.GetRoomEntities()) do
		local sprite = entity:GetSprite()
		if entity.Type == EntityType.ENTITY_ISAAC and entity.Variant == 0 then
			betterUniqueIsaacFight:replaceIsaac(player,sprite)
		end
		if entity.Type == EntityType.ENTITY_BABY and entity.Variant == 1 and #Isaac.FindByType(102, 0, -1, false, true) >= 1 then
			betterUniqueIsaacFight:replaceAngelicBaby(player,sprite)
		end
	end
end

--- replace Isaac's sprite based on char name and if Last Judgement mod is enabled
--- @param player EntityPlayer
--- @param sprite Sprite
function betterUniqueIsaacFight:replaceIsaac(player, sprite)
	local playerName = player:GetName()
	local lastJudgementPrefix = betterUniqueIsaacFight:addLastJudgementPrefix()
	local specialVariant = betterUniqueIsaacFight:returnCharSpecialVariant(playerName)
	local spritePath = ""
	if player:GetPlayerType() <= PlayerType.PLAYER_JACOB2_B then
		spritePath = "gfx/dudes/" .. playerName .. lastJudgementPrefix .. specialVariant .. "/boss_075_isaac.png"
	else
		spritePath = "gfx/dudes/Isaac/" .. lastJudgementPrefix .. "/boss_075_isaac.png"
	end
	
	sprite:ReplaceSpritesheet(0, spritePath)
	sprite:LoadGraphics()
end

--- replace angelic baby sprite based on char name and MCM settings
--- @param player EntityPlayer
--- @param sprite Sprite
function betterUniqueIsaacFight:replaceAngelicBaby(player,sprite)
	local playerName = player:GetName()
	local spritePath = ""
	if modConfig.shouldAngelicBabyBeRespited(playerName) then
		spritePath = "gfx/dudes/" .. playerName .. "/angelicbaby.png"
		sprite:ReplaceSpritesheet(0, spritePath)
		sprite:LoadGraphics()		
	end
end

--- @param npc EntityType
function betterUniqueIsaacFight:initVars(npc)
	spawnedCorpse = {}
end

--- @param npc EntityType
function betterUniqueIsaacFight:spawnIsaacBody(npc)
	local playertype = Isaac.GetPlayer(0):GetPlayerType()
	if not npc or npc.Variant ~= 0 then
		return
	end

	local sprite = npc:GetSprite()

	if sprite:IsFinished("2Evolve") and not spawnedCorpse[npc.Index] then
		if 
			playertype == PlayerType.PLAYER_THELOST
			or playertype == PlayerType.PLAYER_THEFORGOTTEN
			or playertype == PlayerType.PLAYER_THESOUL
			or playertype == PlayerType.PLAYER_THELOST_B
			or playertype == PlayerType.PLAYER_THEFORGOTTEN_B
		then
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
function betterUniqueIsaacFight:killIsaacsBody(npc)
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

---return special variants for some chars
---@param playerName string
---@return string
function betterUniqueIsaacFight:returnCharSpecialVariant(playerName)
	local CHARS_WITH_SPECIAL_SPRITES = {"Judas", "Apollyon", "Azazel", "Lazarus"}
	local specialVariant = ""
	for _, value in ipairs(CHARS_WITH_SPECIAL_SPRITES) do
		if value == playerName then
			specialVariant = "/" .. modConfig.getSelectedVariantByCharName(playerName)
		end
	end
	return specialVariant
end

---return prefix for Last Judgement sprites
---returns string
function betterUniqueIsaacFight:addLastJudgementPrefix()
	local lastJudgementPrefix = ""
	if LastJudgement then
		lastJudgementPrefix = "/LJ"
	end

	return lastJudgementPrefix
end

betterUniqueIsaacFight:AddCallback(ModCallbacks.MC_POST_NPC_INIT, betterUniqueIsaacFight.initVars, EntityType.ENTITY_ISAAC)
betterUniqueIsaacFight:AddCallback(ModCallbacks.MC_NPC_UPDATE, betterUniqueIsaacFight.spawnIsaacBody, EntityType.ENTITY_ISAAC)
betterUniqueIsaacFight:AddCallback(ModCallbacks.MC_POST_UPDATE, betterUniqueIsaacFight.OnFrame)
betterUniqueIsaacFight:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, betterUniqueIsaacFight.killIsaacsBody, EntityType.ENTITY_ISAAC)
betterUniqueIsaacFight:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, betterUniqueIsaacFight.saveModData)
betterUniqueIsaacFight:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, betterUniqueIsaacFight.LoadModData)