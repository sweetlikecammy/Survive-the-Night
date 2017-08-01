if CLIENT then
	killicon.AddFont( "weapon_hl2_crossbow",			"HL2MPTypeDeath",	"1",	Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/sg552")
end

SWEP.Category				= "BurgerBase: Half Life 2"
SWEP.PrintName				= "Crossbow"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 3500
SWEP.CSSMoveSpeed			= 200

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/c_crossbow.mdl"
SWEP.WorldModel				= "models/weapons/w_crossbow.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "crossbow"

SWEP.Primary.Damage			= 100
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("weapons/crossbow/fire1.wav")
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= -1
SWEP.Primary.SpareClip		= 36
SWEP.Primary.Delay			= 0.5
SWEP.Primary.Ammo			= "XBowBolt"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 0.5
SWEP.SideRecoilMul			= 0.5
SWEP.MoveConeMul			= 1
SWEP.HeatMul				= 1

SWEP.HasScope 				= true
SWEP.ZoomAmount 			= 7
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= true
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= false
SWEP.HasDryFire				= false
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = false

SWEP.HasIronSights 			= false
SWEP.EnableIronCross		= false
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.25
SWEP.ZoomDelay				= 0.125
SWEP.ZoomTime				= 0

SWEP.IronSightsPos 			= Vector(-8, 0, 2.079)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(6.119, 0, -1.8)
SWEP.IronRunAng 			= Vector(0, 28.141, 0)

SWEP.IronMeleePos 			= Vector(-7.961, 0, -12.2)
SWEP.IronMeleeAng 			= Vector(33.769, 0, 0)

--[[
function SWEP:ShootBullet(Damage,Shots,Cone,Source,Direction,Source)
	self:ThrowObject("crossbow_bolt",4000)
	self:SendWeaponAnim(ACT_VM_RELOAD)
	self.Owner:SetAnimation(PLAYER_RELOAD)
	self.Owner:EmitSound("weapons/crossbow/reload1.wav")
end
--]]

local ArrowModel = Model("models/crossbow_bolt.mdl")
local ArrowSound = Sound("fofgunsounds/bow/hit1.wav")

SWEP.UseSpecialProjectile	= true
SWEP.UseMuzzle				= true
SWEP.BulletAngOffset		= Angle(-1,0,0)

SWEP.HasHL2Pump = true
SWEP.PumpAnimation = ACT_VM_RELOAD
SWEP.PumpSound = Sound("weapons/crossbow/reload1.wav")

function SWEP:ModBoltDelay()
	return 2.5
end

function SWEP:ModProjectileTable(datatable)

	datatable.direction = datatable.direction*3000
	datatable.hullsize = 4
	datatable.resistance = (datatable.direction*0.05) + Vector(0,0,100)
	datatable.dietime = CurTime() + 10
	datatable.id = "crossbow_bolt"

	return datatable

end

-- Register Bullet
local datatable = {}
	
datatable.drawfunction = function(datatable)
	if datatable.special and datatable.special ~= NULL then
		datatable.special:SetPos(datatable.pos)
		datatable.special:SetAngles( datatable.direction:GetNormalized():Angle() )
		datatable.special:DrawModel()
	else
		datatable.special = ClientsideModel(ArrowModel, RENDERGROUP_OPAQUE )
	end
end

datatable.diefunction = function(datatable)
	if CLIENT then
		if datatable.special and datatable.special ~= NULL then
			datatable.special:Remove()
		end
	end
end

datatable.hitfunction = function(datatable,traceresult)

	local Victim = traceresult.Entity
	local Attacker = datatable.owner
	local Inflictor = datatable.weapon
	
	if not IsValid(Attacker) then
		Attacker = Victim
	end
	
	if not IsValid(Inflictor) then
		Inflictor = Attacker
	end
	
	if IsValid(Attacker) and IsValid(Victim) and IsValid(Inflictor) then
		local DmgInfo = DamageInfo()
		DmgInfo:SetDamage( datatable.damage )
		DmgInfo:SetAttacker( Attacker )
		DmgInfo:SetInflictor( Inflictor )
		DmgInfo:SetDamageForce( datatable.direction:GetNormalized() )
		DmgInfo:SetDamagePosition( datatable.pos )
		DmgInfo:SetDamageType( DMG_BULLET )
		traceresult.Entity:DispatchTraceAttack( DmgInfo, traceresult )
	end

	if SERVER and traceresult.HitWorld then
		local CreatedAmmo = BURGERBASE_FUNC_CreateAmmo(traceresult.HitPos - datatable.direction:GetNormalized()*10,datatable.direction:GetNormalized():Angle(),"XBowBolt",1,ArrowModel)
		local Phys = CreatedAmmo:GetPhysicsObject()
		CreatedAmmo:EmitSound(ArrowSound)
		SafeRemoveEntityDelayed(CreatedAmmo,30)
	end
	
end



BURGERBASE_RegisterProjectile("crossbow_bolt",datatable)