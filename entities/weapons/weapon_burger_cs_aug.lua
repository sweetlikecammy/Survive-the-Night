if CLIENT then
	killicon.AddFont( "weapon_burger_cs_aug", "csd", "e", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon		= surface.GetTextureID("vgui/gfx/vgui/aug")
end 

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "AUG"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 3500
SWEP.CSSMoveSpeed				= 221

SWEP.Description			= "Excels at long-to-medium range. Comes with a scope."

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_rif_aug.mdl"
SWEP.WorldModel				= "models/weapons/w_rif_aug.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "smg"

SWEP.Primary.Damage			= 32
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_AUG.Single")
SWEP.Primary.Cone			= 0.001
SWEP.Primary.ClipSize		= 30
SWEP.Primary.SpareClip		= 90
SWEP.Primary.Delay			= 0.09
SWEP.Primary.Ammo			= "bb_556mm"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.5
SWEP.RecoilSpeedMul			= 0.9
SWEP.MoveConeMul			= 2
SWEP.HeatMul				= 0.25
SWEP.CoolMul				= 0.75
SWEP.CoolSpeedMul			= 1
SWEP.MaxHeat				= 10

SWEP.HasScope 				= true
SWEP.ZoomAmount				= 3
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= true

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= false
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = false

SWEP.DamageFalloff			= 3000

SWEP.HasIronSights 			= false
SWEP.EnableIronCross		= false
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.5
SWEP.ZoomTime				= 0.5
SWEP.ZoomDelay				= 0.125

SWEP.IronSightsPos 			= Vector(-7.437, -7.035, 2.009)
SWEP.IronSightsAng 			= Vector(0, 0, -36.401)

SWEP.IronRunPos 			= Vector(-2.01, 0.201, 0.602)
SWEP.IronRunAng 			= Vector(-5, 15, -7.739)

SWEP.IronMeleePos			= Vector(3.417, -14.674, -13.87)
SWEP.IronMeleeAng 			= Vector(-9.146, 70, -70)

