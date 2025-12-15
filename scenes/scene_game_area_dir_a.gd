extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_character_creation_e", true)
	)
	globals.set_cursor_x(1)
	globals.write("Pick a layer to view corresponding areas or choose Any to view them all.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Layer")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.area_dir_layer = "Any"
		globals.set_scene("scene_game_area_dir_b", true)
	)
	globals.write("Any")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.area_dir_layer = "Surface"
		globals.set_scene("scene_game_area_dir_b", true)
	)
	globals.write("Surface")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.area_dir_layer = "Underground"
		globals.set_scene("scene_game_area_dir_b", true)
	)
	globals.write("Underground")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.area_dir_layer = "Depths"
		globals.set_scene("scene_game_area_dir_b", true)
	)
	globals.write("Depths")
