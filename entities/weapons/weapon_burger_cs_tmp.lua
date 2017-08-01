if CLIENT then
	killicon.AddFont( "weapon_burger_cs_tmp", "csd", "d", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/tmp")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "TMP"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 1250
SWEP.CSSMoveSpeed				= 250

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 2
SWEP.SlotPos				= 1

SWEP.Description			= "Silenced SMG that's good for close range."

SWEP.ViewModel 				= "models/weapons/cstrike/c_smg_tmp.mdl"
SWEP.WorldModel				= "models/weapons/w_smg_tmp.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "smg"

SWEP.Primary.Damage			= 26
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Sound			= Sound("Weapon_TMP.Single")
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.SpareClip		= 120
SWEP.Primary.Delay			= 0.07 --1/(857/60)
SWEP.Primary.Ammo			= "bb_9mm"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 2
SWEP.SideRecoilMul			= 0.25
SWEP.RecoilSpeedMul			= 1
SWEP.MoveConeMul			= 0.75
SWEP.HeatMul				= 1
SWEP.CoolMul				= 1
SWEP.CoolSpeedMul			= 1

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 0.5
SWEP.ZoomTime				= 0.5
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

SWEP.DamageFalloff			= 800

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.25
SWEP.ZoomTime				= 0.5

SWEP.IronSightsPos = Vector(-4.08, 0, 2.24)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(-2.01, -5, 0.602)
SWEP.IronRunAng 			= Vector(-5, 15, -7.739)

SWEP.IronMeleePos 			= Vector(-5.801, -13.468, -20)
SWEP.IronMeleeAng 			= Vector(70, 0, 0)