if CLIENT then
	killicon.AddFont( "weapon_burger_cs_glock", "csd", "c", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon		= surface.GetTextureID("vgui/gfx/vgui/glock18")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "Glock18"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Secondary"

SWEP.Cost					= 400
SWEP.CSSMoveSpeed				= 250

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Description			= "Minimal recoil pistol. Has burst fire settings."

SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_pist_glock18.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_glock18.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "revolver"

SWEP.Primary.Damage			= 25
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_Glock.Single")
SWEP.Primary.Cone			= 0.005
SWEP.Primary.ClipSize		= 20
SWEP.Primary.SpareClip		= 0
SWEP.Primary.Delay			= 0.15 --1/(400/60)
SWEP.Primary.Ammo			= "bb_9mm"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 0.1
SWEP.SideRecoilMul			= 0.25
SWEP.MoveConeMul			= 0.5
SWEP.HeatMul				= 1
SWEP.CoolMul				= 1

SWEP.RecoilMul				= 0.25
SWEP.SideRecoilMul			= 0.25
SWEP.RecoilSpeedMul			= 0.75
SWEP.MoveConeMul			= 0.5
SWEP.HeatMul				= 1
SWEP.CoolMul				= 1
SWEP.CoolSpeedMul			= 1

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 0.75
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= true
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= false
SWEP.HasDownRecoil			= false
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = true

SWEP.DamageFalloff			= 2000

SWEP.RandomSeed				= 30

SWEP.BurstSpeedAbs			= 0.6	
SWEP.BurstConeMul			= 1.5
SWEP.BurstHeatMul			= 0.5
SWEP.BurstCoolMul			= 2
SWEP.BurstAnimationOverride	= ACT_VM_SECONDARYATTACK
SWEP.BurstAnimationOnce		= true


SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.25
SWEP.ZoomTime				= 0.5

SWEP.IronSightsPos 			= Vector(-5.801, 10, 2)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(0, 0, 0)
SWEP.IronRunAng 			= Vector(0, 0, 0)

SWEP.IronMeleePos 			= Vector(-5.801, -13.468, -20)
SWEP.IronMeleeAng 			= Vector(70, 0, 0)