extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_game_b", true)
	)
	globals.set_cursor_x(1)
	var is_this_you = globals.party_member_viewed == globals.savegame.player
	var is_this_your_companion = globals.party_member_viewed == globals.savegame.companion
	globals.write("This is you." if is_this_you else ("This is your companion, " if is_this_your_companion else "This is your servant, ") + globals.party_member_viewed.get_name(), "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Party member actions")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.set_scene("scene_game_equipment_a")
	)
	globals.write("Change equipment")
	if not is_this_you && is_this_your_companion:
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write_selectable(func():
			globals.party_member_viewed = null
			globals.savegame.companion = null
			globals.set_scene("scene_game_b")
		)
		globals.write("Dismiss companion")
	elif not is_this_you && not is_this_your_companion:
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write_selectable(func():
			globals.party_member_viewed = null
			globals.savegame.servant = null
			globals.set_scene("scene_game_b")
		)
		globals.write("Dismiss servant")
