--
-- This defines a new panel type for the player row. The player row is given a player
-- and then from that point on it pretty much looks after itself. It updates player info
-- in the think function, and removes itself when the player leaves the server.
--

SCOREBOARD = {}

SCOREBOARD.suspicions = {
	
}

SCOREBOARD.teamPlayers = {
	
}

local textColor = Color(255,255,255)
local barBG = Color(75,75,75,255)
local barFG = Color(100,100,100,255)
local adminColor = Color(255,0,0,150)
local connectingColor = Color(0,255,0,150)

local materials = {
	["leaderStar"] = "Scoreboard/leaderStar.png"
}

local line_player = {
	Init = function( self )

		self.AvatarButton = self:Add( "DButton" )
		self.AvatarButton:Dock( LEFT )
		self.AvatarButton:SetSize( 54, 54 )
		self.AvatarButton.DoClick = function() self.Player:ShowProfile() end

		self.Avatar = vgui.Create( "AvatarImage", self.AvatarButton )
		self.Avatar:SetSize( 54, 54 )
		self.Avatar:SetMouseInputEnabled( false )
		
		self.Name = self:Add( "DLabel" )
		self.Name:Dock( LEFT )
		self.Name:SetFont( "UIInfo" )
		self.Name:SetTextColor( textColor )
		self.Name:DockMargin( 8, 0, 0, 0 )
		self.Name:SetWide(300)
		
		self.jobIcon = self:Add("DImage")
		self.jobIcon:Dock(LEFT)
		self.jobIcon:DockMargin( 0, 5, 0, 5 )
		self.jobIcon:SetSize(40,5)
		self.jobIcon:SetImage(materials["leaderStar"])
		self.jobIcon:SetVisible(false)
		
		self.jobName = self:Add( "DLabel" )
		self.jobName:Dock( LEFT )
		self.jobName:SetFont( "UIInfo" )
		self.jobName:SetText( "" )
		self.jobName:SetTextColor( textColor )
		self.jobName:DockMargin( 8, 0, 0, 0 )
		self.jobName:SetWide(300)
		
		self.Mute = self:Add( "DImageButton" )
		self.Mute:SetSize( 54, 54 )
		self.Mute:Dock( RIGHT )

		self.Ping = self:Add( "DLabel" )
		self.Ping:Dock( RIGHT )
		self.Ping:SetWidth( 50 )
		self.Ping:SetFont( "UIInfo" )
		self.Ping:SetTextColor( textColor )
		self.Ping:SetContentAlignment( 5 )
		
		
		self.Deaths = self:Add( "DLabel" )
		self.Deaths:Dock( RIGHT )
		self.Deaths:SetWidth( 50 )
		self.Deaths:SetFont( "UIInfo" )
		self.Deaths:SetTextColor( textColor )
		self.Deaths:SetContentAlignment( 5 )
		self.Deaths:SetVisible( false )
		
		
		self.Kills = self:Add( "DLabel" )
		self.Kills:Dock( RIGHT )
		self.Kills:SetWidth( 50 )
		self.Kills:SetFont( "UIInfo" )
		self.Kills:SetTextColor( textColor )
		self.Kills:SetContentAlignment( 5 )
		self.Kills:SetVisible( false )
		
		self.Suspicion = self:Add( "DButton" )
		self.Suspicion:DockMargin( 0,0,0,0 )
		self.Suspicion:Dock( LEFT )
		self.Suspicion:SetContentAlignment( 5 )
		self.Suspicion:SetSize( 500,20 )
		self.Suspicion:SetFont( "UIInfo" )
		self.Suspicion:SetColor(Color(0,255,255,75))
		self.Suspicion:SetText( "Set Suspicion" )
		self.Suspicion:SetTextColor( textColor )
		
		-- Create temp surface font and text to check width
		surface.SetFont("UIInfo")
		local width, height = surface.GetTextSize("Set Suspicion")
		self.Suspicion:SetSize(width+50, height+20)
		
		self.Suspicion.Paint = function()
			surface.SetDrawColor(Color(255,255,255,150))
			surface.DrawRect(0,0,width+50, self.Suspicion:GetTall())
		end
		
		self.Suspicion.DoClick = function()
			local suspicionList = DermaMenu()  -- Create DermaMenu
			suspicionList:AddOption(" ", function() 
				self.jobName:SetText("") 
				SCOREBOARD.suspicions[LocalPlayer():GetName()][self.Player:GetName()] = nil 
			end)
			for k,v in pairs(CLASS_CONFIG.Classes)do
				if(v["faction"]["name"] != team.GetName(LocalPlayer():Team()))then
					suspicionList:AddOption(v["name"], function() 
						self.jobName:SetText(v["name"]) 
						SCOREBOARD.suspicions[LocalPlayer():GetName()][self.Player:GetName()] = v["name"] 
					end)
				end
			end
			suspicionList:Open()
		end

		self:Dock( TOP )
		self:DockPadding( 3, 3, 3, 3 )
		self:SetHeight( 60 )
		self:DockMargin( 2, 0, 2, 2 )

	end,

	Setup = function( self, pl )

		self.Player = pl

		self.Avatar:SetPlayer( pl )

		self:Think( self )

		--local friend = self.Player:GetFriendStatus()
		--MsgN( pl, " Friend: ", friend )

	end,

	Think = function( self )
		
		if ( !IsValid( self.Player ) ) then
			self:SetZPos( 9999 ) -- Causes a rebuild
			self:Remove()
			return
		end

		if ( self.PName == nil || self.PName != self.Player:Nick() ) then
			self.PName = self.Player:Nick()
			self.Name:SetText( self.PName )
		end
		
		local check1 = false
		local check2 = false
		
		if(SCOREBOARD.suspicions[LocalPlayer():GetName()] == nil)then 
			SCOREBOARD.suspicions[LocalPlayer():GetName()] = {} 
		end
		
		if(SCOREBOARD.teamPlayers[LocalPlayer():GetName()] == nil)then 
			SCOREBOARD.teamPlayers[LocalPlayer():GetName()] = {} 
		end
		
		if(SCOREBOARD.suspicions[LocalPlayer():GetName()][self.Player:GetName()] != nil)then 
				self.jobName:SetText(SCOREBOARD.suspicions[LocalPlayer():GetName()][self.Player:GetName()])
				check1 = true
		end
		
		
		local shouldShowTeam = true
		for g,m in pairs(CLASS_CONFIG.Factions)do
			if(m["solo"] == true and team.GetName(LocalPlayer():Team()) == m["name"])then
				shouldShowTeam = false
			end
		end
		if(SCOREBOARD.teamPlayers[LocalPlayer():GetName()][self.Player:GetName()] != nil && LocalPlayer():Team() == self.Player:Team() && shouldShowTeam)then 
			self.jobName:SetText(SCOREBOARD.teamPlayers[LocalPlayer():GetName()][self.Player:GetName()])
			check2 = true
		end
		
		if(!check1 and !check2)then
			self.jobName:SetText("")
		end
		
		if(self.Player:GetNWBool("revealed"))then
			SCOREBOARD.teamPlayers[LocalPlayer():GetName()][self.Player:GetName()] = player_manager.GetPlayerClass(self.Player)
			self.jobName:SetText(SCOREBOARD.teamPlayers[LocalPlayer():GetName()][self.Player:GetName()])
		end
		
		if(self.Player:Team() == LocalPlayer():Team())then
			if(self.Player == LocalPlayer() or shouldShowTeam)then
					self.jName = player_manager.GetPlayerClass(self.Player)
					SCOREBOARD.teamPlayers[LocalPlayer():GetName()][self.Player:GetName()] = self.jName
				for x,y in pairs(CLASS_CONFIG.Classes)do
					leaderBool = y["leader"] or false
					if(y["name"] == player_manager.GetPlayerClass(self.Player) and leaderBool == true && LocalPlayer():Team() == self.Player:Team())then
						self.jobIcon:SetVisible(true)
					else
						self.jobIcon:SetVisible(false)
					end
				end
			else
				self.jobIcon:SetVisible(false)
				--self.jobName:SetText( "" )
			end
		end
		
		if(SCOREBOARD.teamPlayers[LocalPlayer():GetName()][self.Player:GetName()] != nil or LocalPlayer() == self.Player)then  -- If on same team
			-- Remove suspicion button
			self.Suspicion:SetVisible(false)
		else
			self.Suspicion:SetVisible(true)
		end
		
		if ( self.NumKills == nil || self.NumKills != self.Player:Frags() ) then
			self.NumKills = self.Player:Frags()
			self.Kills:SetText( self.NumKills )
		end

		if ( self.NumDeaths == nil || self.NumDeaths != self.Player:Deaths() ) then
			self.NumDeaths = self.Player:Deaths()
			self.Deaths:SetText( self.NumDeaths )
		end

		if ( self.NumPing == nil || self.NumPing != self.Player:Ping() ) then
			self.NumPing = self.Player:Ping()
			self.Ping:SetText( self.NumPing )
		end

		--
		-- Change the icon of the mute button based on state
		--
		if ( self.Muted == nil || self.Muted != self.Player:IsMuted() ) then

			self.Muted = self.Player:IsMuted()
			if ( self.Muted ) then
				self.Mute:SetImage( "icon32/muted.png" )
			else
				self.Mute:SetImage( "icon32/unmuted.png" )
			end

			self.Mute.DoClick = function() self.Player:SetMuted( !self.Muted ) end

		end

		--
		-- Connecting players go at the very bottom
		--
		if ( self.Player:Team() == TEAM_CONNECTING ) then
			self:SetZPos( 2000 + self.Player:EntIndex() )
			return
		end

		--
		-- This is what sorts the list. The panels are docked in the z order,
		-- so if we set the z order according to kills they'll be ordered that way!
		-- Careful though, it's a signed short internally, so needs to range between -32,768k and +32,767
		--
		self:SetZPos( ( self.NumKills * -50 ) + self.NumDeaths + self.Player:EntIndex() )

	end,

	Paint = function( self, w, h )

		if ( !IsValid( self.Player ) ) then
			return
		end

		--
		-- We draw our background a different colour based on the status of the player
		--

		if ( self.Player:Team() == TEAM_CONNECTING ) then
			draw.RoundedBox( 4, 0, 0, w, h, barBG) -- Stroke
			draw.RoundedBox( 4, 0, 0, w, h, connectingColor ) -- Stroke
			draw.RoundedBox( 4, 3, 3, w-6, h-6, barFG )
			draw.RoundedBox( 4, 3, 3, w-6, h-6, connectingColor )
			return
		end
		
		
		--[[
		if ( !self.Player:Alive() ) then
			draw.RoundedBox( 4, 0, 0, w, h, Color( 230, 200, 200, 255 ) )
			return
		end
		]]
		
		local shouldShowTeam = true
		for g,m in pairs(CLASS_CONFIG.Factions)do
			if(m["solo"] == true and team.GetName(LocalPlayer():Team()) == m["name"])then
				shouldShowTeam = false
			end
		end
		
		if ( self.Player == LocalPlayer() or  shouldShowTeam == true) then
			if ( self.Player:Team() == LocalPlayer():Team()) then
				alphaTeamColor = team.GetColor(self.Player:Team())
				alphaTeamColor.a = 150
				draw.RoundedBox( 4, 0, 0, w, h, barBG  ) -- Stroke
				draw.RoundedBox( 4, 0, 0, w, h, alphaTeamColor ) -- Team Stroke
				draw.RoundedBox( 4, 3, 3, w-6, h-6, barFG)
				draw.RoundedBox( 4, 3, 3, w-6, h-6, alphaTeamColor )
				return
			end
		end
		
		if ( self.Player:IsAdmin() ) then
			draw.RoundedBox( 4, 0, 0, w, h, barBG  ) -- Stroke
			draw.RoundedBox( 4, 0, 0, w, h,adminColor ) -- Stroke
			draw.RoundedBox( 4, 3, 3, w-6, h-6, barFG  )
			draw.RoundedBox( 4, 3, 3, w-6, h-6,adminColor )
			return
		end
		
		draw.RoundedBox( 4, 0, 0, w, h, barBG ) -- Stroke
		draw.RoundedBox( 4, 3, 3, w-6, h-6, barFG  )
		

	end
}

--
-- Convert it from a normal table into a Panel Table based on DPanel
--
line_player = vgui.RegisterTable( line_player, "DPanel" )

--
-- Here we define a new panel table for the scoreboard. It basically consists
-- of a header and a scrollpanel - into which the player lines are placed.
--
local SCORE_BOARD = {
	Init = function( self )

		self.Header = self:Add( "Panel" )
		self.Header:Dock( TOP )
		self.Header:SetHeight( 100 )

		self.Name = self.Header:Add( "DLabel" )
		self.Name:SetFont( "UIHeader" )
		self.Name:SetTextColor( Color( 255, 255, 255, 255 ) )
		--self.Name:Dock( TOP )
		--self.Name:DockMargin( 0,0,200,1000 )
		self.Name:SetPos( ScrW()/2 ,0 )
		self.Name:SetHeight( ScrH()/12 )
		self.Name:SetWidth( 0 )
		--self.Name:SetContentAlignment( 5 )
		self.Name:SetExpensiveShadow( 2, Color( 0, 0, 0, 200 ) )

		--self.NumPlayers = self.Header:Add( "DLabel" )
		--self.NumPlayers:SetFont( "ScoreboardDefault" )
		--self.NumPlayers:SetTextColor( Color( 255, 255, 255, 255 ) )
		--self.NumPlayers:SetPos( 0, 100 - 30 )
		--self.NumPlayers:SetSize( 300, 30 )
		--self.NumPlayers:SetContentAlignment( 4 )

		self.Scores = self:Add( "DScrollPanel" )
		self.Scores:Dock( FILL )

	end,

	PerformLayout = function( self )

		self:SetSize( ScrW() * .4, ScrH() * .75 )
		self:SetPos( ScrW() / 2 - ScrW() * .2, ScrH() * .1 )

	end,

	Paint = function( self, w, h )

		--draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 200 ) )

	end,

	Think = function( self, w, h )
	
		surface.SetFont("UIHeader")
		local width,height = surface.GetTextSize(GetHostName())
		self.Name:SetHeight(height)
		self.Name:SetWidth(width)
		self.Name:SetText( GetHostName() )
		--
		-- Loop through each player, and if one doesn't have a score entry - create it.
		--
		local plyrs = player.GetAll()
		for id, pl in pairs( plyrs ) do

			if ( IsValid( pl.ScoreEntry ) ) then continue end

			pl.ScoreEntry = vgui.CreateFromTable( line_player, pl.ScoreEntry )
			pl.ScoreEntry:Setup( pl )

			self.Scores:AddItem( pl.ScoreEntry )

		end

	end
}

SCORE_BOARD = vgui.RegisterTable( SCORE_BOARD, "EditablePanel" )

function ResetScoreboard()
	Msg("Scoreboard reset!")
	if ( IsValid( g_Scoreboard ) ) then 
		g_Scoreboard:Remove(); 
		SCOREBOARD.teamPlayers = {}; 
		SCOREBOARD.suspicions = {}; 
		if ( !IsValid( g_Scoreboard ) ) then
			g_Scoreboard = vgui.CreateFromTable( SCORE_BOARD )
			g_Scoreboard:Hide()
		end
	end
end

function ResetTeamPlayers()
	Msg("Scoreboard reset!")
	if ( IsValid( g_Scoreboard ) ) then 
		g_Scoreboard:Remove(); 
		SCOREBOARD.teamPlayers = {}; 
		if ( !IsValid( g_Scoreboard ) ) then
			g_Scoreboard = vgui.CreateFromTable( SCORE_BOARD )
			g_Scoreboard:Hide()
		end
	end
end

--[[---------------------------------------------------------
	Name: gamemode:ScoreboardShow( )
	Desc: Sets the scoreboard to visible
-----------------------------------------------------------]]
function GM:ScoreboardShow()

	if ( !IsValid( g_Scoreboard ) ) then
		g_Scoreboard = vgui.CreateFromTable( SCORE_BOARD )
	end

	if ( IsValid( g_Scoreboard ) ) then
		g_Scoreboard:Show()
		g_Scoreboard:MakePopup()
		g_Scoreboard:SetKeyboardInputEnabled( false )
	end

end
--[[---------------------------------------------------------
	Name: SetSuspicion()
	Desc: Sets player job to the suspected job or actual job
-----------------------------------------------------------
function()
	
end]]

--[[---------------------------------------------------------
	Name: gamemode:ScoreboardHide( )
	Desc: Hides the scoreboard
-----------------------------------------------------------]]
function GM:ScoreboardHide()

	if ( IsValid( g_Scoreboard ) ) then
		g_Scoreboard:Hide()
	end

end

--[[---------------------------------------------------------
	Name: gamemode:HUDDrawScoreBoard( )
	Desc: If you prefer to draw your scoreboard the stupid way (without vgui)
-----------------------------------------------------------]]
function GM:HUDDrawScoreBoard()
end
