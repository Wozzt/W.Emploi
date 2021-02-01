Esx = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('emploie:eboueur')
AddEventHandler('emploie:eboueur', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setJob("garbage", 0)  
end)

RegisterServerEvent('emploie:gopostal')
AddEventHandler('emploie:gopostal', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setJob("gopostal", 0)  
end)
