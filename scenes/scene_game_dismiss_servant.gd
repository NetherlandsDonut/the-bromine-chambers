extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_game_c", true)
	)
	globals.set_cursor_x(1)
	globals.write("Are you sure you want to dismiss your servant?", "Yellow")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("This action is irreversible. You will lose that servant forever.", "Yellow")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.set_scene("scene_game_c", true)
	)
	globals.write("No, keep it")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.party_member_viewed = null
		globals.savegame.servant = null
		globals.set_scene("scene_game_b")
	)
	globals.write("Yes, dismiss it")
