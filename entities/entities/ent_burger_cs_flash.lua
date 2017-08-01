ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "FLASH NADE"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false 

ENT.BounceSound = Sound("Flashbang.Bounce")
ENT.ExplodeSound = Sound("Flashbang.Explode")

AddCSLuaFile()

function ENT:Initialize()

	if SERVER then
		self:SetModel("models/weapons/w_eq_flashbang.mdl") 
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
	
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
			phys:SetBuoyancyRatio(0)
		end

	end
	
	self.Delay = CurTime() + 2
	self.First = true
	
end

function ENT:PhysicsCollide(data, physobj)
	if SERVER then
		self.HitP = data.HitPos
		self.HitN = data.HitNormal
		
		if self:GetVelocity():Length() > 50 then
			self:EmitSound(self.BounceSound)
		end
	end
end



function ENT:Think()

	if self.First == true then
		self.First = false
	end

	if CurTime() > self.Delay then 
		self:Detonate(self,self:GetPos())
	end
	
	if SERVER then
		self:NextThink( CurTime() + 1 )
	end
	
	if CLIENT then
		self:SetNextClientThink( CurTime() + 1 )
	end

end

function ENT:Detonate(self,pos)

	local maxdistance = 1024

	if not self:IsValid() then return end
	
	util.BlastDamage( self, self.Owner, self:GetPos(), maxdistance, 10 )
	
	local effectdata = EffectData()
	effectdata:SetStart( pos + Vector(0,0,100)) // not sure if we need a start and origin (endpoint) for this effect, but whatever
	effectdata:SetOrigin( pos)
	effectdata:SetScale( 100 )
	effectdata:SetRadius( 5000 )
	util.Effect( "HelicopterMegaBomb", effectdata )	
	
	self:EmitSound(self.ExplodeSound)

	local Players = player.GetAll()

	if table.Count(Players) > 0 then
		for k,v in pairs(Players) do
			if (v:IsBot() and SERVER) or (!v:IsBot() and CLIENT) then
				local DistanceDiff = (maxdistance - v:EyePos():Distance(self:GetPos()))
				if DistanceDiff > 0 then
					self:BlindEffects(v,DistanceDiff/100)
				end
			end
		end
	end


	if SERVER then
		SafeRemoveEntity(self)
	end
	
end


function ENT:BlindEffects(ply,distancecount)

	if ply:IsLineOfSightClear(self.Entity) then

		if not self:IsPlayerLookingAtSelf(ply) then
			distancecount = distancecount*0.5
		end
		
		ply.BlindAmount = math.Clamp(distancecount,0,1) * (BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_flashbang_dur"):GetFloat()/2)
		
		--[[
		if ply.BlindAmount < 1 then
			ply:SetDSP( 37, true )
		end
		--]]
		
		ply.IsBlinded = true

	end
	
end

function ENT:IsPlayerLookingAtSelf(ply)

	local FOV = 90
	
	local PlyPos = ply:EyePos()
	local SelfPos = self:GetPos() + self:OBBCenter()
	
	local Angle01 = (SelfPos - PlyPos):Angle()
	local Angle02 = ply:EyeAngles()
	Angle01:Normalize()
	Angle02:Normalize()

	local MathY = math.abs( Angle01.y - Angle02.y )
	local MathP = math.abs( Angle01.p - Angle02.p )
	
	if MathP <= FOV and MathY <= FOV then
		return true
	else
		return false
	end

end



function ENT:Draw()
	if CLIENT then
		self:DrawModel()
	end
end