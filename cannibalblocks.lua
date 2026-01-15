local S = minetest.get_translator("lualore")

minetest.register_node("lualore:jungleshrine", {
    description = S"Jungle Shrine",
    visual_scale = 1,
    mesh = "jungleshrine.b3d",
    tiles = {"texturejungleshrine.png"},
    inventory_image = "ajungleshrine.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3},
    walkable = false,
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        }
    },
    sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "cooking",
	output = "default:bronzeblock",
	recipe = "lualore:jungleshrine",

})

