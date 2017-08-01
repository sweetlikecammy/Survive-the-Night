if CLIENT then
	killicon.AddFont( "weapon_hl2_357",			"HL2MPTypeDeath",	".",	Color( 255, 80, 0, 255 ) )
--	killicon.AddFont( "ent_cs_crossbow_bolt",		"HL2MPTypeDeath",	"1",	Color( 255, 80, 0, 255 ) )
--	killicon.AddFont( "ent_cs_combine_ball",	"HL2MPTypeDeath",	"8",	Color( 255, 80, 0, 255 ) )
--	killicon.AddFont( "ent_cs_smg1_grenade",		"HL2MPTypeDeath",	"7",	Color( 255, 80, 0, 255 ) )
end

SWEP.Category				= "BurgerBase: Half Life 2"
SWEP.PrintName				= ".357"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Secondary"

SWEP.Cost					= 0
SWEP.CSSMoveSpeed			= 230

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/c_357.mdl"
SWEP.WorldModel				= "models/weapons/w_357.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "revolver"

SWEP.Primary.Damage			= 95
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("weapons/357/357_fire2.wav")
SWEP.Primary.Cone			= 0.002
SWEP.Primary.ClipSize		= 6
SWEP.Primary.SpareClip		= 36
SWEP.Primary.Delay			= 1/(120/60)
SWEP.Primary.Ammo			= "357"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.25
SWEP.RecoilSpeedMul			= 0.75
SWEP.MoveConeMul			= 2
SWEP.HeatMul				= 1
SWEP.CoolMul				= 1
SWEP.CoolSpeedMul			= 1

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 1
SWEP.HasCrosshair			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= false
SWEP.HasDryFire				= false
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = false

SWEP.BurstOverride			= 6
SWEP.BurstConeMul			= 10

SWEP.DamageFalloff			= 3000

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.25

SWEP.IronSightsPos 			= Vector(-4.64, 20, 0)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(0, -12.664, -21.48)
SWEP.IronRunAng			 	= Vector(70, 0, 0)

SWEP.IronMeleePos 			= Vector(-6.433, -13.468, -20)
SWEP.IronMeleeAng 			= Vector(70, 0, 0)

SWEP.UseSpecialProjectile	= false
SWEP.UseMuzzle				= false

function SWEP:ModProjectileTable(datatable)

	datatable.direction = datatable.direction*6000
	datatable.hullsize = 1
	datatable.usehull = true
	datatable.resistance = (datatable.direction*0.05) + Vector(0,0,100)
	datatable.dietime = CurTime() + 50
	datatable.id = "css_bullet"

	return datatable
	
end
