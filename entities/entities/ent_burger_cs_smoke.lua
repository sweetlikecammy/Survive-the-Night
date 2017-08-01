ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "SMOKE GRENADE"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false 

ENT.BounceSound = Sound("SmokeGrenade.Bounce")
ENT.ExplodeSound = Sound("BaseSmokeEffect.Sound")

AddCSLuaFile()

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/weapons/w_eq_smokegrenade.mdl") 
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
			phys:SetBuoyancyRatio(0)
		end
		
		self.Delay = CurTime() + 2
		self.NextParticle = 0
		self.ParticleCount = 0
		self.First = true
		self.IsDetonated = false
	end
end

function ENT:PhysicsCollide(data, physobj)
	if SERVER then
		self.HitP = data.HitPos
		self.HitN = data.HitNormal

		if self:GetVelocity():Length() > 50 then
			self:EmitSound(self.BounceSound)
		end
		
		if self:GetVelocity():Length() < 5 then
			self:SetMoveType(MOVETYPE_NONE)
		end
		
	end
end

function ENT:Think()
	if SERVER then
		
		if CurTime() > self.Delay then 
		
			local ConVar = math.floor(BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_smoke_dur"):GetFloat())
			
			if self.NextParticle <= CurTime() then 
			
				if self.ParticleCount < 100 * (ConVar/10) then
					local ent = ents.Create("ent_burger_cs_smokeparticle")
					ent:SetPos(self:GetPos())
					ent:SetAngles(Angle(0,0,0))
					ent:Spawn()
					ent:Activate()
					ent:SetOwner(self.Owner)
					ent:GetPhysicsObject():SetVelocity(Vector(math.Rand(-25,25),math.Rand(-25,25),math.Rand(0,25)))
					self.ParticleCount = self.ParticleCount + 1
				end

				self.NextParticle = CurTime() + 0.1
			end

			if self.IsDetonated == false then
				self:Detonate(self,self:GetPos())
				self.IsDetonated = true
			end
			
		end
	end
end

function ENT:Detonate(self,pos)
	if SERVER then
		if not self:IsValid() then return end
		self:SetNWBool("IsDetonated",true)
		self:EmitSound(self.ExplodeSound)
		local ConVar = math.floor(BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_smoke_dur"):GetFloat())
		SafeRemoveEntityDelayed(self,30 * (ConVar/10) )
	end
end

function ENT:Draw()
	if CLIENT then
		self:DrawModel()
	end
end