extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_character_creation_k", true)
	)
	globals.set_cursor_x(1)
	globals.write("You have successfully created your character and your companion's.", "Yellow")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("You are now fully prepared to embark on your quest.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("On the last night before departing, you take a look at", "Yellow")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("your sleeping companion and consider your choices.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.savegame = Savegame.create(globals.character_creation_name, globals.character_creation_sex, globals.character_creation_race, globals.character_creation_background)
		globals.savegame.companion = Character.create(globals.companion_creation_name, globals.companion_creation_sex, globals.companion_creation_race, globals.companion_creation_background)
		globals.event = globals.events.filter(func(n): return n["ID"] == globals.defines["starting_event"])[0]
		globals.savegame.process_effects(globals.event["effects"])
		globals.set_scene("scene_game_event_a", true)
	)
	globals.write("Continue with the plan to venture together")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.savegame = Savegame.create(globals.character_creation_name, globals.character_creation_sex, globals.character_creation_race, globals.character_creation_background)
		globals.event = globals.events.filter(func(n): return n["ID"] == globals.defines["starting_event"])[0]
		globals.savegame.process_effects(globals.event["effects"])
		globals.set_scene("scene_game_event_a", true)
	)
	globals.write("Leave your companion behind and venture alone")
