class_name Character extends Object

# Name of the character
var name
# Sex of the character
var sex
# Race of the character
var race
# Background of the character
var background
# Equipment of the character
var equipment
# Natural equipment of the character
var natural_equipment
# Accessories of the character
var accessories
# Known powers by the character
var known_powers
# Action points in combat
var action_points
# Hit points
var hit_points
# Current amount of wounds
var wounds
# Current amount of initiative
var initiative

#Initializes a new Character from json
static func from_json(dict) -> Character:
	if dict == null: return null
	var new = Character.new()
	new.name = dict["name"]
	new.sex = dict["sex"]
	new.race = dict["race"]
	new.background = dict["background"]
	new.equipment = dict["equipment"]
	new.natural_equipment = dict["natural_equipment"]
	new.accessories = dict["accessories"]
	new.known_powers = dict["known_powers"]
	new.action_points = dict["action_points"]
	new.hit_points = dict["hit_points"]
	new.wounds = dict["wounds"]
	new.initiative = dict["initiative"]
	return new
	
#Initializes a new Character
static func create(_name, _sex, _race, _background) -> Character:
	var new = Character.new()
	if _name == null && _sex != null:
		var pool = _race["names"][_sex]
		new.name = pool[globals.rand.randi_range(0, pool.size() - 1)]
	else: new.name = _name
	new.sex = _sex
	new.race = null if _race == null else _race["name"]
	new.background = null if _background == null else _background["name"]
	new.equipment = {}
	new.natural_equipment = {}
	new.accessories = []
	new.known_powers = []
	if _background != null && _background.has("equipment"):
		for slot in _background["equipment"]:
			new.equipment[slot] = _background["equipment"][slot]
	if _background != null && _background.has("natural_equipment"):
		for slot in _background["natural_equipment"]:
			new.natural_equipment[slot] = _background["natural_equipment"][slot]
	if _background != null && _background.has("powers"):
		for power in _background["powers"]:
			new.known_powers.append(power)
	new.action_points = 3
	new.hit_points = new.max_hit_points()
	new.wounds = 0
	new.initiative = 0
	return new
	
#Initializes a new Character
static func create_random(_race) -> Character:
	var new = Character.new()
	new.sex = "Male" if globals.rand.randi_range(0, 1) == 0 else "Female"
	var find = globals.races.filter(func(n): return n["name"] == _race)[0]
	new.race = null if find == null else find["name"]
	new.equipment = {}
	new.natural_equipment = {}
	new.accessories = []
	new.known_powers = []
	if find != null && find.has("backgrounds") && find["backgrounds"].size() > 0:
		var random_background = find["backgrounds"][globals.rand.randi_range(0, find["backgrounds"].size() - 1)]
		new.background = random_background["name"]
		if random_background.has("equipment"):
			for slot in random_background["equipment"]:
				new.equipment[slot] = random_background["equipment"][slot]
		if random_background.has("natural_equipment"):
			for slot in random_background["natural_equipment"]:
				new.natural_equipment[slot] = random_background["natural_equipment"][slot]
		if random_background.has("powers"):
			for power in random_background["powers"]:
				new.known_powers.append(power)
	new.action_points = 3
	new.hit_points = new.max_hit_points()
	new.wounds = 0
	new.initiative = 0
	return new
	
# Gets how much hit points this character has per wound
func max_hit_points() -> int:
	return (get_attribute("VIT") + 10) * 10

#Gets the name or just the race in case of lack of name
func get_name() -> String:
	return race if name == null else name

#Gets an attribute
func get_attribute(attribute) -> int:
	var amount : int = 0
	var _race = globals.get_race(race)
	if race != null: amount += _race["attributes"][attribute]
	if background != null:
		var _background = globals.get_background(_race, background)
		if _background != null: amount += _background["attributes"][attribute]
	return amount

#Gets a skill
func get_skill(skill) -> int:
	var amount : int = 0
	var _race = globals.get_race(race)
	if race != null: amount += _race["skills"][skill]
	var _background = globals.get_background(_race, background)
	if background != null: amount += _background["skills"][skill]
	return amount

# Checks whether the character has a specific equipment slot
func has_equipment_slot(slot) -> bool:
	var _race = globals.get_race(race)
	return _race != null && _race.has("equipment_slots") && _race["equipment_slots"].has(slot)

# Checks whether the character has a specific equipment slot
func get_powers() -> Array:
	var list = []
	for power_name in known_powers:
		list.append(globals.get_power(power_name))
	return list
	
