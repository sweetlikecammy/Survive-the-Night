ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "You Shouldn't be seeing this"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false
ENT.AdminSpawnable		= false 
ENT.Category			= ""

AddCSLuaFile()

--ENT.AmmoType 			= ""
--ENT.AmmoAmount 			= ""
--ENT.AmmoModel			= ""


function ENT:Initialize()

	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	
		
	if SERVER then
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
	end
	
	--[[
	if CLIENT then
		self:SetPredictable(true)
	end
	--]]
	
	
end

function ENT:Draw()
	self:DrawModel()
end