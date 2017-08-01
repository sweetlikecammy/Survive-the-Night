if CLIENT then
	killicon.AddFont( "weapon_burger_cs_awp", "csd", "r", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/awp")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "AWP"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 4750
SWEP.CSSMoveSpeed			= 210
SWEP.CSSZoomSpeed			= 150

SWEP.Description			= "Bolt action high-damage sniper rifle. Bodyshots are fatal."

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_snip_awp.mdl"
SWEP.WorldModel				= "models/weapons/w_snip_awp.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 115
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_AWP.Single")
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= 10
SWEP.Primary.SpareClip		= 30
SWEP.Primary.Delay			= 1.5
SWEP.Primary.Ammo			= "bb_338"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 0.5
SWEP.SideRecoilMul			= 0.25
SWEP.RecoilSpeedMul			= 0.75
SWEP.MoveConeMul			= 3
SWEP.HeatMul				= 1
SWEP.CoolMul				= 0.75
SWEP.CoolSpeedMul			= 1


SWEP.HasScope 				= true
SWEP.ZoomAmount 			= 9
SWEP.HasCrosshair 			= false
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= true
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= false
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = false

SWEP.DamageFalloff			= 9000

SWEP.HasIronSights 			= false
SWEP.EnableIronCross		= false
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.5
SWEP.ZoomTime				= 0.125
SWEP.ZoomDelay				= 0.125

SWEP.IronSightsPos 			= Vector(-7.481, 0, 2.279)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(-2.01, 0.201, 0.602)
SWEP.IronRunAng 			= Vector(-5, 15, -7.739)

SWEP.IronMeleePos			= Vector(3.417, -14.674, -13.87)
SWEP.IronMeleeAng 			= Vector(-9.146, 70, -70)