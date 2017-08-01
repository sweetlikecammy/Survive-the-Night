ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "Base Ammo"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false
ENT.AdminSpawnable		= false 
ENT.Category			= "CS:S Ammo"

AddCSLuaFile()


function ENT:Initialize()

	if SERVER then
	
		self:SetModel(self.AmmoModel)
		
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
		self:SetUseType(SIMPLE_USE)	
		self:CollisionRulesChanged()
	
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
			phys:SetBuoyancyRatio(0)
		end
	end
	
end

local Throwables = {}
Throwables["hegrenade"] = "weapon_burger_cs_he"
Throwables["flashgrenade"] = "weapon_burger_cs_flash"
Throwables["smokegrenade"] = "weapon_burger_cs_smoke"

function ENT:Use(activator,caller,useType,value)
	if ( activator:IsPlayer() ) then
		for k,v in pairs(self.AmmoTable) do
			if v > 0 then
				activator:GiveAmmo(v,k,false)
				if Throwables[game.GetAmmoName(k)] then
					activator:Give(Throwables[game.GetAmmoName(k)])
				end
			end
		end
		self:EmitSound("items/ammopickup.wav")
		self:Remove()
	end
end

function ENT:Draw()
	if CLIENT then
		self:DrawModel()
	end
end
