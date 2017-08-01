BURGERBASE_RegisteredBullets = {}

if not BURGERBASE_RegisteredBulletTemplates then
	BURGERBASE_RegisteredBulletTemplates = {}
end

function BURGERBASE_RegisterProjectile(id,DataTable)
	BURGERBASE_RegisteredBulletTemplates[id] = DataTable
end


function BUREGRBASE_HOOK_Tick_Bullets()

	for num,data in pairs(BURGERBASE_RegisteredBullets) do
	
		data = table.Copy(data)
	
		data.pos = data.pos + ( data.direction * engine.TickInterval() )
	
		if data.target and IsValid(data.target) then
			local COM = data.target:GetPos() + data.target:OBBCenter()
			data.direction = ((COM - data.pos):GetNormal()*data.direction:Length()) - ( data.resistance * engine.TickInterval() )
		else	
			data.direction = data.direction - ( data.resistance * engine.TickInterval() )
		end

		local TraceData = {}
		local HullSize = data.hullsize or 1
		
		TraceData.start = data.pos - ( data.direction * engine.TickInterval() )
		TraceData.endpos = data.pos
		TraceData.mask = MASK_SHOT
		TraceData.filter = function(ent) return (ent ~= data.owner and ent ~= data.weapon) end
		
		local TraceResult = {}
		local TraceResultHull = {}
		
		TraceResult = util.TraceLine(TraceData)
	
		if data.usehull then
			TraceData.maxs = Vector(HullSize,HullSize,HullSize)
			TraceData.mins = Vector(-HullSize,-HullSize,-HullSize)
			TraceResultHull = util.TraceHull(TraceData)
		end
		
		if TraceResult.Hit then	
			if not data.hitfunction(data,TraceResult) then
				data.diefunction(data)
				data = nil
			end
		elseif TraceResultHull.Hit and TraceResultHull.Entity and TraceResultHull.Entity:Health() > 0 then
			if not data.hitfunction(data,TraceResultHull) then
				data.diefunction(data)
				data = nil
			end
		elseif data.dietime <= CurTime() then
			data.diefunction(data)
			data = nil
		end

		if data == nil then
			table.remove(BURGERBASE_RegisteredBullets,num)
		else
			data.tickfunction(data)
			BURGERBASE_RegisteredBullets[num] = data
		end
		
	end

end

hook.Add("Tick","BUREGRBASE_HOOK_Tick_Bullets",BUREGRBASE_HOOK_Tick_Bullets)

function BURGERBASE_HOOK_PostCleanupMap_Bullets()
	BURGERBASE_RegisteredBullets = {}
end

hook.Add("PostCleanupMap","BURGERBASE_HOOK_PostCleanupMap_Bullets",BURGERBASE_HOOK_PostCleanupMap_Bullets)

local DefaultMaterial = Material("sprites/physg_glow1")

function BURGERBASE_FUNC_ShootProjectile(Attacker,Inflictor,Damage,Shots,Cone,Source,Direction,AimCorrection,UsePrediction,OverrideNet,Target)

	if (CLIENT and !UsePrediction) or IsFirstTimePredicted() then
	
		if AimCorrection then
			local HitPos = Attacker:GetEyeTrace().HitPos
			local DirectionOffset = Direction - Attacker:GetAimVector()	
			if CLIENT and Inflictor.UseMuzzle then
				local ViewModel = Attacker:GetViewModel()
				--local MuzzleID = ViewModel:LookupAttachment( "muzzle" )
				local MuzzleData = ViewModel:GetAttachment( 1 )	
				Source = MuzzleData.Pos
				Direction = (HitPos - Source):GetNormalized() + DirectionOffset
			elseif CLIENT and SourceOverride then
				Source = Source + Attacker:GetForward()*Inflictor.SourceOverride.y + Attacker:GetRight()*Inflictor.SourceOverride.x + Attacker:GetUp()*Inflictor.SourceOverride.z	
				Direction = (HitPos - Source):GetNormalized() + DirectionOffset
			end
		end

		local datatable = {}	
		datatable.weapon = Inflictor
		datatable.owner = Attacker
		datatable.pos = Source
		datatable.direction = Direction
		datatable.target = Target
		datatable.damage = Damage
		datatable.usehull = true
		datatable.hullsize = 8
		datatable.resistance = Vector(0,0,0)
		datatable.dietime = CurTime() + 30
		datatable.special = nil
		datatable.id = "css_bullet"
		datatable = Inflictor:ModProjectileTable(datatable)
		datatable.OverrideNet = OverrideNet
		

		BURGERBASE_FUNC_AddBullet(datatable)
	end

end

function BURGERBASE_FUNC_AddBullet(datatable)

	local NewTable = {}
	NewTable.weapon = datatable.weapon
	NewTable.owner = datatable.owner
	NewTable.pos = datatable.pos
	NewTable.direction = datatable.direction

	NewTable.damage = datatable.damage or 10
	NewTable.hullsize = datatable.hullsize or 1
	NewTable.usehull = datatable.usehull or false
	NewTable.target = datatable.target or nil
	
	NewTable.resistance = datatable.resistance or Vector(0,0,0)
	NewTable.dietime = datatable.dietime or (CurTime() + 10)
	
	NewTable.id = datatable.id or "crossbow_bolt"
	
	NewTable.OverrideNet = datatable.OverrideNet

	if SERVER then
		net.Start("BURGERBASE_SendBulletToClient")
			net.WriteTable(NewTable)
			net.WriteFloat(CurTime())
		net.Broadcast()
	end
	
	local RegisteredTable = BURGERBASE_RegisteredBulletTemplates[NewTable.id] or {}
	NewTable.drawfunction = RegisteredTable.drawfunction or function(data) end
	NewTable.diefunction = RegisteredTable.diefunction or function(data) end
	NewTable.tickfunction = RegisteredTable.tickfunction or function(data) end
	NewTable.hitfunction = RegisteredTable.hitfunction or function(data,traceresult) end
	
	table.Add(BURGERBASE_RegisteredBullets,{NewTable})

end

if SERVER then
	util.AddNetworkString( "BURGERBASE_SendBulletToClient" )
end

local BulletMat = Material( "sprites/physg_glow1" )

if CLIENT then

	net.Receive("BURGERBASE_SendBulletToClient", function(len)
	
		local DataTable = net.ReadTable()
		local ServerSysTimeDif = CurTime() - net.ReadFloat()
		local id = DataTable.id
		
		--print(ServerSysTimeDif)
		
		DataTable.pos = DataTable.pos + (DataTable.direction * ServerSysTimeDif)
		
		
		
		table.Add(DataTable,BURGERBASE_RegisteredBulletTemplates[id])

		if DataTable.OverrideNet or (LocalPlayer() ~= DataTable.owner) or game.SinglePlayer() then
			BURGERBASE_FUNC_AddBullet(DataTable)
		end
		
	end)

	 function BUREGRBASE_HOOK_3D_Bullets()
	 
		for num,data in pairs(BURGERBASE_RegisteredBullets) do
			data.drawfunction(data)
		end
	 
	 end
	 
	 hook.Add("PreDrawEffects","BUREGRBASE_HOOK_3D_Bullets",BUREGRBASE_HOOK_3D_Bullets)
	
end