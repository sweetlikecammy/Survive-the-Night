if CLIENT then
	killicon.AddFont( "weapon_burger_cs_famas", "csd", "t", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/famas")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "FAMAS"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 2250
SWEP.CSSMoveSpeed				= 220

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Description			= "General all-purpose rifle. Comes with a burst fire setting."

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_rif_famas.mdl"
SWEP.WorldModel				= "models/weapons/w_rif_famas.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_FAMAS.Single")
SWEP.Primary.Cone			= 0.0033
SWEP.Primary.ClipSize		= 25
SWEP.Primary.SpareClip		= 90
SWEP.Primary.Delay			= 0.09 --1/(666/60)
SWEP.Primary.Ammo			= "bb_556mm"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.25
SWEP.RecoilSpeedMul			= 1.1
SWEP.MoveConeMul			= 1.25
SWEP.HeatMul				= 1
SWEP.CoolMul				= 0.5
SWEP.CoolSpeedMul			= 1

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 1
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire			= true
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= false
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = false

SWEP.BurstConeMul			= 1.5
SWEP.BurstHeatMul			= 0.5
SWEP.BurstRecoilMul			= 0.75
SWEP.BurstSpeedOverride		= 1.25

SWEP.DamageFalloff			= 2500

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.5
SWEP.ZoomTime				= 0.5

SWEP.IronSightsPos 			= Vector(-5, 10, 3)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(-2.01, 0.201, 0.602)
SWEP.IronRunAng 			= Vector(-5, 15, -7.739)

SWEP.IronMeleePos = Vector(3.14, 4.623, 0)
SWEP.IronMeleeAng = Vector(0, 46.431, -26.734)