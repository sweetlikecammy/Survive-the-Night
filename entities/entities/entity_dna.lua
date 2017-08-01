ENT.Type = "anim"
ENT.Base = "base_entity"
 
ENT.PrintName= "DNA Spot"
ENT.Author= "JacksonPeeven"
ENT.Contact= "Through Steam"
ENT.Purpose= "Entity to mark the spot where investigators can investigate"
ENT.Spawnable = true
ENT.AdminSpawnable = false

if CLIENT then
	
end
if SERVER then
AddCSLuaFile( "entity_dna.lua" )  -- and shared scripts are sent.
--include("main_config.lua")

function ENT:Initialize()
	--self:SetModel( "models/props_interiors/BathTub01a.mdl" )
	--self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	--self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	--self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
end
 
function ENT:Use( act, caller, useType, value )
	print("SCANNED")
    local randNum = math.Rand(0,1)
	local randomChances =  MAIN_CONFIG.DNARevealChances or {["name"] = .1, ["job"] = .3, ["faction"] = .5}
	local killerInfo = self:GetVar("killerInfo", {})
	if(randomChances["name"] > randNum)then
		print("YOU GET A NAME: " .. killerInfo[3])
		act:ChatPrint("INVESTIGATE:You have found the killer from this DNA! The killer is "..killerInfo[3].."!")
	elseif(randomChances["job"] > randNum)then
		print("YOU GET A JOB: " .. killerInfo[2])
		act:ChatPrint("INVESTIGATE:You have found the job of the killer from this DNA! The killer is a "..killerInfo[2].."!")
	elseif(randomChances["faction"] > randNum)then
		print("YOU GET A FACTION: " .. killerInfo[1])
		act:ChatPrint("INVESTIGATE:You have found the faction of the killer from this DNA! The killer is part of the "..killerInfo[1].."!")
	else
		print("YOU GET NO INFO")
		act:ChatPrint("INVESTIGATE:You have found no information on the killer from this DNA!")
	end
	self:Remove()
end
 
function ENT:Think()
    return
end

function ENT:SetDNA(killerFaction,killerJob,killerName)
	self:SetVar("killerInfo", {killerFaction,killerJob,killerName})
	print("KILLER: ")
	PrintTable(self:GetVar("killerInfo", {}))
end

end