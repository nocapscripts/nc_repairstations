local framework = nil
local Core = nil
local ESX = nil

CreateThread(function()

   if GetResourceState(Config.ESX) == 'starting' or GetResourceState(Config.ESX) == 'started' then 
    framework = "ESX"
    ESX = exports["es_extended"]:getSharedObject()
   end

   if GetResourceState(Config.QBCore) == 'starting' or GetResourceState(Config.QBCore) == 'started' then 
    framework = "QB"
    Core = exports["qb-core"]:GetCoreObject()
   end


end)

CreateThread(function()
    if framework == "QB" then 
        RegisterNetEvent('redux_repair:repairpay', function(RepairPrice)
            local src = source
            local xPlayer = Core.Functions.GetPlayer(src)
            xPlayer.Functions.RemoveMoney("bank", RepairPrice, "Bennys Repair")
        end)
    end

end)

