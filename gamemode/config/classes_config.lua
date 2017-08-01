CLASS_CONFIG = {}  -- Don't touch this, its mine
Factions = CLASS_CONFIG.Factions -- Don't touch this, its mine

--[[Factions! Factions are a crucial part of this gamemode, each class in on a faction 
and the only way a player can win is if their faction wins!]]
CLASS_CONFIG.Factions = {
	TEAM_GOVERNMENT = {
		["name"] = "GOVERNMENT",  -- Clean name for the faction, this is the name players will see for the faction.
		
		--[[Mission for the faction, this is the mission that all memebers 
		of the faction will see as the way they can win!]] 
		["mission"] = [[As part of the Government, your job is to find all criminals and bring them justice! (AKA Death)]], 
		["color"] = Color(0,0,150,255), 
		["solo"] = true, -- Solo makes the team members not know each other, figuring out jobs is a MAJOR component of the game
		["playerAmount"] = .5, -- Decimal place for the amount of total players to be assigned to this Faction 
		["victoryFunc"] = function()  -- Return true for if team wins, return number to display how many people are left they need to kill
			local badGuysLeft = {}
			for a,b in pairs(player.GetAll())do
				for k,v in pairs(CLASS_CONFIG.groups["criminals"])do  -- For each faction in the group criminals
					for y,z in pairs(v)do  -- For each faction in the group criminals
						if(k == "faction")then -- Make sure its a faction
							if(team.GetName(b:Team()) == z["name"])then -- If victim's team is part of the criminals then return true
								if(!table.HasValue(badGuysLeft, a))then
									badGuysLeft[#badGuysLeft+1] = a
								end
							end
						end
					end
				end
			end
			if(#badGuysLeft < 1)then
				return true
			else
				return #badGuysLeft
			end
		end
		
	},
	
	TEAM_MOB = {
		["name"] = "MOB", 
		["mission"] = [[As part of the Mob, your job is to kill all members of the Government!]], 
		["color"] = Color(150,0,0,255), 
		["playerAmount"] = .45, -- Decimal place for the amount of total players to be assigned to this Faction 
		["victoryFunc"] = function()
			local enemiesLeft = {}
			for a,b in pairs(player.GetAll())do
				for k,v in pairs(CLASS_CONFIG.groups["criminals"])do  -- For each faction in the group criminals
					if(team.GetName(b:Team()) == "GOVERNMENT")then -- If victim's team is part of the criminals then return true
						if(!table.HasValue(enemiesLeft, a))then
							enemiesLeft[#enemiesLeft+1] = a
						end
					end
				end
			end
			if(#enemiesLeft < 1)then
				return true
			else
				return #enemiesLeft
			end
		end
	},
	TEAM_MURDERER = {
		["name"] = "MURDERERS", 
		["mission"] = [[As part of the Murderers, your job is it to kill EVERYONE!]], 
		["color"] = Color(255,100,50,255), 
		["playerAmount"] = .05, -- Decimal place for the amount of total players to be assigned to this Faction 
		["victoryFunc"] = function()
			local enemiesLeft = {}
			for a,b in pairs(player.GetAll())do
				if(!table.HasValue(enemiesLeft, a))then
					print("Add biotch")
					if(team.GetName(b:Team()) != "MURDERS" && b:Team() != 99 && b:Team() != TEAM_CONNECTING)then
						enemiesLeft[#enemiesLeft+1] = a
					end
				end
			end
			if(#enemiesLeft < 1)then
				return true
			else
				return #enemiesLeft
			end
		end
	}
}

--[[Classes! Classes are what make this gamemode SO MUCH FUN! 
Each class has different weapons, traits, skills, and missions to complete for their faction!]]
CLASS_CONFIG.Classes = {
	["policeOfficer"] = {
		["name"] = "Police Officer", -- Clean name for the class, this is the name players will see for the class.
		["info"] = [[Arrest the criminals you find that are suspcious or that are selected by the Sheriff for judgement!]],
		["faction"] = CLASS_CONFIG.Factions.TEAM_GOVERNMENT, -- Faction for this class, more info on factions below
		["playerAmount"] = .5, -- Decimal place for the amount of faction members to be put in this job (All jobs in same faction should have these equal to 1)
		["items"]={
			["melee"] = "weapon_melee_billystick",
			["ranged"] = nil,
			["tool"] = nil
		},
		["jobFunc"] = function(victim, killer, weapon)
			print("Victim: " .. team.GetName(victim:Team()) .. " Killer: " .. team.GetName(killer:Team()))
			if(victim:Team() == killer:Team() or killer:GetNWEntity("currentTarget") != victim)then return 2 end
			for k,v in pairs(CLASS_CONFIG.groups["criminals"])do  -- For each faction in the group criminals
				if(k == "faction")then -- Make sure its a faction
					if(v["name"] == team.GetName(victim:Team()))then -- If victim's team is part of the criminals then return true
						return 1
					end
				end
			end
		end
	},
	["sheriff"] = {
		["name"] = "Sheriff", -- Clean name for the class, this is the name players will see for the class.
		["info"] = [[Arrest the criminals you find that are suspcious or that are selected by the Sheriff for judgement!]],
		["faction"] = CLASS_CONFIG.Factions.TEAM_GOVERNMENT, -- Faction for this class, more info on factions below
		["maxAmount"] = 1, -- Max amount of players
		["playerAmount"] = 0, -- Decimal place for the amount of faction members to be put in this job (All jobs in same faction should have these equal to 1)
		["items"]={
			["melee"] = "weapon_melee_billystick",
			["ranged"] = nil,
			["tool"] = "weapon_tool_jail"
		}, 
		["jobFunc"] = function(victim, killer, weapon)
			print("Victim: " .. team.GetName(victim:Team()) .. " Killer: " .. team.GetName(killer:Team()))
			if(victim:Team() == killer:Team())then return 2 end
			for k,v in pairs(CLASS_CONFIG.groups["criminals"])do  -- For each faction in the group criminals
				if(k == "faction")then -- Make sure its a faction
					if(v["name"] == team.GetName(victim:Team()))then -- If victim's team is part of the criminals then return true
						return 1
					end
				end
			end
		end
	},
	["investigator"] = {
		["name"] = "Investigator", -- Clean name for the class, this is the name players will see for the class.
		["info"] = [[Arrest the criminals you find that are suspcious or that are selected by the Sheriff for judgement!]],
		["faction"] = CLASS_CONFIG.Factions.TEAM_GOVERNMENT, -- Faction for this class, more info on factions below
		["playerAmount"] = .25, -- Decimal place for the amount of faction members to be put in this job (All jobs in same faction should have these equal to 1)
		["items"]={
			["melee"] = nil,
			["ranged"] = "weapon_burger_cs_xm1014",
			["tool"] = "weapon_tool_scanner"
		}, 
		["jobFunc"] = function(victim, killer, weapon)
			print("Victim: " .. team.GetName(victim:Team()) .. " Killer: " .. team.GetName(killer:Team()))
			if(victim:Team() == killer:Team())then return 2 end
			for k,v in pairs(CLASS_CONFIG.groups["criminals"])do  -- For each faction in the group criminals
				if(k == "faction")then -- Make sure its a faction
					if(v["name"] == team.GetName(victim:Team()))then -- If victim's team is part of the criminals then return true
						return 1
					end
				end
			end
		end
	},
	
	["governor"] = {
		["name"] = "Governor", -- Clean name for the class, this is the name players will see for the class.
		["info"] = [[You are the leader of the Government and it is your job to maintain order!]],
		["faction"] = CLASS_CONFIG.Factions.TEAM_GOVERNMENT, -- Faction for this class, more info on factions below
		["playerAmount"] = 0, -- Decimal place for the amount of faction members to be put in this job (All jobs in same faction should have these equal to 1)
		["items"]={
			["melee"] = nil,
			["ranged"] = nil,
			["tool"] = "weapon_tool_pointer"
		}, 
		["maxAmount"] = 1, -- Max amount of players
		["leader"] = true, -- Whether this class is the leader of the faction
		["jobFunc"] = function(victim, killer, weapon)
			print("Victim: " .. team.GetName(victim:Team()) .. " Killer: " .. team.GetName(killer:Team()))
			if(victim:Team() == killer:Team())then return 2 end
		end
	},
	
	["medic"] = {
		["name"] = "Medic", -- Clean name for the class, this is the name players will see for the class.
		["info"] = [[You have a medkit that can heal 100 health total per night! Use it for yourself or others!]],
		["faction"] = CLASS_CONFIG.Factions.TEAM_GOVERNMENT, -- Faction for this class, more info on factions below
		["playerAmount"] = .25, -- Decimal place for the amount of faction members to be put in this job (All jobs in same faction should have these equal to 1)
		["items"]={
			["melee"] = nil,
			["ranged"] = nil,
			["tool"] = "weapon_medkit"
		}, 
		["jobFunc"] = function(victim, killer, weapon)
			print("Victim: " .. team.GetName(victim:Team()) .. " Killer: " .. team.GetName(killer:Team()))
			if(victim:Team() == killer:Team())then return 2 end
		end
	},
	
	
	["murderer"] = {
		["name"] = "Murderer", -- Clean name for the class, this is the name players will see for the class.
		["info"] = [[Murder everyone! Leave no survivors...]],
		["faction"] = CLASS_CONFIG.Factions.TEAM_MURDERER, -- Faction for this class, more info on factions below
		["playerAmount"] = 1, -- Decimal place for the amount of faction members to be put in this job (All jobs in same faction should have these equal to 1)
		["maxAmount"] = 1, -- Max amount of players
		["items"]={
			["melee"] = nil,
			["ranged"] = "weapon_burger_cs_knife",
			["tool"] = nil
		}, 
		["jobFunc"] = function(victim, killer, weapon)
			print("Victim: " .. team.GetName(victim:Team()) .. " Killer: " .. team.GetName(killer:Team()))
			if(victim:Team() == killer:Team())then return 2 end
			for k,v in pairs(player.GetAll())do  -- For each faction in the group criminals
				if(team.GetName(v:Team()) != "MURDERS")then
					return 1
				end
			end
		end
	},
	
	["gangster"] = {
		["name"] = "Gangster", -- Clean name for the class, this is the name players will see for the class.
		["info"] = [[Kill those targeted by your Don!]],
		["faction"] = CLASS_CONFIG.Factions.TEAM_MOB, -- Faction for this class, more info on factions below
		["playerAmount"] = .6, -- Decimal place for the amount of faction members to be put in this job (All jobs in same faction should have these equal to 1)
		["items"]={
			["melee"] = nil,
			["ranged"] = "weapon_burger_cs_glock",
			["tool"] = nil
		},
		["jobFunc"] = function(victim, killer, weapon)
			print("Victim: " .. team.GetName(victim:Team()) .. " Killer: " .. team.GetName(killer:Team()))
			if(victim:Team() == killer:Team() or killer:GetNWEntity("currentTarget") != victim)then return 2 end
			for k,v in pairs(CLASS_CONFIG.Factions)do
				if(v["name"] == team.GetName(victim:Team()) && v["name"] == "GOVERNMENT")then
					return 1
				end
			end
		end
	},
	
	["don"] = {
		["name"] = "Don", -- Clean name for the class, this is the name players will see for the class.
		["info"] = [[Target players to be executed by your mob!]],
		["faction"] = CLASS_CONFIG.Factions.TEAM_MOB, -- Faction for this class, more info on factions below
		["playerAmount"] = 0, -- Decimal place for the amount of faction members to be put in this job (All jobs in same faction should have these equal to 1)
		["items"]={
			["melee"] = nil,
			["ranged"] = nil,
			["tool"] = "weapon_tool_pointer"
		},
		["maxAmount"] = 1, -- Max amount of players
		["leader"] = true, -- Whether this class is the leader of the faction
		["jobFunc"] = function(victim, killer, weapon)
			print("Victim: " .. team.GetName(victim:Team()) .. " Killer: " .. team.GetName(killer:Team()))
			if(victim:Team() == killer:Team())then return 2 end
			
		end
	},
	["scout"] = {
		["name"] = "Scout", -- Clean name for the class, this is the name players will see for the class.
		["info"] = [[Scan player's quietly to get info on their role!]],
		["faction"] = CLASS_CONFIG.Factions.TEAM_MOB, -- Faction for this class, more info on factions below
		["playerAmount"] = .25, -- Decimal place for the amount of faction members to be put in this job (All jobs in same faction should have these equal to 1)
		["items"]={
			["melee"] = nil,
			["ranged"] = nil,
			["tool"] = "weapon_tool_scanner"
		},
		["jobFunc"] = function(victim, killer, weapon)
			print("Victim: " .. team.GetName(victim:Team()) .. " Killer: " .. team.GetName(killer:Team()))
			if(victim:Team() == killer:Team())then return 2 end
			
		end
	},
	["disguiser"] = {
		["name"] = "Disguiser", -- Clean name for the class, this is the name players will see for the class.
		["info"] = [[Disguise as other players, changing your name and player model to infiltrate operations!]],
		["faction"] = CLASS_CONFIG.Factions.TEAM_MOB, -- Faction for this class, more info on factions below
		["playerAmount"] = .15, -- Decimal place for the amount of faction members to be put in this job (All jobs in same faction should have these equal to 1)
		["items"]={
			["melee"] = nil,
			["ranged"] = nil,
			["tool"] = nil
		},
		["jobFunc"] = function(victim, killer, weapon)
			print("Victim: " .. team.GetName(victim:Team()) .. " Killer: " .. team.GetName(killer:Team()))
			if(victim:Team() == killer:Team())then return 2 end
			
		end
	}
}

CLASS_CONFIG.groups = { -- Create groups for larger  grouping of classes to use, for example: All mob jobs and psycho jobs are criminals but not in same faction
	["criminals"] = {["faction"] = {CLASS_CONFIG.Factions.TEAM_MOB, CLASS_CONFIG.Factions.TEAM_MURDERER}}
}


