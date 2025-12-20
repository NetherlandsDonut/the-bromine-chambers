class_name Combat extends Object

# Turn of the combat
var turn : int
# Friendly participants in the battle
var friends : Array
# Enemies in the battle
var enemies : Array
# Loot yielded from the battle
var loot : Array

#Initializes a new Character
static func create(_enemies : Array) -> Combat:
	var new = Combat.new()
	new.turn = 1
	new.friends = [globals.savegame.player]
	if globals.savegame.companion != null:
		new.friends.append(globals.savegame.companion)
	if globals.savegame.servant != null:
		new.friends.append(globals.savegame.servant)
	new.enemies = _enemies
	var all = []
	all.append_array(new.friends)
	all.append_array(new.enemies)
	all.sort_custom(func(a, b): return a.get_attribute("SPE") < b.get_attribute("SPE"))
	globals.combat_current = all[0]
	return new
