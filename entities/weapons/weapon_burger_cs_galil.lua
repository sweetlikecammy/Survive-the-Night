if CLIENT then	
	killicon.AddFont( "weapon_burger_cs_galil", "csd", "v", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/galil")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "Galil"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"
SWEP.Cost					= 2000
SWEP.CSSMoveSpeed			= 215

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Description			= "Excels at medium range."

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel				= "models/weapons/w_rif_galil.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_Galil.Single")
SWEP.Primary.Cone			= 0.0065
SWEP.Primary.ClipSize		= 35
SWEP.Primary.SpareClip		= 90
SWEP.Primary.Delay			= 0.09 --1/(666/60)
SWEP.Primary.Ammo			= "bb_556mm"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 1.25
SWEP.SideRecoilMul			= 0.25
SWEP.RecoilSpeedMul			= 1
SWEP.MoveConeMul			= 1
SWEP.HeatMul				= 0.75
SWEP.CoolMul				= 1
SWEP.CoolSpeedMul			= 1

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 1
SWEP.HasCrosshair 			= true
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

SWEP.DamageFalloff			= 3000

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.5
SWEP.ZoomTime				= 0.5

SWEP.IronSightsPos 			= Vector(-6.361, 10 , 2)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(-2.01, 0.201, 0.602)
SWEP.IronRunAng 			= Vector(-5, 15, -7.739)

SWEP.IronMeleePos			= Vector(3.417, -14.674, -13.87)
SWEP.IronMeleeAng 			= Vector(-9.146, 70, -70)