if CLIENT then
	killicon.AddFont( "weapon_burger_cs_usp", "csd", "y", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/usp45")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "USP"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Secondary"

SWEP.Cost					= 500
SWEP.CSSMoveSpeed				= 250

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Description			= ".45 pistol that comes with a silencer"

SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_usp.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "revolver"

SWEP.Primary.Damage			= 34
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Sound			= Sound("Weapon_USP.Single")
SWEP.Primary.Cone			= 0.004
SWEP.Primary.ClipSize		= 12
SWEP.Primary.SpareClip		= 100
SWEP.Primary.Delay			= 0.15 --1/(400/60)
SWEP.Primary.Ammo			= "bb_45acp"
SWEP.Primary.Automatic 		= false

SWEP.WorldModel1			= "models/weapons/w_pist_usp.mdl"
SWEP.WorldModel2 			= "models/weapons/w_pist_usp_silencer.mdl"
SWEP.Secondary.Sound 		= Sound("Weapon_USP.SilencedShot")

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.25
SWEP.RecoilSpeedMul			= 1.5
SWEP.MoveConeMul			= 1
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
SWEP.HasSilencer 			= true
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= false
SWEP.HasDownRecoil			= false
SWEP.HasDryFire				= true
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = true

SWEP.DamageFalloff			= 2000

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.25
SWEP.ZoomTime				= 0.5

SWEP.IronSightsPos 			= Vector(-4, 0, 1.759)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(0, 0, 0)
SWEP.IronRunAng 			= Vector(0, 0, 0)

SWEP.IronMeleePos 			= Vector(-5.801, -13.468, -20)
SWEP.IronMeleeAng 			= Vector(70, 0, 0)