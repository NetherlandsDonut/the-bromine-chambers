extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.companion_creation_background = {}
		globals.set_scene("scene_character_creation_g", true)
	)
	globals.set_cursor_x(1)
	globals.write("Pick a background for your companion.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Background")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	for background in globals.companion_creation_race["backgrounds"]:
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write_selectable(func():
			globals.companion_creation_background = background
			globals.set_scene("scene_character_creation_i")
		)
		if globals.last_write_selectable_active:
			globals.companion_creation_background = background
		globals.write(background["name"])
	globals.set_cursor_xy(33, 2)
	globals.write("Description")
	globals.set_cursor_x(65)
	globals.write("TAB 2/2" if globals.tab_swap else "TAB 1/2", "White")
	globals.modify_cursor_y(1)
	if globals.companion_creation_background != {}:
		for line in (globals.companion_creation_background["equipment_description"] if globals.tab_swap else globals.companion_creation_background["description"]):
			globals.set_cursor_x(33)
			globals.modify_cursor_y(1)
			globals.write(line, "Gray")
	globals.print_stats_raw(globals.companion_creation_race, globals.companion_creation_background, false)
