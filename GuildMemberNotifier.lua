--[[
	GuildMemberNotifier
	Author: @ChrisAnn
	Thanks to SoulGemsCounter, Combat Log Statistics and XPNotifier for being inspiration
]]


GuildMemberNotifier = {}
GuildMemberNotifier.name = "GuildMemberNotifier"
GuildMemberNotifier.version = "1.0.0"
GuildMemberNotifier.debug = false

function GuildMemberNotifier.Initialise(eventCode, addOnName)
	if (addOnName ~= GuildMemberNotifier.name) then return end

	zo_callLater(function() d("Guild Member Notifier Initialised.") end, 4000)
	EVENT_MANAGER:RegisterForEvent(GuildMemberNotifier.name, EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED, GuildMemberNotifier.OnGuildMemberPlayerStatusChanged)
end

function GuildMemberNotifier.OnGuildMemberPlayerStatusChanged(GuildID, PlayerName, prevStatus, curStatus)
	
	if (GuildMemberNotifier.debug) then
		d("|r|c888888 [GuildID:"..GuildID.."][PlayerName:"..PlayerName.."][prevStatus:"..prevStatus.."][curStatus:"..curStatus.."]")
	end

	if (curStatus == PLAYER_STATUS_ONLINE) then
		d(string.format("|r|cFFC700 %s has logged on", PlayerName)
	end

	if (curStatus == PLAYER_STATUS_OFFLINE) then
		d(string.format("|r|cFFC700 %s has logged off", PlayerName)
	end
end

EVENT_MANAGER:RegisterForEvent(GuildMemberNotifier.name, EVENT_ADD_ON_LOADED, GuildMemberNotifier.Initialise)