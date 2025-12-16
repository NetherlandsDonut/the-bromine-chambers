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
# Accessories of the character
var accessories

#Initializes a new Character from json
static func from_json(dict) -> Character:
	var new = Character.new()
	new.name = dict["name"]
	new.sex = dict["sex"]
	new.race = dict["race"]
	new.background = dict["background"]
	new.equipment = dict["equipment"]
	new.accessories = dict["accessories"]
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
	if _background != null:
		for slot in _background["equipment"]:
			new.equipment[slot] = _background["equipment"][slot]
	new.accessories = []
	return new
	
#Initializes a new Character
static func create_random(_race) -> Character:
	var new = Character.new()
	new.sex = "Male" if globals.rand.randi_range(0, 1) == 0 else "Female"
	var find = globals.races.filter(func(n): return n["name"] == _race)[0]
	new.race = null if find == null else find["name"]
	if find != null && find.has("backgrounds") && find["backgrounds"].size() > 0:
		var random_background = find["backgrounds"][globals.rand.randi_range(0, find["backgrounds"].size() - 1)]
		new.background = random_background["name"]
		new.equipment = {}
		if random_background.has("equipment"):
			for slot in random_background["equipment"]:
				new.equipment[slot] = random_background["equipment"][slot]
		new.accessories = []
	return new

#Gets the name or just the race in case of lack of name
func get_name() -> String:
	return race if name == null else name

#Gets an attribute
func get_attribute(attribute) -> float:
	var amount : float = 0
	var _race = globals.get_race(race)
	if race != null: amount += _race["attributes"][attribute]
	if background != null:
		var _background = globals.get_background(_race, background)
		if _background != null: amount += _background["attributes"][attribute]
	return amount

#Gets a skill
func get_skill(skill) -> float:
	var amount : float = 0
	var _race = globals.get_race(race)
	if race != null: amount += _race["skills"][skill]
	var _background = globals.get_background(_race, background)
	if background != null: amount += _background["skills"][skill]
	return amount

# Checks whether the character has a specific equipment slot
func has_equipment_slot(slot) -> bool:
	var _race = globals.get_race(race)
	return _race != null && _race.has("equipment_slots") && _race["equipment_slots"].has(slot)
	
