if CLIENT then
	killicon.AddFont( "weapon_burger_cs_knife", "csd", "j", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/achievements/pistol_round_knife_kill")
end

SWEP.Category				= "BurgerBase: Counter-Strike"
SWEP.PrintName				= "Knife"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Melee"

SWEP.Cost					= 0
SWEP.CSSMoveSpeed			= 250

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Description			= "Combat knife that deals bonus damage from behind."

SWEP.Slot					= 0
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel				= "models/weapons/w_knife_t.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "knife"

SWEP.Primary.Damage			= 20
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= -1
SWEP.Primary.SpareClip		= -1
SWEP.Primary.Delay			= 0.5
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Automatic 		= true 

SWEP.Secondary.Damage		= 65
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.SpareClip	= -1
SWEP.Secondary.Delay		= 1
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.Automatic 	= true 

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

SWEP.MeleeSoundMiss			= Sound("Weapon_Knife.Slash")
SWEP.MeleeSoundWallHit		= Sound("Weapon_Knife.HitWall")
SWEP.MeleeSoundFleshSmall	= Sound("Weapon_Knife.Hit")
SWEP.MeleeSoundFleshLarge	= Sound("Weapon_Knife.Stab")

SWEP.DamageFalloff			= 40
SWEP.MeleeRange				= 40
SWEP.MeleeSize				= 32
SWEP.MeleeDelay				= 0.1

function SWEP:PrimaryAttack()
	if self:IsUsing() then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	self:NewSwing(self.Primary.Damage)
end

function SWEP:SecondaryAttack()
	if self:IsUsing() then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
	self:NewSwing(self.Primary.Damage * (65/25) )	
end

function SWEP:Reload()

end

function SWEP:Deploy()
	self:EmitGunSound("weapons/knife/knife_deploy1.wav")
	self.Owner:DrawViewModel(true)
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + self.Owner:GetViewModel():SequenceDuration())	
	self:CheckInventory()
	return true
end









