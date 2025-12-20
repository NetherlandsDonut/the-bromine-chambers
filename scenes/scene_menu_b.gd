extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		if globals.savegame != null: globals.set_scene("scene_menu_c", true)
		else: globals.set_scene("scene_menu_a", true)
	)
	globals.set_cursor_x(1)
	globals.write("Pick a saved game from the list to load.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Saved games")
	globals.set_cursor_x(33)
	globals.write("Details")
	globals.set_cursor_x(49)
	globals.write("Value")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	var files = globals.list_files_in_directory("Saved Games")
	for file : String in files:
		var save : Savegame = Savegame.from_json(JSON.parse_string(FileAccess.open(globals.dir + "/Saved Games/" + file, FileAccess.READ).get_as_text()))
		if save.game_finished: continue
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write_selectable(func():
			globals.savegame = save
			globals.set_scene("scene_game_a")
		)
		if globals.last_write_selectable_active:
			globals.savegame_temp = save
		if globals.savegame_temp != null:
			globals.write(save.player.name)
			globals.set_cursor_x(1)
	if globals.savegame_temp != null:
		globals.set_cursor_x(33)
		globals.set_cursor_y(4)
		globals.write("Name            ")
		globals.write(globals.savegame_temp.player.name)
		globals.set_cursor_x(33)
		globals.modify_cursor_y(1)
		globals.write("Sex             ")
		globals.write(globals.savegame_temp.player.sex)
		globals.set_cursor_x(33)
		globals.modify_cursor_y(1)
		globals.write("Race            ")
		globals.write(globals.savegame_temp.player.race)
		globals.set_cursor_x(33)
		globals.modify_cursor_y(1)
		globals.write("Background      ")
		globals.write(globals.savegame_temp.player.background)
	globals.set_cursor_xy(59, 21)
	globals.write("a game by Eerie/Luna", "DarkGray")
