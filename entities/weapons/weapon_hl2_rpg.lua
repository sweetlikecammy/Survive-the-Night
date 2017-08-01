
if CLIENT then
	killicon.AddFont( "ent_hl2_rocket",		"HL2MPTypeDeath",	"3",	Color( 255, 80, 0, 255 ) )
	killicon.AddFont( "weapon_hl2_rocket",		"HL2MPTypeDeath",	"3",	Color( 255, 80, 0, 255 ) )
end


SWEP.Category				= "BurgerBase: Half Life 2"
SWEP.PrintName				= "RPG"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 3500
SWEP.CSSMoveSpeed			= 100

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/c_rpg.mdl"
SWEP.WorldModel				= "models/weapons/w_rocket_launcher.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "rpg"

game.AddAmmoType({name = "css_rocket"})

if CLIENT then 
	language.Add("css_rocket_ammo","RPG")
end

SWEP.Primary.Damage			= 200
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("weapons/rpg/rocketfire1.wav")
SWEP.Primary.Cone			= .00125
SWEP.Primary.ClipSize		= -1
SWEP.Primary.SpareClip		= 1
SWEP.Primary.Delay			= 1/(30/60)
SWEP.Primary.Ammo			= "css_rocket"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 0.01
SWEP.SideRecoilMul			= 0
SWEP.MoveConeMul				= 0
SWEP.HeatMul				= 0

SWEP.HasScope 				= true
SWEP.ZoomAmount 			= 3
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= true

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= false
SWEP.HasDryFire				= false

SWEP.HasIronSights 			= false
SWEP.EnableIronCross		= false
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.5
SWEP.IronSightsPos 			= Vector(0, 0, 0)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

function SWEP:ShootBullet(Damage,Shots,Cone,Source,Direction,Source)
	self:ThrowObject("ent_hl2_rocket",10000)
	self:SendWeaponAnim(ACT_VM_RELOAD)
end