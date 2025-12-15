extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_game_area_dir_a", true)
	)
	globals.set_cursor_x(1)
	globals.write("Pick a specific area to view additional details.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Area")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	var areas = globals.areas.filter(func(n): return globals.area_dir_layer == "Any" || n.has("layer") && n["layer"] == globals.area_dir_layer)
	for area in areas:
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write_selectable(func():
			globals.set_scene("scene_game_area_dir_c")
		)
		globals.write(area["name"])
	globals.set_cursor_xy(33, 2)
	globals.write("Exploration")
	globals.modify_cursor_y(1)
	for area in areas:
		globals.set_cursor_x(33)
		globals.modify_cursor_y(1)
		globals.write("12 / ?")
	globals.set_cursor_xy(49, 2)
	globals.write("Layer")
	globals.modify_cursor_y(1)
	for area in areas:
		globals.set_cursor_x(49)
		globals.modify_cursor_y(1)
		globals.write(area["layer"])
