BURGERBASE:FUNC_MENU_AddTitle("Core - Weapon Settings",false)
BURGERBASE:FUNC_MENU_AddConVarSlider("sv_burgerbase_damagescale",false,"Weapon Damage Scale",2,2)
BURGERBASE:FUNC_MENU_AddConVarSlider("sv_burgerbase_recoilscale",false,"Recoil Scale",2,2)
BURGERBASE:FUNC_MENU_AddConVarSlider("sv_burgerbase_baseconescale",false,"Base Cone Scale",2,2)
BURGERBASE:FUNC_MENU_AddConVarSlider("sv_burgerbase_movementconescale",false,"Movement Cone Scale",2,2)
BURGERBASE:FUNC_MENU_AddConVarSlider("sv_burgerbase_heatconescale",false,"Recoil Cone Scale",2,2)
BURGERBASE:FUNC_MENU_AddConVarSlider("sv_burgerbase_damagefalloffscale",false,"Damage Falloff Scale",1,2)

BURGERBASE:FUNC_MENU_AddTitle("Core - Damage Settings",false)
BURGERBASE:FUNC_MENU_AddConVarCheckbox("sv_burgerbase_damage_enable",false,"Enable Custom Damage")
BURGERBASE:FUNC_MENU_AddConVarCheckbox("sv_burgerbase_damage_sandboxfix",false,"Sandbox Fix")
BURGERBASE:FUNC_MENU_AddConVarSlider("sv_burgerbase_damage_bodyscale",false,"Torso Damage Scale",5,2)
BURGERBASE:FUNC_MENU_AddConVarSlider("sv_burgerbase_damage_legscale",false,"Leg Damage Scale",5,2)
BURGERBASE:FUNC_MENU_AddConVarSlider("sv_burgerbase_damage_armscale",false,"Arm Damage Scale",5,2)
BURGERBASE:FUNC_MENU_AddConVarSlider("sv_burgerbase_damage_headscale",false,"Head Damage Scale",5,2)

BURGERBASE:FUNC_MENU_AddTitle("Core - Penetration Settings",false)
BURGERBASE:FUNC_MENU_AddConVarCheckbox("sv_burgerbase_enable_penetration",false,"Enable Bullet Penetration")
BURGERBASE:FUNC_MENU_AddConVarSlider("sv_burgerbase_penetration_scale",false,"Penetration Scale",5,2)

BURGERBASE:FUNC_MENU_AddTitle("Core - Spawning Settings",false)
BURGERBASE:FUNC_MENU_AddConVarCheckbox("sv_burgerbase_ammo_loaded",false,"Give Loaded Weapons")
BURGERBASE:FUNC_MENU_AddConVarCheckbox("sv_burgerbase_ammo_givespare",false,"Give Spare Magazines")
BURGERBASE:FUNC_MENU_AddConVarSlider("sv_burgerbase_limit_equipped",false,"Equipment Setting",3,0)

BURGERBASE:FUNC_MENU_AddTitle("Core - Drop Settings",false)
BURGERBASE:FUNC_MENU_AddConVarCheckbox("sv_burgerbase_drops_enable",false,"Enable Weapon Drops")
BURGERBASE:FUNC_MENU_AddConVarCheckbox("sv_burgerbase_drops_timed",false,"Enable Weapon Drop Timer")
BURGERBASE:FUNC_MENU_AddConVarSlider("sv_burgerbase_drops_timer",false,"Drop Timer",600,0)

BURGERBASE:FUNC_MENU_AddTitle("Core - Other Settings",false)
BURGERBASE:FUNC_MENU_AddConVarCheckbox("sv_burgerbase_quick",false,"Allow Quick Grenades")
BURGERBASE:FUNC_MENU_AddConVarCheckbox("sv_burgerbase_enable_mags",false,"Allow Cosmetic Magazines")

BURGERBASE:FUNC_MENU_AddTitle("Core - Crosshair",true)

BURGERBASE:FUNC_MENU_AddConVarCheckbox("cl_burgerbase_crosshair_dynamic",true,"Dynamic Crosshair")
BURGERBASE:FUNC_MENU_AddConVarCheckbox("cl_burgerbase_crosshair_dot",true,"Center Dot")

BURGERBASE:FUNC_MENU_AddConVarSlider("cl_burgerbase_crosshair_style",true,"Crosshair Style",5,0)
BURGERBASE:FUNC_MENU_AddConVarSlider("cl_burgerbase_crosshair_length",true,"Crosshair Length",30,0)
BURGERBASE:FUNC_MENU_AddConVarSlider("cl_burgerbase_crosshair_offset",true,"Crosshair Offset",10,0)
BURGERBASE:FUNC_MENU_AddConVarCheckbox("cl_burgerbase_crosshair_smoothing",true,"Crosshair Smoothing")
BURGERBASE:FUNC_MENU_AddConVarSlider("cl_burgerbase_crosshair_smoothing_mul",true,"Crosshair Smoothing Multiplier",2,2)
BURGERBASE:FUNC_MENU_AddConVarSlider("cl_burgerbase_crosshair_color_r",true,"Red",255,0)
BURGERBASE:FUNC_MENU_AddConVarSlider("cl_burgerbase_crosshair_color_g",true,"Green",255,0)
BURGERBASE:FUNC_MENU_AddConVarSlider("cl_burgerbase_crosshair_color_b",true,"Blue",255,0)
BURGERBASE:FUNC_MENU_AddConVarSlider("cl_burgerbase_crosshair_color_a",true,"Alpha",255,0)
BURGERBASE:FUNC_MENU_AddConVarCheckbox("cl_burgerbase_crosshair_shadow",true,"Shadow")

BURGERBASE:FUNC_MENU_AddTitle("Core - Viewmodel",true)
BURGERBASE:FUNC_MENU_AddConVarSlider("cl_burgerbase_viewmodel_fov",true,"Viewmodel Add",45,0)
BURGERBASE:FUNC_MENU_AddConVarCheckbox("cl_burgerbase_crosshair_neversights",true,"Disable Ironsights")

BURGERBASE:FUNC_MENU_AddTitle("Core - Other",true)
BURGERBASE:FUNC_MENU_AddConVarCheckbox("cl_burgerbase_customslots",true,"Enable Custom Slots")

local function BURGERBASE_HOOK_OnPlayerChat(ply,text,teamChat,isDead)

	--print(text)

	if ply == LocalPlayer() then
		if text == "!burgerclient" then
			RunConsoleCommand("burgerbase_client")
			return true
		elseif text == "!burgerserver" then
			RunConsoleCommand("burgerbase_server")
			return true
		end
	end

end


hook.Add("OnPlayerChat","BURGERBASE_HOOK_OnPlayerChat",BURGERBASE_HOOK_OnPlayerChat)

