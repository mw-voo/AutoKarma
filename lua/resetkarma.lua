local rankcheck = {'moderator','admin','superadmin','owner'} --Ranks that enable autokarma, change to suite group names if ever changed. IE: superadmin becomes superbadmins

CreateConVar("autokarma_enable", "1", {FCVAR_ARCHIVE,FCVAR_NOTIFY}) -- Convar to enable auto karma when a suffient rank is currently online
CreateConVar("autokarma_nokick", "1", {FCVAR_ARCHIVE,FCVAR_NOTIFY}) -- Convar to enable no kicking when below threshold and an admin is online
CreateConVar("autokarma_notify", "1", {FCVAR_ARCHIVE,FCVAR_NOTIFY}) -- Convar to enable no kicking when below threshold and an admin is online


hook.Add('TTTEndRound', 'AutoKarma_RoundStart', function()
	if GetConVar('autokarma_enable'):GetBool() then
		local should_reset = false
		local users_lowkarma = {}
		local admins_online = {}
		for _ , v in pairs(player.GetAll()) do
			--Check to see if permitted ranks are online
			if (table.HasValue(rankcheck, v:GetUserGroup()) or v:IsAdmin()) then 
				table.insert(admins_online, v)
			end
			--Get any player with ultra low karma (Below banning threshold), usually these are mass rdmers. Used to report to admins whos been rdming too much
			if v:GetBaseKarma() < GetConVar('ttt_karma_low_amount'):GetInt() then
				table.insert(users_lowkarma, v)
			end
		end
		if #admins_online >= 1 then should_reset = true  end
		
		if should_reset == true then
			for _ , ply in pairs(player.GetAll()) do
				---Reset karma to whatever the default max karma is
				ply:SetBaseKarma(GetConVar("ttt_karma_max"):GetInt())
				ply:SetLiveKarma(GetConVar("ttt_karma_max"):GetInt())
				--
	    	end
		end
		--Should we notify admins of karma refreshing / anyone with threshold karma
		if should_reset == true and GetConVar('autokarma_notify'):GetBool() and  GetConVar('autokarma_enable'):GetBool() then
			for _,p in pairs(player.GetAll()) do
				p:ChatPrint('[AutoKarma] Refreshed all karma.')
			end
			ulx.fancyLogAdmin(admins_online, true, "[AutoKarma] Users with karma below banning threshold: #T", users_lowkarma)
		end
	end
end)
--Because of how the hook TTTEndRound works, we must prevent player kicking (if permitted) on round end
--Preventing karma kicks will only be enabled if autokarma_enable and autokarma_nokick are enabled
hook.Add('TTTKarmaLow','AutoKarma_Nokick', function(ply)
	if GetConVar('autokarma_nokick'):GetBool() == true and GetConVar('autokarma_enable'):GetBool() == true then
		--Check if any admins are online
		for _ , v in pairs(player.GetAll()) do
			if table.HasValue(rankcheck, v:GetUserGroup()) or v:IsAdmin() then return false end
		end
	end

end)

