if CLIENT then
	killicon.AddFont( "weapon_burger_cs_scout", "csd", "n", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/scout")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "Scout Sniper"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 2750
SWEP.CSSMoveSpeed				= 260

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.Description			= "Gives a boost to movement speed, is not affected by movement penalties."

SWEP.ViewModel 				= "models/weapons/cstrike/c_snip_scout.mdl"
SWEP.WorldModel				= "models/weapons/w_snip_scout.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 75
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_Scout.Single")
SWEP.Primary.Cone			= 0.0003
SWEP.Primary.ClipSize		= 10
SWEP.Primary.SpareClip		= 90
SWEP.Primary.Delay			= 1.25 --1/(48/60)
SWEP.Primary.Ammo			= "bb_762mm"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 0.3
SWEP.SideRecoilMul			= 1
SWEP.RecoilSpeedMul			= 1
SWEP.MoveConeMul			= 0
SWEP.HeatMul				= 1
SWEP.CoolMul				= 1
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
SWEP.HasSideRecoil			= false
SWEP.HasDownRecoil			= false
SWEP.HasFirstShotAccurate	= true
SWEP.HasIdle				= false
SWEP.CanShootWhileSprinting = false

SWEP.DamageFalloff			= 5000

SWEP.HasIronSights 			= false
SWEP.EnableIronCross		= false
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.125
SWEP.ZoomDelay				= 0.125
SWEP.ZoomTime				= 0

SWEP.IronSightsPos 			= Vector(-6.72, 0, 3.359)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(-2.01, -5, 0.602)
SWEP.IronRunAng 			= Vector(-5, 15, -7.739)

SWEP.IronMeleePos			= Vector(3.417, -10, -13.87)
SWEP.IronMeleeAng 			= Vector(-9.146, 70, -70)


