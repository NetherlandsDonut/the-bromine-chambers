extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_game_a", true)
	)
	globals.set_cursor_x(1)
	globals.write("This is the game menu.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("The Bromine Chambers")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.set_scene("scene_game_a")
	)
	globals.write("Return to the game")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.set_scene("scene_menu_b")
	)
	globals.write("Load a saved game")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.set_scene("scene_menu_d")
	)
	globals.write("Game settings")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.save_file(globals.savegame, "Saved games", globals.savegame.file_name())
		globals.set_scene("scene_game_a")
	)
	globals.write("Save the game")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.save_file(globals.savegame, "Saved games", globals.savegame.file_name())
		globals.savegame = null
		globals.set_scene("scene_menu_a")
	)
	globals.write("Save the game and return to the menu")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.save_file(globals.savegame, "Saved games", globals.savegame.file_name())
		globals.savegame = null
		globals.get_tree().quit()
	)
	globals.write("Save the game and exit")
	globals.set_cursor_xy(59, 21)
	globals.write("a game by Eerie/Luna", "DarkGray")
