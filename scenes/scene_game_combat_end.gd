extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_cursor_x(1)
	if globals.combat_result == "Fled":
		globals.write("Your team successfully escaped from combat.", "Yellow")
	elif globals.combat_result == "Victory":
		globals.write("Your team successfully defeated the enemies.", "Yellow")
	elif globals.combat_result == "Defeat":
		globals.write("Your team was defeated in battle.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.combat = null
		if globals.combat_result == "Defeat": globals.set_scene("scene_game_finished")
		else: globals.set_scene("scene_game_a")
	)
	globals.write("Ok")
