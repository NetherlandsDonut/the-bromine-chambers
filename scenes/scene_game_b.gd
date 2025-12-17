extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_game_a", true)
	)
	globals.set_cursor_x(1)
	globals.write("This is the party management screen. All of your companions", "Yellow")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("and servants will be listed here, as well as your party wide actions.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Party members")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.party_member_viewed = globals.savegame.player
		globals.set_scene("scene_game_c")
	)
	globals.write(globals.savegame.player.get_name())
	if globals.savegame.companion != null:
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write_selectable(func():
			globals.party_member_viewed = globals.savegame.companion
			globals.set_scene("scene_game_c")
		)
		globals.write(globals.savegame.companion.get_name())
	if globals.savegame.servant != null:
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write_selectable(func():
			globals.party_member_viewed = globals.savegame.servant
			globals.set_scene("scene_game_c")
		)
		globals.write(globals.savegame.servant.get_name())
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Party actions")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.set_scene("scene_game_inventory_a")
	)
	globals.write("Explore inventory")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		globals.set_scene("scene_game_b")
	)
	globals.write("Camp and rest")
