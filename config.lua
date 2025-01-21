--[[

 ██████╗  ███████╗ ███╗   ██╗ ██████╗ ███████╗ 
 ██╔══██╗ ██╔════╝ ████╗  ██║║██╔════╝██╔════╝ 
 ██████╔╝ █████╗   ██╔██╗ ██║║██║     █████╗   
 ██╔══██╗ ██╔══╝   ██║╚██╗██║║██║     ██╔══╝   
 ██████╔╝ ███████╗ ██║ ╚████║╚██████╗ ███████╗
 ╚═════╝  ╚══════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

]]

Config = {}

-- NPC Configuration
Config.NPC = {
    coords = vector4(-261.7377, -967.7023, 31.2248, 65.7711), -- NPC location (x, y, z, heading)
    model = 'a_m_m_acult_01' -- NPC model
}

-- Package Definitions
Config.Packs = {
    ["pack1"] = {
        label = "Basic Pack", -- Name of the package displayed in the menu
        price = 500, -- Cost of the package in game currency
        items = {
            {name = "hamburger", count = 3}, -- Items included in the package
            {name = "9mm", count = 10}       -- Example item: 10 units of 9mm ammo
        }
    },
    ["pack2"] = {
        label = "Advanced Pack", -- Name of the package displayed in the menu
        price = 1000, -- Cost of the package in game currency
        items = {
            {name = "water", count = 5}, -- Items included in the package
            {name = "9mm", count = 1}    -- Example item: 1 unit of 9mm ammo
        }
    }
}

-- Notification Types for ESX Notifications
Config.Notify = {
    success = 'success', -- Notification type for successful actions
    error = 'error',     -- Notification type for errors
    info = 'info'        -- Notification type for informational messages
}
