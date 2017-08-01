-- This is used for all custom serverside methods/functions

-- Start Vars --
SVR = {}

SVR.friendlyKillers = {}
SVR.playersRevealed = {}  -- List of those who have revealed their job
SVR.nightPlayersDead = {}  -- List of those who have revealed their job

SVR.callingCards = {}  -- List of Calling Cards psycho groups can place on their victims
SVR.deathNotes = {}  -- List of Death notes players can create

SVR.ghostMessages = {}  -- List of messages sent by the ghosts

SVR.gameStarted = false
SVR.gameOver = false
SVR.time = 0 -- 0 = Not Started, 1 = night , 2 = judgement

SVR.dayClasses = {}
SVR.nightClasses = {}
SVR.alivePlayers = {}

SVR.judgementStandPos = Vector(0,0,0)
SVR.collisionsOff = false

SVR.flag_hasPlayerDied = true -- Flag to see if anyone died the night before
SVR.deathlessNights = 0 -- Count of how many nights of gone by without a death

-- End Vars --

-- All Net Messages to Precache
util.AddNetworkString("SelectWeapon")
util.AddNetworkString("job")
util.AddNetworkString("StartGameTimer")
util.AddNetworkString("winGame")
util.AddNetworkString("jobAction")
util.AddNetworkString("SetDeathCard")
util.AddNetworkString("SetCallingCard")
util.AddNetworkString("GameOver")

-- SelectWeapon
net.Receive("SelectWeapon", function(length, plyr)
	print("FUCK") 
	if(plyr == nil) then return end
	wepName = net.ReadString()
	plyr:SelectWeapon(wepName)
	
	print("Weapon: " .. wepName .. " was given to " .. plyr:Name())
end)

function SVR:StartRound()  -- Function called when a new round is starting
	if(gameStarted == false or gameOver == true)then
		Msg("Start Round")
	end
end

function SVR:StartWeapons(plyr)  -- Give weapons to player on spawn
	jobName = player_manager.GetPlayerClass(plyr)
	plyr:Give("weapon_fists")
	plyr:GetWeapon("weapon_fists"):SetNWInt("slot", 1)
	print("SLOT " .. 1 .. " WEAPON " .. "weapon_fists")
	
	if(CLASS_CONFIG != nil)then
		for k,v in pairs(CLASS_CONFIG.Classes)do
			if(jobName == v["name"])then
				for i,w in pairs(v["items"]) do
					if(w == nil)then break end
					if (i == "melee") then
						plyr:Give(w)
						plyr:GetWeapon(w):SetNWInt("slot", 2)
						print("SLOT " .. 2 .. " WEAPON " .. w)
					elseif(i == "ranged")then
						plyr:Give(w)
						plyr:GetWeapon(w):SetNWInt("slot", 3)
						print("SLOT " .. 3 .. " WEAPON " .. w)
					elseif(i == "tool")then
						plyr:Give(w)
						plyr:GetWeapon(w):SetNWInt("slot", 4)
						print("SLOT " .. 4 .. " WEAPON " .. w)
					end
				end
			end
		end
	end
end

--[[function CreateDeathDoll(vitim,killer,dmginfo)

	local ragdoll = ents.Create("prop_ragdoll")
	ragdoll:SetPos(vitim:GetPos())
		ragdoll:SetModel(vitim:GetModel())
		ragdoll:Spawn()
		ragdoll:Activate()
		ragdoll:SetVelocity(vitim:GetVelocity())
		ragdoll.OwnerINT = vitim:EntIndex()
		ragdoll.PhysgunPickup = false
		ragdoll.CanTool = false
		ragdoll.Owner = vitim      
		ragdoll.Useable = true
		ragdoll.HealAmt = 5

end ]]

function SVR:ChangeTime()
	if(timer.Exists("ChangeTime") == true)then
		timer.Remove("ChangeTime")
	end
	local curTime = SVR.time
	if(curTime == 1) then -- To Judgement
		curTime = 2
		SVR:JudgementTime()
	elseif(curTime == 2 or curTime == 0)then -- To Night
		curTime = 1
		SVR:NightTime()
		net.Start("StartGameTimer")
			net.WriteString("nightTimer")
		net.Broadcast()
		local nightTime = MAIN_CONFIG.nightTime or 60
		timer.Create("ChangeTime", nightTime, 0, function()
			SVR:ChangeTime()
		end)
	end
	
	SVR.time = curTime
end

function SVR:NightTime()
	SVR:ClearJail()
	if(SVR.flag_hasPlayerDied)then
		SVR.deathlessNights = 0
		SVR.flag_hasPlayerDied = false
	else
		if(MAIN_CONFIG.deathlessNights <= SVR.deathlessNights)then
			--SVR:Gameover(nil, false)
		end
		SVR.deathlessNights = SVR.deathlessNights + 1
	end
	print("It is now night time!")
	SVR:RespawnPlayers(nil)
end

function SVR:ClearJail()
	for k,v in pairs(ents.GetAll())do
		if(v:GetClass() == "entity_jail")then v:Remove() end
	end
end

function SVR:RespawnPlayers(plyr)
	local spawnPoints = {}
	table.Add(spawnPoints, ents.FindByClass( "info_player_start" ))
	table.Add(spawnPoints, ents.FindByClass( "info_player_counterterrorist" ))
	table.Add(spawnPoints, ents.FindByClass( "info_player_terrorist" ))
	table.Add(spawnPoints, ents.FindByClass( "info_player_deathmatch" ))
	if(plyr == nil)then
		for k,v in pairs(player.GetAll())do
			if(v:Team() != 99)then
				local randNum = math.random( #spawnPoints )
				local randSpawnPos = spawnPoints[randNum]:GetPos() or spawnPoints[1]:GetPos()
				randSpawnPos = Vector(randSpawnPos.x, randSpawnPos.y, randSpawnPos.z)
				v:SetPos(randSpawnPos)
				GAMEMODE:SetPlayerSpeed(v, 250, 400)
				SVR:StartWeapons(v)
			end
		end
	else
		local randNum = math.random( #spawnPoints )
		local randSpawnPos = spawnPoints[randNum]:GetPos() or spawnPoints[1]:GetPos()
		randSpawnPos = Vector(randSpawnPos.x, randSpawnPos.y, randSpawnPos.z)
		plyr:SetPos(randSpawnPos)
		GAMEMODE:SetPlayerSpeed(plyr, 250, 400)
		SVR:StartWeapons(plyr)
	end
end

function SVR:JudgementTime()
	local randomizedMessages = {}
	for a,b in pairs(SVR.ghostMessages)do
		randomizedMessages[#randomizedMessages + 1] = SVR:ScrambleText(b)
	end
	
	for c,d in pairs(player.GetAll())do
		if(#randomizedMessages > 0)then d:ChatPrint("Ghost Messages") end
		for e,f in pairs(randomizedMessages)do
			d:ChatPrint(f)
		end
	end
	
	SVR.ghostMessages = {}
	
	net.Start("ListDeadPeople")
		net.WriteTable(SVR.nightPlayersDead)
	net.Broadcast()
	deadPeoplesIndex = 0
	for a,b in pairs(SVR.nightPlayersDead)do
		deadPeoplesIndex = deadPeoplesIndex + 1
	end
	timer.Create("ListDeadPeople", deadPeoplesIndex * 4, 1, function()
		SVR:CheckMission()
		SV_JUDGE:Start()
	end)
	SVR.nightPlayersDead = {}
	print("It is now judgementx time!")
	local teleBuffer = 0
	local alivePlayers = {}
	for k,v in pairs(player.GetAll())do
		if(player_manager.GetPlayerClass(v) != "Dead")then alivePlayers[k] = v end
	end
	local startLineBuffer = #alivePlayers * 10/2 -- Distance to move the entire line to center it
	print(startLineBuffer)
	for k,v in pairs(alivePlayers)do
		v:StripWeapons()
		v:SetLocalVelocity(Vector(0,0,0))
		if(not v:IsSuperAdmin()) then GAMEMODE:SetPlayerSpeed(v, 0, 0) end
		v:SetPos(Vector(judgementStandPos.x+teleBuffer-startLineBuffer, judgementStandPos.y, judgementStandPos.z))
		teleBuffer = teleBuffer + 20
	end 
end


--[[---------------------------------------------------------
   Name: gamemode:ShouldCollide( a, b )
   Desc: This should always return true unless you have
		  a good reason for it not to.
-----------------------------------------------------------]]
function EntsShouldCollide( a, b )
	if(a:IsPlayer() && b:IsPlayer())then
		if(a:Team() == 99 or b:Team() == 99) then return false end
		if(SVR.time == 2) then return false end
	end
	
	if a:IsValid() and a:IsPlayer() and b:IsValid() and b:IsPlayer() then
		if a:GetPhysicsObject():IsPenetrating() != false or b:GetPhysicsObject():IsPenetrating() != false then
			return false
		end
	end
	
	return true

end
hook.Add("ShouldCollide", "DisableCollisionsDuringJudgement", EntsShouldCollide) 

function OnKill(victim, killer, damageInfo)
	if(victim:IsPlayer() && killer:IsPlayer())then
		local createDNASpot = ents.Create("entity_dna")
		local faction, job, name = team.GetName(killer:Team()), player_manager.GetPlayerClass(killer), killer:Nick()
		createDNASpot:SetDNA(faction, job, name)
		createDNASpot:SetPos(victim:GetPos())
		createDNASpot:Spawn()
		createDNASpot:Activate()
	
	if(SVR.time == 1)then
		local deathNote = SVR.deathNotes[victim:Nick()] or ""
		local callingCard = SVR.callingCards[killer:Nick()] or ""
		SVR.nightPlayersDead[victim:Nick()] = {["deathNote"] = deathNote, ["callingCard"] = callingCard, ["player"] = victim}
	end 
	
	SVR:CheckJob(victim,killer,damageInfo)
	
	end
end
hook.Add("DoPlayerDeath", "CheckJobandMission", OnKill)

net.Receive("SetDeathCard", function(len, plyr)
	local deathMessage = net.ReadString()
	SVR.deathNotes[plyr:Nick()] = deathMessage
	PrintTable(SVR.deathNotes)
end)

net.Receive("SetCallingCard", function(len, plyr)
	local killMessage = net.ReadString()
	SVR.callingCards[plyr:Nick()] = killMessage
	PrintTable(SVR.callingCards)
end)

function SVR:CheckJob(victim, killer, dmgInfo)  -- Check if player has accomplished something of his job
	if(!killer:IsPlayer() or !victim:IsPlayer() or victim == killer) then 
		
	else
		SVR.flag_hasPlayerDied = true
		local victimName = victim:GetName()
		print(victimName)
		for k,v in pairs(CLASS_CONFIG.Classes)do -- For each class
			if(v["name"] == player_manager.GetPlayerClass(killer))then
				local jobFunction = v["jobFunc"]
				local jobResult = jobFunction(victim, killer, dmgInfo) or 3
				if(jobResult == 1)then -- If the player has done something
					--killer:SendLua("WINSCREEN:SuccessDrawChatProgress("..victim:Team()..",'".. player_manager.GetPlayerClass(victim) .."', '"..victimName.."' )")
				elseif(jobResult == 2)then
					friendsKilled = SVR.friendlyKillers[killer:GetName()] or 0
					SVR.friendlyKillers[killer:GetName()] = friendsKilled + 1
					killer:SendLua("WINSCREEN:FailureDrawChatProgress("..victim:Team()..",'".. player_manager.GetPlayerClass(victim) .."', '"..victimName.."' )")
				else
					
				end
					friendsKilled = SVR.friendlyKillers[killer:GetName()] or 0
				if(friendsKilled > MAIN_CONFIG.friendlyKillMax && MAIN_CONFIG.friendlyKillMax != -1)then
					killer:SendLua("WINSCREEN:GuiltSuicide()")
					print("Friendlies: "..SVR.friendlyKillers[killer:GetName()])
					SVR.friendlyKillers[killer:GetName()] = 0
					print("Friendlies: "..SVR.friendlyKillers[killer:GetName()])
					killer:Kill()
				end
			end
		end
	end
end

function SVR:CheckMission()  -- Check if anyone has gained from the death
	for k,v in pairs(CLASS_CONFIG.Factions)do -- For each class
		local jobFunction = v["victoryFunc"]
		local teamNum = 99
		local jobResult = jobFunction() or false
		if(isnumber(jobResult) && jobResult > 1)then
			for a,b in pairs(player.GetAll())do
				if(team.GetName(b:Team()) == v["name"])then
					b:ChatPrint("You have "..jobResult.." enemies left!")
				end
			end
		elseif(jobResult == true)then -- If the player has done something
			for a,b in pairs(team.GetAllTeams())do
				if(b["Name"] == v["name"])then
					teamNum = a
					print("SET GAMEOVER TEAM TO : " .. a)
				end
			end
			SVR:Gameover(teamNum, true)
		elseif(jobResult == false)then
			
		end
	end
end

function SVR:Gameover(winTeam, didWin)
	if SVR.gameOver or winTeam == nil then return end
	SVR.gameOver = true
	if(didWin)then
		net.Start("StartGameTimer")
			net.WriteString("gameOverTimer")
		net.Broadcast()
		print("START THE WIN GAME")
		net.Start("winGame")
			net.WriteInt(winTeam,32)
		net.Broadcast()
		SVR.deathlessNights = 0
		SVR.flag_hasPlayerDied = true
		timer.Create("GameOverTimer", MAIN_CONFIG.gameOverTime - 1, 1, function()
			SVR.deathlessNights = 0
			SVR.flag_hasPlayerDied = true
			SVR.gameOver = false
			SVR:StartGame()
		end)
	else
		SVR.deathlessNights = 0
		SVR.flag_hasPlayerDied = true
		for k,v in pairs(player.GetAll())do
			v:ChatPrint("Game is over because no one died!")
			v:ChatPrint("Game will reset in...")
		end
		timer.Create("GameOverTimer", 1, 5, function()
			if(timer.RepsLeft("GameOverTimer") == 0)then
				SVR.deathlessNights = 0
				SVR.flag_hasPlayerDied = true
				SVR.gameOver = false
				SVR:StartGame()
			else
				for k,v in pairs(player.GetAll())do
					v:ChatPrint(timer.RepsLeft("GameOverTimer"))
				end
			end
		end)
	end
end

function SVR:StartGame()
	for k,v in pairs(player.GetAll())do
		if(v:Team() != TEAM_CONNECTING)then
			player_manager.ClearPlayerClass(v)
			player_manager.SetPlayerClass( v, "Dead")
			v:SetTeam(99)
			v:StripWeapons()
			v:SendLua("ResetScoreboard()")
			v:SendLua("HUD.spawn = true")
			v:SetColor(Color(255,255,255,255))
			v:SetCollisionGroup(COLLISION_GROUP_PLAYER)
			
		end
	end
	if(timer.Exists("StartVoteTime") == true)then timer.Remove("StartVoteTime")end
	if(timer.Exists("ExecutePlayer") == true)then timer.Remove("ExecutePlayer")end
	
	SVR.time = 0
	SVR.playersRevealed = {}
	SVR:SetFactions()
	SVR:ChangeTime()
end

function SVR:SetFactions()
	if(CLASS_CONFIG == nil)then error("ERROR: CLASSES CONFIG FILE NOT FOUND! FIX AND RESTART!") return end
	print("Set Player in Factions")
	local factionAmounts = {}
	classAmounts = {}
	
	local factionPercent = 0
	for k,v in pairs(CLASS_CONFIG.Factions)do  -- For each Faction
		factionPercent = factionPercent + v["playerAmount"]
		teamCode = v["teamCode"] or 100
		factionAmounts[teamCode] = math.ceil(v["playerAmount"] * #team.GetPlayers(99))
		print("Percent: " .. v["playerAmount"])
	end
	print("FACTION AMOUNTS:" .. #team.GetPlayers(99))
	PrintTable(factionAmounts)
	if(factionPercent != 1)then -- Check to see if the Faction Percent is more than 1, if it is call an error
		error("playerAmount in Factions do not add up to 1! Fix this or else placement will be falted.")
	end
	
	for x,y in pairs(factionAmounts)do -- For each Faction
		for i=1, #team.GetPlayers(99) do  -- For each player
			print(factionAmounts[x])
			local playerRand = math.random(1,#team.GetPlayers(99))
			local randomPlayer = team.GetPlayers(99)[playerRand]
			if(factionAmounts[x] > 0)then
				randomPlayer:SetTeam(x)
				print("Set " .. randomPlayer:Name() .. " to " .. team.GetName(x))
				SVR.alivePlayers[#SVR.alivePlayers+1] = randomPlayer
				factionAmounts[x] = factionAmounts[x] - 1
			end
		end
	end
	
	SVR:SetClasses()
end

function SVR:SetClasses()
	print("Set players' classes")
	for k,v in pairs(team.GetAllTeams())do  -- For each team , k = index, v = team
		classAmounts[k] = {}-- Table for the amount of each class people need to be assigned to
		plyrsLeft = team.NumPlayers(k)
			for c,d in pairs(CLASS_CONFIG.Classes)do  -- For each class , c = shortCode, d = class details
				if(d["faction"]["name"] == v["Name"])then
					if(d["priority"] == nil)then -- Create priority if none given
						CLASS_CONFIG.Classes[c]["priority"] = 9999
					end
					if(d["leader"] != nil)then
						classAmounts[k][#classAmounts[k]+1] = {
							["name"] = d["name"],
							["priority"] = 0,
							["leader"] = true
						}
						plyrsLeft = plyrsLeft - 1
					elseif(d["maxAmount"] != nil)then
						classAmounts[k][#classAmounts[k]+1] = {
							["name"] = d["name"],
							["priority"] = d["priority"],
							["maxAmount"] = d["maxAmount"]
						}
					else
						classAmounts[k][#classAmounts[k]+1] ={
							["name"] = d["name"],
							["priority"] = d["priority"],
							["amount"] = math.ceil(plyrsLeft * d["playerAmount"])
						} 
					end
				end
			end	
	end
	
	for k,v in pairs(classAmounts)do -- For each Class, k = Faction ID
		local teamPlayers = team.GetPlayers(k)
		print("BEFORE...")
		PrintTable(classAmounts[k])
		table.sort(classAmounts[k], function(a,b)
			return a["priority"] < b["priority"]
		end)
		print("AFTER...")
		PrintTable(classAmounts[k])
		if(teamPlayers == nil)then break end
		teamPlayers = SVR:MainRandomizer(teamPlayers)
		usedPlayers = {}
		for x,y in pairs(classAmounts[k])do -- For each Class, k = Class Shortcode, v = Class Details
			local classCount = 0
			if(y["maxAmount"] != nil)then  -- If there is a max
				classCount = y["maxAmount"]
			elseif(y["amount"] != nil)then
				classCount = y["amount"]
			end
			
			if(y["leader"] != nil)then  -- If there is a leader
				local randPlayer = teamPlayers[math.random(1, #teamPlayers - 1)] or NULL
				if(randPlayer != NULL)then
					player_manager.ClearPlayerClass(randPlayer)
					player_manager.SetPlayerClass( randPlayer,  y["name"])
					player_manager.OnPlayerSpawn( randPlayer )
					player_manager.RunClass( randPlayer, "Spawn" )
					usedPlayers[#usedPlayers+1] = randPlayer
				end
			end
			--print("IS IT STILL "..#teamPlayers)
			for a,b in pairs (teamPlayers)do
				if(!table.HasValue(usedPlayers, b)) then
					print("TEAM: " .. team.GetName(k) )
					PrintTable(team.GetPlayers(k))
					if(classCount > 0)then
					--print("Start 4am Bullshit")
					--PrintTable(classAmounts[k])
						--print(#team.GetPlayers(k))
						--PrintTable(team.GetPlayers(k))
						--print("CURRENT CLASS AMOUNT BEFORE DEDUCTION: "..classCount)
						print("Set Player to "..y["name"].." in "..team.GetName(k))
						player_manager.ClearPlayerClass(b)
						player_manager.SetPlayerClass( b,  y["name"])
						player_manager.OnPlayerSpawn( b )
						player_manager.RunClass( b, "Spawn" )
						classCount = classCount-1
						usedPlayers[#usedPlayers+1] = b
					end
				end
			end
		end
	end
end

function SetMapJudgement(pos)
	if(not file.IsDir("judgement_circle", "DATA"))then  -- If the file exists
		file.CreateDir("judgement_circle")
	end
	
	local poleVector = Vector(pos.x, pos.y, pos.z + 60)
	
	file.Write("judgement_circle/"..game.GetMap()..".txt", tostring(poleVector) )
	print("Judgement Circle Set: " .. file.Read("judgement_circle/"..game.GetMap()..".txt", "DATA") )
	MsgN("Watch out! Spawning Judgement area!")
	timer.Simple(5,LoadMapJudgement)
end

function LoadMapJudgement()
	if(not file.Exists("judgement_circle/"..game.GetMap()..".txt", "DATA"))then  -- If the file exists
		print("No Judgement Circle set yet! Please have a superadmin use 'set_judgement' on an open area!")
		return
	end
	
	local pos = file.Read("judgement_circle/"..game.GetMap()..".txt", "DATA")
	CreateMapJudgement(pos)
	vectorPos = util.StringToType(pos, "Vector")
	judgementStandPos = Vector(vectorPos.x, vectorPos.y - 150, vectorPos.z)
	
	print("Judgement Circle Set: " .. file.Read("judgement_circle/"..game.GetMap()..".txt", "DATA") .. " @ " .. pos )
end
--LoadMapJudgement()

function CreateMapJudgement(pos)  -- Function handling the spawning of the judgement pole and vehicle
	local polePosition = util.StringToType(pos, "Vector")
	pole = ents.Create("prop_physics")
	pole:SetModel("models/props_docks/dock01_pole01a_128.mdl")
	pole:SetPos(polePosition)
	pole:Spawn()
	local polePhysics = pole:GetPhysicsObject()
	polePhysics:EnableMotion(false)
	
	local podPosition = Vector(polePosition.x, polePosition.y-15, polePosition.z)
	local podAngle = Angle(0,-90,0)
	pod = ents.Create("prop_vehicle_prisoner_pod")
	pod:SetNoDraw(true)
	pod:SetModel("models/vehicles/prisoner_pod_inner.mdl")
	pod:SetPos(podPosition)
	pod:SetAngles(podAngle)
	pod:SetKeyValue("vehiclescript", "prisoner_pod.txt")
	pod:SetName("EXECUTION")
	pod:Spawn()
	local podPhysics = pod:GetPhysicsObject()
	podPhysics:EnableMotion(false)
	
end
function SVR:MainRandomizer(givenTable)
	local randNum = math.random(3,10) or 5
	local randomizedTable = givenTable
	for i=1, randNum do
		randomizedTable = SVR:Randomizer(randomizedTable)
	end
	
	return randomizedTable
end

function SVR:Randomizer(givenTable)
    -- Thank you to Fisher-Yates!
    local randomTable = { }
    local randNum = math.random

    for i = 1, #givenTable do
        local diff = i - 1
        local value = givenTable[i]
        local randomIndex = diff*randNum()
        local cleanRandIndex = math.floor(randomIndex)

        if cleanRandIndex == diff then
            randomTable[#randomTable + 1] = value
        else
            randomTable[#randomTable + 1] = randomTable[cleanRandIndex + 1]
            randomTable[cleanRandIndex + 1] = value
        end
    end

    return randomTable
end
math.randomseed(os.time())

function SVR:SetGhostMessage(nick, msg)
	SVR.ghostMessages[nick] = msg
end

hook.Add("PlayerSay", "CheckForGamemodeChatTagss!s", function(plyr, text, team)
	local hintSub = string.sub(text, 1, 5)
	local revealSub = string.sub(text, 1, 7)
	print(revealSub)
	if( hintSub == "!hint" && plyr:Team() == 99)then
		SVR:SetGhostMessage(plyr:Nick(), string.sub(text, 6, string.len(text)))
		if(SVR.ghostMessages[nick] == nil)then
			plyr:ChatPrint("You have submitted your message for tonight!")
		else
			plyr:ChatPrint("You have changed your message for tonight!")
		end
		return ""
	elseif(revealSub == "!reveal")then
		if(plyr:GetNWBool("revealed") == true)then plyr:ChatPrint("You already revealed yourself! This ain't no round trip train!") return "" end
		plyr:SetNWBool("revealed", true)
		plyr:ChatPrint("You have revealed your identity! Watch your back!")
		for k,v in pairs(player.GetAll())do
			if(v:Team() != 99 && v:Team() != TEAM_CONNECTING && v != plyr)then
				v:ChatPrint(plyr:Nick().." has revealed his identity as the "..player_manager.GetPlayerClass(plyr).."!")
			end
		end
		return " "
	elseif(string.sub(text, 1, 8) == "!execute" && player_manager.GetPlayerClass(plyr) == "Sheriff") then
		for k,v in pairs(ents.GetAll())do
			if(v:GetClass() == "entity_jail")then
				local jailedPlyr = v:GetJailedPlayer() or nil
				if(jailedPlyr != nil)then
					jailedPlyr:Kill()
					plyr:ChatPrint("You have executed "..jailedPlyr:Nick().."!")
					v:SetJailedPlayer(nil)
					for a,b in pairs(player.GetAll())do
						if(b:Team() != 99 && b:Team() != TEAM_CONNECTING && b != plyr) then 
							b:ChatPrint(plyr:Nick().." has executed "..jailedPlyr:Nick().."!")
						end
					end
				else
					plyr:ChatPrint("There is no jailed player!")
				end
			end
		end
	elseif(string.sub(text, 1, 8) == "!release" && player_manager.GetPlayerClass(plyr) == "Sheriff") then
		for k,v in pairs(ents.GetAll())do
			if(v:GetClass() == "entity_jail")then
				local jailedPlyr = v:GetJailedPlayer() or nil
				if(jailedPlyr != nil)then
					SVR:RespawnPlayers(jailedPlyr)
					plyr:ChatPrint("You have released "..jailedPlyr:Nick().."!")
					v:SetJailedPlayer(nil)
					for a,b in pairs(player.GetAll())do
						if(b:Team() != 99 && b:Team() != TEAM_CONNECTING && b != plyr) then 
							b:ChatPrint(plyr:Nick().." has released "..jailedPlyr:Nick().."!")
						end
					end
				else
					plyr:ChatPrint("There is no jailed player!")
				end
			end
		end
	end
end)

function SVR:ScrambleText(msg)
	local msgTable = string.ToTable(msg)
	
	table.sort(msgTable, function(a,b) return math.Rand(0,1) > 0.5 end)
	PrintTable(msgTable)
	
	return table.concat(msgTable)
end

concommand.Add("set_judgement", function(plyr, cmd, args)
	if(plyr:IsSuperAdmin())then
		SetMapJudgement(plyr:GetPos())
	else
		print("YOU CAN'T DO THIS! YOU ARE NOT A SUPERADMIN YOU PLEEB!")
	end
end)

concommand.Add("spawn_judgement", function(plyr, cmd, args)
	if(plyr:IsSuperAdmin())then
		LoadMapJudgement()
	else
		print("YOU CAN'T DO THIS! YOU ARE NOT A SUPERADMIN YOU PLEEB!")
	end
end)

concommand.Add("changeTime", function(plyr, cmd, args)
	if(plyr:IsSuperAdmin())then
		print("Change Time")
		SVR:ChangeTime()
	else
		print("YOU CAN'T DO THIS! YOU ARE NOT A SUPERADMIN YOU PLEEB!")
	end
end)

concommand.Add("restartGame", function(plyr, cmd, args)
	if(plyr:IsSuperAdmin())then
		--RunConsoleCommand( "_restart" )
	else
		print("YOU CAN'T DO THIS! YOU ARE NOT A SUPERADMIN YOU PLEEB!")
	end
end)

concommand.Add("startGame", function(plyr, cmd, args)
	if(plyr:IsSuperAdmin())then
		print("Start Game")
		SVR:StartGame()
		--print("CLASS ID: " .. player_manager.GetPlayerClass(plyr))
	else
		print("YOU CAN'T DO THIS! YOU ARE NOT A SUPERADMIN YOU PLEEB!")
	end
end)

concommand.Add("listEnts", function(plyr, cmd, args)
	if(plyr:IsSuperAdmin())then
		PrintTable(ents.GetAll())
	else
		print("YOU CAN'T DO THIS! YOU ARE NOT A SUPERADMIN YOU PLEEB!")
	end
end)

concommand.Add("fade", function(plyr, cmd, args)
	if(plyr:IsSuperAdmin())then
		net.Start("FadeToBlack")
		net.Broadcast()
	else
		print("YOU CAN'T DO THIS! YOU ARE NOT A SUPERADMIN YOU PLEEB!")
	end
end)
