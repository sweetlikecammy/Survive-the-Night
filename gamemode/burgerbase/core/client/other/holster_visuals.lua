--[[
function CSSParentProject(ply)

	for k,ply in pairs(player.GetAll()) do

		local primary = ply:GetNWString("cssprimary",nil)
		local secondary = ply:GetNWString("csssecondary",nil)
		
		local PSWEP = weapons.GetStored(primary)
		local SSWEP = weapons.GetStored(secondary)

		local PlayerModel = ply:GetModel()
		
		local PBoneIndex = ply:LookupBone("ValveBiped.Bip01_Spine4")
		local PBonePos, PBoneAng = ply:GetBonePosition(PBoneIndex)
		
		local SBoneIndex = ply:LookupBone("ValveBiped.Bip01_R_Thigh")
		local SBonePos, SBoneAng = ply:GetBonePosition(SBoneIndex)
		
		
		--local PModel = "models/weapons/w_rif_ak47.mdl"
		--local SModel = "models/weapons/w_eq_eholster_elite.mdl"
			
		if PSWEP then
			PModel = PSWEP.WorldModel
		end
		
		if SSWEP then
			SModel = SSWEP.WorldModel
		end
		
		if not ply:HasWeapon(primary) then
			PModel = "models/hunter/blocks/cube025x025x025.mdl"
		end
		
		if not ply:HasWeapon(secondary) then
			SModel = "models/hunter/blocks/cube025x025x025.mdl"
		end
		
		if ply:GetActiveWeapon():IsValid() then
			if ply:GetActiveWeapon():GetClass() == primary then
				PModel = "models/hunter/blocks/cube025x025x025.mdl"
			end
			
			if ply:GetActiveWeapon():GetClass() == secondary then
				SModel = "models/hunter/blocks/cube025x025x025.mdl"
			end
		end
		
		if not ply.PrimaryObj and ply:Alive() then

			local posmod, angmod = LocalToWorld(Vector(-3,-4,6), Angle(180,0,0) ,ply:GetPos(), ply:GetAngles() )
		
			ply.PrimaryObj = ClientsideModel( PModel )
			ply.PrimaryObj:SetAngles(angmod) 
			ply.PrimaryObj:SetPos(posmod)
			ply.PrimaryObj:FollowBone( ply, PBoneIndex ) 

		elseif not ply:Alive() then
		
			if ply.PrimaryObj then
				ply.PrimaryObj:Remove()
			end
			
			ply.PrimaryObj = false
	
		elseif ply.PrimaryObj then

			ply.PrimaryObj:SetModel(PModel)
			
		end
		
		
		if not ply.SecondaryObj and ply:Alive() then
		
			local posmod, angmod = LocalToWorld(Vector(0,5,-7), Angle(0,0,80) ,ply:GetPos(), ply:GetAngles() )
		
			ply.SecondaryObj = ClientsideModel( SModel )
			ply.SecondaryObj:SetAngles(angmod) 
			ply.SecondaryObj:SetPos(posmod)
			ply.SecondaryObj:FollowBone( ply, SBoneIndex ) 
		
		elseif not ply:Alive() then
		
			if ply.SecondaryObj then
				ply.SecondaryObj:Remove()
			end
			
			ply.SecondaryObj = false
	
		elseif ply.SecondaryObj then
	
			ply.SecondaryObj:SetModel(SModel)

		end
		
		if ply:ShouldDrawLocalPlayer( ) == true then
			
			if ply.PrimaryObj then
				if PModel == "models/hunter/blocks/cube025x025x025.mdl" or GetConVarNumber("cl_css_equipment") == 0 then
					ply.PrimaryObj:SetNoDraw( true )
				else
					ply.PrimaryObj:SetNoDraw( false )
				end
			end
			
			if ply.SecondaryObj then
				if SModel == "models/hunter/blocks/cube025x025x025.mdl" or GetConVarNumber("cl_css_equipment") == 0 then
					ply.SecondaryObj:SetNoDraw( true )
				else
					ply.SecondaryObj:SetNoDraw( false )
				end
				
			end
			
		else
		
			if ply.PrimaryObj then
	
				ply.PrimaryObj:SetNoDraw( true )
			
			end
			
			if ply.SecondaryObj then
			
				ply.SecondaryObj:SetNoDraw( true )
			
			end
			
		end

	end



end

hook.Add ("Think", "CSSParentProject", CSSParentProject)
--]]


