local AssociatedWeapons = {
	bb_hegrenade = "weapon_burger_cs_he",
	bb_flashgrenade = "weapon_burger_cs_flash",
	bb_smokegrenade = "weapon_burger_cs_smoke",
	ex_gasgrenade = "weapon_burger_ex_gas"
}

local function BURGERBASE_HOOK_DoPlayerDeath(ply)

	ply:SetNWString("cssprimary","")
	ply:SetNWString("csssecondary","")

	if BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_drops_enable",false):GetInt() == 1 then
	
		for k,v in pairs(ply:GetWeapons()) do
			BURGERBASE_FUNC_DropWeapon(ply,v)
		end
		
		BURGERBASE_FUNC_DropAmmo(ply,"all")
		
	end
end
	
hook.Add("DoPlayerDeath", "BURGERBASE_HOOK_DoPlayerDeath", BURGERBASE_HOOK_DoPlayerDeath )

local NextThink = 0

local function BURGERBASE_HOOK_Think()
	if NextThink <= CurTime() then
		for k,v in pairs(player.GetAll()) do
			for ammo,weapon in pairs(AssociatedWeapons) do
				if not v:HasWeapon(weapon) then
					if v:GetAmmoCount(ammo) > 0 then
						local NewWeapon = v:Give(weapon)
						NewWeapon.AlreadyGiven = true
					end
				end
			end
		end
		NextThink = CurTime() + 1
	end
end

hook.Add("Think","BURGERBASE_HOOK_Think",BURGERBASE_HOOK_Think)



function BURGERBASE_FUNC_ReplaceHL2Weapons()

	local ReplacementTable = {}
	ReplacementTable["weapon_357"] = 		"weapon_hl2_357"
	ReplacementTable["weapon_ar2"] = 		"weapon_hl2_ar2"
	ReplacementTable["weapon_crossbow"] = 	"weapon_hl2_crossbow"
	ReplacementTable["weapon_crowbar"] = 	"weapon_hl2_crowbar"
	ReplacementTable["weapon_frag"] = 		"weapon_burger_cs_he"
	ReplacementTable["weapon_pistol"] = 	"weapon_hl2_pistol"
	ReplacementTable["weapon_rpg"] = 		"weapon_hl2_rpg"
	ReplacementTable["weapon_shotgun"] = 	"weapon_hl2_spas"
	ReplacementTable["weapon_smg1"] = 		"weapon_hl2_smg"
	ReplacementTable["weapon_stunstick"] = 	"weapon_hl2_stunstick"
	
	for k,v in pairs(ents.GetAll()) do
		if v:IsWeapon() and ReplacementTable[v:GetClass()] then
			BURGERBASE_FUNC_CreateWeapon(ReplacementTable[v:GetClass()],v:GetPos(),v:GetAngles(),nil,nil)
			SafeRemoveEntity(v)
		end
	end

end

hook.Add("PostCleanupMap","BURGERBASE_FUNC_ReplaceHL2Weapons",BURGERBASE_FUNC_ReplaceHL2Weapons)

BURGERBASE_FUNC_ReplaceHL2Weapons()

function BURGERBASE_FUNC_CreateWeapon(class,pos,ang,ammooverride,spareoverride)

	local StoredWeapon = weapons.GetStored(class)
	
	if not StoredWeapon then 
		print(string.upper("ERROR: BURGERBASE_FUNC_CreateWeapon() COULD NOT CREATE " .. class .. "!"))
		return false 
	end
	
	if not spareoverride then 
		spareoverride = StoredWeapon.Primary.SpareClip
	end
	
	if not ammooverride then
		ammooverride = StoredWeapon.Primary.ClipSize
	end

	local WeaponModel = StoredWeapon.WorldModel

	if StoredWeapon.DisplayModel then
		WeaponModel = StoredWeapon.DisplayModel
	end
	
	--print(WeaponModel)

	if WeaponModel && WeaponModel ~= "" then
		local CreatedWeapon = ents.Create("ent_burger_core_dropped_weapon")
		CreatedWeapon:SetPos(pos)
		CreatedWeapon:SetAngles(ang)
		CreatedWeapon:SetModel(WeaponModel)
		CreatedWeapon:SetNWString("class",class)
		CreatedWeapon:SetNWFloat("clip",ammooverride)
		CreatedWeapon:SetNWFloat("spare",spareoverride)	
		CreatedWeapon:SetCustomCollisionCheck( true )
		CreatedWeapon:Spawn()
		CreatedWeapon:Activate()
		return CreatedWeapon
	else
		return NULL
	end

end

function BURGERBASE_FUNC_CreateAmmo(pos,ang,ammotype,amount,model)

	if not model then
		model = "models/weapons/w_defuser.mdl"
	end

	local Ammo = ents.Create("ent_burger_core_ammo")
	Ammo.AmmoType = ammotype
	Ammo.AmmoAmount = amount
	Ammo.AmmoModel = model
	Ammo:SetPos( pos )
	Ammo:SetAngles( ang )
	Ammo:SetCustomCollisionCheck( true )
	Ammo:Spawn()
	Ammo:Activate()

	return Ammo
	
end

function BURGERBASE_FUNC_CreateAmmoTable(pos,ang,ammotable,model)

	if not model then
		model = "models/weapons/w_defuser.mdl"
	end

	local Ammo = ents.Create("ent_burger_core_dropped_ammo")
	Ammo.AmmoTable = ammotable
	Ammo.AmmoModel = model
	Ammo:SetPos( pos )
	Ammo:SetAngles( ang )
	Ammo:SetCustomCollisionCheck( true )
	Ammo:Spawn()
	Ammo:Activate()
	
	return Ammo

end



function BURGERBASE_FUNC_DropWeapon(ply,weapon)

	if weapon:IsScripted() then
		if weapon.BurgerBase ~= nil or weapon.Base == "weapon_burger_core_base" then
		
			local Class = weapon:GetClass()
			local StoredWeapon =  weapons.GetStored(Class)
			local Pos = ply:GetPos() + ply:OBBCenter()
			local Ang = ply:EyeAngles()
			local Clip1 = weapon:Clip1() -- Ammo in the clip
			local Ammo1 = weapon:Ammo1() -- Ammo in reserve
			local CreatedWeapon = BURGERBASE_FUNC_CreateWeapon(Class,Pos,Ang,Clip1,0)
			
			if ply:Alive() then
				if StoredWeapon.WeaponType == "Throwable" then
					local AmmoToSet = math.Clamp(Ammo1 - 1,0,9999)
					ply:SetAmmo( AmmoToSet, weapon:GetPrimaryAmmoType() )
					if AmmoToSet <= 0 then
						ply:StripWeapon(Class)
					end
				else
					ply:StripWeapon(Class)
				end
			elseif BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_drops_timed",false):GetInt() == 1 then
				if CreatedWeapon and CreatedWeapon ~= NULL then
					SafeRemoveEntityDelayed(CreatedWeapon,BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_drops_timer",false):GetInt())
				end
			end
			
			if ply and CreatedWeapon and CreatedWeapon ~= NULL then
				CreatedWeapon:GetPhysicsObject():SetVelocity(ply:EyeAngles():Forward()*100)
			end
			
		end
	end
	
end

function BURGERBASE_FUNC_DropAmmo(ply,weapon,amount)

	local Pos = ply:GetPos() + ply:OBBCenter()
	local Ang = ply:EyeAngles() + Angle( math.Rand(1,360),math.Rand(1,360),math.Rand(1,360))
	local DroppedAmmo = nil

	if weapon == "all" then
	
		local AllAmmoTable = {}
		
		for i = 1, 100 do
			AllAmmoTable[i] = ply:GetAmmoCount( i )
		end
		
		if AllAmmoTable[1] then
			DroppedAmmo = BURGERBASE_FUNC_CreateAmmoTable(Pos,Ang,AllAmmoTable)
			ply:RemoveAllAmmo()
		end
		
	else
	
		local AmmoModel = "models/weapons/w_defuser.mdl"
		local AmmoType = weapon:GetPrimaryAmmoType()
		local AmmoCount = ply:GetAmmoCount(AmmoType)
		local ClipCount = weapon:GetMaxClip1()
	
		if weapon:IsScripted() and (weapon.BurgerBase or weapon.Base == "weapon_burger_core_base") then
			if weapon.WeaponType == "Throwable" then
				BURGERBASE_FUNC_DropWeapon(ply,weapon)
				return
			elseif weapon.GetMagModel then
				if file.Exists(weapon.GetMagModel,"GAME") then
					AmmoModel = weapon.GetMagModel
				end
			end
		end

		if ClipCount == -1 and weapon.Primary.SpareClip then
			ClipCount = math.Clamp(math.ceil(weapon.Primary.SpareClip * 0.1),-1,9999)
		end
		
		local AmmoCountToDrop = math.min(AmmoCount,ClipCount)

		if amount then
			AmmoCountToDrop = amount
		end

		if AmmoCountToDrop > 0 then
		
			DroppedAmmo = BURGERBASE_FUNC_CreateAmmo(Pos,Ang,AmmoType,AmmoCountToDrop,AmmoModel)

			if weapon.WeaponType == "Throwable" then
				if ply:GetAmmoCount(AmmoType) <= 0 then
					ply:StripWeapon(weapon:GetClass())
				end
			end

			if ply:Alive() then
				ply:SetAmmo( math.Clamp(AmmoCount - AmmoCountToDrop,0,9999) , AmmoType)
			end

		end
			
	end
	
	if DroppedAmmo then
		DroppedAmmo:GetPhysicsObject():SetVelocity(ply:GetForward()*100)
		if BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_drops_timed",false):GetInt() == 1 then
			SafeRemoveEntityDelayed(DroppedAmmo,BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_drops_timer",false):GetInt())
		end
	end
	
end


local function BURGERBASE_COMMAND_Dropping(ply,cmd,args,argStr)

	local Weapon = ply:GetActiveWeapon()
	
	if Weapon and Weapon:IsValid() then
		if cmd == "dropweapon" then
			BURGERBASE_FUNC_DropWeapon(ply,Weapon)
		elseif cmd == "dropammo" then
			BURGERBASE_FUNC_DropAmmo(ply,Weapon)
		end
	end

end

concommand.Add("dropweapon", BURGERBASE_COMMAND_Dropping)
concommand.Add("dropammo", BURGERBASE_COMMAND_Dropping)
