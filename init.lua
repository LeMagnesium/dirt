-- Description : 
-- Utilisation de la terre pour creer different bloc et objet

--Créé par : turbogus

--code et graphisme : license gpl v2 ou superieur

--***********
--***********

-- Brique de terre :
minetest.register_craftitem("dirt:dirt_brick", {
	description = "brique de terre",
	inventory_image = "dirt_brick.png",
})

minetest.register_craft({
	output = 'node "dirt:dirt_brick" 1',
	recipe = {
		{'node "default:dirt"', 'node "default:dirt"' },
		{'node "default:dirt"', 'node "default:dirt"'},
	}
})

--***********
--***********

-- Block de brique en terre :
minetest.register_craft({
	output = 'node "dirt:dirt_brick_wall" 1',
	recipe = {
		{'node "dirt:dirt_brick"', 'node "dirt:dirt_brick"' },
		{'node "dirt:dirt_brick"', 'node "dirt:dirt_brick"'},
	}
})

minetest.register_node("dirt:dirt_brick_wall", {
	description = "bloc de brick en terre",
	tiles = {"dirt_brick_wall.png"},
	is_ground_content = false,
	walkable = true,
	pointable = true,
	diggable = true,
	groups = {cracky=2,crumbly=3},
--	sounds = default.node_sound_stone_defaults(),
	drop ='node  "dirt:dirt_brick" 4',
})

--***********
--***********

-- Block de brique en terre :
minetest.register_craft({
	output = 'node "dirt:dirt_block" 1',
	recipe = {
		{'node "default:dirt"', 'node "default:dirt"', 'node "default:dirt"' },
		{'node "default:dirt"', 'node "default:dirt"', 'node "default:dirt"'},
		{'node "default:dirt"', 'node "default:dirt"', 'node "default:dirt"'},
	}
})

minetest.register_node("dirt:dirt_block", {
	description = "bloc de terre",
	tiles = {"dirt_block.png"},
	is_ground_content = false,
	walkable = true,
	pointable = true,
	diggable = true,
	groups = {cracky=2,crumbly=3},
--	sounds = default.node_sound_stone_defaults(),
	
})
