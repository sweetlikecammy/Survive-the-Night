AddCSLuaFile()
WINSCREEN = {}

WINSCREEN.showWinScreen = false
WINSCREEN.winningFaction = ""

-- Start Variables --

WINSCREEN.materials = {
	
}

-- End Variables --

-- Start Methods -- 
local randColor
local nextTime = 0
function WINSCREEN:Draw()
	if(timer.Exists("gameOverTimer") && timer.TimeLeft("gameOverTimer") > 0 )then
		if(os.time() > nextTime)then randColor = Color(math.random(0,255),math.random(0,255),math.random(0,255)) end
		nextTime = os.time() + .01
		local factionName = WINSCREEN.winningFaction or ""
		HUD:DrawText(ScrW()*(.5),ScrH()*(.075),randColor,"GAMEOVER!","UIFactionHeader")
		HUD:DrawText(ScrW()*(.5),ScrH()*(.12),Color(255,255,255),factionName.." has won the game!","UIFactionHeader")
	end
end


function WINSCREEN:SuccessDrawChatProgress(victimTeam, victimClass, victimName)
	chat.AddText(Color(255,255,255), "You killed "..victimName.." a ", team.GetColor(victimTeam), victimClass, Color(255,255,255,255), "! You are one step closer to your goal!"  )
end

function WINSCREEN:FailureDrawChatProgress(victimTeam, victimClass, victimName)
	chat.AddText(Color(255,255,255), "You killed "..victimName.." a ", team.GetColor(victimTeam), victimClass, Color(255,255,255,255), "! You killed a member of your own faction!"  )
end

function WINSCREEN:GuiltSuicide()
	chat.AddText(Color(255,255,255), "You can not deal with the guilt anymore and shoot yourself!"  )
end

net.Receive("winGame", function()
	local faction = net.ReadInt(32) or 100
	local factionName = team.GetName(faction)
	local factionColor = team.GetColor(faction)

	WINSCREEN.winningFaction = factionName
	WINSCREEN.showWinScreen = true
	local localPlayerFaction = team.GetName(LocalPlayer():Team()) or "Dead"
	if(localPlayerFaction == factionName)then
		chat.AddText(factionColor, "Your team has won! Congragulations!"  )
	else
		chat.AddText(factionColor, factionName,Color(255,255,255)," has won! You lost, because you suck!"  )
	end
	
end)

-- End Methods --