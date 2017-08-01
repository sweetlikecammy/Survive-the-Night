if CLIENT then
	killicon.AddFont( "weapon_burger_cs_m4", "csd", "w", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/m4a1")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "M4A1"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 3100
SWEP.CSSMoveSpeed			= 230

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Description			= "Your classic automatic rifle with a lot of stopping power. Comes with a silencer."

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel				= "models/weapons/w_rif_m4a1.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 33
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_M4A1.Single")
SWEP.Primary.Cone			= 0.005
SWEP.Primary.ClipSize		= 30
SWEP.Primary.SpareClip		= 90
SWEP.Primary.Delay			= 0.09 --1/(666/60)
SWEP.Primary.Ammo			= "bb_556mm"
SWEP.Primary.Automatic 		= true

SWEP.WorldModel1			= "models/weapons/w_rif_m4a1.mdl"
SWEP.WorldModel2 			= "models/weapons/w_rif_m4a1_silencer.mdl"
SWEP.Secondary.Sound		= Sound("Weapon_M4A1.Silenced")

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.5
SWEP.RecoilSpeedMul			= 1.25
SWEP.MoveConeMul			= 1.5
SWEP.HeatMul				= 1
SWEP.CoolMul				= 1
SWEP.CoolSpeedMul			= 1

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 0.75
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= true
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= false
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = false
SWEP.DamageFalloff			= 2000

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.5
SWEP.ZoomTime				= 0.5

SWEP.IronSightsPos 			= Vector(-4.481, 0, 1)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(-2.01, -5, 0.602)
SWEP.IronRunAng 			= Vector(-5, 15, -7.739)

SWEP.IronMeleePos			= Vector(3.417, -10, -13.87)
SWEP.IronMeleeAng 			= Vector(-9.146, 70, -70)

