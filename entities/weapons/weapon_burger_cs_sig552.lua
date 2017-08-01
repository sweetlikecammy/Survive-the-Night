if CLIENT then
	killicon.AddFont( "weapon_burger_cs_sig552", "csd", "A", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/sg552")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "SG552"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 3500
SWEP.CSSMoveSpeed				= 230

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.Description			= "Scoped assault rifle that deals quite a bit of damage."

SWEP.ViewModel 				= "models/weapons/cstrike/c_rif_sg552.mdl"
SWEP.WorldModel				= "models/weapons/w_rif_sg552.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 33
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_SG552.Single")
SWEP.Primary.Cone			= 0.002
SWEP.Primary.ClipSize		= 30
SWEP.Primary.SpareClip		= 90
SWEP.Primary.Delay			= 0.09 --1/(666/60)
SWEP.Primary.Ammo			= "bb_556mm"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.5
SWEP.RecoilSpeedMul			= 1.25
SWEP.MoveConeMul			= 1.5
SWEP.HeatMul				= 1
SWEP.CoolMul				= 1
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
SWEP.HasDownRecoil			= false
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = false

SWEP.DamageFalloff			= 2000

SWEP.HasIronSights 			= false
SWEP.EnableIronCross		= false
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.25
SWEP.ZoomTime				= 0
SWEP.ZoomDelay				= 0.125

SWEP.IronSightsPos 			= Vector(-7.881, 0, 2.559)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(-2.01, -5, 0.602)
SWEP.IronRunAng 			= Vector(-5, 15, -7.739)

SWEP.IronMeleePos			= Vector(3.417, -10, -13.87)
SWEP.IronMeleeAng 			= Vector(-9.146, 70, -70)




