if CLIENT then
	killicon.AddFont( "weapon_burger_cs_fiveseven", "csd", "u", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/fiveseven")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "Five-seven"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Secondary"

SWEP.Cost					= 750
SWEP.CSSMoveSpeed				= 250

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Description			= "High capacity accurate pea-shooter. Good for finishing wounded off."

SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_fiveseven.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "revolver"

SWEP.Primary.Damage			= 25
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_FiveSeven.Single")
SWEP.Primary.Cone			= 0.003
SWEP.Primary.ClipSize		= 20
SWEP.Primary.SpareClip		= 100
SWEP.Primary.Delay			= 0.15 --1/(400/60)
SWEP.Primary.Ammo			= "bb_57mm"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 0.75
SWEP.SideRecoilMul			= 0.5
SWEP.RecoilSpeedMul			= 1.25
SWEP.MoveConeMul			= 0.5
SWEP.HeatMul				= 1
SWEP.CoolMul				= 0.5
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
SWEP.ZoomTime				= 0.25

SWEP.IronSightsPos 			= Vector(-5.75, 10, 2.079)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(0, 0, 0)
SWEP.IronRunAng 			= Vector(0, 0, 0)

SWEP.IronMeleePos 			= Vector(-6.433, -13.468, -20)
SWEP.IronMeleeAng 			= Vector(70, 0, 0)