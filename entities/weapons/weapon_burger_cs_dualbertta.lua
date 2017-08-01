if CLIENT then
	killicon.AddFont( "weapon_burger_cs_dualbertta", "csd", "s", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/elites")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "Dual Elites"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Secondary"

SWEP.Cost					= 800
SWEP.CSSMoveSpeed				= 250

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Description			= "Inaccurate akimbo guns that deal a moderate amount of damage."

SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_pist_elite.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_elite.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "duel"

SWEP.Primary.Damage			= 45
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_ELITE.Single")
SWEP.Primary.Cone			= 0.0025
SWEP.Primary.ClipSize		= 30
SWEP.Primary.SpareClip		= 120
SWEP.Primary.Delay			= 0.12 --1/(750/60)
SWEP.Primary.Ammo			= "bb_9mm"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= -1
SWEP.RecoilSpeedMul			= 1.25
SWEP.MoveConeMul			= 1
SWEP.HeatMul				= 2
SWEP.CoolMul				= 1
SWEP.CoolSpeedMul			= 0.5

SWEP.HasScope 				= false
SWEP.ZoomAmount				= 0.5
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false 
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= false
SWEP.HasDual				= true
SWEP.HasFirstShotAccurate	= true
SWEP.SideRecoilBasedOnDual	= true
SWEP.CanShootWhileSprinting = true

SWEP.DamageFalloff			= 1000

SWEP.GetMagModel			= "models/weapons/unloaded/pist_fiveseven_mag.mdl"

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.5
SWEP.ZoomTime				= 0.5

SWEP.IronSightsPos 			= Vector(0, 0, 2)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(0, 0, 0)
SWEP.IronRunAng 			= Vector(0, 0, 0)

SWEP.IronMeleePos 			= Vector(-6, -13.468, -20)
SWEP.IronMeleeAng 			= Vector(70, 0, 0)


