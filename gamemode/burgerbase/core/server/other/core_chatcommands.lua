function BURGERBASE_HOOK_PlayerSay_CC(sender,text,teamChat)

	if sender:IsPlayer() then
		if text == "!burgerclient" then
			sender:ConCommand("burgerbase_client")
			return ""
		elseif text == "!burgerserver" then
			sender:ConCommand("burgerbase_server")
			return ""
		end
	end
	
	return text

end


hook.Add("PlayerSay","BURGERBASE_HOOK_PlayerSay_CC",BURGERBASE_HOOK_PlayerSay_CC)

