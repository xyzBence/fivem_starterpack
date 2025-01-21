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

local isNearNPC = false

Citizen.CreateThread(function()
    local npc = Config.NPC
    -- Load NPC model
    RequestModel(npc.model)
    while not HasModelLoaded(npc.model) do
        Citizen.Wait(100)
    end

    -- Spawn the NPC
    local ped = CreatePed(4, npc.model, npc.coords.x, npc.coords.y, npc.coords.z - 1, npc.coords.w, false, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    -- Check player proximity to NPC
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local dist = #(playerCoords - vector3(npc.coords.x, npc.coords.y, npc.coords.z))

        if dist < 3.0 then
            isNearNPC = true
            ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to purchase a package.')
            if IsControlJustReleased(0, 38) then -- "E" key
                OpenPackMenu()
            end
        else
            isNearNPC = false
        end
    end
end)

function OpenPackMenu()
    local elements = {}

    -- Add packages to the menu
    for key, pack in pairs(Config.Packs) do
        table.insert(elements, {
            label = pack.label .. " - $" .. pack.price,
            value = key
        })
    end

    -- Open the ESX menu
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pack_menu', {
        title = 'Packages',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        -- Trigger the server event to purchase the selected pack
        TriggerServerEvent('itempack:purchasePack', data.current.value)
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end

function DrawText3D(x, y, z, text, scale, color)
    SetTextScale(scale, scale)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(color[1], color[2], color[3], color[4])
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    local npc = Config.NPC

    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local dist = #(playerCoords - vector3(npc.coords.x, npc.coords.y, npc.coords.z))

        -- Display the text only if the player is within 5 meters
        if dist < 5.0 then
            DrawText3D(npc.coords.x, npc.coords.y, npc.coords.z + 1.0, "Starter Pack", 0.35, {0, 255, 255, 255})
        end
    end
end)
