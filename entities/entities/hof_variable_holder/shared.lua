--[[ ENT.Type = "entity"

ENT.PrintName = "Player Variables Holder"
ENT.Author = "JacksonPeeven / Cameron"
ENT.Purpose "Used for storing player variables"

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Job")
end

if SERVER then

	AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
	--include('shared.lua')
	 
	function ENT:Initialize()
	 
		self:SetMoveType(MOVETYPE_NONE)
		self:SetNotSolid(true)
		self:SetNoDraw(true)
		self:DrawShadow(false)
	 
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
	end
	 
	function ENT:Use( activator, caller )
		return
	end
	 
	function ENT:Think()
		-- We don't need to think, we are just a prop after all!
	end

else
	--include('shared.lua')
 
	--[[---------------------------------------------------------
	   Name: Draw
	   Purpose: Draw the model in-game.
	   Remember, the things you render first will be underneath!
	---------------------------------------------------------
	function ENT:Draw()
		-- self.BaseClass.Draw(self)  -- We want to override rendering, so don't call baseclass.
									  -- Use this when you need to add to the rendering.
		self:DrawEntityOutline( 1.0 ) -- Draw an outline of 1 world unit.
		self:DrawModel()       -- Draw the model.
	 
		AddWorldTip( self:EntIndex(), "BATHTUB TIME!", 0.5, self:GetPos(), self  ) -- Add an example tip.
	end
end ]]