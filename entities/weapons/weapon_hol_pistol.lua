if SERVER then
	-- Send to Clients
	AddCSLuaFile()
	
	-- Weight of weapon
	SWEP.Weight = 5
	
	// AutoSwitch
	SWEP.AutoSwitch = false
	SWEP.AutoSwitchFrom = false
	
elseif CLIENT then
	SWEP.PrintName = "Pistol"
	
	// Slot 1 = Melee, Slot 2 = Ranged, Slot 3 = Tool
	SWEP.Slot = 2
	
else
	print("What the fuck are you?")
end

SWEP.Author = "JacksonPeeven / Cameron Watson"
SWEP.Purpose = "House of Lies Gamemode"

SWEP.ViewModel = "models/weapons/v_RPG.mdl"
SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
 
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

-- Precache sounds
local disabledSound = Sound("weapons/pistol/pistol_empty.wav")
local fireSound = Sound("weapons/pistol/pistol_fire2.wav")

function SWEP:Reload()
end
 
function SWEP:Think()
end

function SWEP:PrimaryAttack()
	print("Primary")
end
 
function SWEP:SecondaryAttack()
	print("Secondary")
end
 