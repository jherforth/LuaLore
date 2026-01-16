-- wizard_wands.lua
-- Wands for the wizards
-- Wand colors align with wizard colors and are dropped on defeat for the player to use.

local S = minetest.get_translator("lualore")

-- Gold wand tool
minetest.register_tool(modname .. ":goldwand", {
    description = "Gives the power to the player to levitate NPCs",
    inventory_image = "gold_wand.png",  -- wand icon
    groups = {,
    on_use = function()
        return weapon_on_use()  -- 
    end,
})

-- White wand tool
minetest.register_tool(modname .. ":whitewand", {
    description = "Gives the power to the player to make NPCs sick and inflict over time damage",
    inventory_image = "white_wand.png",  -- wand icon
    groups = {,
    on_use = function()
        return weapon_on_use()  -- 
    end,
})

-- Red wand tool
minetest.register_tool(modname .. ":redwand", {
    description = "Gives the power to the player to teleport NPCs",
    inventory_image = "red_wand.png",  -- wand icon
    groups = {,
    on_use = function()
        return weapon_on_use()  -- 
    end,
})

-- Black wand tool
minetest.register_tool(modname .. ":blackwand", {
    description = "Gives the power to the player to blind NPCs and make them not attack",
    inventory_image = "black_wand.png",  -- wand icon
    groups = {,
    on_use = function()
        return weapon_on_use()  -- 
    end,
})
