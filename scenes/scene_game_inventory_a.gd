extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_game_b", true)
	)
	globals.set_cursor_x(1)
	globals.write("Pick an item from the list to interact with it.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Inventory items")
	globals.set_cursor_x(33)
	globals.write("  D PRT OUTPUT    A DMG OUTPUT", "DimGray")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	for item in globals.savegame.inventory:
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.print_item_from_inventory(item, globals.savegame.player)
