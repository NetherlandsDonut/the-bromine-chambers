extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_character_creation_d", true)
	)
	globals.set_cursor_x(1)
	globals.write("Make sure this information is correct.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Summary")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Name            ")
	globals.write(globals.character_creation_name)
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Sex             ")
	globals.write(globals.character_creation_sex)
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Race            ")
	globals.write(globals.character_creation_race["name"])
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Background      ")
	globals.write(globals.character_creation_background["name"])
	globals.set_cursor_x(1)
	globals.modify_cursor_y(2)
	globals.write_selectable(func():
		globals.savegame = Savegame.create(globals.character_creation_name, globals.character_creation_sex, globals.character_creation_race, globals.character_creation_background)
		globals.event = globals.events.filter(func(n): return n["ID"] == globals.defines["starting_event"])[0]
		globals.savegame.process_effects(globals.event["effects"])
		globals.set_scene("scene_game_event_a", true)
	)
	globals.write("Finish character creation")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.set_scene("scene_game_area_dir_a", true)
	)
	globals.write("Adjust appearance")
	globals.print_stats_raw(globals.character_creation_race, globals.character_creation_background, false)
