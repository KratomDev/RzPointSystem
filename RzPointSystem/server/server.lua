local killTable= LoadResourceFile(GetCurrentResourceName(), "./points.json")






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
	local steamid  = nil
	local discord  = nil

	for k,v in pairs(GetPlayerIdentifiers(playerId))do
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
            killTable[i]["kills"] = killTable[i]["kills"] + config.points
			kills = killTable[i]["kills"]
        end

    end

	if not found then
		killTable[#killTable + 1] = {["steam"] = steamid, ["kills"] = 1}
		kills = 1
	end

	TriggerClientEvent("updateUI", playerId, kills)

	SaveResourceFile(GetCurrentResourceName(), "points.json", json.encode(killTable), -1)
end)


RegisterNetEvent("addDeath")
AddEventHandler("addDeath", function(playerId)
	local death
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
	print (steamid)

	local found = false

	for i = 1, #killTable do
        if killTable[i]["steam"] == steamid then
			found = true
            killTable[i]["kills"] = killTable[i]["kills"] - config.DeathPoints
			kills = killTable[i]["kills"]
        end

    end

	if not found then
		killTable[#killTable + 1] = {["steam"] = steamid, ["kills"] = 1}
		kills = 1
	end

	TriggerClientEvent("updateUI", source, kills)

	SaveResourceFile(GetCurrentResourceName(), "points.json", json.encode(killTable), -1)
end)
