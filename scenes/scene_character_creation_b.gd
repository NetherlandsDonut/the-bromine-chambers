extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.character_creation_background = {}
		globals.set_scene("scene_character_creation_a", true)
	)
	globals.set_cursor_x(1)
	globals.write("Pick a background for your character.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Background")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	for background in globals.character_creation_race["backgrounds"]:
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write_selectable(func():
			globals.character_creation_background = background
			globals.set_scene("scene_character_creation_c")
		)
		if globals.last_write_selectable_active:
			globals.character_creation_background = background
		globals.write(background["name"])
	globals.set_cursor_xy(33, 2)
	globals.write("Description")
	globals.set_cursor_x(76)
	globals.write("TAB", "White")
	globals.modify_cursor_y(1)
	if globals.character_creation_background != {}:
		for line in (globals.character_creation_background["equipment_description"] if globals.tab_swap else globals.character_creation_background["description"]):
			globals.set_cursor_x(33)
			globals.modify_cursor_y(1)
			globals.write(line, "Gray")
	globals.print_stats_raw(globals.character_creation_race, globals.character_creation_background, false)
