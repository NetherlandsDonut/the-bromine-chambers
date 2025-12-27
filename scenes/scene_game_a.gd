extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_menu_c")
	)
	globals.set_cursor_xy(1, 0)
	globals.write("Continue on your quest or try to return home.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write(globals.savegame.current_area + " ")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.set_scene("scene_game_b")
	)
	globals.write("Manage party")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.set_scene("scene_game_map")
	)
	globals.write("Open map")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	var current_tile = globals.savegame.areas[globals.savegame.current_area]["tiles"][globals.savegame.current_position]
	if current_tile.has("site"):
		globals.write(" " + current_tile["site"]["logo"] + " ", "Black", "LightGray")
		globals.write(" " + current_tile["site"]["name"])
	else:
		globals.write(" -- ", "Black", "Gray")
		globals.write(" Empty tile")
	if current_tile["remains"].size() > 0:
		globals.set_cursor_x(33)
		globals.write("Remains")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	if current_tile.has("site") && current_tile["site"].has("investigate_event"):
		var index = globals.events.find_custom(func(n): return n["ID"] == current_tile["site"]["investigate_event"])
		if index >= 0:
			globals.set_cursor_x(1)
			globals.modify_cursor_y(1)
			globals.write_selectable(func():
					globals.event = globals.events[index]
					globals.set_scene("scene_game_event_a")
			)
			globals.write("Investigate site")
	if current_tile["items"].size() > 0: 
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write_selectable(func():
			globals.combat = Combat.create([Character.create_random("Red Dragon"), Character.create_random("Beastman Skeleton")])
			globals.set_scene("scene_game_loot_a")
		)
		globals.write("Loot items")
	if current_tile["remains"].size() > 0:
		globals.set_cursor_xy(33, 9)
		for remains in current_tile["remains"]:
			globals.write(remains["name"], "Gray")
			globals.write(" " + remains["tier"], "DimGray")
			globals.set_cursor_x(1)
			globals.modify_cursor_y(1)
	globals.set_cursor_xy(1, 18)
	globals.write_selectable(func():
		if globals.savegame.current_position > 0:
			globals.savegame.current_position -= 1
		var new_tile = globals.savegame.areas[globals.savegame.current_area]["tiles"][globals.savegame.current_position]
		if not new_tile["explored"] && new_tile.has("Site") && new_tile["Site"].has("discovery_event"):
			var index = globals.events.find_custom(func(n): return n["ID"] == new_tile["site"]["discovery_event"])
			if index >= 0:
				globals.event = globals.events[index]
				globals.set_scene("scene_game_event_a")
		new_tile["explored"] = true
		if globals.savegame.current_position > 0:
			globals.savegame.areas[globals.savegame.current_area]["tiles"][globals.savegame.current_position - 1]["visible"] = true
	)
	globals.write("Travel left")
	globals.set_cursor_xy(78, 18)
	globals.write_selectable(func():
		if globals.savegame.current_position < globals.savegame.areas[globals.savegame.current_area]["tiles"].size() - 1:
			globals.savegame.current_position += 1
		var new_tile = globals.savegame.areas[globals.savegame.current_area]["tiles"][globals.savegame.current_position]
		if not new_tile["explored"] && new_tile.has("site") && new_tile["site"].has("discovery_event"):
			var index = globals.events.find_custom(func(n): return n["ID"] == new_tile["site"]["discovery_event"])
			if index >= 0:
				globals.event = globals.events[index]
				globals.set_scene("scene_game_event_a")
		new_tile["explored"] = true
		if globals.savegame.current_position < globals.savegame.areas[globals.savegame.current_area]["tiles"].size() - 1:
			globals.savegame.areas[globals.savegame.current_area]["tiles"][globals.savegame.current_position + 1]["visible"] = true
	)
	globals.set_cursor_xy(65, 18)
	globals.write("Travel right")
	globals.set_cursor_xy(0, 19)
	globals.write("-".repeat(80))
	globals.set_cursor_x(0)
	globals.modify_cursor_y(2)
	globals.write("-".repeat(80))
	globals.set_cursor_xy(3, 20)
	for i in range(-7, 8):
		var id = globals.savegame.current_position + i
		if i == -7 && id > 0 && globals.savegame.areas[globals.savegame.current_area]["tiles"][id - 1]["visible"]:
			globals.modify_cursor_x(-2)
			globals.write("←", "Gray")
			globals.modify_cursor_x(1)
		#if i == 0: globals.write("→ ")
		if id >= 0 && id <= globals.savegame.areas[globals.savegame.current_area]["tiles"].size() - 1:
			var tile = globals.savegame.areas[globals.savegame.current_area]["tiles"][id]
			if tile["visible"]:
				if not tile["explored"]: globals.write(" ?? ", "DarkGray", "DimGray")
				elif tile.has("site"):
					globals.write(" " + tile["site"]["logo"] + " ", "Black", "White" if i == 0 else "Gray")
					if tile["site"].has("connects_top") && tile["site"]["connects_top"]:
						globals.modify_cursor_xy(-4, -1)
						globals.write("›")
						globals.write("↕↨", "White" if i == 0 else "Gray")
						globals.write("‹")
						globals.modify_cursor_xy(0, 1)
					if tile["site"].has("connects_bottom") && tile["site"]["connects_bottom"]:
						globals.modify_cursor_xy(-4, 1)
						globals.write("›")
						globals.write("↓↔", "White" if i == 0 else "Gray")
						globals.write("‹")
						globals.modify_cursor_xy(0, -1)
				else: globals.write(" -- ", "Black", "White" if i == 0 else "DarkGray")
			else: globals.write("    ")
		else: globals.write("    ")
		#if i == 0: globals.write(" ←")
		globals.modify_cursor_x(1)
		if i == 7 && id < globals.savegame.areas[globals.savegame.current_area]["tiles"].size() - 2 && globals.savegame.areas[globals.savegame.current_area]["tiles"][id + 1]["visible"]:
			globals.write("→", "Gray")
