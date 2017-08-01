if CLIENT then
	killicon.AddFont( "weapon_burger_cs_ump", "csd", "q", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/gfx/vgui/ump45")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "UMP45"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 1700
SWEP.CSSMoveSpeed				= 250

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 2
SWEP.SlotPos				= 1

SWEP.Description			= "Powerful SMG that's excels at medium range."

SWEP.ViewModel 				= "models/weapons/cstrike/c_smg_ump45.mdl"
SWEP.WorldModel				= "models/weapons/w_smg_ump45.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "smg"

SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_UMP45.Single")
SWEP.Primary.Cone			= 0.004
SWEP.Primary.ClipSize		= 25
SWEP.Primary.SpareClip		= 100
SWEP.Primary.Delay			= 0.09 --1/(666/60)
SWEP.Primary.Ammo			= "bb_45acp"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.25
SWEP.RecoilSpeedMul			= 1.25
SWEP.MoveConeMul			= 1
SWEP.HeatMul				= 0.75
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
SWEP.HasDownRecoil			= false
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = false

SWEP.DamageFalloff			= 1500

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.25
SWEP.ZoomTime				= 0.5

SWEP.IronSightsPos = Vector(-7.401, 0, 2.2)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(-2.01, -5, 0.602)
SWEP.IronRunAng 			= Vector(-5, 15, -7.739)

SWEP.IronMeleePos 			= Vector(-5.801, -13.468, -20)
SWEP.IronMeleeAng 			= Vector(70, 0, 0)
