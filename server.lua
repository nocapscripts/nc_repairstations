RegisterNetEvent('ks-repair:repairpay', function(RepairPrice)
    local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.RemoveMoney("bank", RepairPrice, "Bennys Repair")
end)