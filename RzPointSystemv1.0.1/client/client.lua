AddEventHandler("baseevents:onPlayerKilled", function(killerId, deathData)
  TriggerServerEvent("addKill", killerId)
end)


AddEventHandler("baseevents:onPlayerDied", function()
  TriggerServerEvent("addDeath")
end)


local kills = 0

RegisterNetEvent("updateUI")
AddEventHandler("updateUI", function(_kills)
  kills = _kills
end)

TriggerServerEvent("getyopussy")

local displaytext = true



RegisterCommand("display", function()
  Citizen.CreateThread(function()
    if displaytext == true then
      displaytext = false
    elseif displaytext == false then
      displaytext = true
    end
  end)
end)



Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
      if displaytext == true then
      SetTextFont(config.Font)
      SetTextColour(config.R, config.G, config.B, 255)
      SetTextScale(config.ScaleX, config.ScaleY)
      SetTextEntry("STRING")
      SetTextCentre(true)
      AddTextComponentString(tostring(config.PointsName .. ": " .. kills))
      DrawText(config.X, config.Y)
   elseif displaytext == false then
    end
  end
end)