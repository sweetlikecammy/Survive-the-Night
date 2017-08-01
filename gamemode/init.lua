include( 'shared.lua' )

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_weaponchange.lua")
AddCSLuaFile("cl_winscreen.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_scoreboard.lua")
AddCSLuaFile("cl_overheadinfo.lua")
AddCSLuaFile("cl_factionboard.lua")
AddCSLuaFile("cl_spawnscreen.lua")
AddCSLuaFile("config/classes_config.lua")
AddCSLuaFile("config/main_config.lua")
AddCSLuaFile("cl_fonts.lua")
AddCSLuaFile("player_class/player_default.lua")
AddCSLuaFile("cl_fonts.lua")
AddCSLuaFile("cl_cards.lua")

GM.PlayerSpawnTime = {}

--[[---------------------------------------------------------
   Name: gamemode:Initialize()
   Desc: Called immediately after starting the gamemode
-----------------------------------------------------------]]
function GM:Initialize()
	StartGameChecker()
end

function StartGameChecker()
	timer.Create("StartGameTimer", 5, 1, function()
		if(#player.GetAll() > 4)then
			SVR:StartGame()
		else
			StartGameChecker()
		end
	end)
end

--[[---------------------------------------------------------
   Name: gamemode:InitPostEntity()
   Desc: Called as soon as all map entities have been spawned
-----------------------------------------------------------]]
function GM:InitPostEntity()
	LoadMapJudgement()
end

--[[---------------------------------------------------------
   Name: gamemode:Think()
   Desc: Called every frame
-----------------------------------------------------------]]
function GM:Think()
	--print(math.Round(timer.TimeLeft("ChangeTime")))
end

function GM:PlayerInitialSpawn(plyr)
	plyr:SetTeam(99)
	plyr:SetCustomCollisionCheck(true)
	player_manager.SetPlayerClass( plyr, "Dead")
	player_manager.OnPlayerSpawn( plyr )
	player_manager.RunClass( plyr, "Spawn" )
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawn(plyr)
   Desc: Called every frame
-----------------------------------------------------------]]
function GM:PlayerSpawn(plyr)
	plyr:SetupHands()
end

--[[---------------------------------------------------------
   Name: gamemode:ShutDown()
   Desc: Called when the Lua system is about to shut down
-----------------------------------------------------------]]
function GM:ShutDown()

end

--[[---------------------------------------------------------
   Name: gamemode:GetFallDamage()
   Desc: Give the player falldamage
-----------------------------------------------------------]]
function GM:GetFallDamage(plyr, speed)
	return(speed/15)
end

--[[---------------------------------------------------------
   Name: gamemode:DoPlayerDeath( )
   Desc: Carries out actions when the player dies
-----------------------------------------------------------]]
function GM:DoPlayerDeath( plyr, attacker, dmginfo )
	if(plyr:Team() != 99)then 
		plyr:CreateRagdoll()
		plyr:SetTeam(99)
		player_manager.SetPlayerClass( plyr, "Dead")
		player_manager.OnPlayerSpawn( plyr )
		player_manager.RunClass( plyr, "Spawn" )
		
		plyr:SetRenderMode(RENDERMODE_TRANSALPHA)
		plyr:SetColor(Color(255,255,255,30))
		plyr:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		plyr:SetNWBool("Ghost", true)
	end
end
function GM:PlayerSay(plyrSender, message, teamChat)
	
end

--[[---------------------------------------------------------
   Name: gamemode:EntityTakeDamage( ent, info )
   Desc: The entity has received damage
-----------------------------------------------------------]]
function GM:EntityTakeDamage( ent, info )
	print(ent:GetName() .. " is taking damage!")
end

function GM:PlayerCanHearPlayersVoice(plyrListener, plyrTalker)
	if(player_manager.GetPlayerClass(plyrTalker) == "Governor" && plyrTalker:GetNWBool("revealed"))then -- If the talker is the governor and he is revealed himself then
		return true
	end
	
	if(plyrTalker:Team() == 99 && plyrListener:Team() != 99)then -- If the talker is dead and the person listening isnt dead then
		return false
	else
		return true
	end
	
	if(plyrTalker:GetPos():Distance( plyrTalker:GetPos() ) > MAIN_CONFIG.maxVocalDistance)then -- If the talker is dead and the person listening isnt dead then
		return false, true
	end
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerHurt( )
   Desc: Called when a player is hurt.
-----------------------------------------------------------]]
function GM:PlayerHurt( player, attacker, healthleft, healthtaken )
end

--[[---------------------------------------------------------
   Name: gamemode:CreateEntityRagdoll( entity, ragdoll )
   Desc: A ragdoll of an entity has been created
-----------------------------------------------------------]]
function GM:CreateEntityRagdoll( entity, ragdoll )
end

-- Set the ServerName every 30 seconds in case it changes..
-- This is for backwards compatibility only - client can now use GetHostName()
local function HostnameThink()

	SetGlobalString( "ServerName", GetHostName() )

end

timer.Create( "HostnameThink", 30, 0, HostnameThink )

--[[---------------------------------------------------------
	Show the default team selection screen
-----------------------------------------------------------]]
function GM:ShowTeam( ply )

end

--
-- CheckPassword( steamid, networkid, server_password, password, name )
--
-- Called every time a non-localhost player joins the server. steamid is their 64bit
-- steamid. Return false and a reason to reject their join. Return true to allow
-- them to join.
--
function GM:CheckPassword( steamid, networkid, server_password, password, name )

	-- The server has sv_password set
	if ( server_password != "" ) then

		-- The joining clients password doesn't match sv_password
		if ( server_password != password ) then
			return false
		end

	end
	
	--
	-- Returning true means they're allowed to join the server
	--
	return true

end

--[[---------------------------------------------------------
   Name: gamemode:PlayerSwitchWeapon(plyr,oldWeapon,newWeapon)
   Desc: Called when the player switches weapon
-----------------------------------------------------------]]
function GM:PlayerSwitchWeapon(plyr, oldWeapon, newWeapon)
	--print("Old Weapon:" .. oldWeapon:GetPrintName())
	--WEPSWITCH:CallWepSwitch()
end

--[[---------------------------------------------------------
   Name: gamemode:FinishMove( player, movedata )
-----------------------------------------------------------]]
function GM:VehicleMove( ply, vehicle, mv )

	--
	-- On duck toggle third person view
	--
	if ( mv:KeyPressed( IN_DUCK ) && vehicle.SetThirdPersonMode ) then
		vehicle:SetThirdPersonMode( !vehicle:GetThirdPersonMode() )
	end

	--
	-- Adjust the camera distance with the mouse wheel
	--
	local iWheel = ply:GetCurrentCommand():GetMouseWheel()
	if ( iWheel != 0 && vehicle.SetCameraDistance ) then
		-- The distance is a multiplier
		-- Actual camera distance = ( renderradius + renderradius * dist )
		-- so -1 will be zero.. clamp it there.
		local newdist = math.Clamp( vehicle:GetCameraDistance() - iWheel * 0.03 * ( 1.1 + vehicle:GetCameraDistance() ), -1, 10 )
		vehicle:SetCameraDistance( newdist )
	end

end
