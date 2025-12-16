extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.companion_creation_race = {}
		globals.set_scene("scene_character_creation_f", true)
	)
	globals.set_cursor_x(1)
	globals.write("Pick a race for your companion.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Race")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	for race in globals.races_starting:
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write_selectable(func():
			globals.companion_creation_race = race
			globals.set_scene("scene_character_creation_h")
		)
		if globals.last_write_selectable_active:
			globals.companion_creation_race = race
		globals.write(race["name"])
	globals.set_cursor_xy(33, 2)
	globals.write("Description")
	globals.modify_cursor_y(1)
	if globals.companion_creation_race != {}:
		for line in globals.companion_creation_race["description"]:
			globals.set_cursor_x(33)
			globals.modify_cursor_y(1)
			globals.write(line, "Gray")
	globals.print_stats_raw(globals.companion_creation_race, globals.companion_creation_background)
