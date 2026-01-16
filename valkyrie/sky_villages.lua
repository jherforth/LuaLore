local S = minetest.get_translator("lualore")

lualore.sky_villages = {}

local spawned_sky_villages = {}
local storage = minetest.get_mod_storage()

local function load_spawned_villages()
	local data = storage:get_string("spawned_sky_villages")
	if data and data ~= "" then
		spawned_sky_villages = minetest.deserialize(data) or {}
	end
end

local save_timer = 0
minetest.register_globalstep(function(dtime)
	save_timer = save_timer + dtime
	if save_timer >= 60 then
		save_timer = 0
		storage:set_string("spawned_sky_villages", minetest.serialize(spawned_sky_villages))
	end
end)

load_spawned_villages()

function lualore.sky_villages.spawn_sky_folk(fortress_pos, fortress_hash)
	if spawned_sky_villages[fortress_hash] then
		return false
	end

	local spawn_count = math.random(4, 8)
	local spawn_radius = 15

	for i = 1, spawn_count do
		local offset_x = math.random(-spawn_radius, spawn_radius)
		local offset_z = math.random(-spawn_radius, spawn_radius)

		local spawn_pos = vector.add(fortress_pos, {x=offset_x, y=2, z=offset_z})

		local node_below = minetest.get_node_or_nil(vector.subtract(spawn_pos, {x=0, y=1, z=0}))

		if node_below and node_below.name ~= "air" then
			local obj = minetest.add_entity(spawn_pos, "lualore:sky_folk")

			if obj then
				minetest.log("action", "[lualore] Spawned Sky Folk at fortress " .. fortress_hash)
			end
		end
	end

	spawned_sky_villages[fortress_hash] = true
	storage:set_string("spawned_sky_villages", minetest.serialize(spawned_sky_villages))

	return true
end

minetest.register_chatcommand("spawn_skyvillage", {
	params = "",
	description = S("Spawn a full sky village for testing"),
	privs = {give = true},
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, S("Player not found")
		end

		local pos = player:get_pos()
		local fortress_hash = "test_village_" .. tostring(math.random(1000000, 9999999))

		local sky_folk_count = math.random(10, 15)
		for i = 1, sky_folk_count do
			local offset = {
				x = math.random(-20, 20),
				y = 1,
				z = math.random(-20, 20)
			}
			local spawn_pos = vector.add(pos, offset)
			minetest.add_entity(spawn_pos, "lualore:sky_folk")
		end

		local valkyrie_types = {"blue", "violet", "gold", "green"}
		local chosen_type = valkyrie_types[math.random(1, #valkyrie_types)]
		local valkyrie_pos = vector.add(pos, {x=0, y=3, z=0})
		minetest.add_entity(valkyrie_pos, "lualore:" .. chosen_type .. "_valkyrie")

		return true, S("Spawned sky village with @1 Sky Folk and 1 @2 Valkyrie", sky_folk_count, chosen_type)
	end
})

minetest.log("action", "[lualore] Sky villages system loaded")
