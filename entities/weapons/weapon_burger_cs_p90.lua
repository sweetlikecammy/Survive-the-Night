if CLIENT then
	killicon.AddFont( "weapon_burger_cs_p90", "csd", "m", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/p90")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "P90"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 2350
SWEP.CSSMoveSpeed				= 245

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Description			= "The mother of all SMGs. This is the best personal defence weapon man could ask for."

SWEP.Slot					= 2
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel				= "models/weapons/w_smg_p90.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "smg"

SWEP.Primary.Damage			= 26
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_P90.Single")
SWEP.Primary.Cone			= 0.002
SWEP.Primary.ClipSize		= 50
SWEP.Primary.SpareClip		= 100
SWEP.Primary.Delay			= 0.07 --1/(857/60)
SWEP.Primary.Ammo			= "bb_57mm"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 1.5
SWEP.SideRecoilMul			= 0.5
SWEP.RecoilSpeedMul			= 1.25
SWEP.MoveConeMul			= 1
SWEP.HeatMul				= 0.75
SWEP.CoolMul				= 1
SWEP.CoolSpeedMul			= 1
SWEP.MaxHeat				= 5

SWEP.HasScope 				= true
SWEP.ZoomAmount 			= 1
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= true
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = false

SWEP.DamageFalloff			= 900
SWEP.ZoomDelay				= 0.125

SWEP.HasIronSights 			= false
SWEP.EnableIronCross		= false
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.5
SWEP.ZoomTime				= 0.5

SWEP.IronSightsPos = Vector(-5.64, 0, 2.2)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(-2.01, -5, 0.602)
SWEP.IronRunAng 			= Vector(-5, 15, -7.739)

SWEP.IronMeleePos			= Vector(3.417, -10, -13.87)
SWEP.IronMeleeAng 			= Vector(-9.146, 70, -70)