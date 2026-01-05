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
	globals.write(title, "White" if globals.combat_current == character else "LightGray")
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
	globals.modify_cursor_x(-title.length() + 1)
	if globals.combat_current == character:
		globals.modify_cursor_x(-2)
		globals.write("► ", "White")
	globals.write(title, "White" if globals.combat_current == character else "LightGray")
	globals.modify_cursor_x(1)
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
	globals.set_cursor_x(x - bar_size - 5)
	globals.write("▀".repeat(healthy_bar_size), "Green" if character.wounds == 0 else ("Yellow" if character.wounds == 1 else "Red"))
	globals.write("▀".repeat(bar_size - healthy_bar_size), "DimGray")

# Draws the scene
static func draw_scene():
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
	globals.set_cursor_xy(0, 14)
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
	globals.set_cursor_x(1)
	globals.modify_cursor_y(2)
	globals.write(globals.combat_current.get_name(true).replace("the ", "The ") + " is considering " + ("his" if globals.combat_current.sex == "Male" else ("her" if globals.combat_current.sex == "Female" else "their")) + " options...", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		if globals.combat.round > 1 && globals.combat_current.get_melee_weapon().has("ATT"):
			globals.combat_action = "Melee"
		elif globals.combat_current.get_ranged_weapon().has("ATT"):
			globals.combat_action = "Range"
		else:
			globals.combat_action = "Do nothing"
		var alive_targets =  globals.combat.friends.filter(func(n): return not n.dead)
		globals.combat_target = alive_targets[randi_range(0, alive_targets.size() - 1)]
		globals.set_scene("scene_game_combat_g")
	)
	globals.write("Ok")
