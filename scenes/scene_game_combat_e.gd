extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_bars_left(character : Character):
	var title = character.get_name()
	var x = globals.cursor.y
	globals.set_cursor_x(x)
	if character.dead: globals.write("  ")
	elif character.initiative >= 0: globals.write("+" + str(character.initiative), "Gray")
	else: globals.write(str(character.initiative), "Gray")
	globals.modify_cursor_x(1)
	globals.write("[")
	globals.write("*".repeat(3 - character.wounds), "Green" if character.wounds == 0 else ("Yellow" if character.wounds == 1 else "Red"))
	globals.write("*".repeat(character.wounds), "DimGray")
	globals.write("]")
	globals.modify_cursor_x(1)
	globals.write_selectable(func():
		if globals.combat.friends.has(globals.combat_target) != globals.combat.friends.has(globals.combat_current):
			if globals.combat_action == "Melee":
				var weapon = globals.combat_current.get_melee_weapon()
				if weapon.has("IN_cost"): globals.combat_current.initiative -= weapon["IN_cost"]
				var melee_roll = globals.combat_current.roll_melee_damage()
				if globals.roll(roundi(globals.defines["success_table"][str(roundi(globals.combat_target.get_skill("DEF") - globals.combat_current.get_skill("ATT") - (weapon["ATT"] if weapon.has("ATT") else 0)))])):
					globals.combat.damage(globals.combat_current, globals.combat_target, melee_roll, true)
				else:
					globals.combat.log.append(globals.combat_current.get_name() + " missed " + globals.combat_target.get_name() + ".")
			elif globals.combat_action == "Range":
				var weapon = globals.combat_current.get_ranged_weapon()
				if weapon.has("IN_cost"): globals.combat_current.initiative -= weapon["IN_cost"]
				var range_roll = globals.combat_current.roll_range_damage()
				if globals.roll(roundi(globals.defines["success_table"][str(roundi(globals.combat_target.get_skill("DEF") - globals.combat_current.get_skill("ATT") - (weapon["ATT"] if weapon.has("ATT") else 0)))])):
					globals.combat.damage(globals.combat_current, globals.combat_target, range_roll, true)
				else:
					globals.combat.log.append(globals.combat_current.get_name() + " missed " + globals.combat_target.get_name() + ".")
			globals.combat.roll_current_character()
	)
	var this_one_selected = false
	if globals.last_write_selectable_active:
		globals.combat_target = character
		this_one_selected = true
	globals.write("")
	globals.write(title, "Cyan" if this_one_selected else ("White" if globals.combat_current == character else "LightGray"))
	if globals.combat_current == character:
		globals.write(" ◄", "White")
		globals.modify_cursor_x(-2)
	globals.modify_cursor_x(-title.length())
	globals.modify_cursor_y(1)
	var bar_size = character.max_hit_points() / globals.defines["hit_points_per_health_bar_point"]
	var health_percent = 100.0 / character.max_hit_points() * (character.hit_points if character.hit_points >= 0 else 0)
	var healthy_bar_size = ceili(bar_size / 100.0 * health_percent)
	globals.write("▀".repeat(healthy_bar_size), "Green" if character.wounds == 0 else ("Yellow" if character.wounds == 1 else "Red"))
	globals.write("▀".repeat(bar_size - healthy_bar_size), "DimGray")
	
# Draws the scene
static func draw_bars_right(character : Character):
	var title = character.get_name()
	var x = globals.cursor.y
	globals.set_cursor_x(x - 6)
	globals.write_selectable(func():
		if globals.combat.friends.has(globals.combat_target) != globals.combat.friends.has(globals.combat_current):
			if globals.combat_action == "Melee":
				var weapon = globals.combat_current.get_melee_weapon()
				if weapon.has("IN_cost"): globals.combat_current.initiative -= weapon["IN_cost"]
				var melee_roll = globals.combat_current.roll_melee_damage()
				if globals.roll(roundi(globals.defines["success_table"][str(roundi(globals.combat_target.get_skill("DEF") - globals.combat_current.get_skill("ATT") - (weapon["ATT"] if weapon.has("ATT") else 0)))])):
					globals.combat.damage(globals.combat_current, globals.combat_target, melee_roll, true)
				else:
					globals.combat.log.append(globals.combat_current.get_name() + " missed " + globals.combat_target.get_name(true) + ".")
			elif globals.combat_action == "Range":
				var weapon = globals.combat_current.get_ranged_weapon()
				if weapon.has("IN_cost"): globals.combat_current.initiative -= weapon["IN_cost"]
				var range_roll = globals.combat_current.roll_range_damage()
				if globals.roll(roundi(globals.defines["success_table"][str(roundi(globals.combat_target.get_skill("DEF") - globals.combat_current.get_skill("ATT") - (weapon["ATT"] if weapon.has("ATT") else 0)))])):
					globals.combat.damage(globals.combat_current, globals.combat_target, range_roll, true)
				else:
					globals.combat.log.append(globals.combat_current.get_name() + " missed " + globals.combat_target.get_name(true) + ".")
			globals.combat.roll_current_character()
	)
	var this_one_selected = false
	if globals.last_write_selectable_active:
		globals.combat_target = character
		this_one_selected = true
	globals.write("")
	globals.modify_cursor_x(-title.length() - 3)
	if globals.combat_current == character:
		globals.modify_cursor_x(-2)
		globals.write("► ", "White")
	globals.write(title, "Cyan" if this_one_selected else ("White" if globals.combat_current == character else "LightGray"))
	globals.modify_cursor_x(3)
	globals.write("[")
	globals.write("*".repeat(3 - character.wounds), "Green" if character.wounds == 0 else ("Yellow" if character.wounds == 1 else "Red"))
	globals.write("*".repeat(character.wounds), "DimGray")
	globals.write("]")
	globals.modify_cursor_x(1)
	if character.dead: globals.write("  ")
	elif character.initiative >= 0: globals.write("+" + str(character.initiative), "Gray")
	else: globals.write(str(character.initiative), "Gray")
	globals.modify_cursor_y(1)
	var bar_size = character.max_hit_points() / globals.defines["hit_points_per_health_bar_point"]
	var health_percent = 100.0 / character.max_hit_points() * (character.hit_points if character.hit_points >= 0 else 0)
	var healthy_bar_size = ceili(bar_size / 100.0 * health_percent)
	globals.set_cursor_x(x - bar_size - 7)
	globals.write("▀".repeat(healthy_bar_size), "Green" if character.wounds == 0 else ("Yellow" if character.wounds == 1 else "Red"))
	globals.write("▀".repeat(bar_size - healthy_bar_size), "DimGray")

# Draws the scene 
static func draw_scene():
	globals.set_return_action(func():
		globals.set_scene("scene_game_combat_b", true)
	)
	globals.set_cursor_x(1)
	globals.write("Combat in the " + globals.savegame.current_area + ", Round " + str(globals.combat.round))
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	if globals.combat.log.size() > 0: globals.write(globals.combat.log[globals.combat.log.size() - 1], "Yellow")
	else: globals.write("", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_y(4)
	for character in globals.combat.friends:
		globals.set_cursor_x(1)
		draw_bars_left(character)
		globals.modify_cursor_y(1)
	globals.set_cursor_y(4)
	for character in globals.combat.enemies:
		globals.set_cursor_x(75)
		draw_bars_right(character)
		globals.modify_cursor_y(1)
	globals.set_cursor_xy(0, 12)
	globals.write("-".repeat(80))
	globals.set_cursor_xy(1, 13)
	globals.write("Current:")
	globals.set_cursor_x(17)
	globals.write(globals.combat_current.get_name())
	globals.write(" [")
	globals.modify_cursor_x(3)
	globals.write("]")
	globals.modify_cursor_x(-4)
	globals.write("*".repeat(3 - globals.combat_current.wounds), "Green" if globals.combat_current.wounds == 0 else ("Yellow" if globals.combat_current.wounds == 1 else "Red"))
	globals.write("*".repeat(globals.combat_current.wounds), "DimGray")
	globals.modify_cursor_x(2)
	if globals.combat_current.wounds == 0: globals.write("Healthy", "Gray")
	elif globals.combat_current.wounds == 1: globals.write("Injured", "Gray")
	elif globals.combat_current.wounds == 2: globals.write("Wounded", "Gray")
	globals.modify_cursor_x(1)
	var plus = globals.combat_current.overall_hit_points() - globals.combat_current.hit_points
	globals.write(str(globals.combat_current.hit_points) + "/" + str(globals.combat_current.max_hit_points()))
	if plus > 0: globals.write(" +" + str(plus), "Gray")
	globals.set_cursor_xy(0, 15)
	globals.write("-".repeat(80))
	if globals.combat_target != null:
		globals.set_cursor_xy(1, 14)
		globals.write("Target:")
		globals.set_cursor_xy(17, 14)
		if globals.combat_current == globals.combat_target:
			globals.write("-")
		else:
			globals.write(globals.combat_target.get_name())
			globals.write(" [")
			globals.modify_cursor_x(3)
			globals.write("]")
			globals.modify_cursor_x(-4)
			globals.write("*".repeat(3 - globals.combat_target.wounds), "Green" if globals.combat_target.wounds == 0 else ("Yellow" if globals.combat_target.wounds == 1 else "Red"))
			globals.write("*".repeat(globals.combat_target.wounds), "DimGray")
			globals.modify_cursor_x(2)
			if globals.combat_target.wounds == 0: globals.write("Healthy", "Gray")
			elif globals.combat_target.wounds == 1: globals.write("Injured", "Gray")
			elif globals.combat_target.wounds == 2: globals.write("Wounded", "Gray")
			globals.modify_cursor_x(1)
			plus = globals.combat_target.overall_hit_points() - globals.combat_target.hit_points
			globals.write(str(globals.combat_target.hit_points) + "/" + str(globals.combat_target.max_hit_points()))
			if plus > 0: globals.write(" +" + str(plus), "Gray")
		var weapon_used = globals.combat_current.get_melee_weapon() if globals.combat_action == "Melee" else globals.combat_current.get_ranged_weapon()
		globals.set_cursor_x(1)
		globals.modify_cursor_y(2)
		globals.write("Raw damage:")
		globals.set_cursor_x(17)
		var dices = roundi(weapon_used["DMG_dices"])
		var sides = roundi(weapon_used["DMG_sides"])
		var min_dmg = dices
		var max_dmg = dices * (sides + int(globals.combat_current.get_attribute("STR")))
		globals.write(str(min_dmg) + ("-" + str(max_dmg) if min_dmg != max_dmg else ""))
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write("Chance to hit:")
		globals.set_cursor_x(17)
		globals.write(str(roundi(globals.defines["success_table"][str(globals.combat_target.get_skill("DEF") - globals.combat_current.get_skill("ATT"))])) + "%")
		globals.set_cursor_x(33)
		globals.modify_cursor_y(-1)
		var protection = globals.combat_target.protection_values()
		globals.write("Final damage:")
		globals.set_cursor_x(49)
		min_dmg = dices - protection.y
		max_dmg = dices * (sides + int(globals.combat_current.get_attribute("STR"))) - protection.x
		globals.write(str(min_dmg) + ("-" + str(max_dmg) if min_dmg != max_dmg else ""))
		globals.set_cursor_x(33)
		globals.modify_cursor_y(1)
		globals.write("Protection:")
		globals.set_cursor_x(49)
		globals.write(str(protection.x) + ("-" + str(protection.y) if protection.x != protection.y else ""))
		globals.set_cursor_x(0)
		globals.modify_cursor_y(1)
		globals.write("-".repeat(80))
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		if globals.combat_target == globals.combat_current:
			globals.write("Cannot attack yourself.", "Red")
		elif globals.combat.friends.has(globals.combat_target) == globals.combat.friends.has(globals.combat_current):
			globals.write("Cannot attack an ally.", "Red")
