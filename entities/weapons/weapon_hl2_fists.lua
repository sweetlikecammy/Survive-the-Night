if CLIENT then
	--killicon.AddFont( "weapon__crowbar",		"HL2MPTypeDeath",	"6",	Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/achievements/pistol_round_knife_kill")
end

SWEP.Category				= "BurgerBase: Half Life 2"
SWEP.PrintName				= "Fists"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Free"

SWEP.Cost					= 0
SWEP.CSSMoveSpeed			= 260

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 0
SWEP.SlotPos				= 1

SWEP.ViewModel				= Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel				= ""
SWEP.VModelFlip 			= false
SWEP.HoldType				= "fist"

SWEP.Primary.Damage			= 20
SWEP.Primary.Cone			= 1
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= -1
SWEP.Primary.SpareClip		= -1
SWEP.Primary.Delay			= 0.4
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Automatic 		= true 

SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.SpareClip	= -1
SWEP.Secondary.Delay		= 0.5
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

SWEP.MeleeSoundMiss			= Sound( "WeaponFrag.Throw" )
SWEP.MeleeSoundWallHit		= Sound( "Flesh.ImpactHard" )
SWEP.MeleeSoundFleshSmall	= Sound( "Flesh.ImpactHard" )
SWEP.MeleeSoundFleshLarge	= Sound( "Flesh.ImpactHard" )

SWEP.DamageFalloff			= 60
SWEP.MeleeRange				= 30
SWEP.MeleeSize				= 30
SWEP.MeleeDamageType		= DMG_CRUSH
SWEP.MeleeDelay				= 0.2

SWEP.EnableBlocking			= true

SWEP.IronSightTime			= 0.125
SWEP.IronSightsPos 			= Vector(0, -15, -5)
SWEP.IronSightsAng 			= Vector(45, 0, 0)




--[[


1:
		act	=	-1
		actname	=	
		id	=	1
2:
		act	=	-1
		actname	=	
		id	=	2
3:
		act	=	-1
		actname	=	
		id	=	3
4:
		act	=	-1
		actname	=	
		id	=	4
5:
		act	=	-1
		actname	=	
		id	=	5
6:
		act	=	-1
		actname	=	
		id	=	6
7:
		act	=	-1
		actname	=	ACT_VM_FISTS_IDLE
		id	=	7
8:
		act	=	-1
		actname	=	ACT_VM_FISTS_IDLE
		id	=	8
--------------------
0	=	reference
1	=	seq_admire
2	=	fists_draw
3	=	fists_right
4	=	fists_left
5	=	fists_uppercut
6	=	fists_holster
7	=	fists_idle_01
8	=	fists_idle_02


--]]


function SWEP:PrimaryAttack()

	if self:IsUsing() then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	
	if self:GetIsLeftFire() then
		self:SetNextSecondaryFire(CurTime() + self.Primary.Delay*0.5)
		self:SendSequence("fists_left")
		self:SetIsLeftFire(false)
	else
		self:SetNextSecondaryFire(CurTime() + self.Primary.Delay*2)
		self:SendSequence("fists_right")
		self:SetIsLeftFire(true)
	end

	self:NewSwing(self.Primary.Damage)
	
end

function SWEP:SpareThink()

	if self.Owner:KeyDown(IN_ATTACK2) then
		self:SetNextPrimaryFire(CurTime() + self.IronSightTime*2)
		self.CSSMoveSpeed				= 250*0.25
	else
		self.CSSMoveSpeed				= 250
	end

	if SERVER then
		if self.Owner:KeyDown(IN_ATTACK2) and self:GetNextSecondaryFire() <= CurTime() then
			self:SetIsBlocking( true )
			--self:SetHoldType("melee2")
		else
			self:SetHoldType(self.HoldType)
			self:SetIsBlocking( false )
		end
	end
	
	if self:GetNextPrimaryFire() + self.Primary.Delay <= CurTime() then
		if self:GetIsLeftFire() then
			self:SetIsLeftFire(false)
		end
	end

end

function SWEP:SecondaryAttack()

	--[[
	if self:IsUsing() then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	self:SendSequence("fists_uppercut")
	
	self:NewSwing(self.Primary.Damage * 2 )

	self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay*0.5 )
	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay )
	
	self:SetIsLeftFire(true)
	--]]
	
end

function SWEP:BlockDamage(Damage,Attacker)
	--self.Owner:SetAnimation(PLAYER_ATTACK1)
	--self:SendWeaponAnim(ACT_VM_HITCENTER)
	--self:EmitGunSound(self.MeleeSoundMiss)
	--self.Owner:EmitSound(Sound("FX_RicochetSound.Ricochet"))
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay*0.5)
	--self:SetNextSecondaryFire(CurTime() + self.Primary.Delay*0.25)
	--self:AddDurability(- math.ceil(Damage*0.1) )
end

function SWEP:Reload()
	--PrintTable(GetActivities(self))
	--PrintTable(self:GetSequenceList())
end

function SWEP:SpecialDeploy()
	self.Owner:DrawViewModel(true)
	self:SendSequence("fists_draw")
	self:SetNextPrimaryFire(CurTime() + self.Owner:GetViewModel():SequenceDuration())	
end