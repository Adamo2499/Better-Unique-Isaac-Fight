local MOD = RegisterMod("Character Based Isaac", 1)
local spawnedCorpse = {}
function MOD:OnFrame()
	local playertype = Isaac.GetPlayer(0):GetPlayerType()
	for _, entity in pairs(Isaac.GetRoomEntities())	do
		local sprite = entity:GetSprite()
		local data = false
		local data2 = false
		if entity.Type == 102 and entity.Variant == 0 then 
			if data == false then
				data = true
				if playertype == PlayerType.PLAYER_MAGDALENE or playertype == PlayerType.PLAYER_MAGDALENE_B then 	
						sprite:ReplaceSpritesheet(0, "gfx/dudes/Magdalene/boss_075_isaac.png")
						sprite:LoadGraphics()
			
				elseif playertype == PlayerType.PLAYER_CAIN or playertype == PlayerType.PLAYER_CAIN_B then 				
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Cain/boss_075_isaac.png")
					sprite:LoadGraphics()
			
				elseif playertype == PlayerType.PLAYER_JUDAS or playertype == PlayerType.PLAYER_JUDAS_B or playertype == PlayerType.PLAYER_BLACKJUDAS then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Judas/boss_075_isaac.png")
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
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Azazel/boss_075_isaac.png")
					sprite:LoadGraphics()
		
				elseif playertype == PlayerType.PLAYER_LAZARUS or PlayerType.PLAYER_LAZARUS2 or playertype == PlayerType.PLAYER_LAZARUS_B or playertype == PlayerType.PLAYER_LAZARUS2_B then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Lazarus/boss_075_isaac.png")
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
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Apollyon/boss_075_isaac.png")
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
		end
		if entity.Type == 38 and entity.Variant == 1 and #Isaac.FindByType(102, 0, -1, false, true) >= 1 then
			if data2 == false then
				data2 = true
				if playertype == 2 or playertype == 23 then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Cain/abel.png")
					sprite:LoadGraphics()
				elseif playertype == 13 or playertype == 32 then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Lilith/incubus.png")
					sprite:LoadGraphics()
				elseif playertype == 19 or playertype == 37 or playertype == 39 then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Jacob/esaujr.png")
					sprite:LoadGraphics()
				end 
			end
		else data2=false
		    end 

        end 
end
MOD:AddCallback(ModCallbacks.MC_POST_UPDATE, MOD.OnFrame)

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


MOD:AddCallback(ModCallbacks.MC_POST_NPC_INIT, MOD.initVars, EntityType.ENTITY_ISAAC)
MOD:AddCallback(ModCallbacks.MC_NPC_UPDATE, MOD.YO, EntityType.ENTITY_ISAAC)
MOD:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, MOD.killMyCorpse, EntityType.ENTITY_ISAAC)

