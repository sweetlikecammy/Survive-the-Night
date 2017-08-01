HEADINFO = {}

-- v Variables v --
HEADINFO.OverHeadOffset = 75

HEADINFO.DNAIcon = Material("HUD/dna.png")
HEADINFO.DNASpots = {}
-- ^ Variables ^ --

function HEADINFO:DrawText(x,y,text,c)
	draw.DrawText(text, "UIInfo", x, y,c, TEXT_ALIGN_CENTER )
	--print(x)
end

function HEADINFO:DrawIcon(x,y,w,h,color,mat)
	surface.SetDrawColor(color)
	surface.SetMaterial(mat)
	surface.DrawTexturedRect(x,y,w,h)
end

function HEADINFO:Draw()
	--[[local traceLine = util.TraceLine({
		start = LocalPlayer():EyePos(),
		endpos = LocalPlayer():EyePos() + EyeAngles():Forward() * HEADINFO.TraceDistance,
		collsiongroup = COLLISION_GROUP_PLAYER
	}) ]]
	--print(#HEADINFO.DNASpots)
	if(#HEADINFO.DNASpots > 0)then
		for k,v in pairs(HEADINFO.DNASpots)do
			local screenPos = v:ToScreen()
			HEADINFO:DrawIcon(screenPos.x, screenPos.y, ScrW()*.05, ScrW()*.05, Color(255,255,255), HEADINFO.DNAIcon)
		end
	end
	
	local viewedEnt = LocalPlayer():GetEyeTrace().Entity
	if (!viewedEnt:IsPlayer() or viewedEnt:GetName() == LocalPlayer():GetName()) then return end
	if(viewedEnt:Team() == 99 && LocalPlayer():Team() != 99)then return end
	local playerPos = viewedEnt:GetPos()
	playerPos.z = playerPos.z + HEADINFO.OverHeadOffset
	local playerPos2D = playerPos:ToScreen()
	
	HEADINFO:DrawText(playerPos2D.x, playerPos2D.y, viewedEnt:GetName(), Color(255,255,255))
	HEADINFO:DrawText(playerPos2D.x, playerPos2D.y+60, "Health: "..viewedEnt:Health(), Color(255,255,255))
	if(SCOREBOARD.suspicions[LocalPlayer():GetName()] == nil || SCOREBOARD.teamPlayers[LocalPlayer():GetName()] == nil) then return end
	if(SCOREBOARD.suspicions[LocalPlayer():GetName()][viewedEnt:GetName()] != nil)then 
		HEADINFO:DrawText(playerPos2D.x, playerPos2D.y+120, "Suspicion: "..SCOREBOARD.suspicions[LocalPlayer():GetName()][viewedEnt:GetName()], Color(255,255,255)) 
	elseif(SCOREBOARD.teamPlayers[LocalPlayer():GetName()][viewedEnt:GetName()] != nil)then
		HEADINFO:DrawText(playerPos2D.x, playerPos2D.y+120,SCOREBOARD.teamPlayers[LocalPlayer():GetName()][viewedEnt:GetName()], team.GetColor(LocalPlayer():Team())) 
	end
	
end

net.Receive("GetDNA", function()
	HEADINFO.DNASpots = net.ReadTable() or {}
	print(#HEADINFO.DNASpots)
end)