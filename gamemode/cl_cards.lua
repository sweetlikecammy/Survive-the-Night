CARDS = {}

-- Start Variables --

CARDS.materials = {
	
}

CARDS.currentDeathNote = ""
CARDS.currentKillNote = ""

-- End Variables --

-- Start Methods -- 
local DC_Menu = nil
function CARDS:DeathCardMenu()
	DC_Menu = vgui.Create("DFrame")
	DC_Menu:SetPos(ScrW()/2 - ScrW() * .15, ScrH()/2 - ScrH() * .25)
	DC_Menu:SetSize(ScrW() * .3, ScrH() * .5)
	DC_Menu:SetTitle("")
	DC_Menu:SetVisible(true)
	DC_Menu:SetDraggable(true)
	DC_Menu:ShowCloseButton(false)
	DC_Menu:MakePopup()
	DC_Menu.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(50,50,50,255))
		draw.SimpleText("Death Card", "UIHeader", w/2, h * .025, Color(255,255,255), TEXT_ALIGN_CENTER)
		draw.SimpleText("Leave a death card when you die to inform others what you know!", "UIInfo", w/2, h * .1, Color(255,255,255), TEXT_ALIGN_CENTER)
	end
	
	local DFrameX, DFrameY = DC_Menu:GetWide(), DC_Menu:GetTall()
	
	local DC_TextInput = vgui.Create("DTextEntry", DC_Menu)
	DC_TextInput:SetPos(DFrameX/2 - DFrameX * .45, DFrameY/2 - DFrameY * .35)
	DC_TextInput:SetSize(DFrameX * .9, DFrameY * .7)
	DC_TextInput:SetText("Enter death note here...")
	DC_TextInput:SetTextColor(Color(70,70,70))
	DC_TextInput:SetFont("UISubHeader")
	DC_TextInput:SetMultiline(true)
	--DC_TextInput.Paint = function(self, w, h)
	--	draw.RoundedBox(0,0,0,w,h,Color(120,120,0,255))
	--end
	DC_TextInput.OnEnter = function(self)
		print("Typey")
	end
	if(CARDS.currentDeathNote != "") then DC_TextInput:SetText(CARDS.currentDeathNote) end
	
	local DC_SetButton = vgui.Create("DButton", DC_Menu)
	DC_SetButton:SetPos(DFrameX * .7 - DFrameX * .166, DFrameY * .925 - DFrameY/20 )
	DC_SetButton:SetSize(DFrameX/3, DFrameY/10)
	DC_SetButton:SetText("Set")
	DC_SetButton:SetFont("UISubHeader")
	DC_SetButton:SetTextColor(Color(255,255,255,255))
	DC_SetButton.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(120,120,120,255))
	end
	DC_SetButton.DoClick = function()
		net.Start("SetDeathCard")
			net.WriteString(DC_TextInput:GetValue())
		net.SendToServer()
		CARDS.currentDeathNote = DC_TextInput:GetValue()
		LocalPlayer():ChatPrint("Death note saved!")
		DC_Menu:SetVisible(false)
	end
	
	local DC_CancelButton = vgui.Create("DButton", DC_Menu)
	DC_CancelButton:SetPos(DFrameX * .3 - DFrameX * .166 , DFrameY * .925 - DFrameY/20 )
	DC_CancelButton:SetSize(DFrameX/3, DFrameY/10)
	DC_CancelButton:SetText("Cancel")
	DC_CancelButton:SetFont("UISubHeader")
	DC_CancelButton:SetTextColor(Color(255,255,255,255))
	DC_CancelButton.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(120,120,120,255))
	end
	DC_CancelButton.DoClick = function()
		DC_Menu:SetVisible(false)
	end
end

local CC_Menu = nil
function CARDS:CallingCardMenu()
	CC_Menu = vgui.Create("DFrame")
	CC_Menu:SetPos(ScrW()/2 - ScrW() * .15, ScrH()/2 - ScrH() * .25)
	CC_Menu:SetSize(ScrW() * .3, ScrH() * .5)
	CC_Menu:SetTitle("")
	CC_Menu:SetVisible(true)
	CC_Menu:SetDraggable(true)
	CC_Menu:ShowCloseButton(false)
	CC_Menu:MakePopup()
	CC_Menu.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(50,50,50,255))
		draw.SimpleText("Calling Card", "UIHeader", w/2, h * .025, Color(255,255,255), TEXT_ALIGN_CENTER)
		draw.SimpleText("Leave a calling card on every player you kill!", "UIInfo", w/2, h * .1, Color(255,255,255), TEXT_ALIGN_CENTER)
	end
	
	local DFrameX, DFrameY = CC_Menu:GetWide(), CC_Menu:GetTall()
	
	local CC_TextInput = vgui.Create("DTextEntry", CC_Menu)
	CC_TextInput:SetPos(DFrameX/2 - DFrameX * .45, DFrameY/2 - DFrameY * .35)
	CC_TextInput:SetSize(DFrameX * .9, DFrameY * .7)
	CC_TextInput:SetText("Enter kill note here...")
	CC_TextInput:SetTextColor(Color(70,70,70))
	CC_TextInput:SetFont("UISubHeader")
	CC_TextInput:SetMultiline(true)
	--CC_TextInput.Paint = function(self, w, h)
	--	draw.RoundedBox(0,0,0,w,h,Color(120,120,0,255))
	--end
	CC_TextInput.OnEnter = function(self)
		
	end
	if(CARDS.currentKillNote != "") then CC_TextInput:SetText(CARDS.currentKillNote) end
	
	local CC_SetButton = vgui.Create("DButton", CC_Menu)
	CC_SetButton:SetPos(DFrameX * .7 - DFrameX * .166, DFrameY * .925 - DFrameY/20 )
	CC_SetButton:SetSize(DFrameX/3, DFrameY/10)
	CC_SetButton:SetText("Set")
	CC_SetButton:SetFont("UISubHeader")
	CC_SetButton:SetTextColor(Color(255,255,255,255))
	CC_SetButton.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(120,120,120,255))
	end
	CC_SetButton.DoClick = function()
		net.Start("SetCallingCard")
			net.WriteString(CC_TextInput:GetValue())
		net.SendToServer()
		CARDS.currentKillNote = CC_TextInput:GetValue()
		LocalPlayer():ChatPrint("Calling card saved!")
		CC_Menu:SetVisible(false)
	end
	
	local CC_CancelButton = vgui.Create("DButton", CC_Menu)
	CC_CancelButton:SetPos(DFrameX * .3 - DFrameX * .166 , DFrameY * .925 - DFrameY/20 )
	CC_CancelButton:SetSize(DFrameX/3, DFrameY/10)
	CC_CancelButton:SetText("Cancel")
	CC_CancelButton:SetFont("UISubHeader")
	CC_CancelButton:SetTextColor(Color(255,255,255,255))
	CC_CancelButton.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(120,120,120,255))
	end
	CC_CancelButton.DoClick = function()
		CC_Menu:SetVisible(false)
	end
end

local PR_Menu
function CARDS:PlayerReviewCards(plyr, deathMsg, killMsg)
	local plyrName = plyr:Nick()
	print("CALLED adskfjnsldkj jfnvlsdjvf';oasdjv'f;ojasdmkvfmsn d;kvfjdsp")
	PR_Menu = vgui.Create("DFrame")
	PR_Menu:SetPos(ScrW()/2 - ScrW() * .15, ScrH()/2 - ScrH() * .35)
	PR_Menu:SetSize(ScrW() * .3, ScrH() * .7)
	PR_Menu:SetTitle("")
	PR_Menu:SetVisible(true)
	PR_Menu:SetDraggable(true)
	PR_Menu:ShowCloseButton(true)
	PR_Menu:MakePopup()
	PR_Menu.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(50,50,50,255))
		draw.SimpleText(plyrName, "UIHeader", w/2, h * .02, Color(255,255,255), TEXT_ALIGN_CENTER)
		draw.SimpleText(player_manager.GetPlayerClass(plyr), "UIHeader", w/2, h * .072, team.GetColor(plyr:Team()), TEXT_ALIGN_CENTER)
		draw.SimpleText("Death Card", "UIHeader", w/2, h * .133, Color(255,255,255), TEXT_ALIGN_CENTER)
		draw.SimpleText("Calling Card", "UIHeader", w/2, h * .57, Color(255,255,255), TEXT_ALIGN_CENTER)
	end
	
	local DFrameX, DFrameY = PR_Menu:GetWide(), PR_Menu:GetTall()
	
	local PRD_TextInput = vgui.Create("DTextEntry", PR_Menu)
	PRD_TextInput:SetPos(DFrameX/2 - DFrameX * .45, DFrameY * .18)
	PRD_TextInput:SetSize(DFrameX * .9, DFrameY * .35)
	PRD_TextInput:SetText(deathMsg)
	PRD_TextInput:SetTextColor(Color(70,70,70))
	PRD_TextInput:SetFont("UISubHeader")
	PRD_TextInput:SetEditable(false)
	PRD_TextInput:SetMultiline(true)
	
	local PRC_TextInput = vgui.Create("DTextEntry", PR_Menu)
	PRC_TextInput:SetPos(DFrameX/2 - DFrameX * .45, DFrameY/2 + DFrameY * .12)
	PRC_TextInput:SetSize(DFrameX * .9, DFrameY * .35)
	PRC_TextInput:SetText(killMsg)
	PRC_TextInput:SetTextColor(Color(70,70,70))
	PRC_TextInput:SetFont("UISubHeader")
	PRC_TextInput:SetEditable(false)
	PRC_TextInput:SetMultiline(true)
	
	PR_Menu:SetVisible(true)
	--local isPanel = PR_MENU:IsVisible() or false
	--timer.Simple( 4, function() if (PR_MENU:IsVisible() == true) then PR_Menu:SetVisible(false) end end)
	timer.Simple( 4, function() PR_Menu:SetVisible(false) end)
	
end

function CARDS:OpenCardsMenu(plyr, key)
	if key == KEY_F2 then
		print(CC_Menu)
		if (CC_Menu == nil or CC_Menu:IsVisible() == false) then CARDS:DeathCardMenu() else print("Yeet") CC_Menu:Close() end
	--elseif key == KEY_F4 then
		--CARDS:PlayerReviewCards(LocalPlayer(), "Test123", "Test421")
	elseif key == KEY_F3 then
		CARDS:CallingCardMenu()
	end
end
hook.Add("PlayerButtonDown", "OpenCardsMenu", function(plyr, key)
	CARDS:OpenCardsMenu(plyr, key)
end)
-- End Methods --