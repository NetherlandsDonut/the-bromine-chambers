extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_game_equipment_a", true)
	)
	globals.set_cursor_x(1)
	if globals.current_slot == "HEA":
		globals.write("Pick an item to equip on the head.", "Yellow")
	elif globals.current_slot == "CHE":
		globals.write("Pick an item to equip on the chest.", "Yellow")
	elif globals.current_slot == "HAN":
		globals.write("Pick an item to equip on the hands.", "Yellow")
	elif globals.current_slot == "LEG":
		globals.write("Pick an item to equip on the legs.", "Yellow")
	elif globals.current_slot == "MAI":
		globals.write("Pick an item to equip in the main hand.", "Yellow")
	elif globals.current_slot == "OFF":
		globals.write("Pick an item to equip in the off hand.", "Yellow")
	elif globals.current_slot == "RAN":
		globals.write("Pick an item to equip as the ranged weapon.", "Yellow")
	elif globals.current_slot == "ACC":
		globals.write("Pick an accessory to equip.", "Yellow")
	var possible_to_unequip = globals.party_member_viewed.equipment.has(globals.current_slot)
	if possible_to_unequip:
		globals.write(" Choose the current to unequip.", "Yellow")
		globals.set_cursor_x(0)
		globals.modify_cursor_y(1)
		globals.write("-".repeat(80))
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write("Currently equipped")
		globals.set_cursor_x(33)
		globals.write("  D PRT OUTPUT    A DMG OUTPUT", "DimGray")
		globals.set_cursor_x(0)
		globals.modify_cursor_y(1)
		globals.write("-".repeat(80))
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.print_item_for_swap(globals.party_member_viewed.equipment[globals.current_slot], globals.party_member_viewed)
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Available items")
	globals.set_cursor_x(33)
	globals.write("  D PRT OUTPUT    A DMG OUTPUT", "DimGray")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	for item in globals.savegame.inventory.filter(func(n): return (not globals.party_member_viewed.equipment.has(globals.current_slot) || n != globals.party_member_viewed.equipment[globals.current_slot]) && globals.get_item(n)["slot"] == globals.current_slot):
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.print_item_for_swap(item, globals.party_member_viewed)
