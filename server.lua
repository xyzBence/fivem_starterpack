--[[

 ██████╗  ███████╗ ███╗   ██╗ ██████╗ ███████╗ 
 ██╔══██╗ ██╔════╝ ████╗  ██║║██╔════╝██╔════╝ 
 ██████╔╝ █████╗   ██╔██╗ ██║║██║     █████╗   
 ██╔══██╗ ██╔══╝   ██║╚██╗██║║██║     ██╔══╝   
 ██████╔╝ ███████╗ ██║ ╚████║╚██████╗ ███████╗
 ╚═════╝  ╚══════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

]]

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('itempack:purchasePack')
AddEventHandler('itempack:purchasePack', function(packKey)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local pack = Config.Packs[packKey]


    if not xPlayer then
        print('[ERROR] xPlayer not found!')
        TriggerClientEvent('esx:showNotification', src, 'Error: Could not fetch player data.')
        return
    end


    if not xPlayer.identifier then
        print('[ERROR] Player identifier is nil!')
        TriggerClientEvent('esx:showNotification', src, 'Error: Identification issue.')
        return
    end


    if not pack then
        print('[ERROR] Pack not found: ' .. tostring(packKey))
        TriggerClientEvent('esx:showNotification', src, 'Error: Invalid pack.')
        return
    end


    MySQL.Async.fetchScalar('SELECT COUNT(1) FROM purchased_packs WHERE identifier = @identifier AND pack = @pack', {
        ['@identifier'] = xPlayer.identifier,
        ['@pack'] = packKey
    }, function(exists)
        if exists > 0 then

            print('[INFO] Player already purchased this pack: ' .. xPlayer.identifier)
            TriggerClientEvent('esx:showNotification', src, 'You have already purchased this pack!')
            return
        end


        if xPlayer.getMoney() >= pack.price then
            xPlayer.removeMoney(pack.price)

            -- Add items to the inventory
            for _, item in ipairs(pack.items) do
                xPlayer.addInventoryItem(item.name, item.count)
            end

            -- Save the purchase to the database
            MySQL.Async.execute('INSERT INTO purchased_packs (identifier, pack) VALUES (@identifier, @pack)', {
                ['@identifier'] = xPlayer.identifier,
                ['@pack'] = packKey
            }, function(rowsChanged)
                if rowsChanged > 0 then
                    print('[INFO] Purchase successfully saved: ' .. xPlayer.identifier .. ', Pack: ' .. packKey)
                    TriggerClientEvent('esx:showNotification', src, 'You successfully purchased the pack!')
                else
                    print('[ERROR] Failed to save the purch
