--[[ 

DIRT
mod permettant de creer d'utiliser la terre récoltée dans minetest

Créé par turbogus
licence gpl 2 ou supérieur ( graphisme et code )

]]--

--Alias :
minetest.register_alias("dirt:dirt_clay","dirt_clay")
minetest.register_alias("dirt:dirt_block","dirt_block")
minetest.register_alias("dirt:dirt_brick","dirt_brick")
minetest.register_alias("dirt:dirt_brick_rusted","dirt_brick_rusted")
minetest.register_alias("dirt:dirt_brick_wall","dirt_brick_wall")
minetest.register_alias("dirt:moulin","moulin")
minetest.register_alias("dirt:tamis","tamis")
minetest.register_alias("dirt:silex","silex")
minetest.register_alias("dirt:silex_block","silex_block")
minetest.register_alias("dirt:silex_hammer","silex_hammer")

-- Glaise
minetest.register_craftitem("dirt:dirt_clay", {
	description = "glaise",
	inventory_image = "dirt_clay.png",
})

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
	drop ='node  "default:dirt" 4',
})

-- Brique de terre :
minetest.register_craftitem("dirt:dirt_brick", {
	description = "brique de terre",
	inventory_image = "dirt_brick.png",
})

minetest.register_craft({
	output = 'node "dirt:dirt_brick" 1',
	recipe = {
		{'node "dirt:dirt_clay"', 'node "dirt:dirt_clay"' },
	}
})

-- Brique de terre cuite :
minetest.register_craftitem("dirt:dirt_brick_rusted", {
	description = "brique de terre cuite",
	inventory_image = "dirt_brick_rusted.png",
})

minetest.register_craft({
	type = "cooking",
	output = "dirt:dirt_brick_rusted",
	recipe = "dirt:dirt_brick",
})

-- Block de brique en terre :
minetest.register_craft({
	output = 'node "dirt:dirt_brick_wall" 4',
	recipe = {
		{'node "dirt:dirt_brick_rusted"', 'node "dirt:dirt_brick_rusted"' },
		{'node "dirt:dirt_brick_rusted"', 'node "dirt:dirt_brick_rusted"'},
	}
})
minetest.register_node("dirt:dirt_brick_wall", {
	description = "bloc de briques en terre",
	tiles = {"dirt_brick_wall.png"},
	is_ground_content = false,
	walkable = true,
	pointable = true,
	diggable = true,
	groups = {cracky=2,crumbly=3},
	drop ='node  "dirt:dirt_brick_rusted" 4',
})

-- Torchis
minetest.register_craft({
	output = '"dirt:torchis" 4',
	recipe = {
		{"default:papyrus"},
		{"dirt:dirt_clay"},
	}
})

minetest.register_node("dirt:torchis", {
	description = "torchis",
	tiles = {"torchis.png"},
	is_ground_content = false,
	walkable = true,
	pointable = true,
	diggable = true,
	groups = {cracky=2,crumbly=3},
	drop = "dirt:torchis",
})

--OUTiL : BLOC MOULiN ( pour creer de la glaise à partir de clay_lump et de dirt )
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
	drop = "dirt:moulin" ,
})
minetest.register_on_punchnode(function(p, node, player)
	if node.name=="dirt:moulin" and player:get_inventory():contains_item('main', 'default:clay_lump') and player:get_inventory():contains_item('main', 'default:dirt') then
		player:get_inventory():add_item('main', 'dirt:dirt_clay 12' )
		player:get_inventory():remove_item('main', 'default:clay_lump')
		player:get_inventory():remove_item('main', 'default:dirt')
	end

end)

-- FOUR en terre cuite :
minetest.register_craft({
	output = 'dirt:furnace',
	recipe = {
		{'dirt:dirt_brick_rusted', 'dirt:dirt_brick_rusted', 'dirt:dirt_brick_rusted'},
		{'dirt:dirt_brick_rusted', '', 'dirt:dirt_brick_rusted'},
		{'dirt:dirt_brick_rusted', 'dirt:dirt_brick_rusted', 'dirt:dirt_brick_rusted'},
		}
})

	
minetest.register_node("dirt:furnace", {
	description = "Four en brique de terre cuite",
	tiles = {"dirt_furnace_top.png", "dirt_furnace_bottom.png", "dirt_furnace_side.png",
		"dirt_furnace_side.png", "dirt_furnace_side.png", "dirt_furnace_front.png"},
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", default.furnace_inactive_formspec)
		meta:set_string("infotext", "Furnace")
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		elseif not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
})

minetest.register_node("dirt:furnace_active", {
	description = "Furnace",
	tiles = {"dirt_furnace_top.png", "dirt_furnace_bottom.png", "dirt_furnace_side.png",
		"dirt_furnace_side.png", "dirt_furnace_side.png", "dirt_furnace_front_active.png"},
	paramtype2 = "facedir",
	light_source = 8,
	drop = "dirt:furnace",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", default.furnace_inactive_formspec)
		meta:set_string("infotext", "Furnace");
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		elseif not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
})

function hacky_swap_node(pos,name)
	local node = minetest.env:get_node(pos)
	local meta = minetest.env:get_meta(pos)
	local meta0 = meta:to_table()
	if node.name == name then
		return
	end
	node.name = name
	local meta0 = meta:to_table()
	minetest.env:set_node(pos,node)
	meta = minetest.env:get_meta(pos)
	meta:from_table(meta0)
end

minetest.register_abm({
	nodenames = {"dirt:furnace","dirt:furnace_active"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.env:get_meta(pos)
		for i, name in ipairs({
				"fuel_totaltime",
				"fuel_time",
				"src_totaltime",
				"src_time"
		}) do
			if meta:get_string(name) == "" then
				meta:set_float(name, 0.0)
			end
		end

		local inv = meta:get_inventory()

		local srclist = inv:get_list("src")
		local cooked = nil
		
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		
		local was_active = false
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			was_active = true
			meta:set_float("fuel_time", meta:get_float("fuel_time") + 1)
			meta:set_float("src_time", meta:get_float("src_time") + 1)
			if cooked and cooked.item and meta:get_float("src_time") >= cooked.time then
				-- check if there's room for output in "dst" list
				if inv:room_for_item("dst",cooked.item) then
					-- Put result in "dst" list
					inv:add_item("dst", cooked.item)
					-- take stuff from "src" list
					srcstack = inv:get_stack("src", 1)
					srcstack:take_item()
					inv:set_stack("src", 1, srcstack)
				else
					print("Could not insert '"..cooked.item:to_string().."'")
				end
				meta:set_string("src_time", 0)
			end
		end
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			local percent = math.floor(meta:get_float("fuel_time") /
					meta:get_float("fuel_totaltime") * 100)
			meta:set_string("infotext","Furnace active: "..percent.."%")
			hacky_swap_node(pos,"dirt:furnace_active")
			meta:set_string("formspec",
				"size[8,9]"..
				"image[2,2;1,1;dirt_furnace_fire_bg.png^[lowpart:"..
						(100-percent)..":dirt_furnace_fire_fg.png]"..
				"list[current_name;fuel;2,3;1,1;]"..
				"list[current_name;src;2,1;1,1;]"..
				"list[current_name;dst;5,1;2,2;]"..
				"list[current_player;main;0,5;8,4;]")
			return
		end

		local fuel = nil
		local cooked = nil
		local fuellist = inv:get_list("fuel")
		local srclist = inv:get_list("src")
		
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		if fuellist then
			fuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
		end

		if fuel.time <= 0 then
			meta:set_string("infotext","Furnace out of fuel")
			hacky_swap_node(pos,"dirt:furnace")
			meta:set_string("formspec", default.furnace_inactive_formspec)
			return
		end

		if cooked.item:is_empty() then
			if was_active then
				meta:set_string("infotext","Furnace is empty")
				hacky_swap_node(pos,"dirt:furnace")
				meta:set_string("formspec", default.furnace_inactive_formspec)
			end
			return
		end

		meta:set_string("fuel_totaltime", fuel.time)
		meta:set_string("fuel_time", 0)
		
		local stack = inv:get_stack("fuel", 1)
		stack:take_item()
		inv:set_stack("fuel", 1, stack)
	end,
})

--==============================================================================================

--OUTIL : TAMIS ( pour obtenir des silex )
--OUTiL : BLOC MOULiN ( pour creer de la glaise à partir de clay_lump et de dirt )
minetest.register_craft({
	output = 'node "dirt:tamis" 1',
	recipe = {
		{'node "default:tree"', 'node "default:steel_ingot"', 'node "default:tree"' },
		{'node "default:tree"', 'node "default:tree"', 'node "default:tree"' },
		}
})

minetest.register_node("dirt:tamis", {
	description = "tamis - pour recupérer des silex",
	tiles = {"dirt_tamis_dessus_dessous.png", "dirt_tamis_dessus_dessous.png", "dirt_wood.png",
		"dirt_wood.png", "dirt_wood.png", "dirt_wood.png"},
	is_ground_content = false,
	walkable = true,
	pointable = true,
	diggable = true,
	groups = {cracky=2,crumbly=3},
	drop = "dirt:tamis" ,
	
})

--table pour le silex :

local alea = {1,2,3}

minetest.register_on_punchnode(function(p, node, player)
	local nombre1=math.random(1,table.getn(alea))
	local nombre2=math.random(1,table.getn(alea))
	if node.name=="dirt:tamis" and player:get_inventory():contains_item('main', 'default:dirt') and nombre1~=nombre2 then
		player:get_inventory():remove_item('main', 'default:dirt')
	end
	if node.name=="dirt:tamis" and player:get_inventory():contains_item('main', 'default:dirt') and nombre1==nombre2 then
		player:get_inventory():remove_item('main', 'default:dirt')
		player:get_inventory():add_item('main', 'dirt:silex')
	end
end)


--silex
minetest.register_craftitem("dirt:silex", {
	description = "morceau de silex",
	inventory_image = "dirt_silex.png",
})

--silex bloc :
minetest.register_craft({
	output = "dirt:silex_block",
	recipe = {
		{"dirt:silex","dirt:silex","dirt:silex" },
		{"dirt:silex","dirt:silex","dirt:silex"},
		{"dirt:silex","dirt:silex","dirt:silex"},
	}
})
minetest.register_craft({
	output = "dirt:silex 9",
	recipe = {
		{"dirt:silex_block"},
	}
})
minetest.register_node("dirt:silex_block", {
	description = "bloc de silex ( extrement dur )",
	tiles = {"dirt_silex_block.png"},
	is_ground_content = false,
	walkable = true,
	pointable = true,
	diggable = true,
	groups = {cracky=1},
	drop ="dirt:silex_block",
})

--hammer :
minetest.register_craft({
	output = "dirt:silex_hammer",
	recipe = {
		{"dirt:silex_block","default:papyrus","dirt:silex_block" },
		{"","default:stick",""},
		{"","default:stick",""},
	}
})
minetest.register_tool("dirt:silex_hammer", {
	description = "Marteau en silex",
	inventory_image = "dirt_silex_hammer.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})
