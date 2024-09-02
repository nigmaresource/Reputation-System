ESX.RegisterServerCallback('gld_reputationsystem:getInfo', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(results)
        if results and #results > 0 then
            cb(results[1])
        else
            cb(nil)
        end
    end)
end)

ESX.RegisterServerCallback('gld_reputationsystem:getData', function(source, cb)
    local data = {}
    MySQL.Async.fetchAll('SELECT * FROM users ORDER BY repsys DESC',{}, function(result)   
        for k, v in pairs(result) do
            local name = v.firstname
            local repsys = v.repsys
            table.insert(data, {name = name, repsys = repsys})
        end
        cb(data)
    end)
end)

RegisterServerEvent('gld_reputationsystem:add', function(data)
    local xPlayer = ESX.GetPlayerFromId(data)
    local identifier = xPlayer.identifier
    local repsys = MySQL.Sync.fetchScalar('SELECT repsys FROM users WHERE identifier = @identifier', {['@identifier'] = identifier})


    Citizen.Wait(1000)

    MySQL.Async.execute('UPDATE users SET repsys = @repsys WHERE identifier = @identifier', {
        ['@identifier'] = identifier, 
        ['@repsys'] = repsys + 1
    })
    
end)

RegisterServerEvent('gld_reputationsystem:removefrom', function(data)
    local xPlayer = ESX.GetPlayerFromId(data)
    local identifier = xPlayer.identifier
    local repsys = MySQL.Sync.fetchScalar('SELECT repsys FROM users WHERE identifier = @identifier', {['@identifier'] = identifier})


    Citizen.Wait(1000)

    MySQL.Async.execute('UPDATE users SET repsys = @repsys WHERE identifier = @identifier', {
        ['@identifier'] = identifier, 
        ['@repsys'] = repsys - 1
    })
    
end)