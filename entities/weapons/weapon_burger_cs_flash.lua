if CLIENT then
	killicon.AddFont( "weapon_burger_cs_flash", "csd", "P", Color( 255, 80, 0, 255 ) ); killicon.AddFont( "ent_burger_cs_flash", "csd", "P", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/flashbang")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "Flashbang Grenade"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Throwable"	

SWEP.Cost					= 200
SWEP.CSSMoveSpeed				= 250

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Description			= "All purpose flashbang grenade."

SWEP.Slot					= 4
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_eq_flashbang.mdl"
SWEP.WorldModel				= "models/weapons/w_eq_flashbang.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "grenade"

SWEP.Primary.Damage			= 0
SWEP.Primary.NumShots		= 0
SWEP.Primary.Sound			= Sound("weapons/ak47/ak47-1.wav")
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= -1
SWEP.Primary.SpareClip		= 1
SWEP.Primary.Delay			= 1
SWEP.Primary.Ammo			= "bb_flashgrenade"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 1
SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 1
SWEP.HasCrosshair 			= false
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= false

SWEP.IsThrowing 			= false
SWEP.HasAnimated			= false
SWEP.HasThrown				= false
SWEP.CanHolster				= true
SWEP.Object					= "ent_burger_cs_flash"
