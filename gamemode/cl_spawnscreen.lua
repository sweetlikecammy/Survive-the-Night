SPAWNSCREEN = {}

-- Start Variables --

SPAWNSCREEN.materials = {
	["factionBoardFG"] = Material("HUD/factionBoardFG.png"),
	["factionBoardBG"] = Material("HUD/factionBoardBG.png")
}

-- End Variables --

-- Start Methods -- 

function SPAWNSCREEN:DrawBackground()
	surface.SetDrawColor(0,0,0,255)
	surface.DrawRect(0,0,ScrW(),ScrH())
end

function SPAWNSCREEN:DrawText(text,font,x,y,c)
	draw.DrawText(text, font, x, y, c, TEXT_ALIGN_CENTER)
end

function SPAWNSCREEN:Draw()
	SPAWNSCREEN:DrawBackground()
	SPAWNSCREEN:DrawText("You are the...", "UIHeader", ScrW() * .5, ScrH() * .05, Color(255,255,255,255)) -- Draw header 
	SPAWNSCREEN:DrawText(player_manager.GetPlayerClass(LocalPlayer()), "UIJobHeader", ScrW() * .5, ScrH() * .15, Color(255,255,255,255)) -- Draw Job Header
	SPAWNSCREEN:DrawText(team.GetName(LocalPlayer():Team()), "UIFactionHeader", ScrW() * .5, ScrH() * .22, team.GetColor(LocalPlayer():Team())) -- Draw Faction header 
	
	--SPAWNSCREEN:DrawText("Mission", "UIJobHeader", ScrW() * .15, ScrH() * .65, team.GetColor(LocalPlayer():Team())) -- Draw header 
	SPAWNSCREEN:DrawText("Weapons", "UIJobHeader", ScrW() * .5, ScrH() * .65, team.GetColor(LocalPlayer():Team())) -- Draw Job Header
	--SPAWNSCREEN:DrawText("Jobs", "UIJobHeader", ScrW() * .85, ScrH() * .65, team.GetColor(LocalPlayer():Team())) -- Draw Faction header 
	
	local currentWeapons = {[1] = "Nothing", [2] = "Nothing", [3] = "Nothing" }
	for k,v in pairs(LocalPlayer():GetWeapons())do
		if(v:GetClass() != "weapon_fists")then currentWeapons[v:GetNWInt("slot", 1)-1] = v:GetPrintName() end
		--print(v:GetSlot() .. " : " .. v:GetPrintName())
	end
	
	-- USE DERMA LABEL
	
	-- Mission --
	--SPAWNSCREEN:DrawText(mission, "UIHeader", ScrW() * .15, ScrH() * .75, Color(255,255,255,255)) -- Draw Melee
	
	-- Weapons --
	SPAWNSCREEN:DrawText("Melee: "..currentWeapons[1], "UIJobHeader", ScrW() * .5, ScrH() * .72, Color(255,255,255,255)) -- Draw Melee
	SPAWNSCREEN:DrawText("Ranged: "..currentWeapons[2], "UIJobHeader", ScrW() * .5, ScrH() * .78, Color(255,255,255,255)) -- Draw Ranged
	SPAWNSCREEN:DrawText("Tool: "..currentWeapons[3], "UIJobHeader", ScrW() * .5, ScrH() * .84, Color(255,255,255,255)) -- Draw Tool
	
	-- Job --
	--SPAWNSCREEN:DrawText(job, "UIHeader", ScrW() * .85, ScrH() * .75, Color(255,255,255,255)) -- Draw Melee
end

-- End Methods --