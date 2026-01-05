class_name Combat extends Object

# Round of the combat
var round : int
# Friendly participants in the battle
var friends : Array
# Enemies in the battle
var enemies : Array
# Loot yielded from the battle
var loot : Array
# Log from the overall combat
var log : Array
# Was welcome screen already used
var welcome : bool

#Initializes a new combat 
static func create(_enemies : Array) -> Combat:
	var new = Combat.new()
	new.round = 0
	new.log = []
	new.welcome = false
	new.friends = [globals.savegame.player]
	if globals.savegame.companion != null:
		new.friends.append(globals.savegame.companion)
	if globals.savegame.servant != null:
		new.friends.append(globals.savegame.servant)
	new.enemies = _enemies
	var all = []
	all.append_array(new.friends)
	all.append_array(new.enemies)
	for character in all:
		character.initiative = -1
	new.roll_current_character()
	return new

func roll_current_character():
	if friends.all(func(n): return n.dead):
		globals.combat_result = "Defeat"
		globals.set_scene("scene_game_combat_end")
	elif enemies.all(func(n): return n.dead):
		globals.combat_result = "Victory"
		globals.set_scene("scene_game_combat_end")
	var all = []
	all.append_array(friends)
	all.append_array(enemies)
	all.sort_custom(func(a, b): return a.initiative > b.initiative)
	var max_in = all[0].initiative
	if max_in < 0:
		set_initiatives()
		all.sort_custom(func(a, b): return a.initiative > b.initiative)
		max_in = all[0].initiative
	all = all.filter(func(a): return a.initiative == max_in)
	if all.size() == 0: globals.combat_current = all[0]
	else: globals.combat_current = all[randi_range(0, all.size() - 1)]
	if globals.current_scene_name != "scene_game_combat_end":
		if not welcome:
			welcome = true
			globals.set_scene("scene_game_combat_welcome")
		elif friends.has(globals.combat_current):
			globals.set_scene("scene_game_combat_b")
		else:
			globals.set_scene("scene_game_combat_h")

func chance_of_fleeing() -> int:
	var friends_temp = []
	friends_temp.append_array(friends)
	var enemies_temp = []
	enemies_temp.append_array(enemies)
	friends_temp.sort_custom(func(a, b): return a.get_attribute("SPE") > b.get_attribute("SPE"))
	enemies_temp.sort_custom(func(a, b): return a.get_attribute("SPE") > b.get_attribute("SPE"))
	return globals.defines["fleeing_table"][str(roundi(friends_temp[0].get_attribute("SPE") - enemies_temp[0].get_attribute("SPE")))]

func set_initiatives():
	round += 1
	var all = []
	all.append_array(friends)
	all.append_array(enemies)
	var min_in = 999
	for character in all:
		if not character.dead:
			character.initiative += character.get_attribute("SPE")
			if min_in > character.initiative: min_in = character.initiative
		else: character.initiative = -999
	if min_in < 0: 
		for character in all:
			character.initiative -= min_in

func damage(attacker : Character, receiver : Character, damage : int, include_protection : bool):
	var prot = receiver.protection_values()
	var prot_roll = randi_range(prot.x, prot.y)
	damage -= prot_roll
	if damage < 0: damage = 0
	if damage == 0: globals.combat.log.append(globals.combat_current.get_name(true).replace("the ", "The ") + " dealt no damage to " + globals.combat_target.get_name(true) + ".")
	else:
		receiver.hurt(damage)
		globals.combat.log.append(globals.combat_current.get_name(true).replace("the ", "The ") + " dealt " + str(damage) + " damage to " + globals.combat_target.get_name(true) + ".")
