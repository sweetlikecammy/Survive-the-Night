if CLIENT then
	killicon.AddFont( "weapon_burger_cs_para", "csd", "z", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/m249")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "M249 PARA"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 5750
SWEP.CSSMoveSpeed			= 220

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.Description			= "Heavy machinegun that's good for clearing rooms."

SWEP.ViewModel 				= "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel				= "models/weapons/w_mach_m249para.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 35
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_M249.Single")
SWEP.Primary.Cone			= 0.0075
SWEP.Primary.ClipSize		= 100
SWEP.Primary.SpareClip		= 200
SWEP.Primary.Delay			= 0.08 --1/(750/60)
SWEP.Primary.Ammo			= "bb_556mm"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 1.25
SWEP.SideRecoilMul			= 0.25
SWEP.RecoilSpeedMul			= 1.25
SWEP.MoveConeMul			= 2
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


SWEP.DamageFalloff			= 2500

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.5
SWEP.ZoomTime				= 0.5

SWEP.IronSightsPos = Vector(-5.961, 0, 2.279)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(-2.01, -5, 0.602)
SWEP.IronRunAng 			= Vector(-5, 15, -7.739)

SWEP.IronMeleePos			= Vector(3.417, -10, -13.87)
SWEP.IronMeleeAng 			= Vector(-9.146, 70, -70)