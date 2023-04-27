function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end



function Title(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end



function GetRepairPrice1()
	local myVehicle = GetVehiclePedIsIn(PlayerPedId(),false)
	local EngineHealth = GetVehicleEngineHealth(myVehicle)
	local RepairPriceMultiplier = 1
	local RepairPrice = math.random(39,49)
	
	EngineHealth = (EngineHealth - 1000)
	RepairPriceMultiplier = ((EngineHealth - (EngineHealth* 2)) / 100)
	RepairPriceEquals = RepairPrice * RepairPriceMultiplier
	RoundedRepairPrice = math.round(RepairPriceEquals)

	return RoundedRepairPrice
end

function GetRepairPrice2()
	local myVehicle = GetVehiclePedIsIn(PlayerPedId(),false)
	local BodyHealth = GetVehicleBodyHealth(myVehicle)
	local RepairPriceMultiplier = 1
	local RepairPrice = math.random(39,49)
	
	BodyHealth = (BodyHealth - 1000)
	RepairPriceMultiplier = ((BodyHealth - (BodyHealth* 2)) / 100)
	RepairPriceEquals = RepairPrice * RepairPriceMultiplier
	RoundedRepairPrice = math.round(RepairPriceEquals)

	return RoundedRepairPrice
end


function EngineRepair()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local getFuel = GetVehicleFuelLevel(plyVeh)
    local RepairPrice = GetRepairPrice1()

    TriggerServerEvent('ks-repair:repairpay', RepairPrice + 200)

	SetVehicleDirtLevel(plyVeh, 0.0)
    SetVehiclePetrolTankHealth(plyVeh, 4000.0)
    SetVehicleFuelLevel(plyVeh, getFuel)
    SetVehicleEngineHealth(plyVeh, 1000.0)
    SetVehicleEngineOn(plyVeh, false, false, true)
    QBCore.Functions.Notify("Engine Repaired!", "success") 

    
    TriggerEvent('veh.randomDegredation',10,plyVeh,3)
end

function BodyRepair()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local getFuel = GetVehicleFuelLevel(plyVeh)
    local RepairPrice = GetRepairPrice2()

    TriggerServerEvent('ks-repair:repairpay', RepairPrice + 200)

	SetVehicleDirtLevel(plyVeh, 0.0)
    SetVehicleFuelLevel(plyVeh, getFuel)
    SetVehicleFixed(plyVeh)
    SetVehicleDeformationFixed(plyVeh)
    WashDecalsFromVehicle(plyVeh)
    SetVehicleBodyHealth(plyVeh, 1000.0)
    SetVehicleEngineOn(plyVeh, true, true, true)
    QBCore.Functions.Notify("Body Repaired!", "success")
    
end

local function playSoundEffect(soundEffect, volume)
    SendNUIMessage({
        playSoundEffect = true,
        soundEffect = soundEffect,
        volume = volume
    })
end





RegisterNetEvent('ks-repair:client:repair', function()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local veh = GetVehiclePedIsIn(plyPed, false)
    local health = GetVehicleBodyHealth(plyVeh)
    if IsPedInAnyVehicle(plyPed, false) and health < 1000.0 and veh ~= 0 then
        playSoundEffect("wrench", 0.5)
        SetVehicleEngineOn(plyVeh, false, false, true)
        if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
            QBCore.Functions.Progressbar("open_locker_drill", "Engine Repairing...", math.random(10000, 14000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                EngineRepair()
                QBCore.Functions.Progressbar("open_locker_drill", "Body Repairing...", math.random(5000, 7000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    Wait(100)
                    BodyRepair()
                end, function() -- Cancel
                    QBCore.Functions.Notify("Canceled..", "error")
                end)
            end, function() -- Cancel
                QBCore.Functions.Notify("Canceled..", "error")
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
          TriggerEvent('ks-repair:client:repair')
        end
                  
  
      end

      
      local dist2 = #(GetEntityCoords(PlayerPedId()) - Config.Stations[2])
     
      if dist2 < 20 and health < 1000.0 and veh ~= 0 then
  
        Title(Config.Stations[2].x, Config.Stations[2].y, Config.Stations[2].z, "[E] FIX CAR")
        DrawMarker(23, Config.Stations[2].x, Config.Stations[2].y, Config.Stations[2].z - 1.0, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 1.0001, 0, 230, 239, 230, 0, 0, 0, 0)
        if IsControlJustReleased(0,38) then
          TriggerEvent('ks-repair:client:repair')
        end
                  
  
      end


      local dist3 = #(GetEntityCoords(PlayerPedId()) - Config.Stations[3])
     
      if dist3 < 20 and health < 1000.0 and veh ~= 0 then
  
        Title(Config.Stations[3].x, Config.Stations[3].y, Config.Stations[3].z, "[E] FIX CAR")
        DrawMarker(23, Config.Stations[3].x, Config.Stations[3].y, Config.Stations[3].z - 1.0, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 1.0001, 0, 230, 239, 230, 0, 0, 0, 0)
        if IsControlJustReleased(0,38) then
          TriggerEvent('ks-repair:client:repair')
        end
                  
  
      end

      local dist4 = #(GetEntityCoords(PlayerPedId()) - Config.Stations[4])
     
      if dist4 < 20 and health < 1000.0 and veh ~= 0 then
  
        Title(Config.Stations[4].x, Config.Stations[4].y, Config.Stations[4].z, "[E] FIX CAR")
        DrawMarker(23, Config.Stations[4].x, Config.Stations[4].y, Config.Stations[4].z - 1.0, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 1.0001, 0, 230, 239, 230, 0, 0, 0, 0)
        if IsControlJustReleased(0,38) then
          TriggerEvent('ks-repair:client:repair')
        end
                  
  
      end
  
      
    end
  
end)
