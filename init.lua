--[[ 

DIRT
mod permettant de creer d'utiliser la terre récoltée dans minetest

Créé par turbogus
licence gpl 2 ou supérieur ( graphisme et code )

]]--

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
	description = "bloc de brick en terre",
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
	description = "Furnace",
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


