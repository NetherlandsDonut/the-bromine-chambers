extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.character_creation_race = null
		globals.set_scene("scene_menu_a", true)
	)
	globals.set_cursor_x(1)
	globals.write("Pick a race for your character.", "Yellow")
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
			globals.character_creation_race = race
			globals.set_scene("scene_character_creation_b")
		)
		if globals.last_write_selectable_active:
			globals.character_creation_race = race
		globals.write(race["name"])
	globals.set_cursor_xy(33, 2)
	globals.write("Description")
	globals.modify_cursor_y(1)
	if globals.character_creation_race != null:
		for line in globals.character_creation_race["description"]:
			globals.set_cursor_x(33)
			globals.modify_cursor_y(1)
			globals.write(line, "Gray")
	globals.print_stats_raw(globals.character_creation_race, globals.character_creation_background)
