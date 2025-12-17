extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_game_c", true)
	)
	globals.set_cursor_x(1)
	globals.write("Pick a ritual to view it's details or to perform it at the current location.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Known rituals")
	globals.set_cursor_x(33)
	globals.write("C N S L D B", "DimGray")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	var rituals = globals.party_member_viewed.get_powers().filter(func(n): return n.has("ritual") && n["ritual"])
	for ritual in rituals:
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write_selectable(func():
			globals.set_scene("scene_game_ritual_a")
		)
		globals.write(ritual["name"])
		globals.set_cursor_x(33)
		if ritual["skills"].has("CHA"):
			var value = ritual["skills"]["CHA"]
			globals.write(str(int(value)), "Red" if value > globals.party_member_viewed.get_skill("CHA") else "Green")
		else: globals.write("-", "DarkGray")
		globals.set_cursor_x(35)
		if ritual["skills"].has("NAT"):
			var value = ritual["skills"]["NAT"]
			globals.write(str(int(value)), "Red" if value > globals.party_member_viewed.get_skill("NAT") else "Green")
		else: globals.write("-", "DarkGray")
		globals.set_cursor_x(37)
		if ritual["skills"].has("SOR"):
			var value = ritual["skills"]["SOR"]
			globals.write(str(int(value)), "Red" if value > globals.party_member_viewed.get_skill("SOR") else "Green")
		else: globals.write("-", "DarkGray")
		globals.set_cursor_x(39)
		if ritual["skills"].has("LIF"):
			var value = ritual["skills"]["LIF"]
			globals.write(str(int(value)), "Red" if value > globals.party_member_viewed.get_skill("LIF") else "Green")
		else: globals.write("-", "DarkGray")
		globals.set_cursor_x(41)
		if ritual["skills"].has("DEA"):
			var value = ritual["skills"]["DEA"]
			globals.write(str(int(value)), "Red" if value > globals.party_member_viewed.get_skill("DEA") else "Green")
		else: globals.write("-", "DarkGray")
		globals.set_cursor_x(43)
		if ritual["skills"].has("BLO"):
			var value = ritual["skills"]["BLO"]
			globals.write(str(int(value)), "Red" if value > globals.party_member_viewed.get_skill("BLO") else "Green")
		else: globals.write("-", "DarkGray")
