-- Description : 
-- Utilisation de la terre pour creer different bloc et objet

--Créé par : turbogus

--code et graphisme : license gpl v2 ou superieur

--***********
--***********

-- Block de terre :
minetest.register_craft({
	output = 'node "dirt:dirt_block" 1',
	recipe = {
		{'node "default:dirt"', 'node "default:dirt"' },
		{'node "default:dirt"', 'node "default:dirt"' },
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
	drop ='node  "default:dirt" 4',
})

--***********
--***********

-- Brique de terre :
minetest.register_craftitem("dirt:dirt_brick", {
	description = "brique de terre",
	inventory_image = "dirt_brick.png",
})
minetest.register_craft({
	type = "cooking",
	output = "dirt:dirt_brick_rusted",
	recipe = "dirt:dirt_brick",
})
-- Brique de terre cuite :

minetest.register_craftitem("dirt:dirt_brick_rusted", {
	description = "brique de terre cuite",
	inventory_image = "dirt_brick_rusted.png",
})

minetest.register_craft({
	output = 'node "dirt:dirt_brick" 1',
	recipe = {
		{'node "dirt:dirt_block"', 'node "dirt:dirt_block"' },
	}
})

--***********
--***********

-- Block de brique en terre :
minetest.register_craft({
	output = 'node "dirt:dirt_brick_wall" 1',
	recipe = {
		{'node "dirt:dirt_brick_rusted"', 'node "dirt:dirt_brick_rusted"' },
		{'node "dirt:dirt_brick_rusted"', 'node "dirt:dirt_brick_rusted"'},
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
	drop ='node  "dirt:dirt_brick_rusted" 4',
})



--OUTIL : BLOC MOULIN ( pour creer de la glaise à partir de clay_lump et de dirt )
minetest.register_craft({
	output = 'node "dirt:moulin" 1',
	recipe = {
		{'node "default:cobble"', 'node "default:stick"', 'node "default:cobble"' },
		{'node "default:cobble"', 'node "bucket:bucket_water"', 'node "default:cobble' },
		{'node "default:cobble"', 'node "default:cobble"', 'node "default:cobble' },
		}
})
minetest.register_node("dirt:moulin", {
	description = "moulin",
	tiles = {"moulin.png"},
	is_ground_content = false,
	walkable = true,
	pointable = true,
	diggable = true,
	groups = {cracky=2,crumbly=3},
--	sounds = default.node_sound_stone_defaults(),
	drop = "dirt:moulin" ,
})
minetest.register_on_punchnode(function(p, node, player)
	if node.name=="dirt:moulin" and player:get_inventory():contains_item('main', 'default:clay_lump') and player:get_inventory():contains_item('main', 'dirt:dirt_block') then
		player:get_inventory():add_item('main', 'dirt:dirt_clay 12' )
		player:get_inventory():remove_item('main', 'default:clay_lump')
		player:get_inventory():remove_item('main', 'dirt:dirt_block')
	end

end)
--***********
--***********

-- Glaise
minetest.register_craftitem("dirt:dirt_clay", {
	description = "glaise",
	inventory_image = "dirt_clay.png",
})