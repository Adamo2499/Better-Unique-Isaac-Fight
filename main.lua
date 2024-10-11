local MOD = RegisterMod("Character Based Isaac", 1)
local game = Game()
local player = Isaac.GetPlayer(0)
local Level = Game():GetLevel()
local spawnedCorpse = {}
local corpseSpawned = false
function MOD:OnFrame()
	local room = game:GetRoom()
	local playertype = Isaac.GetPlayer(0):GetPlayerType()
	--local entity = Isaac.FindByType(102, 0, -1) 
	for _, entity in pairs(Isaac.GetRoomEntities())	do
		local sprite = entity:GetSprite()
		local data = false
		local data2 = false
		if entity.Type == 102 and entity.Variant == 0 then 
			if data == false then
				data = true
				if playertype == PlayerType.PLAYER_ISAAC or playertype == PlayerType.PLAYER_ISAAC_B then 	
						sprite:ReplaceSpritesheet(0, "gfx/dudes/Magdalene/boss_075_isaac.png")
						sprite:LoadGraphics()
			
				elseif playertype == 2 or playertype == 23 then 				
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Cain/boss_075_isaac.png")
					sprite:LoadGraphics()
			
				elseif playertype == 3 or playertype == 24 or playertype == 12 then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Judas/boss_075_isaac.png")
					sprite:LoadGraphics()
				
				elseif playertype == 4 or playertype == 25 then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/BlueBaby/boss_075_isaac.png")
					sprite:LoadGraphics()
			
				elseif playertype == 5 or playertype == 26 then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Eve/boss_075_isaac.png")
					sprite:LoadGraphics()
			
				elseif playertype == 6 or playertype == 27 then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Samson/boss_075_isaac.png")
					sprite:LoadGraphics()
			
				elseif playertype == 7 or playertype == 28 then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Azazel/boss_075_isaac.png")
					sprite:LoadGraphics()
		
				elseif playertype == 8 or playertype == 29 or playertype == 38 or playertype == 11 then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Lazarus/boss_075_isaac.png")
					sprite:LoadGraphics()
			
				elseif playertype == 9 or playertype == 30 then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Eden/boss_075_isaac.png")
					sprite:LoadGraphics()
			
				elseif playertype == 10 or playertype == 31 then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/TheLost/boss_075_isaac.png")
					sprite:LoadGraphics()
			
				elseif playertype == 13 or playertype == 32 then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Lilith/boss_075_isaac.png")
					sprite:LoadGraphics()
			
				elseif playertype == 14 or playertype == 33 then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Keeper/boss_075_isaac.png")
					sprite:LoadGraphics()
			
				elseif playertype == 15 or playertype == 34 then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Apollyon/boss_075_isaac.png")
					sprite:LoadGraphics()
			
				elseif playertype == 16 or playertype == 17 or playertype == 35 then
					sprite:ReplaceSpritesheet(0, "gfx/dudes/TheForgotten/boss_075_isaac.png")
					sprite:LoadGraphics()
			
				elseif playertype == 18 or playertype == 36 then 
					sprite:ReplaceSpritesheet(0, "gfx/dudes/Bethany/boss_075_isaac.png")
					sprite:LoadGraphics()
			
				elseif playertype == 19 or playertype == 37 or playertype == 39 then 
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

