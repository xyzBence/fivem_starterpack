# Fivem Starter Pack

This is a FiveM resource designed for **older ESX versions** (e.g., **es_extended 1.2**) that allows players to purchase predefined item packs from an NPC. The script is simple to configure and comes with built-in database support to track purchased packs, ensuring that players cannot repurchase the same pack.

---

## Features
- NPC located at a configurable position.
- Purchase predefined item packs using the in-game currency.
- Real-time database tracking to prevent duplicate purchases.
- Fully integrated with **esx_menu** for an interactive user interface.
- ESX notifications for all interactions (success, error, info).
- Compatibility with older ESX versions like **es_extended 1.2**.

---

## Installation

1. **Download and extract**
   - Place the resource in your `resources` folder (e.g., `starterpack_npc`).

2. **Add to server.cfg**
   - Include the resource in your `server.cfg`:
     ```
     ensure starterpack_npc
     ```

3. **Database setup**
   - Execute the following SQL query in your database to create the necessary table:
     ```sql
     CREATE TABLE IF NOT EXISTS purchased_packs (
         id INT AUTO_INCREMENT PRIMARY KEY,
         identifier VARCHAR(64) NOT NULL,
         pack VARCHAR(50) NOT NULL,
         UNIQUE(identifier, pack)
     );
     ```

4. **Start your server**
   - Restart your server or use the `refresh` and `start` commands to load the script.

---

## Configuration

Edit the `config.lua` file to customize the NPC location, item packs, and notification types.

### Example Configuration
```lua
Config = {}

Config.NPC = {
    coords = vector4(-261.7377, -967.7023, 31.2248, 65.7711),
    model = 'a_m_m_acult_01' -- Change the NPC model here
}

Config.Packs = {
    ["pack1"] = {
        label = "Basic Pack",
        price = 500,
        items = {
            {name = "hamburger", count = 3},
            {name = "9mm", count = 10}
        }
    },
    ["pack2"] = {
        label = "Advanced Pack",
        price = 1000,
        items = {
            {name = "water", count = 5},
            {name = "9mm", count = 1}
        }
    }
}

Config.Notify = {
    success = 'success',
    error = 'error',
    info = 'info'
}
```

---

## Usage

1. Approach the NPC located at the configured position.
2. Press the **E key** to open the package menu.
3. Select a package to purchase.
4. If you have enough money, the items will be added to your inventory, and the purchase will be saved to the database.

---

## Dependencies
- **es_extended 1.2** or older ESX versions.
- **mysql-async** (for database functionality).

---

## Notes
- This script is not compatible with newer ESX versions (e.g., **legacy ESX**).
- Ensure the NPC's coordinates and model are properly configured in `config.lua`.
- Use `refresh` and `start starterpack_npc` if making changes while the server is running.

---

## Support
If you encounter any issues or need help setting up the script, feel free to reach out or consult the official ESX documentation for older versions.

