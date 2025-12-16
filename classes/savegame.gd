class_name Savegame extends Object

# Flags set in the save game
var flags
# Creation date of the save game
var creation_date
# Player character
var player
# Player companion
var companion
# Player servant
var servant
# Areas unlocked
var areas_discovered
# Sites unlocked
var sites_discovered
# Currently visited area
var current_area
# Did the game finish
var game_finished
# Player party inventory
var inventory

#Initializes a new Savegame from json
static func from_json(dict) -> Savegame:
	var new = Savegame.new()
	new.flags = dict["flags"] if dict.has("flags") else {}
	new.creation_date = dict["creation_date"] if dict.has("creation_date") else null
	new.player = Character.from_json(dict["player"]) if dict.has("player") else null
	new.companion = Character.from_json(dict["companion"]) if dict.has("companion") else null
	new.current_area = dict["current_area"] if dict.has("current_area") else null
	new.game_finished = dict["game_finished"] if dict.has("game_finished") else false
	new.inventory = dict["inventory"] if dict.has("inventory") else {}
	return new

#Initializes a new Savegame
static func create(name, sex, race, background) -> Savegame:
	var new = Savegame.new()
	new.flags = {}
	new.creation_date = Time.get_datetime_dict_from_system()
	new.player = Character.create(name, sex, race, background)
	new.companion = null
	new.areas_discovered = []
	new.sites_discovered = []
	new.game_finished = false
	new.inventory = []
	return new

# Gives the file name for this savegame
func file_name():
	return format_date() + " " + str("%02d" % creation_date["hour"]) + "-" + str("%02d" % creation_date["minute"]) + "-" + str("%02d" % creation_date["second"]) + " " + str(player.name) + "-" + str(player.race) + "-" + str(player.background)

# Gives the file name for this savegame
func format_date():
	return str("%04d" % creation_date["year"]) + "-" + str("%02d" % creation_date["month"]) + "-" + str("%02d" % creation_date["day"])

# Process a list of effects
func process_effects(effects : Array):
	if effects == null: return
	for effect in effects:
		process_effect(effect)

# Processes a single effect
func process_effect(effect):
	if effect == null: return
	if effect.has("type"):
		if effect.has("value"):
			if effect["type"] == "unlock_area":
				areas_discovered.append(effect["value"])
				if current_area == null: current_area = effect["value"] # If no area has been set as current yet, set it to the first one discovered
			elif effect["type"] == "unlock_site":
				sites_discovered.append(effect["value"])
			elif effect["type"] == "set_flag" && effect.has("flag"):
				flags[effect["flag"]] = effect["value"]
		else:
			if effect["type"] == "end_game":
				game_finished = true
