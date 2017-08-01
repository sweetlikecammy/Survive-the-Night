if CLIENT then
	killicon.AddFont( "weapon_burger_cs_sig550", "csd", "o", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/sg550")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "SG550"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 4200
SWEP.CSSMoveSpeed			= 210

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.Description			= "Powerful automatic sniper that's easier to control than the G3."

SWEP.ViewModel 				= "models/weapons/cstrike/c_snip_sg550.mdl"
SWEP.WorldModel				= "models/weapons/w_snip_sg550.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 70
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_SG550.Single")
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= 30
SWEP.Primary.SpareClip		= 90
SWEP.Primary.Delay			= 0.25 --1/(240/60)
SWEP.Primary.Ammo			= "bb_556mm"
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
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.25
SWEP.ZoomTime				= 0
SWEP.ZoomDelay				= 0.125

SWEP.IronSightsPos 			= Vector(-7.481, 0, 1.48)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(-2.01, -5, 0.602)
SWEP.IronRunAng 			= Vector(-5, 15, -7.739)

SWEP.IronMeleePos			= Vector(3.417, -10, -13.87)
SWEP.IronMeleeAng 			= Vector(-9.146, 70, -70)