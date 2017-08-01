if CLIENT then
	killicon.AddFont( "weapon_burger_cs_g3", "csd", "i", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/g3sg1")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "G3SG1"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 5000
SWEP.CSSMoveSpeed				= 210

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Description			= "Powerful automatic sniper. Two shots is all you need."

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_snip_g3sg1.mdl"
SWEP.WorldModel				= "models/weapons/w_snip_g3sg1.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 80
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_G3SG1.Single")
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= 20
SWEP.Primary.SpareClip		= 90
SWEP.Primary.Delay			= 0.25 --1/(240/60)
SWEP.Primary.Ammo			= "bb_762mm"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.25
SWEP.RecoilSpeedMul			= 0.75
SWEP.MoveConeMul			= 5
SWEP.HeatMul				= 0.5
SWEP.CoolMul				= 1
SWEP.CoolSpeedMul			= 2

SWEP.HasScope 				= true
SWEP.ZoomAmount 			= 7
SWEP.HasCrosshair 			= false
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false 
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= false
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = false

SWEP.DamageFalloff			= 4000

SWEP.HasIronSights 			= false
SWEP.EnableIronCross		= false
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.5
SWEP.ZoomTime				= 0
SWEP.ZoomDelay				= 0.25

SWEP.IronSightsPos 			= Vector(-6.2, 0, 1.879)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(-2.01, 0.201, 0.602)
SWEP.IronRunAng 			= Vector(-5, 15, -7.739)

SWEP.IronMeleePos			= Vector(3.417, -14.674, -13.87)
SWEP.IronMeleeAng 			= Vector(-9.146, 70, -70)


