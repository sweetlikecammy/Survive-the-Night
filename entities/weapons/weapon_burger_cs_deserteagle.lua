if CLIENT then
	killicon.AddFont( "weapon_burger_cs_deserteagle", "csd", "f", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/deserteagle")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "Desert Eagle"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Secondary"

SWEP.Cost					= 650
SWEP.CSSMoveSpeed				= 250

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Description			= "Accurate high-damage handcannon. Headshots are usually fatal."

SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_deagle.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "revolver"

SWEP.Primary.Damage			= 54
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_DEagle.Single")
SWEP.Primary.Cone			= 0.001
SWEP.Primary.ClipSize		= 7
SWEP.Primary.SpareClip		= 35
SWEP.Primary.Delay			= 0.225
SWEP.Primary.Ammo			= "bb_50ae"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 2
SWEP.SideRecoilMul			= 1
SWEP.RecoilSpeedMul			= 0.8
SWEP.MoveConeMul			= 1
SWEP.HeatMul				= 3
SWEP.CoolMul				= 1
SWEP.CoolSpeedMul			= 1

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 0.75
SWEP.HasCrosshair			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= false
SWEP.HasFirstShotAccurate	= true
SWEP.DamageFalloff			= 3000

SWEP.CanShootWhileSprinting = true

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.25
SWEP.ZoomTime				= 0.25

SWEP.IronSightsPos 			= Vector(-6.361, 10, 1.5)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(0, 0, 0)
SWEP.IronRunAng 			= Vector(0, 0, 0)

SWEP.IronMeleePos 			= Vector(-6.433, -13.468, -20)
SWEP.IronMeleeAng 			= Vector(70, 0, 0)

