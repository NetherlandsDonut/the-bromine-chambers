extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_character_creation_e", true)
	)
	globals.set_cursor_x(1)
	globals.write("You have successfully created your character.", "Yellow")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Now, this game does not feature a typical difficulty settings.", "Yellow")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Instead, the game's difficulty is determined by whether you venture", "Yellow")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("alone, or with a companion. If you desire a companion with which you", "Yellow")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("can share the burdens of the upcoming adventures, then do so below.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.savegame = Savegame.create(globals.character_creation_name, globals.character_creation_sex, globals.character_creation_race, globals.character_creation_background)
		globals.event = globals.events.filter(func(n): return n["ID"] == globals.defines["starting_event"])[0]
		globals.savegame.process_effects(globals.event["effects"])
		globals.set_scene("scene_game_event_a", true)
	)
	globals.write("Venture alone")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.set_scene("scene_character_creation_g", true)
	)
	globals.write("Create a companion character")
