class_name Savegame extends Object

# Flags set in the save game
var flags : Dictionary
# Creation date of the save game
var creation_date : Dictionary
# Player character
var player : Character
# Player companion
var companion : Character
# Player servant
var servant : Character
# Areas unlocked
var areas_discovered : Array
# Sites unlocked
var sites_discovered : Array
# Currently visited area
var current_area : String
# Position of the player in the current area
var current_position : int 
# Did the game finish
var game_finished : bool
# Player party inventory
var inventory : Array
# Map of the game
var areas : Dictionary

#Initializes a new Savegame from json
static func from_json(dict : Dictionary) -> Savegame:
	var new = Savegame.new()
	new.flags = dict["flags"] if dict.has("flags") else {}
	new.creation_date = dict["creation_date"] if dict.has("creation_date") else {}
	new.player = Character.from_json(dict["player"]) if dict.has("player") else null
	new.companion = Character.from_json(dict["companion"]) if dict.has("companion") else null
	new.servant = Character.from_json(dict["servant"]) if dict.has("servant") else null
	new.current_area = dict["current_area"] if dict.has("current_area") else null
	new.current_position = dict["current_position"] if dict.has("current_position") else 0
	new.game_finished = dict["game_finished"] if dict.has("game_finished") else false
	new.inventory = dict["inventory"] if dict.has("inventory") else []
	new.areas = dict["areas"] if dict.has("areas") else {}
	return new

#Initializes a new Savegame
static func create(name, sex, race, background) -> Savegame:
	var new = Savegame.new()
	new.flags = {}
	new.creation_date = Time.get_datetime_dict_from_system()
	new.player = Character.create(name, sex, race, background)
	new.companion = null
	new.servant = null
	new.game_finished = false
	new.current_position = -1
	new.inventory = []
	new.areas = {}
	for area in globals.areas:
		var area_name = area["name"]
		new.areas[area_name] = {}
		new.areas[area_name]["size"] = globals.rand.randi_range(area["min_size"], area["max_size"])
		new.areas[area_name]["tiles"] = []
		for i in range(new.areas[area_name]["size"]):
			new.areas[area_name]["tiles"].append({})
			new.areas[area_name]["tiles"][i]["visible"] = false
			new.areas[area_name]["tiles"][i]["explored"] = false
			new.areas[area_name]["tiles"][i]["items"] = []
			new.areas[area_name]["tiles"][i]["remains"] = []
		if area.has("sites"):
			var overall_amount_of_tiles = new.areas[area_name]["tiles"].size()
			for site in area["sites"]:
				var done = false
				while not done:
					var site_rand_pos = int((overall_amount_of_tiles - 1) / 100.0 * globals.rand.randi_range(site["min_%"], site["max_%"]))
					if not new.areas[area_name]["tiles"][site_rand_pos].has("site"):
						print_debug("overall: " + str(overall_amount_of_tiles) + " dropped " + site["name"] + " at " + str(site_rand_pos))
						new.areas[area_name]["tiles"][site_rand_pos]["site"] = {}
						new.areas[area_name]["tiles"][site_rand_pos]["site"]["name"] = site["name"]
						new.areas[area_name]["tiles"][site_rand_pos]["site"]["logo"] = site["logo"]
						if site.has("discovery_event"): new.areas[area_name]["tiles"][site_rand_pos]["site"]["discovery_event"] = site["discovery_event"]
						if site.has("investigate_event"): new.areas[area_name]["tiles"][site_rand_pos]["site"]["investigate_event"] = site["investigate_event"]
						if site.has("connects_bottom"): new.areas[area_name]["tiles"][site_rand_pos]["site"]["connects_bottom"] = site["connects_bottom"]
						if site.has("connects_top"): new.areas[area_name]["tiles"][site_rand_pos]["site"]["connects_top"] = site["connects_top"]
						done = true
		if area.has("tiles"):
			for i in range(new.areas[area_name]["size"]):
				var percentage = 100 / new.areas[area_name]["size"] * i
				var tile = new.areas[area_name]["tiles"][i]
				if not tile.has("site"):
					var possible_fillers = area["tiles"].filter(func(n): return n["min_%"] <= percentage && n["max_%"] >= percentage)
					if possible_fillers.size() > 0:
						var random_filler = possible_fillers[globals.rand.randi_range(0, possible_fillers.size() - 1)]
						new.areas[area_name]["tiles"][i]["site"] = {}
						new.areas[area_name]["tiles"][i]["site"]["name"] = random_filler["name"]
						new.areas[area_name]["tiles"][i]["site"]["logo"] = random_filler["logo"]
						if random_filler.has("discovery_event"): new.areas[area_name]["tiles"][i]["site"]["discovery_event"] = random_filler["discovery_event"]
	return new

# Gives the file name for this savegame
func file_name(): return format_date() + " " + str("%02d" % creation_date["hour"]) + "-" + str("%02d" % creation_date["minute"]) + "-" + str("%02d" % creation_date["second"]) + " " + str(player.name) + "-" + str(player.race) + "-" + str(player.background)

# Gives the file name for this savegame
func format_date(): return str("%04d" % creation_date["year"]) + "-" + str("%02d" % creation_date["month"]) + "-" + str("%02d" % creation_date["day"])

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
			if effect["type"] == "show_event":
				var index = globals.events.find_custom(func(n): return n["ID"] == effect["value"])
				if index >= 0:
					if globals.current_scene_name.contains("event"):
						globals.selection = Vector2i(-1, -1)
					globals.event = globals.events[index]
			elif effect["type"] == "unlock_area":
				areas_discovered.append(effect["value"])
				if current_area == "": current_area = effect["value"]
			elif effect["type"] == "unlock_site":
				var find = areas[current_area]["tiles"].find_custom(func(n): return n.has("site") && n["site"]["name"] == effect["value"])
				areas[current_area]["tiles"][find]["visible"] = true
				areas[current_area]["tiles"][find]["explored"] = true
				if current_position == -1:
					current_position = find
					if areas[current_area]["tiles"].size() > find + 1: areas[current_area]["tiles"][find + 1]["visible"] = true
					if find > 0: areas[current_area]["tiles"][find - 1]["visible"] = true
			elif effect["type"] == "change_area":
				current_area = effect["value"]
				var find = areas[current_area]["tiles"].find_custom(func(n): return n.has("site") && n["site"]["name"] == effect["at"])
				areas[current_area]["tiles"][find]["visible"] = true
				areas[current_area]["tiles"][find]["explored"] = true
				current_position = find
				if areas[current_area]["tiles"].size() > find + 1: areas[current_area]["tiles"][find + 1]["visible"] = true
				if find > 0: areas[current_area]["tiles"][find - 1]["visible"] = true
			elif effect["type"] == "set_flag" && effect.has("flag"):
				flags[effect["flag"]] = effect["value"]
		else:
			if effect["type"] == "end_game":
				game_finished = true
