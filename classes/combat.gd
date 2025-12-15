class_name Combat extends Object

# Turn of the combat
var turn
# Friendly participants in the battle
var friends
# Enemies in the battle
var enemies

#Initializes a new Combat from json
static func from_json(dict) -> Combat:
	var new = Combat.new()
	new.turn = dict["turn"]
	new.friends = dict["friends"]
	new.enemies = dict["enemies"]
	return new

#Initializes a new Character
static func create(_friends : Array, _enemies : Array) -> Combat:
	var new = Combat.new()
	new.turn = 1
	new.friends = _friends
	new.enemies = _enemies
	var all = []
	all.append_array(new.friends)
	all.append_array(new.enemies)
	all.sort_custom(func(a, b): return a.get_attribute("SPE") < b.get_attribute("SPE"))
	globals.combat_current = all[0]
	return new
