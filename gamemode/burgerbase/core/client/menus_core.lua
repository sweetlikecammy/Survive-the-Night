BURGERBASE.ServerMenuConvars = {}
BURGERBASE.ClientMenuConvars = {}

function BURGERBASE:FUNC_MENU_GetBurgerBaseWeapons()

	local ReturnTable = {}

	for k,v in pairs(weapons.GetList()) do
		if v.Base == "weapon_burger_core_base" then
			table.Add(ReturnTable,{v.ClassName})
		end	
	end

	return ReturnTable

end

function BURGERBASE:FUNC_MENU_AddConVarSlider(convar,clientside,description,max,round)

	local RealmTable = nil

	if clientside then
		RealmTable = BURGERBASE.ClientMenuConvars
	else
		RealmTable = BURGERBASE.ServerMenuConvars
	end

	local TableCount = table.Count(RealmTable)

	RealmTable[TableCount] = {
		type = "DNumSlider",
		text = description,
		ConVar = BURGERBASE:CONVARS_GetStoredConvar(convar,clientside),
		min = 0,
		max = max,
		round = round,
	}	

end

function BURGERBASE:FUNC_MENU_AddConVarCheckbox(convar,clientside,description,realm)

	local RealmTable = nil

	if clientside then
		RealmTable = BURGERBASE.ClientMenuConvars
	else
		RealmTable = BURGERBASE.ServerMenuConvars
	end

	local TableCount = table.Count(RealmTable)

	RealmTable[TableCount] = {
		type = "DCheckBoxLabel",
		text = description,
		ConVar = BURGERBASE:CONVARS_GetStoredConvar(convar,clientside),
	}	

end

function BURGERBASE:FUNC_MENU_AddTitle(title,clientside)

	local RealmTable = nil

	if clientside then
		RealmTable = BURGERBASE.ClientMenuConvars
	else
		RealmTable = BURGERBASE.ServerMenuConvars
	end

	local TableCount = table.Count(RealmTable)
	
	RealmTable[TableCount] = {
		type = "Divider",
	}

	RealmTable[TableCount + 1] = {
		type = "DLabel",
		text = title,
		font = "DermaLarge",
		textcolor = Color(0,0,0,255)
	}
	
end

function BURGERBASE_FUNC_MENU_ServerMenu()

	if SERVER then return end
	
	local ply = LocalPlayer()
	local x = ScrW()
	local y = ScrH()

	local BaseList = BURGERBASE:CreateBaseFrame(x*0.05,x*0.05,x*0.4,y*1 - x*0.1)


	for num,data in pairs(BURGERBASE.ServerMenuConvars) do
		BURGERBASE:CreateElement(BaseList,data)
	end

end

if CLIENT then
	concommand.Add( "burgerbase_server", BURGERBASE_FUNC_MENU_ServerMenu)
end

function BURGERBASE_FUNC_MENU_ClientMenu()

	if SERVER then return end
	
	local ply = LocalPlayer()
	local x = ScrW()
	local y = ScrH()

	local BaseList = BURGERBASE:CreateBaseFrame(x*0.05,x*0.05,x*0.4,y*1 - x*0.1)

	for num,data in pairs(BURGERBASE.ClientMenuConvars) do
		BURGERBASE:CreateElement(BaseList,data)
	end

end

if CLIENT then
	concommand.Add( "burgerbase_client", BURGERBASE_FUNC_MENU_ClientMenu)
end

function BURGERBASE:CreateBaseFrame(x,y,w,h)
	
	local SpaceOffset = 10

	local BaseFrame = vgui.Create("DFrame")
	BaseFrame:SetSize(w,h)
	BaseFrame:SetPos(x,y)
	BaseFrame:SetVisible( true )
	BaseFrame:SetDraggable( false )
	BaseFrame:ShowCloseButton( true )
	BaseFrame:SetTitle(" ")
	BaseFrame:MakePopup()
	BaseFrame.Paint = function(self,w,h)
		draw.RoundedBoxEx( 4, 0, 0, w, h, Color( 255, 255, 255, 150 ), true,true,true,true )
	end
	
	local BaseScroll = vgui.Create("DScrollPanel",BaseFrame)
	BaseScroll:StretchToParent(SpaceOffset,SpaceOffset + 40,SpaceOffset,SpaceOffset)
	BaseScroll:Center()
	
	local LW, LH = BaseScroll:GetSize()

	local BaseList = vgui.Create("DIconLayout",BaseScroll)
	BaseList:SetSize(LW - SpaceOffset*2 - 20,LH - SpaceOffset) -- 20 is for the scrollbars
	BaseList:SetPos(SpaceOffset,0)
	BaseList:SetSpaceX(0)
	BaseList:SetSpaceY(0)

	return BaseList
	
end

function BURGERBASE:CreateElement(BaseList,data)

	local LW, LH = BaseList:GetSize()
	
	local Tester =  BaseList:Add("DPanel")
	Tester:SetSize(LW,200)
	function Tester:Paint(w,h) end
	
	local ElementType = data.type

	if ElementType == "Divider" then
		local Element = vgui.Create("DPanel",Tester)
		Element:SetSize(LW,50)
		function Element:Paint(w,h)
			draw.RoundedBox( 0, 0, h/2, w, 1, Color(0,0,0,255) )
		end
	elseif ElementType == "DLabel" then
		local Element = vgui.Create(ElementType,Tester)
		Element:SetText(data.text)
		Element:SetFont(data.font)
		Element:SetTextColor(data.textcolor)
		Element:SizeToContents()
	elseif ElementType == "DCheckBoxLabel" then
		local Element = vgui.Create(ElementType,Tester)
		Element:SetText(data.text)
		Element:SetDark(true)
		Element:SetValue()	
		Element:SizeToContents()
		Element:SetSize(LW,20)
		if data.ConVar:GetBool() then
			Element:SetChecked(true)
		end
		function Element:OnChange()
			local Value = 0
			if self:GetChecked() then
				Value = 1
			end
			RunConsoleCommand(data.ConVar:GetName(),tostring(Value))
		end
		Element:SetTooltip( data.ConVar:GetHelpText() .. " Default: " .. data.ConVar:GetDefault() )

	elseif ElementType == "DNumSlider" then
		local Element = vgui.Create(ElementType,Tester)
		Element:SetText(data.text)
		Element:SetDark(true)
		Element:SetMin( data.min )
		Element:SetMax( data.max )
		Element:SetSize(LW,20)
		Element:SetDecimals( data.round )	
		Element:SetValue(data.ConVar:GetFloat())
		Element:UpdateNotches()	
		function Element:OnValueChanged(newvalue)
			newvalue = math.Round(newvalue,self:GetDecimals())
			self:SetValue(newvalue)
			RunConsoleCommand(data.ConVar:GetName(),tostring(newvalue))
		end
		Element:SetTooltip( data.ConVar:GetHelpText() .. " Default: " .. data.ConVar:GetDefault() )
	end

	Tester:SizeToChildren(false,true)
	
end

BURGERBASE:INIT_MassInclude("menus/","client",false,7)
BURGERBASE:INIT_MassInclude("other/","client",false,7)