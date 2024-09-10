framework = nil
Core = nil
ESX = nil

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
        RegisterNetEvent('redux_repair:client:repair', function()
            local plyPed = PlayerPedId()
            local plyVeh = GetVehiclePedIsIn(plyPed, false)
            local veh = GetVehiclePedIsIn(plyPed, false)
            local health = GetVehicleBodyHealth(plyVeh)
            if IsPedInAnyVehicle(plyPed, false) and health < 1000.0 and veh ~= 0 then
                playSoundEffect("wrench", 0.5)
                SetVehicleEngineOn(plyVeh, false, false, true)
                if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
                    Core.Functions.Progressbar("open_locker_drill", "Engine Repairing...", math.random(10000, 14000), false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function() -- Done
                        EngineRepair()
                        Core.Functions.Progressbar("open_locker_drill", "Body Repairing...", math.random(5000, 7000), false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function() -- Done
                            Wait(100)
                            BodyRepair()
                        end, function() -- Cancel
                            Notify("Canceled..", "error")
                        end)
                    end, function() -- Cancel
                        Notify("Canceled..", "error")
                    end, "fa-solid fa-wrench")
                end
            else
                Wait(2000)
            end
            Wait(1)
        end)






        Citizen.CreateThread(function()

            while true do
        
            Citizen.Wait(1)
            
            local plyPed = PlayerPedId()
            local plyVeh = GetVehiclePedIsIn(plyPed, false)
            local veh = GetVehiclePedIsIn(plyPed, false)
            local health = GetVehicleBodyHealth(plyVeh)
        
            local dist = #(GetEntityCoords(PlayerPedId()) - Config.Stations[1])
            
            
            
            if dist < 20 and health < 1000.0 and veh ~= 0 then
        
                Title(Config.Stations[1].x, Config.Stations[1].y, Config.Stations[1].z, "[E] FIX CAR")
                DrawMarker(23, Config.Stations[1].x, Config.Stations[1].y, Config.Stations[1].z - 1.0, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 1.0001, 0, 230, 239, 230, 0, 0, 0, 0)
                if IsControlJustReleased(0,38) then
                    TriggerEvent('redux_repair:client:repair')
                end
                        
        
            end

            
            local dist2 = #(GetEntityCoords(PlayerPedId()) - Config.Stations[2])
            
            if dist2 < 20 and health < 1000.0 and veh ~= 0 then
        
                Title(Config.Stations[2].x, Config.Stations[2].y, Config.Stations[2].z, "[E] FIX CAR")
                DrawMarker(23, Config.Stations[2].x, Config.Stations[2].y, Config.Stations[2].z - 1.0, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 1.0001, 0, 230, 239, 230, 0, 0, 0, 0)
                if IsControlJustReleased(0,38) then
                    TriggerEvent('redux_repair:client:repair')
                end
                        
        
            end


            local dist3 = #(GetEntityCoords(PlayerPedId()) - Config.Stations[3])
            
            if dist3 < 20 and health < 1000.0 and veh ~= 0 then
        
                Title(Config.Stations[3].x, Config.Stations[3].y, Config.Stations[3].z, "[E] FIX CAR")
                DrawMarker(23, Config.Stations[3].x, Config.Stations[3].y, Config.Stations[3].z - 1.0, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 1.0001, 0, 230, 239, 230, 0, 0, 0, 0)
                if IsControlJustReleased(0,38) then
                    TriggerEvent('redux_repair:client:repair')
                end
                        
        
            end

            local dist4 = #(GetEntityCoords(PlayerPedId()) - Config.Stations[4])
            
            if dist4 < 20 and health < 1000.0 and veh ~= 0 then
        
                Title(Config.Stations[4].x, Config.Stations[4].y, Config.Stations[4].z, "[E] FIX CAR")
                DrawMarker(23, Config.Stations[4].x, Config.Stations[4].y, Config.Stations[4].z - 1.0, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 1.0001, 0, 230, 239, 230, 0, 0, 0, 0)
                if IsControlJustReleased(0,38) then
                    TriggerEvent('redux_repair:client:repair')
                end
                        
        
            end
        
            
            end
        
        end)
    end


end)