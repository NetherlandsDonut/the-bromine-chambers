extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_character_creation_i", true)
	)
	globals.set_cursor_x(1)
	globals.write("Pick a name for your companion", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Sex")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("● Male", "Cyan" if globals.companion_creation_sex == "Male" else "LightGray")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("● Female", "Cyan" if globals.companion_creation_sex == "Female" else "LightGray")
	globals.set_cursor_xy(17, 2)
	globals.write("Name : " + globals.companion_creation_name)
	globals.set_cursor_x(17)
	globals.modify_cursor_y(2)
	globals.write_selectable(func():
		var pool = globals.companion_creation_race["names"][globals.companion_creation_sex]
		globals.companion_creation_name = pool[globals.rand.randi_range(0, pool.size() - 1)]
	)
	globals.write("Generate a new name")
	globals.set_cursor_x(17)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.companion_creation_name = "Guwnos"
	)
	globals.write("Choose a custom name")
	globals.set_cursor_x(17)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.set_scene("scene_character_creation_k")
	)
	globals.write("Confirm name")
	globals.print_stats_raw(globals.companion_creation_race, globals.companion_creation_background, false)
