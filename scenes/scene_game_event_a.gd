extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	var event = globals.event["ID"]
	for line in globals.event["description"]:
		if line["text"] == "\b":
			globals.set_cursor_x(0)
			globals.write("-".repeat(80))
		else:
			globals.set_cursor_x(1)
			globals.write(line["text"], line["fore"])
		globals.modify_cursor_y(1)
	globals.set_cursor_x(0)
	globals.write("-".repeat(80))
	globals.modify_cursor_y(1)
	for dialog in globals.event["dialogs"]:
		globals.set_cursor_x(1)
		globals.write_selectable(func():
			if dialog.has("effects"): globals.savegame.process_effects(dialog["effects"])
			if globals.event["ID"] == event: globals.event = {}
			if globals.savegame.game_finished: globals.set_scene("scene_game_finished")
			elif globals.event == {}: globals.set_scene("scene_game_a")
		)
		globals.write(dialog["text"])
		globals.modify_cursor_y(1)
