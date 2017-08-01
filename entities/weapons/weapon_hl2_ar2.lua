if CLIENT then
	killicon.AddFont( "weapon_hl2_ar2",			"HL2MPTypeDeath",	"2",	Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/sg552")
end

SWEP.Category				= "BurgerBase: Half Life 2"
SWEP.PrintName				= "AR2"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 3500
SWEP.CSSMoveSpeed			= 220

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/c_irifle.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 20
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("weapons/ar2/fire1.wav")
SWEP.Primary.Cone			= 0.006
SWEP.Primary.ClipSize		= 30
SWEP.Primary.SpareClip		= 90
SWEP.Primary.Delay			= 0.1
SWEP.Primary.Ammo			= "ar2"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 1
SWEP.RecoilSpeedMul			= 2
SWEP.MoveConeMul			= 2
SWEP.HeatMul				= 0.5
SWEP.CoolMul				= 0.5
SWEP.CoolSpeedMul			= 1

SWEP.HasScope 				= true
SWEP.ZoomAmount 			= 3
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= true

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= true
SWEP.HasDryFire				= false
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = false

SWEP.DamageFalloff			= 3000
SWEP.DamageType				= 2

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= false
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.5
SWEP.ZoomTime				= 0.125
SWEP.ZoomDelay				= 0.125

SWEP.IronSightsPos 			= Vector(-5.801, 0, 1.08)
SWEP.IronSightsAng 			= Vector(0, 0, -10)

SWEP.IronRunPos 			= Vector(8.843, -7.035, -5)
SWEP.IronRunAng 			= Vector(0, 45, 0)

SWEP.IronMeleePos 			= Vector(0, -1.609, -0.202)
SWEP.IronMeleeAng 			= Vector(-5.628, 35.879, -52.061)