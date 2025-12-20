extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_game_a", true)
	)
	globals.set_cursor_x(1)
	globals.write("The battle yielded following loot.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Loot items")
	globals.set_cursor_x(33)
	globals.write("  D PRT OUTPUT    A DMG OUTPUT", "DimGray")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	for item in globals.combat.loot:
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.print_item_for_pickup(item, globals.combat.loot)
