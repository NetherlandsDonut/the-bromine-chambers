extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_game_c", true)
	)
	globals.set_cursor_x(1)
	var is_this_you = globals.party_member_viewed == globals.savegame.player
	var is_this_your_companion = globals.party_member_viewed == globals.savegame.companion
	globals.write("This is your character's equipment." if is_this_you else ("This is your companion's equipment." if is_this_your_companion else "This is your servant's equipment."), "Yellow")
	globals.write(" You can change it freely here.", "Yellow")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("If you want to see the overall change in DEF skill or the overall", "Yellow")
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("PRT your equipment provides you should be looking in the character panel.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	var can_wear_armor = globals.party_member_viewed.has_equipment_slot("HEA") || globals.party_member_viewed.has_equipment_slot("CHE") || globals.party_member_viewed.has_equipment_slot("HAN") || globals.party_member_viewed.has_equipment_slot("LEG")
	if can_wear_armor:
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write("Armor")
		globals.set_cursor_x(33)
		globals.write("  D PRT OUTPUT", "DimGray")
		globals.set_cursor_x(0)
		globals.modify_cursor_y(1)
		globals.write("-".repeat(80))
		if globals.party_member_viewed.has_equipment_slot("HEA"):
			globals.set_cursor_x(1)
			globals.modify_cursor_y(1)
			globals.print_slot("HEA", globals.party_member_viewed)
		if globals.party_member_viewed.has_equipment_slot("CHE"):
			globals.set_cursor_x(1)
			globals.modify_cursor_y(1)
			globals.print_slot("CHE", globals.party_member_viewed)
		if globals.party_member_viewed.has_equipment_slot("HAN"):
			globals.set_cursor_x(1)
			globals.modify_cursor_y(1)
			globals.print_slot("HAN", globals.party_member_viewed)
		if globals.party_member_viewed.has_equipment_slot("LEG"):
			globals.set_cursor_x(1)
			globals.modify_cursor_y(1)
			globals.print_slot("LEG", globals.party_member_viewed)
		globals.set_cursor_x(0)
		globals.modify_cursor_y(1)
		globals.write("-".repeat(80))
	var can_wear_arms = globals.party_member_viewed.has_equipment_slot("MAI") || globals.party_member_viewed.has_equipment_slot("OFF") || globals.party_member_viewed.has_equipment_slot("RAN")
	if can_wear_arms:
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write("Arms")
		globals.set_cursor_x(33)
		globals.write("  D PRT OUTPUT", "DimGray")
		globals.set_cursor_x(49)
		globals.write("  A DMG OUTPUT", "DimGray")
		globals.set_cursor_x(0)
		globals.modify_cursor_y(1)
		globals.write("-".repeat(80))
		if globals.party_member_viewed.has_equipment_slot("MAI"):
			globals.set_cursor_x(1)
			globals.modify_cursor_y(1)
			globals.print_slot("MAI", globals.party_member_viewed)
		if globals.party_member_viewed.has_equipment_slot("MOFF"):
			globals.set_cursor_x(1)
			globals.modify_cursor_y(1)
			globals.print_slot("OFF", globals.party_member_viewed)
		if globals.party_member_viewed.has_equipment_slot("RAN"):
			globals.set_cursor_x(1)
			globals.modify_cursor_y(1)
			globals.print_slot("RAN", globals.party_member_viewed)
		globals.set_cursor_x(0)
		globals.modify_cursor_y(1)
		globals.write("-".repeat(80))
	var can_wear_accessories = globals.party_member_viewed.has_equipment_slot("ACC")
	if can_wear_accessories:
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write("Accessories")
		globals.set_cursor_x(33)
		globals.write("  D PRT OUTPUT", "DimGray")
		globals.set_cursor_x(0)
		globals.modify_cursor_y(1)
		globals.write("-".repeat(80))
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.print_accessory(0, globals.party_member_viewed)
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.print_accessory(1, globals.party_member_viewed)
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.print_accessory(2, globals.party_member_viewed)
