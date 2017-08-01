if CLIENT then
	killicon.AddFont( "weapon_hl2_pistol",		"HL2MPTypeDeath",	"-",	Color( 255, 80, 0, 255 ) )
	--SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/usp45")
end

SWEP.Category				= "BurgerBase: Half Life 2"
SWEP.PrintName				= "Pistol"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Secondary"

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Cost					= 0
SWEP.CSSMoveSpeed			= 230

SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/c_pistol.mdl"
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "revolver"

SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Sound			= Sound("weapons/pistol/pistol_fire2.wav")
SWEP.Primary.Cone			= 0.005
SWEP.Primary.ClipSize		= 18
SWEP.Primary.SpareClip		= 150
SWEP.Primary.Delay			= 0.1
SWEP.Primary.Ammo			= "pistol"
SWEP.Primary.Automatic 		= false
SWEP.ReloadSound			= Sound("weapons/pistol/pistol_reload1.wav")

SWEP.RecoilMul				= 2
SWEP.SideRecoilMul			= 1
SWEP.RecoilSpeedMul			= 0.75
SWEP.MoveConeMul			= 0.5
SWEP.HeatMul				= 0.25
SWEP.CoolMul				= 1
SWEP.CoolSpeedMul			= 1

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 0.75
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= false
SWEP.HasDryFire				= false
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = true

SWEP.DamageFalloff			= 1000

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.25

SWEP.IronSightsPos = Vector(-2.401, 0, 1.919)
SWEP.IronSightsAng = Vector(0, 0, -70)

SWEP.IronMeleePos = Vector(-3.481, 0, 3)
SWEP.IronMeleeAng = Vector(15, 0, 22.513)

SWEP.IronRunPos				= Vector(0,0,0)
SWEP.IronRunAng				= Vector(0,0,0)




