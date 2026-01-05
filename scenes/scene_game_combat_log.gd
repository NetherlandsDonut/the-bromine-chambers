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
	globals.set_return_action(func():
		globals.set_scene("scene_game_combat_b", true)
	)
	globals.set_cursor_x(1)
	globals.write("Combat in the " + globals.savegame.current_area + ", Round " + str(globals.combat.round))
	globals.set_cursor_x(76)
	globals.write("TAB", "White")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	var lines = globals.combat.log.size() if globals.combat.log.size() < 20 else 20
	for i in range(0, lines):
		globals.set_cursor_x(1)
		globals.modify_cursor_y(1)
		globals.write(globals.combat.log[globals.combat.log.size() - 1 - i], "Yellow")
	globals.set_cursor_x(78)
	globals.write("▲", "Gray")
