if SERVER then

util.AddNetworkString("playerVote")
util.AddNetworkString("playerUnvote")
util.AddNetworkString("ListDeadPeople")
util.AddNetworkString("FadeToBlack")
util.AddNetworkString("SendVotesToAll")

SV_JUDGE = {}

-- START SERVER VARS --

SV_JUDGE.playerVotes = {}
SV_JUDGE.exectuionVotes = {}
SV_JUDGE.chosenPlayer = nil

-- Main Config --
SV_JUDGE.MainConfig = MAIN_CONFIG or {}
SV_JUDGE.minPlayerVotes = 0
SV_JUDGE.minExecutionVotes = 0
SV_JUDGE.timers = {}
SV_JUDGE.allowAccess = false

SV_JUDGE.curPhase = 0 -- 0 == Not started, 1 = Players voting, 2 = Executing

-- END SERVER VARS --

function SV_JUDGE:Start()
	print("START JUDGEMENT")
	SV_JUDGE.timers[1] = self.MainConfig.votingTime
	SV_JUDGE.timers[2] = self.MainConfig.lastWordsTime
	SV_JUDGE.allowAccess = true
	SV_JUDGE.minPlayerVotes = SV_JUDGE.MainConfig.minPlayerVotes
	SV_JUDGE.minExecutionVotes = SV_JUDGE.MainConfig.minExecutionVotes
	SV_JUDGE.curPhase = 0
	
	net.Start("SendVotesToAll")
		net.WriteTable(SV_JUDGE.playerVotes)
	net.Broadcast()
	
	SV_JUDGE:Timers()
end

function SV_JUDGE:Timers()
	local curPhase = SV_JUDGE.curPhase or 0
	if(curPhase == 0)then
		SV_JUDGE.curPhase = 1
		if(timer.Exists("StartVoteTime") == true)then 
			timer.Remove("StartVoteTime")
		end
		net.Start("StartGameTimer")
			net.WriteString("judgementTimer")
		net.Broadcast()
		timer.Create("StartVoteTime", SV_JUDGE.timers[1], 1 , function()
			SV_JUDGE:SendToExecution()
		end)	
	elseif(curPhase == 1)then
		SV_JUDGE:ChatMessage(SV_JUDGE.chosenPlayer, SV_JUDGE.chosenPlayer:Nick().." has been chosen for execution and will now speak their final words.", true)
		SV_JUDGE:ChatMessage(SV_JUDGE.chosenPlayer, "You have been chosen for execution and may now speak your final words.", false)
		net.Start("StartGameTimer")
			net.WriteString("lastWordsTimer")
		net.Broadcast()
		if(timer.Exists("ExecutePlayer") == true)then timer.Remove("ExecutePlayer")end
		timer.Create("ExecutePlayer", SV_JUDGE.timers[2], 1, function() SV_JUDGE:Execute() end)
	end
end

function SV_JUDGE:VotePlayer(victim, voter)
	local curVotes = SV_JUDGE.playerVotes[victim] or 0
	if(player_manager.GetPlayerClass(voter) == "Governor" && voter:GetNWBool("revealed"))then SV_JUDGE.playerVotes[victim] = curVotes + 4 else SV_JUDGE.playerVotes[victim] = curVotes + 1 end
	
	net.Start("SendVotesToAll")
		net.WriteTable(SV_JUDGE.playerVotes)
	net.Broadcast()
	
	for k,v in pairs(player.GetAll())do
		if(v:Nick() != voter:Nick() and v:Nick() != victim)then
			v:ChatPrint(voter:Nick().." has voted to execute "..victim.."!")
		elseif(v:Nick() == victim)then
			v:ChatPrint(voter:Nick().." has voted to execute you!")
		end
	end
		
end
net.Receive("playerVote", function(len,plyr)
	local victim = net.ReadString()
	print("VOTE FOR THIS FRUITY: "..victim)
	SV_JUDGE:VotePlayer(victim, plyr)
end)

function SV_JUDGE:UnvotePlayer(victim)
	local curVotes = SV_JUDGE.playerVotes[victim] or 0
	if(curVotes == 1 or curVotes > 1)then if(player_manager.GetPlayerClass(voter) == "Governor" && voter:GetNWBool("revealed"))then SV_JUDGE.playerVotes[victim] = curVotes - 4 else SV_JUDGE.playerVotes[victim] = curVotes - 1 end end
	print("UNVOTE THE BIOTCH")
end
net.Receive("playerUnvote", function(len,pl)
	print("GOT UNVOTE")
	local victim = net.ReadString()
	SV_JUDGE:UnvotePlayer(victim)
end)

function SV_JUDGE:Execute()
	local chosenPlayer = SV_JUDGE.chosenPlayer
	local playerJob = player_manager.GetPlayerClass(chosenPlayer) or "Dude"
	local playerTeam = team.GetName(chosenPlayer:Team()) or "DUDES"
	SV_JUDGE.chosenPlayer:Ignite(3)
	timer.Simple(3, function() 
		SV_JUDGE.chosenPlayer:Kill()
		SV_JUDGE:ChatMessage(nil, SV_JUDGE.chosenPlayer:Nick()..", a "..playerJob.." part of the "..playerTeam.." has been slayed!", true)
		SV_JUDGE:EndJudgement()
	end)
end

function SV_JUDGE:EndJudgement()
	SVR:CheckMission()
	-- Clean Up --
	SV_JUDGE.playerVotes = {}
	SV_JUDGE.exectuionVotes = {}
	if(timer.Exists("StartVoteTime") == true)then 
			timer.Remove("StartVoteTime")
	end
	SV_JUDGE.allowAccess = false
	SV_JUDGE.chosenPlayer = nil
	SV_JUDGE.curPhase = 0
	SV_JUDGE:ChatMessage(nil, "Judgement has ended! Now you must survive the night!", true)
	net.Start("FadeToBlack")
	net.Broadcast()
	timer.Simple(3, function()
		SVR:ChangeTime()
	end)
end

function SV_JUDGE:ChatMessage(plyr, message, all )
	if(all)then
		for k,v in pairs(player.GetAll())do
			if(v:Team() != 99)then
				if(plyr == nil)then 
					v:ChatPrint(message) 
				else
					if(v != plyr)then
						v:ChatPrint(message) 
					end
				end
			end
		end
	else
		plyr:ChatPrint(message)
	end
end

function SV_JUDGE:SendToExecution()
	PrintTable(SV_JUDGE.playerVotes)
	local possiblePlayers = {}
	local possPlayerCount = 0
	for c,d in pairs(SV_JUDGE.playerVotes)do
		if(d > SV_JUDGE.minPlayerVotes )then
			possiblePlayers[c] = d
			possPlayerCount = possPlayerCount + 1
		end
	end
	PrintTable(possiblePlayers)
	if(possPlayerCount < 1)then -- No players to execute
		SV_JUDGE:ChatMessage(nil, "Not enough votes were casted, no one will be executed!", true)
		SV_JUDGE:EndJudgement()
		return
	end
	
	local flag_sameNum = false -- Flag to see if there were any players with same amount of votes
	local plyrSortedVotes = table.SortByKey(possiblePlayers)
	
	-- Check if there was another person who had the same amount of votes --
	if(flag_sameNum)then 
		SV_JUDGE:ChatMessage(nil, "Players received the same amount of votes, no one will be executed!", true)
		SV_JUDGE:EndJudgement()
		return
	end
	for k,v in pairs(player.GetAll())do  -- k = player index, v = player
		if(v:GetName() == plyrSortedVotes[1])then
			self.chosenPlayer = v
		end
	end
	
	for a,b in pairs(ents.GetAll())do  -- a = Entity index, b = Entity table
		if(b:GetName() != nil)then
			if(b:GetName() == "EXECUTION")then
				self.chosenPlayer:EnterVehicle(b)
				SV_JUDGE:Timers()
			end
		end
	end
end

function SV_JUDGE:CanEnterVehicle(plyr,vehicle)
	if(vehicle:GetName() == "EXECUTION" && SV_JUDGE.allowAccess == false)then
		return false
	end
end
hook.Add("CanPlayerEnterVehicle", "DisableEnteringPodBeforeTimeisReady", function(plyr,veh,role)
	return SV_JUDGE:CanEnterVehicle(plyr,veh)
end)

end

if (CLIENT) then

CL_JUDGE = {}
-- START CLIENT VARS --

CL_JUDGE.curDeadPlayer = nil
CL_JUDGE.curDeadPlayers = {}

CL_JUDGE.selectedPlayer = nil
CL_JUDGE.highlightedPlayer = nil
CL_JUDGE.lastSelectedPlayer = nil
CL_JUDGE.currentPlayers = {}
CL_JUDGE.playerVotes = {}

-- END CLIENT VARS --

function CL_JUDGE:DrawPanel(x,y,w,h,color)
	surface.SetDrawColor(color)
	surface.DrawRect(x,y,w,h)
end

function CL_JUDGE:DrawText(x,y,color,text,font,align)
	draw.SimpleText(text, font, x, y, color, align)
end

function CL_JUDGE:Draw()
	if(LocalPlayer():Team() == 99)then return end
	local plyrAmount = #player.GetAll() - #team.GetPlayers(99) - #team.GetPlayers(TEAM_CONNECTING)
	if(timer.Exists("nightTimer") or plyrAmount < 1 )then return end
	CL_JUDGE:DrawPanel(ScrW() * .02, ScrW() * .02, ScrW() * .15, ScrW() * .024 + (ScrW() * plyrAmount * .016), Color(90,90,90,150))
	
	-- Title --
	CL_JUDGE:DrawText(ScrW() * .021 + (ScrW() * .15 * .475), ScrW() * .023, Color(255,255,255,255), "Judgement", "UISubHeader", TEXT_ALIGN_CENTER)
	
	local shouldShowTeam = true
	for g,m in pairs(CLASS_CONFIG.Factions)do
		if(m["solo"] == true and team.GetName(LocalPlayer():Team()) == m["name"])then
			shouldShowTeam = false
		end
	end
	
	-- Each player --
	local plyrIndex = 1
	for k,v in pairs(player.GetAll())do
		local voteAmount = CL_JUDGE.playerVotes[v:Nick()] or 0
		if(v:Team() != 99 and v:Team() != TEAM_CONNECTING)then
			if(CL_JUDGE.highlightedPlayer != nil && CL_JUDGE.highlightedPlayer:Nick() == v:Nick())then
				CL_JUDGE:DrawText(ScrW() * .021, ScrW() * .024 + (ScrW() * plyrIndex * .016), Color(255,255,255,255), plyrIndex..". "..v:Nick().." : "..voteAmount.." votes", "UIInfo", TEXT_ALIGN_LEFT)
			else
				if(LocalPlayer():Team() == v:Team() && shouldShowTeam)then	
					CL_JUDGE:DrawText(ScrW() * .021, ScrW() * .024 + (ScrW() * plyrIndex * .016), team.GetColor(v:Team()), plyrIndex..". "..v:Nick().." : "..voteAmount.." votes", "UIInfo", TEXT_ALIGN_LEFT)
				elseif(v:GetNWBool("revealed"))then
					CL_JUDGE:DrawText(ScrW() * .021, ScrW() * .024 + (ScrW() * plyrIndex * .016), team.GetColor(v:Team()), plyrIndex..". "..v:Nick().." : "..voteAmount.." votes", "UIInfo", TEXT_ALIGN_LEFT)
				else
					CL_JUDGE:DrawText(ScrW() * .021, ScrW() * .024 + (ScrW() * plyrIndex * .016), Color(200,200,200,255), plyrIndex..". "..v:Nick().." : "..voteAmount.." votes", "UIInfo", TEXT_ALIGN_LEFT)
				end
			end
			CL_JUDGE.currentPlayers[plyrIndex] = v
			plyrIndex = plyrIndex + 1
		end
	end
	-- Instructions --
		CL_JUDGE:DrawText(ScrW() * .021 + (ScrW() * .15 * .475), ScrW() * .03 + (ScrW() * plyrIndex * .016), Color(255,255,255,255), "Use the arrow keys to change players", "UISmall", TEXT_ALIGN_CENTER) 
		CL_JUDGE:DrawText(ScrW() * .021 + (ScrW() * .15 * .475), ScrW() * .03 + (ScrW() * plyrIndex * .016) + 30, Color(255,255,255,255), "and the enter key to select.", "UISmall", TEXT_ALIGN_CENTER) 
	
end
hook.Add("HUDPaint", "DrawJudgementPanels", function()
	CL_JUDGE:Draw()
end)
local choiceDelay = 0
local spamCount = 0
local curIndex = 1
function CL_JUDGE:CheckPress(plyr, key)
	if(LocalPlayer():Team() == 99 or !timer.Exists("judgementTimer"))then return end
	CL_JUDGE.highlightedPlayer = CL_JUDGE.currentPlayers[curIndex]
	if(key == KEY_UP)then
		print(curIndex)
		if(curIndex == 1)then 
			curIndex = #CL_JUDGE.currentPlayers 
		else
			curIndex = curIndex -1
		end
		CL_JUDGE.highlightedPlayer = CL_JUDGE.currentPlayers[curIndex]
	elseif(key == KEY_DOWN)then
		if(curIndex == #CL_JUDGE.currentPlayers)then 
			curIndex = 1 
		else
			curIndex = curIndex + 1
		end
		CL_JUDGE.highlightedPlayer = CL_JUDGE.currentPlayers[curIndex]
	elseif(key == KEY_ENTER)then
		if(choiceDelay > os.time())then 
			spamCount = spamCount + 1
			if(spamCount > 3)then LocalPlayer():ChatPrint("Stop spamming! We get it! You want "..CL_JUDGE.highlightedPlayer:Nick().." dead. Now, can you be patient and wait a second before voting? Thanks!")end
			return 
		end
		choiceDelay = os.time() + .25
		spamCount = 0
		if(CL_JUDGE.highlightedPlayer == nil) then return end
		net.Start("playerVote")
			net.WriteString(CL_JUDGE.highlightedPlayer:Nick())
		net.SendToServer()
		if(CL_JUDGE.lastSelectedPlayer != nil)then
			net.Start("playerUnvote")
			net.WriteString(CL_JUDGE.lastSelectedPlayer:Nick())
			net.SendToServer()
		end
		
		LocalPlayer():ChatPrint("You have voted "..CL_JUDGE.highlightedPlayer:Nick().." to be executed!")
		
		CL_JUDGE.lastSelectedPlayer = CL_JUDGE.selectedPlayer
		CL_JUDGE.selectedPlayer = CL_JUDGE.highlightedPlayer
	end
end
hook.Add("PlayerButtonDown", "CheckIfPlayerPressesJudgementMenuKey", function(plyr,key) CL_JUDGE:CheckPress(plyr,key)end)

function CL_JUDGE:ListDeadPlayer()
	if(CL_JUDGE.curDeadPlayer == nil) then return end
	local deadply = CL_JUDGE.curDeadPlayer
	local deathMsg= deadply["deathNote"]
	local callingMsg =  deadply["callingCard"]
	local name = deadply["name"] or "NULLLLLLLLLL"
	CL_JUDGE:DrawText(ScrW()/2,ScrH() * .2,Color(255,255,255),name,"UIJobHeader",TEXT_ALIGN_CENTER)
	CL_JUDGE:DrawText(ScrW()/2,ScrH() * .25,Color(255,255,255),deathMsg,"UIJobHeader",TEXT_ALIGN_CENTER)
	CL_JUDGE:DrawText(ScrW()/2,ScrH() * .3,Color(255,255,255),callingMsg,"UIJobHeader",TEXT_ALIGN_CENTER)
end
hook.Add("HUDPaint", "PaintEachDeadPlayer", function()
	--CL_JUDGE:ListDeadPlayer()
end)

net.Receive("ListDeadPeople", function()
	print("List dead people")
	local deadPeople = net.ReadTable()
	CL_JUDGE.curDeadPlayers = deadPeople
	local timeUntil = 0
	for k,v in pairs(CL_JUDGE.curDeadPlayers)do
		if(CL_JUDGE.curDeadPlayer != nil)then
			timeUntil = timeUntil + 4
			timer.Simple(timeUntil, function()
				CARDS:PlayerReviewCards(v["player"], v["deathNote"], v["callingCard"])
			end)
		else
			CARDS:PlayerReviewCards(v["player"], v["deathNote"], v["callingCard"])
		end
		CL_JUDGE.curDeadPlayer = v
	end
	
	
end)

net.Receive("SendVotesToAll", function()
	CL_JUDGE.playerVotes = net.ReadTable()
end)

end
