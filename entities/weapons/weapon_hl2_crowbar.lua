if CLIENT then
	killicon.AddFont( "weapon_hl2_crowbar",		"HL2MPTypeDeath",	"6",	Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/achievements/pistol_round_knife_kill")
end

SWEP.Category				= "BurgerBase: Half Life 2"
SWEP.PrintName				= "Crowbar"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Melee"

SWEP.Cost					= 0
SWEP.CSSMoveSpeed			= 240

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 0
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/c_crowbar.mdl"
SWEP.WorldModel				= "models/weapons/w_crowbar.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "melee"

SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= -1
SWEP.Primary.SpareClip		= -1
SWEP.Primary.Delay			= 0.34
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Automatic 		= true 

SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.SpareClip	= -1
SWEP.Secondary.Delay		= 0
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

SWEP.EnableBlocking			= true
SWEP.IronSightTime			= 0.125
SWEP.IronSightsPos 			= Vector(-10, -10, 5)
SWEP.IronSightsAng 			= Vector(0, 0, -45)

SWEP.MeleeSoundMiss			= Sound("Weapon_Crowbar.Single")
SWEP.MeleeSoundWallHit		= Sound("Flesh.BulletImpact")
SWEP.MeleeSoundFleshSmall	= Sound("Weapon_Crowbar.Melee_Hit")
SWEP.MeleeSoundFleshLarge	= Sound("Weapon_Crowbar.Melee_Hit")

SWEP.DamageFalloff			= 55
SWEP.MeleeRange				= 55
SWEP.MeleeSize				= 32
SWEP.MeleeDamageType		= DMG_CLUB
SWEP.MeleeDelay				= 0

function SWEP:PrimaryAttack()

	if self:IsUsing() then return end
	if self:GetNextPrimaryFire() > CurTime() then return end
	if self.Owner:KeyDown(IN_ATTACK2) then return end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	local Delay = self.Primary.Delay
	
	if self:NewSwing(self.Primary.Damage) then
		self:SendWeaponAnim(ACT_VM_HITCENTER)
	else
		self:SendWeaponAnim(ACT_VM_MISSCENTER)
		Delay = Delay*1.25
	end
	
	self:SetNextPrimaryFire(CurTime() + Delay)
	self:SetNextSecondaryFire(CurTime() + Delay)
	

end

function SWEP:SecondaryAttack()

end

function SWEP:BlockDamage(Damage,Attacker)
	--self.Owner:SetAnimation(PLAYER_ATTACK1)
	--self:SendWeaponAnim(ACT_VM_HITCENTER)
	--self:EmitGunSound(self.MeleeSoundMiss)
	self.Owner:EmitSound(Sound("FX_RicochetSound.Ricochet"))
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay*0.5)
	--self:SetNextSecondaryFire(CurTime() + self.Primary.Delay*0.25)
	--self:AddDurability(- math.ceil(Damage*0.1) )
end

function SWEP:SpareThink()
	if self.Owner:KeyDown(IN_ATTACK2) then
		self.CSSMoveSpeed				= 240*0.25
	else
		self.CSSMoveSpeed				= 240
	end
end

function SWEP:Reload()

end

--[[
function SWEP:SpecialDeploy()
	self:CheckInventory()
	self.Owner:DrawViewModel(true)
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + self.Owner:GetViewModel():SequenceDuration())	
	return true
end
--]]


