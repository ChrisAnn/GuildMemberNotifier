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

function GuildMemberNotifier.OnGuildMemberPlayerStatusChanged(eventCode, guildId, playerName, previousStatus, currentStatus)
	
	if (GuildMemberNotifier.debug) then
		d("|r|c888888 [eventCode:"..eventCode.."][guildId:"..guildId.."][playerName:"..playerName.."][previousStatus:"..previousStatus.."][currentStatus:"..currentStatus.."]")
	end

	if (currentStatus == PLAYER_STATUS_ONLINE) then
		d(string.format("|r|cFFC700 %s has logged on", playerName))
	end

	if (currentStatus == PLAYER_STATUS_OFFLINE) then
		d(string.format("|r|cFFC700 %s has logged off", playerName))
	end
end

EVENT_MANAGER:RegisterForEvent(GuildMemberNotifier.name, EVENT_ADD_ON_LOADED, GuildMemberNotifier.Initialise)