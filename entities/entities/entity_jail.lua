ENT.Type = "anim"
ENT.Base = "base_entity"
 
ENT.PrintName= "Jail Spot"
ENT.Author= "SweetLikeCammy"
ENT.Contact= "Through Steam"
ENT.Purpose= "Entity to mark the spot where the jail is spawned for players to be sent to."
ENT.Spawnable = true
ENT.AdminSpawnable = false

if CLIENT then
	
end
if SERVER then
AddCSLuaFile( "entity_jail.lua" )  -- and shared scripts are sent.

function ENT:SetupDataTables()
	
	self:NetworkVar("Entity", 0, "JailedPlayer" )
	self:NetworkVar("Entity", 1, "JailWall" )
	
end

local jailWalls = {}
function ENT:Initialize()
	--self:SetModel( "models/props_interiors/BathTub01a.mdl" )
	--self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	--self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	--self:SetSolid( SOLID_VPHYSICS )         -- Toolbox	
	self:SetJailedPlayer(nil)
	local entPos = self:GetPos()
	local wallPos = {
		[1] = {Vector(entPos.x+32,entPos.y,entPos.z + 50), Angle(0,0,0)},
		[2] = {Vector(entPos.x,entPos.y+32,entPos.z + 50), Angle(0,90,0)},
		[3] = {Vector(entPos.x-32,entPos.y,entPos.z + 50), Angle(0,180,0)},
		[4] = {Vector(entPos.x,entPos.y-32,entPos.z + 50), Angle(0,270,0)},
	}
	
	for k,v in pairs(wallPos)do
		jailWalls[k] = ents.Create("prop_physics")
		jailWalls[k]:SetModel("models/props_building_details/Storefront_Template001a_Bars.mdl")
		jailWalls[k]:SetPos(v[1])
		jailWalls[k]:SetColor(Color(0,0,0))
		jailWalls[k]:SetAngles(v[2])
		jailWalls[k]:SetName("Jail Wall "..k)
		jailWalls[k]:Spawn()
		local jailWallPhys = jailWalls[k]:GetPhysicsObject()
		jailWallPhys:EnableMotion(false)
	end
	self:SetJailWall(jailWalls[2])
	
end
 
function ENT:Use( act, caller, useType, value )
	
end
 
function ENT:Think()
    return
end

function ENT:OnRemove()
	for k,v in pairs(jailWalls)do
		v:Remove()
	end
end

function ENT:Release()
	if(self:GetJailedPlayer() != nil)then
		print("RELEASE JAILED PLAYER")
	end
end

function ENT:Execute()
	if(self:GetJailedPlayer() != nil)then
		print("EXECUTE JAILED PLAYER")
	end
end

end