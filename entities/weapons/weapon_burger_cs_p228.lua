if CLIENT then
	killicon.AddFont( "weapon_burger_cs_p228", "csd", "y", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/p228")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "P228"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Secondary"

SWEP.Cost					= 600
SWEP.CSSMoveSpeed				= 250

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.Description			= "Inaccurate pistol that deals high damage. Headshots are fatal."

SWEP.ViewModel 				= "models/weapons/cstrike/c_pist_p228.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_p228.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "revolver"

SWEP.Primary.Damage			= 48
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_P228.Single")
SWEP.Primary.Cone			= 0.01
SWEP.Primary.ClipSize		= 13
SWEP.Primary.SpareClip		= 52
SWEP.Primary.Delay			= 0.15 --1/(400/60)
SWEP.Primary.Ammo			= "bb_357sig"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.25
SWEP.RecoilSpeedMul			= 1.25
SWEP.MoveConeMul			= 0.5
SWEP.HeatMul				= 0.5
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
SWEP.HasSideRecoil			= false
SWEP.HasDownRecoil			= false
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = true

SWEP.DamageFalloff			= 2000

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.25
SWEP.ZoomTime				= 0.5

SWEP.IronSightsPos 			= Vector(-5.961, 0, 1.759)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(0, 0, 0)
SWEP.IronRunAng 			= Vector(0, 0, 0)

SWEP.IronMeleePos 			= Vector(-5.801, -13.468, -20)
SWEP.IronMeleeAng 			= Vector(70, 0, 0)