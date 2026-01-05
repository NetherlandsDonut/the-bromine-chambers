extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_game_a", true)
	)
	globals.set_cursor_x(1)
	globals.write("There is following loot here.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Loot items")
	globals.set_cursor_x(33)
	globals.write("  D PRT OUTPUT    A DMG IN OUTPUT", "DimGray")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	var tile = globals.savegame.areas[globals.savegame.current_area]["tiles"][globals.savegame.current_position]
	for item in tile["items"]:
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.print_item_for_pickup(item, tile["items"])
