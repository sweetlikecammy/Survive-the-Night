FBOARD = {}

-- Start Variables --

FBOARD.materials = {
	["factionBoardFG"] = Material("HUD/factionBoardFG.png"),
	["factionBoardBG"] = Material("HUD/factionBoardBG.png")
}

-- End Variables --

-- Start Methods -- 

function FBOARD:DrawBoard(x,y,w,h,color,mat) -- Draw Faction Board
	mats = FBOARD.materials
	if(mats[mat] !=	nil)then  -- Check if material is valid
		surface.SetDrawColor(color)
		surface.SetMaterial(mats[mat])
		surface.DrawTexturedRect(x,y,w,h)
	end
	
end

local missionText = nil
local jobText = nil
function FBOARD:DrawMissionText(x,y,w,color, text,isFaction) -- Draw Faction Board
	if(isFaction)then
		if(LocalPlayer():KeyDown(IN_SCORE))then 
			if(missionText != nil)then missionText:SetText(text) return end
			--print("Mission Text Create")
			missionText = vgui.Create( "DLabel" );
			missionText:SetText( text );
			missionText:SetPos( x,y );
			missionText:SetAutoStretchVertical( true );
			missionText:SetWide( w );
			missionText:SetFont("UIInfo");
			missionText:SetWrap( true );
		else
			if(missionText == nil)then return end
			--print("SET TEXT TO NOTHING")
			missionText:SetText("")
		end
	else
		if(LocalPlayer():KeyDown(IN_SCORE))then 
			if(jobText != nil)then jobText:SetText(text) return end
			--print("Mission Text Create")
			jobText = vgui.Create( "DLabel" );
			jobText:SetText( text );
			jobText:SetPos( x,y );
			jobText:SetFont("UIInfo");
			jobText:SetAutoStretchVertical( true );
			jobText:SetWide( w );
			jobText:SetWrap( true );
		else
			if(jobText == nil)then return end
			--print("SET TEXT TO NOTHING")
			jobText:SetText("")
		end
	end
	
end

function FBOARD:DrawFactionText(x,y,text, font) -- Draw Faction Board
	teamName = team.GetName(LocalPlayer():Team()) or "NULL"

	surface.SetTextColor(Color(255,255,255,255))
	surface.SetFont(font)
	xSize,ySize = surface.GetTextSize(text)
	surface.SetTextPos(x - xSize/2,y)
	surface.DrawText(text)
	
end

function FBOARD:Draw() -- Main Draw
	factionColor = team.GetColor(LocalPlayer():Team()) or Color(255,255,255,255)
	factionName = team.GetName(LocalPlayer():Team()) or "DEAD"
	jobName = player_manager.GetPlayerClass(LocalPlayer())

	FBOARD:DrawBoard(ScrW() * .73, ScrH() * .03, ScrW() * .25, ScrH() * .25, factionColor, "factionBoardBG") -- Draw Faction Board
	FBOARD:DrawBoard(ScrW() * .73 + ScrW() * .005, ScrH() * .03 + ScrH() * .01, ScrW() * .24, ScrH() * .23, Color(255,255,255,5), "factionBoardFG") -- Draw Faction Board
	
	if(CLASS_CONFIG != nil)then  
	
	FBOARD:DrawFactionText(ScrW() * .73 + ScrW() * .125, ScrH() * .03 + ScrH() * .014, factionName, "UIHeader")
	FBOARD:DrawFactionText(ScrW() * .73 + ScrW() * .125, ScrH() * .03 + ScrH() * .048, jobName, "UISubHeader")
	
	--FBOARD:DrawMissionText(0,0,250,Color(255,255,255,255), [[GABJKFADSFKJLBASDLJKFBAKSJLDBFLKJASBDLKFBASDLKJBFALKSJDB]])
	
	end  -- Make sure CLASS_CONFIG is valid
	
end

-- End Methods --