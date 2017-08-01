if CLIENT then
	killicon.AddFont( "weapon_burger_cs_mp5", "csd", "x", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/mp5")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "MP5"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 1500
SWEP.CSSMoveSpeed				= 250

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Description			= "SMG that has long range capabilities."

SWEP.Slot					= 2
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_smg_mp5.mdl"
SWEP.WorldModel				= "models/weapons/w_smg_mp5.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "smg"

SWEP.Primary.Damage			= 26
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_MP5Navy.Single")
SWEP.Primary.Cone			= 0.003
SWEP.Primary.ClipSize		= 30
SWEP.Primary.SpareClip		= 120
SWEP.Primary.Delay			= 0.08 --1/(750/60)
SWEP.Primary.Ammo			= "bb_9mm"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 1.25
SWEP.SideRecoilMul			= 0.25
SWEP.RecoilSpeedMul			= 1.25
SWEP.MoveConeMul			= 0.75
SWEP.HeatMul				= 0.5
SWEP.CoolMul				= 1
SWEP.CoolSpeedMul			= 1

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 0.5
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

SWEP.DamageFalloff			= 2000

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.25
SWEP.ZoomTime				= 0.5
SWEP.IronSightsPos 			= Vector(-5.321, 0, 1.36)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(-2.01, -5, 0.602)
SWEP.IronRunAng 			= Vector(-5, 15, -7.739)

SWEP.IronMeleePos 			= Vector(-5.801, -13.468, -20)
SWEP.IronMeleeAng 			= Vector(70, 0, 0)

