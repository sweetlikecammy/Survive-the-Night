if CLIENT then
	
	
	local function CreateFonts()
			
			surface.CreateFont("UIJobHeader", {
			size = 128,
			weight = 0,
			antialias = false,
			shadow = false,
			font = "Game Continue 02"})
			
			
			surface.CreateFont("UIFactionHeader", {
			size = 100,
			weight = 0,
			antialias = false,
			shadow = false,
			font = "Game Continue 02"})
			
			
			surface.CreateFont("UIHeader", {
			size = 72,
			weight = 0,
			antialias = false,
			shadow = false,
			font = "Game Continue 02"})
			
			surface.CreateFont("UIBarText", {
			size = 62,
			weight = 0,
			antialias = false,
			shadow = false,
			font = "Game Continue 02"})
			
			surface.CreateFont("UISubHeader", {
			size = 52,
			weight = 0,
			antialias = true,
			shadow = false,
			font = "Game Continue 02"})
			
			surface.CreateFont("UIInfo", {
			size = 40,
			weight = 0,
			antialias = true,
			shadow = false,
			font = "Game Continue 02"})
			
			surface.CreateFont("UIBasic", {
			size = 36,
			weight = 800,
			antialias = true,
			shadow = false,
			font = "Game Continue 02"})
			
			surface.CreateFont("UISmall", {
			size = 30,
			weight = 0,
			antialias = true,
			shadow = false,
			font = "Game Continue 02"})
			
			surface.CreateFont("Godfather", {
			size = 36,
			weight = 800,
			antialias = true,
			shadow = false,
			font = "The Godfather"})
			
			surface.CreateFont("Ninja", {
			size = 36,
			weight = 800,
			antialias = true,
			shadow = false,
			font = "Ninja Naruto"})
	end	
		
	CreateFonts()
	
	hook.Add("InitPostEntity", "HOL_CreateFonts", CreateFonts)
	
	
end