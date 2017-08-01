if CLIENT then
	killicon.AddFont( "weapon_burger_cs_ak47", "csd", "b", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/ak47")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "AK-47"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 2500
SWEP.CSSMoveSpeed			= 221

SWEP.Description			= "Excels at long-to-medium range."

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel				= "models/weapons/w_rif_ak47.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 36
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_AK47.Single")
SWEP.Primary.Cone			= 0.0025
SWEP.Primary.ClipSize		= 30
SWEP.Primary.SpareClip		= 90
SWEP.Primary.Delay			= 0.1
SWEP.Primary.Ammo			= "bb_762mm"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 2
SWEP.SideRecoilMul			= 0.25
SWEP.RecoilSpeedMul			= 1.125
SWEP.MoveConeMul			= 3
SWEP.HeatMul				= 0.5
SWEP.CoolMul				= 0.75
SWEP.CoolSpeedMul			= 1.25
SWEP.MaxHeat				= 10

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

SWEP.IronSightsPos 			= Vector(-6.64, 20, 1)
SWEP.IronSightsAng			= Vector(2.5, 0, 0)

SWEP.IronRunPos 			= Vector(8.843, -7.035, 0)
SWEP.IronRunAng 			= Vector(0, 45, 0)

SWEP.IronMeleePos 			= Vector(0, -1.609, -0.202)
SWEP.IronMeleeAng 			= Vector(-5.628, 35.879, -52.061)





