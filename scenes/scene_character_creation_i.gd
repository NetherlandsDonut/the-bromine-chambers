extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_character_creation_h", true)
	)
	globals.set_cursor_x(1)
	globals.write("Pick a sex for your companion.", "Yellow")
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
	globals.write_selectable(func():
		globals.companion_creation_sex = "Male"
		if globals.companion_creation_name == "" || globals.companion_creation_name_generated_for != "Male":
			var pool = globals.companion_creation_race["names"][globals.companion_creation_sex]
			globals.companion_creation_name = pool[globals.rand.randi_range(0, pool.size() - 1)]
		globals.set_scene("scene_character_creation_j")
	)
	if globals.last_write_selectable_active:
		globals.companion_creation_sex = "Male"
	globals.write("Male")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.companion_creation_sex = "Female"
		if globals.companion_creation_name == "" || globals.companion_creation_name_generated_for != "Female":
			var pool = globals.companion_creation_race["names"][globals.companion_creation_sex]
			globals.companion_creation_name = pool[globals.rand.randi_range(0, pool.size() - 1)]
		globals.set_scene("scene_character_creation_j")
	)
	if globals.last_write_selectable_active:
		globals.companion_creation_sex = "Female"
	globals.write("Female")
	globals.print_stats_raw(globals.companion_creation_race, globals.companion_creation_background, false)
