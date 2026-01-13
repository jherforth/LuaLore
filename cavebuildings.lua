local S = minetest.get_translator("lualore")

-- ===================================================================
-- CAVE CASTLE SPAWNING - Simple decoration approach like villages
-- ===================================================================

-- Simple noise parameters for rare spawning
local cave_castle_noise = {
    offset = 0,
    scale = 1,
    spread = {x = 1000, y = 1000, z = 1000},
    seed = 8492,
    octaves = 3,
    persist = 0.5,
    lacunarity = 2.0,
}

-- Register cave castle as a decoration
minetest.register_decoration({
    name = "lualore:cavecastle",
    deco_type = "schematic",
    place_on = {
        "default:stone",
        "default:desert_stone",
        "default:sandstone",
        "default:silver_sandstone",
        "default:desert_sandstone",
        "default:cobble",
        "default:mossycobble",
    },
    sidelen = 80,
    fill_ratio = 0.0001,  -- Very rare
    noise_params = cave_castle_noise,
    y_min = -8000,
    y_max = -20,
    place_offset_y = 0,
    flags = "place_center_x, place_center_z, force_placement, all_floors",
    schematic = minetest.get_modpath("lualore") .. "/schematics/cavecastle.mts",
    rotation = "random",
})

-- Debug command to manually spawn a cave castle
minetest.register_chatcommand("spawn_cavecastle", {
    params = "",
    description = "Spawn a cave castle at your current position (for testing)",
    privs = {server = true},
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local pos = player:get_pos()
        pos.y = math.floor(pos.y)

        local schematic_path = minetest.get_modpath("lualore") .. "/schematics/cavecastle.mts"

        -- Check if file exists
        local file = io.open(schematic_path, "r")
        if not file then
            return false, "Schematic file not found at: " .. schematic_path
        end
        file:close()

        -- Place the schematic directly with same flags as decoration
        local success = minetest.place_schematic(
            pos,
            schematic_path,
            "random",
            nil,
            true,
            "place_center_x, place_center_z, force_placement, all_floors"
        )

        if success then
            return true, "Cave castle spawned at " .. minetest.pos_to_string(pos)
        else
            return false, "Failed to spawn cave castle"
        end
    end,
})

print(S("[MOD] Lualore - Cave castles loaded (decoration spawning)"))
