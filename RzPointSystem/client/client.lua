AddEventHandler("baseevents:onPlayerKilled", function(killerId, deathData)
  TriggerServerEvent("addKill", killerId)
end)

local kills = 0

RegisterNetEvent("updateUI")
AddEventHandler("updateUI", function(_kills)
  kills = _kills
end)

TriggerServerEvent("getyopussy")

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(3)
    SetTextFont(config.Font)
    SetTextColour(config.R, config.G, config.B, 255)
    SetTextScale(config.ScaleX, config.ScaleY)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(tostring(config.PointsName .. ": " .. kills))
    DrawText(config.X, config.Y)
  end
end)