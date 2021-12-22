AddEventHandler("baseevents:onPlayerKilled", function(killerId, deathData)
  TriggerServerEvent("addKill", killerId)
end)


AddEventHandler("baseevents:onPlayerDied", function(playerId)
  TriggerServerEvent("addDeath", playerId)
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
    displaytext = not displaytext
  end)
end)



Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
    if displaytext == true then
      SetTextFont(Config.Design.Font)
      SetTextColour(Config.Design.R, Config.Design.G, Config.Design.B, 255)
      SetTextScale(Config.Design.ScaleX, Config.Design.ScaleY)
      SetTextEntry("STRING")
      SetTextCentre(true)
      AddTextComponentString(tostring(Config.Points.PointsName .. ": " .. kills))
      DrawText(Config.Design.X, Config.Design.Y)
    end
  end
end)