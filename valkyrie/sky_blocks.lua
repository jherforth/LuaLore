local S = minetest.get_translator("lualore")

lualore.sky_wings = {}

local active_wings = {}

local wing_types = {
	green = {
		description = "Green Valkyrie Wings",
		texture = "green_valkyrie_wings.png",
		flight_time = 30,
		speed_boost = 1.1,
		color = "#00FF00"
	},
	blue = {
		description = "Blue Valkyrie Wings",
		texture = "blue_valkyrie_wings.png",
		flight_time = 45,
		speed_boost = 1.2,
		color = "#00FFFF"
	},
	violet = {
		description = "Violet Valkyrie Wings",
		texture = "violet_valkyrie_wings.png",
		flight_time = 45,
		speed_boost = 1.35,
		color = "#9000FF"
	},
	gold = {
		description = "Gold Valkyrie Wings",
		texture = "gold_valkyrie_wings.png",
		flight_time = 60,
		speed_boost = 1.5,
		color = "#FFD700"
	}
}

local function update_wing_visual(player, wing_type)
	if not player or not player:is_player() then return end

	local player_name = player:get_player_name()
	local wing_data = wing_types[wing_type]

	if not wing_data then return end

	player:set_properties({
		textures = {"character.png^[multiply:" .. wing_data.color .. ":50"}
	})
end

local function remove_wing_visual(player)
	if not player or not player:is_player() then return end

	player:set_properties({
		textures = {"character.png"}
	})
end

local function activate_wings(player, wing_type)
	if not player or not player:is_player() then return end

	local player_name = player:get_player_name()
	local wing_data = wing_types[wing_type]

	if not wing_data then return end

	if active_wings[player_name] then
		minetest.chat_send_player(player_name, S("Wings already active!"))
		return
	end

	active_wings[player_name] = {
		wing_type = wing_type,
		timer = 0,
		flight_time = wing_data.flight_time
	}

	local privs = minetest.get_player_privs(player_name)
	if not privs.fly then
		privs.fly = true
		minetest.set_player_privs(player_name, privs)
	end

	local physics = player:get_physics_override()
	physics.speed = wing_data.speed_boost
	player:set_physics_override(physics)

	update_wing_visual(player, wing_type)

	minetest.chat_send_player(player_name, S("Wings activated! Flight time: @1 seconds", wing_data.flight_time))
end

local function deactivate_wings(player, player_name)
	if not active_wings[player_name] then return end

	local privs = minetest.get_player_privs(player_name)
	if privs.fly then
		privs.fly = nil
		minetest.set_player_privs(player_name, privs)
	end

	if player and player:is_player() then
		local physics = player:get_physics_override()
		physics.speed = 1.0
		player:set_physics_override(physics)

		remove_wing_visual(player)
	end

	active_wings[player_name] = nil

	if player and player:is_player() then
		minetest.chat_send_player(player_name, S("Wings have expired!"))
	end
end

for wing_type, wing_data in pairs(wing_types) do
	minetest.register_craftitem("lualore:" .. wing_type .. "_wings", {
		description = S(wing_data.description),
		inventory_image = wing_data.texture,
		stack_max = 1,
		on_use = function(itemstack, user, pointed_thing)
			if not user or not user:is_player() then return end

			activate_wings(user, wing_type)
			itemstack:take_item()
			return itemstack
		end
	})
end

minetest.register_globalstep(function(dtime)
	for player_name, wing_data in pairs(active_wings) do
		local player = minetest.get_player_by_name(player_name)

		if not player then
			active_wings[player_name] = nil
		else
			wing_data.timer = wing_data.timer + dtime

			if wing_data.timer >= wing_data.flight_time then
				deactivate_wings(player, player_name)
			else
				local player_pos = player:get_pos()
				local wing_info = wing_types[wing_data.wing_type]

				minetest.add_particlespawner({
					amount = 5,
					time = 0.1,
					minpos = vector.subtract(player_pos, {x=0.3, y=0.5, z=0.3}),
					maxpos = vector.add(player_pos, {x=0.3, y=0.5, z=0.3}),
					minvel = {x=-0.5, y=-1, z=-0.5},
					maxvel = {x=0.5, y=-0.5, z=0.5},
					minacc = {x=0, y=-0.5, z=0},
					maxacc = {x=0, y=-0.5, z=0},
					minexptime = 0.5,
					maxexptime = 1.5,
					minsize = 1,
					maxsize = 2,
					texture = "lualore_particle_star.png^[colorize:" .. wing_info.color .. ":200",
					glow = 10
				})

				if math.floor(wing_data.timer) % 10 == 0 and math.floor(wing_data.timer * 10) % 10 == 0 then
					local remaining = wing_data.flight_time - wing_data.timer
					if remaining <= 10 then
						minetest.chat_send_player(player_name, S("Wings expire in @1 seconds!", math.floor(remaining)))
					end
				end
			end
		end
	end
end)

minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	deactivate_wings(player, player_name)
end)

minetest.register_on_dieplayer(function(player)
	local player_name = player:get_player_name()
	deactivate_wings(player, player_name)
end)

minetest.log("action", "[lualore] Sky wings system loaded")
