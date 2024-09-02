Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        ESX.TriggerServerCallback("gld_reputationsystem:getInfo",function(info)
            local star
            if info.repsys <= 5 then 
                star = "#one"
            elseif info.repsys > 5 and info.repsys <= 10 then
                star = "#two"
            elseif info.repsys > 10 and info.repsys <= 20 then
                star = "#three"
            elseif info.repsys > 20 and info.repsys <= 30 then
                star = "#four"
            elseif info.repsys > 30 then 
                star = "#five"
            end
            SendNUIMessage({type = "show", repsys = Config.RepSys, value = star})
        end)
    end
end)

RegisterCommand('repsys', function(source, args)
    SendNUIMessage({type = "command"})
	SetNuiFocus(true, true)
end)

RegisterNUICallback('addto', function(data)
    SetNuiFocus(false, false)
    TriggerServerEvent("gld_reputationsystem:add", data.id)
end)

RegisterNUICallback('removefrom', function(data)
    SetNuiFocus(false, false)
    TriggerServerEvent("gld_reputationsystem:removefrom", data.id)
end)

RegisterNUICallback('leaderboard', function(data)
    ESX.TriggerServerCallback('gld_reputationsystem:getData', function(cb)
        local count = 0
        for k, v in pairs(cb) do
            SendNUIMessage({
                message = "add",
                name = v.name:gsub("^%l", string.upper),
                stars = v.repsys,
            })
            count = count + 1
            if count >= 10 then
                break
            end
        end
    end)
end)

RegisterNUICallback("close", function(data)
    SetNuiFocus(false, false)
end)




