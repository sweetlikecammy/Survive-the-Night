-- Copied from garry's tooltracer

EFFECT.BulletMats = {}
EFFECT.BulletMats[1] = Material( "effects/spark" )
EFFECT.BulletMats[2] = Material( "effects/gunshiptracer")
EFFECT.BulletMats[3] = Material( "effects/laser_tracer" )

EFFECT.SmokeTrailMat = Material("trails/smoke")
EFFECT.TubeTrailMat = Material("trails/tube")

--EFFECT.SmokeParticle = Material("particle/particle_smoke_dust")

function EFFECT:Init( data )

	local Magnitude = data:GetMagnitude()
	local Range = data:GetRadius()
	
	self.Damage = Magnitude
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment ) -- Should return normal position if no weapon
	self.EndPos = data:GetOrigin()
	self.Direction = (self.StartPos - self.EndPos):GetNormalized()
	self.Distance = self.StartPos:Distance(self.EndPos)
	self.Width = ((Magnitude*50)^0.30)*0.3
	self.Length = (Range*0.03)^1
	
	--self.Width = 149 * 0.05
	--self.Length = 320 * 0.1
	
	
	self.DamageType = data:GetDamageType()
	self.SmokePercent = 0
	
	local Ratio = self.Length/self.Width

	self.BulletSpeed = ( math.Clamp(Ratio * 100,2000,6000) + 1000 )
	--self.BulletSpeed = 30
	self.FadeTime = Range
	self.MaxFade = BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_damagefalloffscale"):GetFloat()
	self.PositionPercent = -(self.Length/self.Distance)
	self:SetRenderBoundsWS( self.StartPos, self.EndPos )
	
	-- Copied from Garrysmod Arrow Widget
	if self.WeaponEnt and self.WeaponEnt ~= NULL and (!self.WeaponEnt:IsWeapon() or !self.WeaponEnt:IsCarriedByLocalPlayer()) then
		local Distance, Position, WhatIsThis = util.DistanceToLine(self.StartPos,self.EndPos,EyePos())
		local SoundSize = 256*self.Width
		if Distance <= SoundSize then
			local VolumeMod = 1 - (Distance/SoundSize)
			sound.Play("Bullets.DefaultNearmiss",Position,75,100,VolumeMod)
		end
	end

end

function EFFECT:Think()
	self.PositionPercent = self.PositionPercent + (self.BulletSpeed/self.Distance)*FrameTime()
	self.SmokePercent = self.SmokePercent + ( FrameTime() * math.max(0.1, 1 - (self.Length)*0.001 ) )
	return self.PositionPercent < 2*self.Width or self.SmokePercent < 1 -- for smoke
	--return self.PositionPercent < 1 -- for non smoke
end

function EFFECT:Render()

	local DistanceTraveled = self.PositionPercent * self.Distance
	local AlphaMath = math.Clamp(math.min( (2) - (DistanceTraveled/self.FadeTime),1),self.MaxFade,1)
	local MinPos = LerpVector(math.Clamp(self.PositionPercent,0,1),self.StartPos,self.EndPos)
	local SmokeMinPos = LerpVector(math.Clamp(self.PositionPercent - 1,0,1),self.StartPos,self.EndPos)
	local ConvertMath = ( (self.Length*AlphaMath)/self.Distance )
	--local ConvertMath = 0
	local MaxPos = LerpVector(math.Clamp( (self.PositionPercent + ConvertMath),0,1),self.StartPos,self.EndPos)
	
	if self.PositionPercent <= 1 then
	
		if self.BulletMats[self.DamageType] then
			render.SetMaterial( self.BulletMats[self.DamageType] )
		else
			render.SetMaterial( self.BulletMats[DMG_BULLET] )
		end

		render.DrawBeam( MinPos , MaxPos, self.Width,0, 1, Color(255,255,255,255) )
		
	end
	
	if self.DamageType == 1 then
	
		local SmokeMul =(1 - self.SmokePercent)/(2*self.Width)
		
		local SmokeOffset = Vector(0,0, self.SmokePercent )*1
		local Size = self.Length + self.Width
		
		local LightColor = render.GetLightColor( EyePos() )

		local Lightness = math.min(150,math.max(LightColor.x*255,LightColor.y*255,LightColor.z*255))
		
		render.SetMaterial( self.SmokeTrailMat )
		render.DrawBeam( self.StartPos + SmokeOffset, MaxPos + SmokeOffset, (self.Width*0.5)*self.SmokePercent,0, 1, Color(Lightness,Lightness,Lightness, math.max(0,Size) * math.max(0,1-self.SmokePercent) ))

	end
	
	
end
