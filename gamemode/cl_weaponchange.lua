WEPSWITCH = {}

if CLIENT then

-- Variables --

-- Convars
WEPSWITCH.switchPersistDelay = CreateConVar("hof_wSwitch_persist", "2", FCVAR_ARCHIVE) -- Create Convar for how long the weapon select stays open, 0 = Instant close

-- Basic Vars
WEPSWITCH.currentSelected = "ranged" -- Current selected weapon ID
WEPSWITCH.switchDelay = 0.012 -- Switch speed to provide some sticking
WEPSWITCH.nextDelay = 0 -- Next time the player can switch weapon
WEPSWITCH.show = false -- If set to false then dont show
WEPSWITCH.currentWeaponIndex = 1 -- 1 = Melee, 2 = Gun, 3 = Tool
WEPSWITCH.scroll = 0 -- Direction of scroll

-- Colors
WEPSWITCH.colors = {
	["selectedText"] = Color(255,255,255), -- Text for the currently highlighted weapon
	["unselectedText"] = Color(200,200,200),
	["selectedBarBG"] = Color(50,50,50, 220), -- Bar behind the currently highlighted weapon
	["unselectedBarBG"] = Color(30,30,30, 220)
}

-- Materials
WEPSWITCH.materials = {
	["sphereBG"] = Material("HUD/circle.png"), 
	["melee"] = Material("HUD/crowbar.png"), 
	["gun"] = Material("HUD/pistol.png"), 
	["tool"] = Material("HUD/binoculars.png"), 
	["fist"] = Material("HUD/fist.png") 
}

-- Weapon Slots
WEPSWITCH.icons = {
	[1] = WEPSWITCH.materials["fist"],
	[2] = WEPSWITCH.materials["melee"],
	[3] = WEPSWITCH.materials["gun"],
	[4] = WEPSWITCH.materials["tool"]
}

WEPSWITCH.sounds = {
	["error"] = "UI/buttonclickrelease.wav"
}

-- End Variables --

-- Start Client Methods --
function WEPSWITCH:DrawCircles(x,y,w,h,bg_c,f_c)
	local x = math.Round(x)
	local y = math.Round(y)
	local h = math.Round(h)
	local w = math.Round(w)
	
	-- Draw BG Bar
	surface.SetDrawColor(bg_c.r,bg_c.b,bg_c.g,bg_c.a) -- Set bar color to parameter color
	surface.SetMaterial(WEPSWITCH.materials["sphereBG"]) -- Set bar color to parameter color
	surface.DrawTexturedRect(x,y,w,h) -- Draw bar
	
end

-- Start Client Methods --
function WEPSWITCH:DrawIcons(x,y,w,h,c,material)
	local x = math.Round(x)
	local y = math.Round(y)
	local h = math.Round(h)
	local w = math.Round(w)
	
	-- Draw BG Bar
	surface.SetDrawColor(c.r,c.b,c.g,c.a) -- Set bar color to parameter color
	surface.SetMaterial(WEPSWITCH.icons[material]) -- Set bar color to parameter color
	surface.DrawTexturedRect(x,y,w,h) -- Draw bar
	
end

function WEPSWITCH:Draw()
	if(WEPSWITCH.show == true)then
		curWep = WEPSWITCH.currentWeaponIndex
		leftWep = curWep - 1
		rightWep = curWep + 1
		if(curWep == 1) then
			leftWep = 4
		elseif(curWep == 4)then
			rightWep = 1
		end
		
		WEPSWITCH:DrawCircles(ScrW() * (.909),ScrH() * (.838),ScrW() * (.065),ScrW() * (.065),Color(255,255,255,255), Color(255,255,255,255))  -- Right Circle
		WEPSWITCH:DrawCircles(ScrW() * (.818),ScrH() * (.722),ScrW() * (.091),ScrW() * (.091),Color(255,255,255,255), Color(255,255,255,255)) -- Middle Circle
		WEPSWITCH:DrawCircles(ScrW() * (.753),ScrH() * (.838),ScrW() * (.065),ScrW() * (.065),Color(255,255,255,255), Color(255,255,255,255)) -- Left Circle
		
		WEPSWITCH:DrawIcons(ScrW() * (.766),ScrH() * (.861),ScrW() * (.039),ScrW() * (.039),Color(255,255,255,255), leftWep) -- Left Slot
		WEPSWITCH:DrawIcons(ScrW() * (.831),ScrH() * (.745),ScrW() * (.065),ScrW() * (.065),Color(255,255,255,255), curWep) -- Middle Slot
		WEPSWITCH:DrawIcons(ScrW() * (.922),ScrH() * (.861),ScrW() * (.039),ScrW() * (.039),Color(255,255,255,255), rightWep) -- Right Slot
	else
		--WEPSWITCH:DrawCircles(ScrW()/2,ScrH()/2,250,250,Color(55,25,5,255), Color(255,255,255,255))
	end
end

function WEPSWITCH:ScrollCheck()
	currentWeapon = WEPSWITCH.currentWeaponIndex
	local mouseWheel = WEPSWITCH.scroll
	if(mouseWheel != 0) then print("FUCK YES " .. mouseWheel) end
	--print("Called, time: " .. CurTime() .. " time left: " .. WEPSWITCH.nextDelay .. " mouseWheel: " .. mouseWheel)
	if(WEPSWITCH.nextDelay < CurTime()) then-- If the current time is past the delay time
		if(mouseWheel < 0)then
			WEPSWITCH.show = true
			if(currentWeapon == 4)then -- If last ID, reset
				currentWeapon = 1
			else
				currentWeapon = currentWeapon + 1
			end
			WEPSWITCH.show = true
			-- Create timer to turn off HUD
			if(not timer.Exists("persistWeaponHUD"))then -- Check if there is already a timer
				timer.Create("persistWeaponHUD", WEPSWITCH.switchPersistDelay:GetInt(), 1, function() 
					WEPSWITCH.show = false
				end)
			else
				timer.Destroy("persistWeaponHUD")
				timer.Create("persistWeaponHUD", WEPSWITCH.switchPersistDelay:GetInt(), 1, function() 
					WEPSWITCH.show = false
				end)
			end
			
			-- End Timer setup
		elseif(mouseWheel > 0)then
			WEPSWITCH.show = true
			if(currentWeapon == 1)then -- If last ID, reset
				currentWeapon = 4
			else
				currentWeapon = currentWeapon - 1
			end
			-- Create timer to turn off HUD
			if(not timer.Exists("persistWeaponHUD"))then -- Check if there is already a timer
				timer.Create("persistWeaponHUD", WEPSWITCH.switchPersistDelay:GetInt(), 1, function() 
					WEPSWITCH.show = false
				end)
			else
				timer.Destroy("persistWeaponHUD")
				timer.Create("persistWeaponHUD", WEPSWITCH.switchPersistDelay:GetInt(), 1, function() 
					WEPSWITCH.show = false
				end)
			end
			-- End Timer setup
		end
		WEPSWITCH.nextDelay = CurTime() + WEPSWITCH.switchDelay -- Set next delay time
	end
	WEPSWITCH.currentWeaponIndex = currentWeapon
end

function WEPSWITCH:SelectWep() -- Change weapon
	if (LocalPlayer():GetActiveWeapon() == NULL) then WEPSWITCH:EquipFail() return end
	currentWepName = LocalPlayer():GetActiveWeapon():GetClass()
	wepSlot = WEPSWITCH.currentWeaponIndex
	for k,v in pairs(LocalPlayer():GetWeapons())do -- Get all weapons player has
		if(wepSlot == v:GetNWInt("slot", 2))then
			if(v:GetClass() != LocalPlayer():GetActiveWeapon():GetClass() && v:GetClass() != nil)then
				currentWepName = v:GetClass()
			else
				WEPSWITCH:EquipFail()
				return
			end
		end
	end
	
	if(currentWepName == nil)then WEPSWITCH:EquipFail() return end
	
	net.Start("SelectWeapon")
	net.WriteString(currentWepName)
	net.SendToServer()
end

function WEPSWITCH:EquipFail() -- When the player tries to equip an already equipped weapon
	print("Equip Failed")
	surface.PlaySound(WEPSWITCH.sounds["error"])
end

function WEPSWITCH:CallWepSwitch() -- Function tied to hook for when player selects weapon
	print("YESSSSS")
	--WEPSWITCH.show = 1
end

end
-- End Client Methods --