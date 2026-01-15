local S = minetest.get_translator("lualore")

minetest.register_node("lualore:grasslandbarrel", {
    description = S"Barrel",
    visual_scale = 1,
    mesh = "Grasslandbarrel.b3d",
    tiles = {"texturegrasslandbarrel.png"},
    inventory_image = "agrasslandbarrel.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 1, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 1, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 1, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 1, 0.5}
        }
    },
    sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "cooking",
	output = "default:cobble",
	recipe = "lualore:grasslandbarrel",
})
