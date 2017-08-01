local SmokeMat = Material("skybox/italydn")
local ActualSmokeAmount = 0

local function BURGERBASE_HOOK_RenderScreenspaceEffects()

	local ply = LocalPlayer()
	
	

	if ply.IsBlinded == true then
	

		if ply.BlindAmount > 0 then
		
			local Mod = math.Clamp(ply.BlindAmount,0,1)
			
			local Settings = {
				[ "$pp_colour_brightness" ] = Mod,
				[ "$pp_colour_contrast" ] = 1,
				[ "$pp_colour_colour" ] = 1,
				[ "$pp_colour_addr" ] = 0,
				[ "$pp_colour_addg" ] = 0,
				[ "$pp_colour_addb" ] = 0,
				[ "$pp_colour_mulr" ] = 0,
				[ "$pp_colour_mulg" ] = 0,
				[ "$pp_colour_mulb" ] = 0
			}
			
			DrawColorModify( Settings )
			
			ply.BlindAmount = ply.BlindAmount - FrameTime()*0.5

		else
		
			ply.BlindAmount = 0
			ply.IsBlinded = false
		
		end

	end
	
	
	local IsInSmoke = false
	
	local SmokeAmount = 0
	local Range = 125
	
	for k,v in pairs(ents.FindByClass("ent_burger_cs_smoke")) do
		local Distance = ply:GetPos():Distance(v:GetPos())
		if Distance <= Range and v:GetNWBool("IsDetonated",false) then
			IsInSmoke = true
			SmokeAmount = SmokeAmount + math.Clamp(Range - Distance,0,Range) / Range
		end
	end
	
	--print(SmokeAmount)
	
	
	if IsInSmoke or ActualSmokeAmount ~= 0 then
	
		local DesiredModAmount = math.Clamp(SmokeAmount*2,0,1)
		
		if ActualSmokeAmount < DesiredModAmount then -- Is less than
			ActualSmokeAmount = math.min(DesiredModAmount,ActualSmokeAmount + FrameTime())
		elseif ActualSmokeAmount > DesiredModAmount then -- Is greater than
			ActualSmokeAmount = math.max(DesiredModAmount,ActualSmokeAmount - FrameTime())
		end
		
		
	
		surface.SetMaterial(SmokeMat)
		surface.SetDrawColor( Color(200,200,200,ActualSmokeAmount*255) )
		--surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		surface.DrawRect( 0, 0, ScrW(), ScrH() )

	end

	
end

hook.Add("RenderScreenspaceEffects","BURGERBASE_HOOK_RenderScreenspaceEffects",BURGERBASE_HOOK_RenderScreenspaceEffects)
