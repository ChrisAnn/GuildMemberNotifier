--[[
	GuildMemberNotifier
	Author: @ChrisAnn
	Thanks to SoulGemsCounter, Combat Log Statistics and XPNotifier for being inspiration
]]


GuildMemberNotifier = {}
GuildMemberNotifier.name = "GuildMemberNotifier"
GuildMemberNotifier.version = "1.1.0"
GuildMemberNotifier.debug = false

GuildMemberNotifier.guildTable = { 
									[1] = true;
									[2] = true;
									[3] = true;
									[4] = true;
									[5] = true;
								}

function GuildMemberNotifier.Initialise(eventCode, addOnName)
	if (addOnName ~= GuildMemberNotifier.name) then return end

	zo_callLater(function() d("Guild Member Notifier Initialised.") end, 4000)
	EVENT_MANAGER:RegisterForEvent(GuildMemberNotifier.name, EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED, GuildMemberNotifier.OnGuildMemberPlayerStatusChanged)
end

function GuildMemberNotifier.OnGuildMemberPlayerStatusChanged(eventCode, guildId, playerName, previousStatus, currentStatus)
	GuildMemberNotifier.Log("[eventCode:"..eventCode.."][guildId:"..guildId.."][playerName:"..playerName.."][previousStatus:"..previousStatus.."][currentStatus:"..currentStatus.."]")

	if (GuildMemberNotifier.guildTable[guildId] == true) then
		if (currentStatus == PLAYER_STATUS_ONLINE  and playerName ~= GetDisplayName()) then
			d(string.format("|r|cFFC700 %s from '%s' has logged on", playerName, GetGuildName(guildId)))
		end

		if (currentStatus == PLAYER_STATUS_OFFLINE) then
			d(string.format("|r|cFFC700 %s from '%s' has logged off", playerName, GetGuildName(guildId)))
		end
	end
end

SLASH_COMMANDS["/gmn"] = function (commands)
	local options = GuildMemberNotifier.SplitSlashOptions(commands)

	if (#options == 0 or options[1] == "help") then
		d("GuildMemberNotifier Help")
		d("Enter '/gmn {guildId} {on|off}'")
		d("eg '/gmn 2 off' to turn off alerts for guild 2")
	else
		local guildId = tonumber(options[1])
		local active = options[2]

		if (guildId ~= nil and (guildId > 0 and guildId <= 5)) then
			GuildMemberNotifier.Log("[guildId:"..guildId.."]")
		else
			d("Unrecognised GuildId. Enter '/gmn help'")
		end

		if (active == 'on') then
			GuildMemberNotifier.guildTable[guildId] = true
			d("Guild Member notifications ON for "..GetGuildName(guildId))
		elseif (active == 'off') then
			GuildMemberNotifier.guildTable[guildId] = false
			d("Guild Member notifications OFF for "..GetGuildName(guildId))
		else
			d("Unrecognised command. Enter '/gmn help'")
			if (active ~= nil) then
				GuildMemberNotifier.Log("[active:"..active.."]")
			end
		end
	end
end

function GuildMemberNotifier.SplitSlashOptions(commands)
	local options = {}
	local searchResult = { string.match(commands,"^(%S*)%s*(.-)$") }
	for i,v in pairs(searchResult) do
		if (v ~= nil and v ~= "") then
			options[i] = string.lower(v)
		end
	end

	return options
end

function GuildMemberNotifier.Log(message)
	if (GuildMemberNotifier.debug) then
		d("|r|c888888 " .. message)
	end
end

EVENT_MANAGER:RegisterForEvent(GuildMemberNotifier.name, EVENT_ADD_ON_LOADED, GuildMemberNotifier.Initialise)
