AddCSLuaFile()

HUD = {}

HUD.gameTimers = {
	["judgementTimer"] = MAIN_CONFIG.votingTime,
	["nightTimer"] = MAIN_CONFIG.nightTime,
	["lastWordsTimer"] = MAIN_CONFIG.lastWordsTime,
	["gameOverTimer"] = MAIN_CONFIG.gameOverTime
}

HUD.materials = {
	["healthBG"] = Material("HUD/healthBG.png"),
	["healthFG"] = Material("HUD/healthFG.png"),
	["faction_supernatural"] = Material("HUD/faction_supernatural.png"),
	["MOB"] = Material("HUD/faction_mob.png"),
	["GOVERNMENT"] = Material("HUD/faction_gov.png"),
	["factionBG"] = Material("HUD/factionBG.png"),
	["timeSpinner"] = Material("HUD/timeSpinner.png"),
	["jobBG"] = Material("HUD/jobBG.png")
}

HUD.target = nil -- Target set for halo drawing

local bounceCount = 0
local increasing = true
HUD.spawn = false
function GM:HUDPaint()
	if(HEADINFO != nil)then
		HEADINFO:Draw()
	end
	
	--SPAWNSCREEN:Draw() 
	--HUD.spawn = true
	if(SPAWNSCREEN != nil && HUD.spawn == true)then
		SPAWNSCREEN:Draw()	
		if(not timer.Exists("spawnScreen"))then
			timer.Create("spawnScreen", 2, 1, function()
				HUD.spawn = false
			end)
		end
	else
	end 
	
	WINSCREEN:Draw()
	
	if(HUD.spawn == true)then
		return
	end
	
	if(FBOARD != nil)then
		if(LocalPlayer():KeyDown(IN_SCORE))then
			FBOARD:Draw()
		end
		local factionMission = "NULL"
		local jobMission = "NULL"
		for k,v in pairs(CLASS_CONFIG.Factions)do
			--print(team.GetName(LocalPlayer():Team()) .." "..v["name"] )
			if(team.GetName(LocalPlayer():Team()) == v["name"])then
				factionMission = v["mission"]
			end
		end
		for k,v in pairs(CLASS_CONFIG.Classes)do
			if(player_manager.GetPlayerClass(LocalPlayer()) == v["name"])then
				jobMission = v["info"]
			end
		end
		if(factionMission == "NULL")then
			FBOARD:DrawMissionText(ScrW() * .74, ScrH() * .11, ScrW() * .24,Color(255,255,255,255), "Faction Mission: "..[[You are dead! That's about it bucko :/]], true)
			FBOARD:DrawMissionText(ScrW() * .74, ScrH() * .18, ScrW() * .24,Color(255,255,255,255), "Role Info: "..[[You can leave hints for alive players by typing !hint followed by your hint. All messages that get to the other side come through scrambled!]], false)
		else
			FBOARD:DrawMissionText(ScrW() * .74, ScrH() * .11, ScrW() * .24,Color(255,255,255,255), "Faction Mission: "..factionMission, true)
			FBOARD:DrawMissionText(ScrW() * .74, ScrH() * .18, ScrW() * .24,Color(255,255,255,255), "Role Info: "..jobMission, false)
		end
		
	end 
	
	if(LocalPlayer():Team() == 99)then
		return
	end
	
	if(WEPSWITCH != nil)then
		WEPSWITCH:Draw() 
	end -- Call Weapon Switch HUD
	
	--SteamAvatarDraw()
	
	-- DRAW HUD --
	
	-- Health --
	HUD:DrawBar(ScrW()*(0.075),ScrH()*(.942),ScrW()*.12,ScrH()*.035,Color(255,255,255),HUD.materials["healthBG"])
	local curHealth = LocalPlayer():Health()
	local curHealthFrac = curHealth / 100
	HUD:DrawBar(ScrW()*(0.075),ScrH()*(.943),ScrW()*.119*curHealthFrac,ScrH()*.033,Color(255,255,255),HUD.materials["healthFG"])
	HUD:DrawText(ScrW()*(0.1345),ScrH()*(.945),Color(255,255,255),curHealth,"UIBarText")
	
	-- Ammo --
	local wep = LocalPlayer():GetActiveWeapon() or nil
	if (wep:IsValid() == true and wep != NULL and timer.Exists("nightTimer") and LocalPlayer():Alive()) then
		if(wep:Clip1() != NULL) then 
			local ammo = wep:Clip1() or 0
			HUD:DrawBar(ScrW()*(0.074),ScrH()*(.909),ScrW()*.12,ScrH()*.033,Color(0,0,0,255),HUD.materials["jobBG"])
			HUD:DrawText(ScrW()*(0.1345),ScrH()*(.911),Color(255,255,255),ammo,"UIBarText")
		end
	else
		HUD:DrawBar(ScrW()*(0.074),ScrH()*(.909),ScrW()*.12,ScrH()*.033,Color(0,0,0,255),HUD.materials["jobBG"])
		HUD:DrawText(ScrW()*(0.1345),ScrH()*(.911),Color(255,255,255),"0","UIBarText")
	end
	
	-- Job --
	local curJob = player_manager.GetPlayerClass(LocalPlayer()) or "NULL"
	local teamColor = team.GetColor(LocalPlayer():Team()) or Color(0,0,0,255)
	HUD:DrawBar(ScrW()*(0.074),ScrH()*(.876),ScrW()*.12,ScrH()*.033,teamColor,HUD.materials["jobBG"])
	HUD:DrawText(ScrW()*(0.1345),ScrH()*(.878),Color(255,255,255),curJob,"UIBarText")
	
	-- Team Icon --
	local curTeam = team.GetName(LocalPlayer():Team()) or "NULL"
	local teamIcon = HUD.materials[curTeam] or HUD.materials["GOVERNMENT"]
	HUD:DrawBar(ScrW()*(0.01),ScrH()*(.87),ScrW()*.065,ScrW()*.065,Color(90,90,90,225),HUD.materials["factionBG"])
	HUD:DrawIcon(ScrW()*(0.01),ScrH()*(.87),ScrW()*.065,ScrW()*.065,Color(255,255,255),teamIcon)
	
	-- Timer --
	for g,m in pairs (HUD.gameTimers)do 
		if(timer.Exists(g))then
			local timeLeft = timer.TimeLeft(g)
			local timeLeftText = math.Round(timeLeft) or ""
			HUD:DrawText(ScrW()*(.5),ScrH()*(.2),Color(255,255,255),timeLeftText,"UIFactionHeader")
		end
	end
	
	if(timer.Exists("judgementTimer") && timer.TimeLeft("judgementTimer") > 0)then
		CL_JUDGE.curDeadPlayer = nil
		local widthBounce = bounceCount * .0001 * ScrW();
		HUD:DrawText(ScrW()*(.5),ScrH()*(.075),team.GetColor(LocalPlayer():Team()),"Judgement","UIJobHeader")
		HUD:DrawText(ScrW()*(.5) + widthBounce,ScrH()*(.135),Color(255,255,255),"Cast your votes!","UIFactionHeader")
	end
	
	-- Time Rotating Icon --
	local timeIcon = HUD.materials["timeSpinner"] or HUD.materials["GOVERNMENT"]
	if(timer.Exists("nightTimer") && timer.TimeLeft("nightTimer") > 0)then
		local timeLeft = timer.TimeLeft("nightTimer")
		local timeFraction = timeLeft / MAIN_CONFIG.nightTime
		local timeDegree = Lerp(timeFraction, 90, 270)
		HUD:DrawDayIcon(ScrW() * .5,ScrH() * .1,ScrW() * .095,ScrW() * .1,timeDegree,Color(255,255,255),timeIcon)
	end
	
	-- Fade to Black --
	if(timer.Exists("FadeToBlack"))then
		local fadeColor = Color(0,0,0, 255 / timer.TimeLeft("FadeToBlack") )
		HUD:DrawRect(0,0,ScrW(),ScrH(),fadeColor)
		HUD:DrawText(ScrW()*(0.5),ScrH()*(.5),Color(255,255,255),"Survive the Night","UIJobHeader")
		HUD.target = nil
	end

	-- Bouncing Text Stuff --
	if(increasing)then
		if(bounceCount < 200)then
			bounceCount = bounceCount + 10
		else
			increasing = false
		end
	else
		if(bounceCount > -200)then
			bounceCount = bounceCount - 10
		else
			increasing = true
		end
	end
	
end 

hook.Add("PreDrawHalos", "AddHalos", function()
	local teamPlayers = {}
	local targetPlayers = {}
	for k,v in pairs(player.GetAll())do
		local shouldShowTeam = true
		for g,m in pairs(CLASS_CONFIG.Factions)do
			if(m["solo"] == true and team.GetName(LocalPlayer():Team()) == m["name"])then
				shouldShowTeam = false
			end
		end
		
		if(shouldShowTeam && LocalPlayer():Team() == v:Team())then
			teamPlayers[k] = v
		end
	end
	if(HUD.target != nil)then targetPlayers[#targetPlayers+1] = HUD.target end -- Draws halo around targets
	halo.Add(targetPlayers, Color(255* bounceCount * .01,255* bounceCount * .1,255* bounceCount * .001,255 * bounceCount * .001),6,6,1,true,false)
	halo.Add(teamPlayers, team.GetColor(LocalPlayer():Team()),3,3,1,true,true)
end)

net.Receive("StartGameTimer", function(len,ply)
	local timerIndex = net.ReadString()
	HUD:StartTimer(timerIndex)
end)

net.Receive("DrawTargetHalo", function(len,ply)
	local plyrName = net.ReadString()
	for k,v in pairs(player.GetAll())do
		if(v:Nick() == plyrName)then HUD.target = v end
	end
	print("Draw Target!")
end)

function HUD:StartTimer(timerIndex)
	print("TIMEREBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBRRRRRR "..timerIndex)
	if(timer.Exists("gameOverTimer"))then 
		timer.Simple(timer.TimeLeft("gameOverTimer") + 1, function()
			HUD:StartTimer(timerIndex)
		end)
		return 
	end
	for k,v in pairs(HUD.gameTimers)do
		if(timer.Exists(k))then timer.Remove(k) end
		if(timerIndex == k)then
			timer.Create(k, v, 1, function()
				print("Timer: " .. k.. " has ended!")
			end)
		end
	end
end

--[[ net.Receive("startGameTickTimer", function(len,ply)  -- Set for timers that need to be updated faster than every second
	local gameTimers = {
		["nightTimer"] = MAIN_CONFIG.nightTime
	}
	local timerIndex = net.ReadString()
	for k,v in pairs(gameTimers)do
		if(timerIndex == k)then
			--local HUD.nextTime = os.time() + v
			timer.Create(k, v, 1, function()
				--HUD.timerLeft = HUD.nextTime - os.time()
			end)
		end
	end
	
end) ]]

local avatarIcon
function SteamAvatarDraw()  -- Draw Steam Avatar
	if(HUD.spawn  == false)then 
		if (IsValid(LocalPlayer()) and !IsValid(avatarIcon)) then -- Check to see if Local Player is Valid but no Avatar
			avatarIcon = vgui.Create("AvatarImage")
			avatarIcon:SetSize(ScrW()*.065,ScrW()*.065)
			avatarIcon:SetPos(ScrW()*(0.01), ScrH()*(.87))
			avatarIcon:SetPlayer(LocalPlayer(), 128)
		end
	else
		if(IsValid(avatarIcon))then
			avatarIcon:Remove()
		end
	end
end

function HUD:DrawIcon(x,y,w,h,color,mat)
	surface.SetDrawColor(color)
	surface.SetMaterial(mat)
	surface.DrawTexturedRect(x,y,w,h)
end

function HUD:DrawBar(x,y,w,h,color,mat)
	surface.SetDrawColor(color)
	surface.SetMaterial(mat)
	surface.DrawTexturedRect(x,y,w,h)
end

function HUD:DrawRect(x,y,w,h,color)
	surface.SetDrawColor(color)
	surface.DrawRect(x,y,w,h)
end

function HUD:DrawText(x,y,color,text, font)
	draw.DrawText(text, font, x, y, color, TEXT_ALIGN_CENTER)
end

function HUD:DrawDayIcon(x,y,w,h,degree,color,mat)
	surface.SetDrawColor(color)
	surface.SetMaterial(mat)
	surface.DrawTexturedRectRotated(x,y,w,h,degree)
end

net.Receive("FadeToBlack", function()
	if(CL_JUDGE.selectedPlayer != nil)then 
		CL_JUDGE.selectedPlayer = nil
		CL_JUDGE.highlightedPlayer = nil
		CL_JUDGE.lastSelectedPlayer = nil
		CL_JUDGE.currentPlayers = {}
		CL_JUDGE.curDeadPlayer = nil
	end
	if(timer.Exists("gameOverTimer"))then  error("GAME OVER TIMER ISNT DONE") return end
	timer.Create("FadeToBlack", 4, 1, function()
	end)
end)