extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_game_c", true)
	)
	globals.set_cursor_x(1)
	globals.write("Pick a combat power to view it's details.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Known combat powers")
	globals.set_cursor_x(33)
	globals.write("C N S L D B", "DimGray")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	var combat_powers = globals.party_member_viewed.get_powers().filter(func(n): return not n.has("ritual") || not n["ritual"])
	for power in combat_powers:
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write_selectable(func():
			globals.set_scene("scene_game_powers_c")
		)
		globals.write(power["name"])
		globals.set_cursor_x(33)
		if power["skills"].has("CHA"):
			var value = power["skills"]["CHA"]
			globals.write(str(int(value)), "Red" if value > globals.party_member_viewed.get_skill("CHA") else "Green")
		else: globals.write("-", "DarkGray")
		globals.set_cursor_x(35)
		if power["skills"].has("NAT"):
			var value = power["skills"]["NAT"]
			globals.write(str(int(value)), "Red" if value > globals.party_member_viewed.get_skill("NAT") else "Green")
		else: globals.write("-", "DarkGray")
		globals.set_cursor_x(37)
		if power["skills"].has("SOR"):
			var value = power["skills"]["SOR"]
			globals.write(str(int(value)), "Red" if value > globals.party_member_viewed.get_skill("SOR") else "Green")
		else: globals.write("-", "DarkGray")
		globals.set_cursor_x(39)
		if power["skills"].has("LIF"):
			var value = power["skills"]["LIF"]
			globals.write(str(int(value)), "Red" if value > globals.party_member_viewed.get_skill("LIF") else "Green")
		else: globals.write("-", "DarkGray")
		globals.set_cursor_x(41)
		if power["skills"].has("DEA"):
			var value = power["skills"]["DEA"]
			globals.write(str(int(value)), "Red" if value > globals.party_member_viewed.get_skill("DEA") else "Green")
		else: globals.write("-", "DarkGray")
		globals.set_cursor_x(43)
		if power["skills"].has("BLO"):
			var value = power["skills"]["BLO"]
			globals.write(str(int(value)), "Red" if value > globals.party_member_viewed.get_skill("BLO") else "Green")
		else: globals.write("-", "DarkGray")
