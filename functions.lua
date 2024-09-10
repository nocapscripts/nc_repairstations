

function Notify(text, type, time)
    if time == nil then time = 10000 end


    if framework == "QB" then
        Core.Functions.Notify(text, type)
    elseif framework == "ESX" then 
        TriggerClientEvent('esx:showNotification', source, text, type, time)
    end

end



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

    TriggerServerEvent('redux_repair:repairpay', RepairPrice + 200)

	SetVehicleDirtLevel(plyVeh, 0.0)
    SetVehiclePetrolTankHealth(plyVeh, 4000.0)
    SetVehicleFuelLevel(plyVeh, getFuel)
    SetVehicleEngineHealth(plyVeh, 1000.0)
    SetVehicleEngineOn(plyVeh, false, false, true)


    Notify("Engine Repaired!", "success")

    
    TriggerEvent('veh.randomDegredation',10,plyVeh,3)
end

function BodyRepair()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local getFuel = GetVehicleFuelLevel(plyVeh)
    local RepairPrice = GetRepairPrice2()

    TriggerServerEvent('redux_repair:repairpay', RepairPrice + 200)

	SetVehicleDirtLevel(plyVeh, 0.0)
    SetVehicleFuelLevel(plyVeh, getFuel)
    SetVehicleFixed(plyVeh)
    SetVehicleDeformationFixed(plyVeh)
    WashDecalsFromVehicle(plyVeh)
    SetVehicleBodyHealth(plyVeh, 1000.0)
    SetVehicleEngineOn(plyVeh, true, true, true)
    Notify("Body Repaired!", "success")
   
    
end

function playSoundEffect(soundEffect, volume)
    SendNUIMessage({
        playSoundEffect = true,
        soundEffect = soundEffect,
        volume = volume
    })
end