local killTable= LoadResourceFile(GetCurrentResourceName(), "./points.json")


function sendToDiscord(color, name, message, footer)
  local embed = {
        {	
			
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = "**" .. "`".. message .."`" .. "**",
            ["footer"] = {
                ["text"] = footer,
            },
        }
    }

  PerformHttpRequest(Config.Webhooks.WebhookLink, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed, avatar_url = Config.Webhooks.AvatarUrl}), { ['Content-Type'] = 'application/json' })
end



if killTable == nil then
	killTable = {}
else
	killTable = json.decode(killTable)
end



RegisterNetEvent("getyopussy")
AddEventHandler("getyopussy", function()
	local kills
	local steamid  = nil
	local discord  = nil

	for k,v in pairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("steam:")) == "steam:" then
		  steamid = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
		  discord = v
		end
	end

	local found = false

	for i = 1, #killTable do
        if killTable[i]["steam"] == steamid then
			found = true
			kills = killTable[i]["kills"]
        end

    end

	if not found then
		kills = 0
	end

	TriggerClientEvent("updateUI", source, kills)
end)




RegisterNetEvent("addKill")
AddEventHandler("addKill", function(playerId)
	local kills
	local steamid = nil
	local discord = nil

	for k,v in pairs(GetPlayerIdentifiers(playerId))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
          steamid = v
          elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
          discordid = string.sub(v, 9)
          discord = "<@" .. discordid .. ">"
        end
    end
	

	local found = false

	for i = 1, #killTable do
        if killTable[i]["steam"] == steamid then
			found = true
            killTable[i]["kills"] = killTable[i]["kills"] + Config.Points.PointsPerKill
			kills = killTable[i]["kills"]
        end

    end

	if not found then
		killTable[#killTable + 1] = {["steam"] = steamid, ["kills"] = 1}
		kills = 1
	end

	TriggerClientEvent("updateUI", playerId, kills)
	sendToDiscord(8454143, Config.Points.PointsName .. " Added!", "User:" .. "`" .. " " .. discord .. "\n" .. "`" .. Config.Points.PointsName .. ": " .. kills, "discord.gg/kratom")


	-- Deaths down below hoe

	for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
          steamid = v
          elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
          discordid = string.sub(v, 9)
          discord = "<@" .. discordid .. ">"
        end
    end


	found = false

	for i = 1, #killTable do
        if killTable[i]["steam"] == steamid then
			found = true
            killTable[i]["kills"] = killTable[i]["kills"] - Config.Points.PointsPerDeath
			kills = killTable[i]["kills"]
        end

    end

	if not found then
		killTable[#killTable + 1] = {["steam"] = steamid, ["kills"] = - Config.Points.PointsPerDeath}
		kills = - Config.Points.PointsPerDeath
	end

	TriggerClientEvent("updateUI", source, kills)
	if Config.Webhooks.DeathWebhook == true then
		sendToDiscord(8454143, Config.Points.PointsName .. " Removed!", "User:" .. "`" .. " " .. discord .. "\n" .. "`" .. Config.Points.PointsName .. ": " .. kills, "discord.gg/kratom")
	end

	SaveResourceFile(GetCurrentResourceName(), "points.json", json.encode(killTable), -1)
end)



RegisterNetEvent("addDeath")
AddEventHandler("addDeath", function()
	local kills
	local steamid  = nil
	local discord  = nil
	for k,v in pairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("steam:")) == "steam:" then
		  steamid = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
		  discord = v
		end
	end


	local found = false

	for i = 1, #killTable do
        if killTable[i]["steam"] == steamid then
			found = true
            killTable[i]["kills"] = killTable[i]["kills"] - Config.Points.PointsPerDeath
			kills = killTable[i]["kills"]
        end

    end

	if not found then
		killTable[#killTable + 1] = {["steam"] = steamid, ["kills"] = - Config.Points.PointsPerDeath}
		kills = - Config.Points.PointsPerDeath
	end

	TriggerClientEvent("updateUI", source, kills)

	SaveResourceFile(GetCurrentResourceName(), "points.json", json.encode(killTable), -1)
end)



