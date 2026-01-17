local S = minetest.get_translator("lualore")

lualore.floating_buildings = {}

local sky_fortress_noise = {
	offset = 0,
	scale = 0.001,
	spread = {x = 600, y = 600, z = 600},
	seed = 98534,
	octaves = 3,
	persist = 0.6
}

local sky_house_noise = {
	offset = 0,
	scale = 0.0025,
	spread = {x = 720, y = 720, z = 720},
	seed = 73829,
	octaves = 3,
	persist = 0.5
}

local function register_sky_fortress(params)
	minetest.register_decoration({
		name = "lualore:" .. params.name,
		deco_type = "schematic",
		place_on = {"everness:dirt_with_crystal_grass"},
		sidelen = 80,
		noise_params = sky_fortress_noise,
		biomes = {"everness_crystal_forest"},
		y_min = 500,
		y_max = 31000,

		place_offset_y = -5,
		flags = "place_center_x, place_center_z, force_placement, all_floors",

		height = 0,
		height_max = 0,

		schematic = minetest.get_modpath("lualore") .. "/schematics/" .. params.file,
		rotation = "random",
	})
end

local function register_sky_house(params)
	minetest.register_decoration({
		name = "lualore:" .. params.name,
		deco_type = "schematic",
		place_on = {"everness:dirt_with_crystal_grass"},
		sidelen = 120,
		noise_params = sky_house_noise,
		biomes = {"everness_crystal_forest"},
		y_min = 500,
		y_max = 31000,

		place_offset_y = -5,
		flags = "place_center_x, place_center_z, force_placement, all_floors",

		height = 0,
		height_max = 0,

		schematic = minetest.get_modpath("lualore") .. "/schematics/" .. params.file,
		rotation = "random",
	})
end

register_sky_fortress({name = "skycastle", file = "skycastle.mts"})

register_sky_house({name = "skyhouse1", file = "skyhouse1.mts"})
register_sky_house({name = "skyhouse2", file = "skyhouse2.mts"})
register_sky_house({name = "skyhouse3", file = "skyhouse3.mts"})

minetest.register_on_generated(function(minp, maxp, blockseed)
	if minp.y < 500 then
		return
	end

	local spawn_chance = math.random(1, 100)
	if spawn_chance > 15 then
		return
	end

	local check_pos = {
		x = math.random(minp.x, maxp.x),
		y = math.random(minp.y, maxp.y),
		z = math.random(minp.z, maxp.z)
	}

	local area_min = vector.subtract(check_pos, {x=25, y=10, z=25})
	local area_max = vector.add(check_pos, {x=25, y=10, z=25})

	local crystal_grass_count = 0
	local crystal_grass_positions = {}

	for x = area_min.x, area_max.x do
		for y = area_min.y, area_max.y do
			for z = area_min.z, area_max.z do
				local pos = {x=x, y=y, z=z}
				local node = minetest.get_node_or_nil(pos)

				if node and node.name == "everness:dirt_with_crystal_grass" then
					crystal_grass_count = crystal_grass_count + 1
					table.insert(crystal_grass_positions, pos)
				end
			end
		end
	end

	if crystal_grass_count >= 50 and #crystal_grass_positions > 0 then
		local fortress_pos = crystal_grass_positions[1]
		local fortress_hash = minetest.hash_node_position(fortress_pos)

		minetest.after(3, function()
			if lualore.sky_villages and lualore.sky_villages.spawn_sky_folk then
				lualore.sky_villages.spawn_sky_folk(fortress_pos, fortress_hash)
			end

			if lualore.sky_valkyries then
				local valkyrie_types_list = {"blue", "violet", "gold", "green"}
				local num_valkyries = math.random(2, 5)

				for i = 1, num_valkyries do
					local random_offset = {
						x = math.random(-15, 15),
						y = math.random(5, 15),
						z = math.random(-15, 15)
					}
					local spawn_pos = vector.add(fortress_pos, random_offset)
					local chosen_type = valkyrie_types_list[math.random(1, #valkyrie_types_list)]
					local mob_name = "lualore:" .. chosen_type .. "_valkyrie"

					minetest.add_entity(spawn_pos, mob_name)
					minetest.log("action", "[lualore] Spawned " .. chosen_type .. " Valkyrie at fortress (offset: " ..
						random_offset.x .. "," .. random_offset.y .. "," .. random_offset.z .. ")")
				end
			end
		end)
	end
end)

minetest.log("action", "[lualore] Floating buildings system loaded")
