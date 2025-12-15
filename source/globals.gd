extends Node

#region program_constants
# Screen filter rectangle
var filter : ColorRect
# Random number generator
var rand = RandomNumberGenerator.new()
# Screen size in amount of tiles
var screen_size = [Vector2i(80, 22), Vector2i(80, 22), Vector2i(80, 22), Vector2i(80, 22)]
# Size of each tile in pixels
var tile_size = [Vector2i(10, 18), Vector2i(10, 18), Vector2i(10, 10), Vector2i(10, 10)]
# Distance between each tile on screen
var tile_spacing = [Vector2i(8, 16), Vector2i(8, 16), Vector2i(8, 16), Vector2i(8, 16)]
# Font foregrounds
var foregrounds = [preload("res://fonts/foreground/ibm_vga_fore.png"), preload("res://fonts/foreground/toshiba_sat_fore.png"), preload("res://fonts/foreground/ibm_bios_fore.png"), preload("res://fonts/foreground/ibm_cga_fore.png")]
# Font backgrounds
var backgrounds = [preload("res://fonts/background/ibm_vga_back.png"), preload("res://fonts/background/toshiba_sat_back.png"), preload("res://fonts/background/ibm_bios_back.png"), preload("res://fonts/background/ibm_cga_back.png")]
# Charset available using the fonts
var charset = "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~¡¢£¤¥¦§¨©ª«¬­¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿĀāĂăĄąĆćĈĉĊċČčĎďĐđĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħĨĩĪīĬĭĮįİıĲĳĴĵĶķĸĹĺĻļĽľĿŀŁłŃńŅņŇňŉŊŋŌōŎŏŐőŒœŔŕŖŗŘřŚśŜŝŞşŠšŢţŤťŦŧŨũŪūŬŭŮůŰűŲųŴŵŶŷŸŹźŻżŽžſƒơƷǺǻǼǽǾǿȘșȚțɑɸˆˇˉ˘˙˚˛˜˝;΄΅Ά·ΈΉΊΌΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώϐϴЀЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюяѐёђѓєѕіїјљњћќѝўџҐґ־אבגדהוזחטיךכלםמןנסעףפץצקרשתװױײ׳״ᴛᴦᴨẀẁẂẃẄẅẟỲỳ‐‒–—―‗‘’‚‛“”„‟†‡•…‧‰′″‵‹›‼‾‿⁀⁄⁔⁴⁵⁶⁷⁸⁹⁺⁻ⁿ₁₂₃₄₅₆₇₈₉₊₋₣₤₧₪€℅ℓ№™Ω℮⅐⅑⅓⅔⅕⅖⅗⅘⅙⅚⅛⅜⅝⅞←↑→↓↔↕↨∂∅∆∈∏∑−∕∙√∞∟∩∫≈≠≡≤≥⊙⌀⌂⌐⌠⌡─│┌┐└┘├┤┬┴┼═║╒╓╔╕╖╗╘╙╚╛╜╝╞╟╠╡╢╣╤╥╦╧╨╩╪╫╬▀▁▄█▌▐░▒▓■□▪▫▬▲►▼◄◊○●◘◙◦☺☻☼♀♂♠♣♥♦♪♫✓ﬁﬂ "
# Color palette
var palette = [
	{
		"Red": Color.from_rgba8(200, 111, 111, 255),
		"Orange": Color.from_rgba8(200, 151, 111, 255),
		"Yellow": Color.from_rgba8(200, 191, 111, 255),
		"Green": Color.from_rgba8(118, 200, 111, 255),
		"Cyan": Color.from_rgba8(111, 200, 190, 255),
		"Blue": Color.from_rgba8(111, 181, 200, 255),
		"Navy": Color.from_rgba8(111, 117, 200, 255),
		"Purple": Color.from_rgba8(172, 111, 200, 255),
		"Pink": Color.from_rgba8(200, 111, 197, 255),
		"DarkRed": Color.from_rgba8(133, 51, 51, 255),
		"DarkOrange": Color.from_rgba8(135, 87, 49, 255),
		"DarkYellow": Color.from_rgba8(135, 126, 49, 255),
		"DarkGreen": Color.from_rgba8(56, 135, 49, 255),
		"DarkCyan": Color.from_rgba8(49, 135, 125, 255),
		"DarkBlue": Color.from_rgba8(49, 116, 135, 255),
		"DarkNavy": Color.from_rgba8(49, 55, 135, 255),
		"DarkPurple": Color.from_rgba8(107, 49, 131, 255),
		"DarkPink": Color.from_rgba8(135, 49, 132, 255),
		"White": Color.from_rgba8(204, 204, 204, 255),
		"LightGray": Color.from_rgba8(164, 164, 164, 255),
		"Gray": Color.from_rgba8(124, 124, 124, 255),
		"DarkGray": Color.from_rgba8(84, 84, 84, 255),
		"DimGray": Color.from_rgba8(44, 44, 44, 255),
		"Black": Color.from_rgba8(0, 0, 0, 255),
	},
	{
		"Red": Color.from_rgba8(215, 96, 96, 255),
		"Orange": Color.from_rgba8(215, 150, 96, 255),
		"Yellow": Color.from_rgba8(215, 203, 96, 255),
		"Green": Color.from_rgba8(106, 215, 96, 255),
		"Cyan": Color.from_rgba8(96, 215, 201, 255),
		"Blue": Color.from_rgba8(96, 189, 215, 255),
		"Navy": Color.from_rgba8(96, 104, 215, 255),
		"Purple": Color.from_rgba8(177, 96, 215, 255),
		"Pink": Color.from_rgba8(215, 96, 211, 255),
		"DarkRed": Color.from_rgba8(147, 37, 37, 255),
		"DarkOrange": Color.from_rgba8(147, 86, 37, 255),
		"DarkYellow": Color.from_rgba8(147, 136, 37, 255),
		"DarkGreen": Color.from_rgba8(46, 147, 37, 255),
		"DarkCyan": Color.from_rgba8(37, 147, 134, 255),
		"DarkBlue": Color.from_rgba8(37, 123, 147, 255),
		"DarkNavy": Color.from_rgba8(37, 44, 147, 255),
		"DarkPurple": Color.from_rgba8(112, 37, 143, 255),
		"DarkPink": Color.from_rgba8(147, 37, 143, 255),
		"White": Color.from_rgba8(204, 204, 204, 255),
		"LightGray": Color.from_rgba8(164, 164, 164, 255),
		"Gray": Color.from_rgba8(124, 124, 124, 255),
		"DarkGray": Color.from_rgba8(84, 84, 84, 255),
		"DimGray": Color.from_rgba8(44, 44, 44, 255),
		"Black": Color.from_rgba8(0, 0, 0, 255),
	},
	{
		"Red": Color.from_rgba8(255, 51, 51, 255),
		"Orange": Color.from_rgba8(255, 146, 51, 255),
		"Yellow": Color.from_rgba8(255, 239, 51, 255),
		"Green": Color.from_rgba8(69, 255, 51, 255),
		"Cyan": Color.from_rgba8(51, 255, 235, 255),
		"Blue": Color.from_rgba8(51, 214, 255, 255),
		"Navy": Color.from_rgba8(51, 65, 255, 255),
		"Purple": Color.from_rgba8(193, 51, 255, 255),
		"Pink": Color.from_rgba8(255, 51, 253, 255),
		"DarkRed": Color.from_rgba8(188, 0, 0, 255),
		"DarkOrange": Color.from_rgba8(188, 81, 0, 255),
		"DarkYellow": Color.from_rgba8(188, 169, 0, 255),
		"DarkGreen": Color.from_rgba8(11, 188, 0, 255),
		"DarkCyan": Color.from_rgba8(0, 188, 165, 255),
		"DarkBlue": Color.from_rgba8(0, 146, 188, 255),
		"DarkNavy": Color.from_rgba8(0, 8, 188, 255),
		"DarkPurple": Color.from_rgba8(128, 0, 183, 255),
		"DarkPink": Color.from_rgba8(188, 0, 181, 255),
		"White": Color.from_rgba8(204, 204, 204, 255),
		"LightGray": Color.from_rgba8(164, 164, 164, 255),
		"Gray": Color.from_rgba8(124, 124, 124, 255),
		"DarkGray": Color.from_rgba8(84, 84, 84, 255),
		"DimGray": Color.from_rgba8(44, 44, 44, 255),
		"Black": Color.from_rgba8(0, 0, 0, 255),
	}
]
#endregion

#region game_variables
# Game directory
var dir = "D:/Games/The Bromine Chambers" # OS.get_executable_path().get_base_dir()
# Game content
#var settings = JSON.parse_string(FileAccess.open(dir + "/Data/defines.json", FileAccess.READ).get_as_text())
var defines = JSON.parse_string(FileAccess.open(dir + "/Data/defines.json", FileAccess.READ).get_as_text())
var events = JSON.parse_string(FileAccess.open(dir + "/Data/events.json", FileAccess.READ).get_as_text())
var areas = JSON.parse_string(FileAccess.open(dir + "/Data/areas.json", FileAccess.READ).get_as_text())
var races = JSON.parse_string(FileAccess.open(dir + "/Data/races.json", FileAccess.READ).get_as_text())
var races_starting = races.filter(func(n): return n.has("starting") && n["starting"])
var items = JSON.parse_string(FileAccess.open(dir + "/Data/items.json", FileAccess.READ).get_as_text())
# Character creation variables
var character_creation_name_generated_for = "?"
var character_creation_name = "?"
var character_creation_race
var character_creation_background
var character_creation_sex
var area_dir_layer = "?"
# Combat variables
var combat_current
var combat_target
# Savegame
var savegame
var savegame_temp
# Event
var event

func get_item(item) -> Dictionary:
	return globals.items.filter(func(n): return n["name"] == item)[0]
func get_race(race) -> Dictionary:
	return globals.races.filter(func(n): return n["name"] == race)[0]
func get_background(race : Dictionary, background) -> Dictionary:
	return race["backgrounds"].filter(func(n): return n["name"] == background)[0] if race.has("backgrounds") else {}
#endregion

#region program_variables
# Stores all the selectable tiles
var selectables = []
# Stores all the tiles on the screen
var tiles = []
# Was the last written thing a selectable?
var last_write_selectable = false
# Was the last written thing a selectable and is it active?
var last_write_selectable_active = false
# Saves a file into a folder
func save_file(data, folder, path):
	DirAccess.make_dir_recursive_absolute(dir + "/" + folder + "/")
	var file = FileAccess.open(dir + "/" + folder + "/" + path + ".json", FileAccess.WRITE)
	if file == null: return
	var json_string = JSON.stringify(Serializer.serialize(data), "\t")
	file.store_string(json_string)
	file.close()
# Saves a file into a folder
func list_files_in_directory(folder) -> Array:
	var file_list = []
	var directory = DirAccess.open(dir + "/" + folder + "/")
	if directory:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		while file_name != "":
			if not directory.current_is_dir():
				file_list.append(file_name)
			file_name = directory.get_next()
		directory.list_dir_end()
	return file_list
#endregion

#region user_variables
# Current user settings set
var settings = JSON.parse_string(FileAccess.open(dir + "/Settings/settings.json", FileAccess.READ).get_as_text())
#endregion

#region cursor_and_selection
# Cursor position on the screen
var cursor = Vector2i(0, 0)
# Mofifies the coordinates of the cursor
func modify_cursor_x(i): cursor.y += i
func modify_cursor_y(j): cursor.x += j
func modify_cursor_xy(i, j): cursor += Vector2i(j, i)
# Sets new coordinates for the cursor
func set_cursor_x(i): cursor.y = i
func set_cursor_y(j): cursor.x = j
func set_cursor_xy(i, j): cursor = Vector2i(j, i)
# Selection position on the screen
var selection = Vector2i(-1, -1)
# Was the tab swapped?
var tab_swap = false
#endregion

#region screen_management
# Clears the screen
func clear_screen():
	# Reset the return action
	current_return_action = Callable()
	selectables = []
	for i in range(screen_size[globals.settings["interface_font"]].y):
		set_cursor_xy(0, i)
		for j in range(screen_size[globals.settings["interface_font"]].x):
			write(" ")
	set_cursor_xy(0, 0)
# Processes user's input in the game
func _process(_delta):
	var redraw = false
	if Input.is_action_just_pressed("switch_tab"):
		tab_swap = not tab_swap
		redraw = true
	if selectables.size() > 0:
		if Input.is_action_just_pressed("up"):
			var temp = selectables.filter(func(n): return n[0].x < selection.x)
			temp.sort_custom(func(a, b): return a[0].distance_to(selection) < b[0].distance_to(selection))
			if temp.size() > 0:
				selection = temp[0][0]
				redraw = true
		elif Input.is_action_just_pressed("right"):
			var temp = selectables.filter(func(n): return n[0].y > selection.y)
			temp.sort_custom(func(a, b): return a[0].distance_to(selection) < b[0].distance_to(selection))
			if temp.size() > 0:
				selection = temp[0][0]
				redraw = true
		elif Input.is_action_just_pressed("down"):
			var temp = selectables.filter(func(n): return n[0].x > selection.x)
			temp.sort_custom(func(a, b): return a[0].distance_to(selection) < b[0].distance_to(selection))
			if temp.size() > 0:
				selection = temp[0][0]
				redraw = true
		elif Input.is_action_just_pressed("left"):
			var temp = selectables.filter(func(n): return n[0].y < selection.y)
			temp.sort_custom(func(a, b): return a[0].distance_to(selection) < b[0].distance_to(selection))
			if temp.size() > 0:
				selection = temp[0][0]
				redraw = true
		elif Input.is_action_just_pressed("confirm") && not Input.is_action_just_pressed("ui_toggle_fullscreen"):
			var temp = selectables.filter(func(n): return n[0] == selection)
			if temp.size() > 0:
				temp[0][1].call()
				redraw = true
	if Input.is_action_just_pressed("return"):
		if current_return_action.is_valid():
			current_return_action.call()
			redraw = true
	# If anything was modified, redraw the screen
	# Without this we would be redrawing the screen each frame for no reason
	if redraw: draw_scene()
# Converts a number into a superscript one
func superscript(number : int) -> String:
	if number == 1: return "¹"
	elif number == 2: return "²"
	elif number == 3: return "³"
	elif number == 4: return "⁴"
	elif number == 5: return "⁵"
	elif number == 6: return "⁶"
	elif number == 7: return "⁷"
	elif number == 8: return "⁸"
	elif number == 9: return "⁹"
	else: return "ⁿ"
# Writes a selectable symbol on current position
func write_selectable(action : Callable):
	selectables.append([cursor, action])
	write("● ")
	last_write_selectable = true
	if selection == Vector2i(cursor.x, cursor.y - 2):
		last_write_selectable_active = true
# Writes text at the current position while moving cursor with it
# If the last thing that was written was a selected selectable
# it will automatically use Cyan color for the foreground
func write(text, fore_color = "LightGray", back_color = "Black"):
	for j in range(text.length()):
		if cursor.x < 0 || cursor.x >= tiles.size(): return
		if cursor.y < 0 || cursor.y >= tiles[cursor.x].size(): return
		var index : int = charset.find(text[j])
		if cursor == selection: tiles[cursor.x][cursor.y][1].material.shader = load("res://other/highlight.gdshader")
		else: tiles[cursor.x][cursor.y][1].material.shader = null
		tiles[cursor.x][cursor.y][1].texture = AtlasTexture.new()
		tiles[cursor.x][cursor.y][1].texture.atlas = foregrounds[settings["interface_font"]]
		tiles[cursor.x][cursor.y][1].texture.region = Rect2((index % 58) * tile_size[globals.settings["interface_font"]].x, index / 58 * tile_size[globals.settings["interface_font"]].y, tile_size[globals.settings["interface_font"]].x, tile_size[globals.settings["interface_font"]].y)
		tiles[cursor.x][cursor.y][1].modulate = palette[settings["color_saturation"]]["Cyan" if cursor == selection || last_write_selectable && selectables.size() > 0 && selectables[selectables.size() - 1][0] == selection else fore_color]
		tiles[cursor.x][cursor.y][2].texture = AtlasTexture.new()
		tiles[cursor.x][cursor.y][2].texture.atlas = backgrounds[settings["interface_font"]]
		tiles[cursor.x][cursor.y][2].texture.region = Rect2((index % 58) * tile_size[globals.settings["interface_font"]].x + 1, index / 58 * tile_size[globals.settings["interface_font"]].y + 1, tile_size[globals.settings["interface_font"]].x, tile_size[globals.settings["interface_font"]].y)
		tiles[cursor.x][cursor.y][2].modulate = palette[settings["color_saturation"]][back_color]
		cursor.y += 1
	last_write_selectable = false
	last_write_selectable_active = false
# Prints an attribute and it's value
func print_attribute(attribute : String, character, rounded : bool = true):
	write(attribute + ": ")
	var value = character.get_attribute(attribute)
	write(("+" if value >= 0 else "") + str(roundi(value)) if rounded else str(value), "Red" if value < 0 else ("Green" if value > 0 else "Gray"))
# Prints an attribute and it's value in character creation
func print_attribute_raw(attribute : String, race, background, rounded : bool = true):
	write(attribute + ": ")
	var value : float = 0
	if race != null: value += race["attributes"][attribute]
	if background != null: value += background["attributes"][attribute]
	write(("+" if value >= 0 else "") + str(roundi(value)) if rounded else str(value), "Red" if value < 0 else ("Green" if value > 0 else "Gray"))
# Prints a skill and it's value
func print_skill(skill : String, character, rounded : bool = true):
	write(skill + ": ")
	var value = character.get_skill(skill)
	write(("+" if value >= 0 else "") + str(roundi(value)) if rounded else str(value), "Red" if value < 0 else ("Green" if value > 0 else "Gray"))
# Prints a skill and it's value in character creation
func print_skill_raw(skill : String, race, background, rounded : bool = true):
	write(skill + ": ")
	var value : float = 0
	if race != null: value += race["skills"][skill]
	if background != null: value += background["skills"][skill]
	write(("+" if value >= 0 else "") + str(roundi(value)) if rounded else str(value), "Red" if value < 0 else ("Green" if value > 0 else "Gray"))
# Prints a slot of the equipment
func print_slot_raw(slot : String, race, background, rounded : bool = true):
	write(slot + ":")
	if background != null && background.has("equipment") && background["equipment"].has(slot):
		var item = get_item(background["equipment"][slot])
		if item.has("def_skill"):
			var def = item["def_skill"]
			write(" ")
			write(("+" if def >= 0 else "") + str(roundi(def)) if rounded else str(def), "Red" if def < 0 else ("Green" if def > 0 else "Gray"))
			write(" ")
			var dices = roundi(item["def_dice_count"])
			var sides = roundi(item["def_dice_sides"])
			write(str(dices) + "d" + str(sides))
		else:
			write("       ", "Gray")
		if item.has("att_skill"):
			var att = item["att_skill"]
			write(" ")
			write(("+" if att >= 0 else "") + str(roundi(att)) if rounded else str(att), "Red" if att < 0 else ("Green" if att > 0 else "Gray"))
			write(" ")
			var dices = roundi(item["att_dice_count"])
			var sides = roundi(item["att_dice_sides"])
			write(str(dices) + "d" + str(sides))
	else:
		write("")
# Prints a slot of the equipment
func print_accessory_raw(slot : int, race, background, rounded : bool = true):
	write("ACC: ")
	if background != null && background.has("accessories") && background["accessories"].size() > slot:
		var item = get_item(background["accessories"][slot])
		write(item["name"])
	else:
		write("")
func print_stats(character, rounded : bool = true):
	set_cursor_xy(0, 15)
	write("-".repeat(80))
	set_cursor_x(1)
	modify_cursor_y(1)
	write("Attributes")
	set_cursor_x(0)
	modify_cursor_y(1)
	write("-".repeat(80))
	set_cursor_x(1)
	modify_cursor_y(1)
	print_attribute("SIZ", character, rounded)
	set_cursor_x(1)
	modify_cursor_y(1)
	print_attribute("VIT", character, rounded)
	set_cursor_x(1)
	modify_cursor_y(1)
	print_attribute("STR", character, rounded)
	set_cursor_x(1)
	modify_cursor_y(1)
	print_attribute("SPE", character, rounded)
	set_cursor_xy(17, 16)
	write("Body Skills")
	set_cursor_x(17)
	modify_cursor_y(2)
	print_skill("ATT", character, rounded)
	set_cursor_x(17)
	modify_cursor_y(1)
	print_skill("DEF", character, rounded)
	set_cursor_x(17)
	modify_cursor_y(1)
	print_skill("PRE", character, rounded)
	set_cursor_xy(33, 16)
	write("Mind Skills")
	set_cursor_x(33)
	modify_cursor_y(2)
	print_skill("CHA", character, rounded)
	set_cursor_x(33)
	modify_cursor_y(1)
	print_skill("NAT", character, rounded)
	set_cursor_x(33)
	modify_cursor_y(1)
	print_skill("SOR", character, rounded)
	set_cursor_xy(49, 16)
	write("Soul Skills")
	set_cursor_x(49)
	modify_cursor_y(2)
	print_skill("LIF", character, rounded)
	set_cursor_x(49)
	modify_cursor_y(1)
	print_skill("DEA", character, rounded)
	set_cursor_x(49)
	modify_cursor_y(1)
	print_skill("BLO", character, rounded)
func print_stats_raw(race, background, just_first_page : bool = true, rounded : bool = true):
	set_cursor_xy(0, 15)
	write("-".repeat(80))
	if just_first_page || not tab_swap:
		set_cursor_x(1)
		modify_cursor_y(1)
		write("Attributes")
		set_cursor_x(0)
		modify_cursor_y(1)
		write("-".repeat(80))
		set_cursor_x(1)
		modify_cursor_y(1)
		print_attribute_raw("SIZ", race, background, rounded)
		set_cursor_x(1)
		modify_cursor_y(1)
		print_attribute_raw("VIT", race, background, rounded)
		set_cursor_x(1)
		modify_cursor_y(1)
		print_attribute_raw("STR", race, background, rounded)
		set_cursor_x(1)
		modify_cursor_y(1)
		print_attribute_raw("SPE", race, background, rounded)
		set_cursor_xy(17, 16)
		write("Body Skills")
		set_cursor_x(17)
		modify_cursor_y(2)
		print_skill_raw("ATT", race, background, rounded)
		set_cursor_x(17)
		modify_cursor_y(1)
		print_skill_raw("DEF", race, background, rounded)
		set_cursor_x(17)
		modify_cursor_y(1)
		print_skill_raw("PRE", race, background, rounded)
		set_cursor_xy(33, 16)
		write("Mind Skills")
		set_cursor_x(33)
		modify_cursor_y(2)
		print_skill_raw("CHA", race, background, rounded)
		set_cursor_x(33)
		modify_cursor_y(1)
		print_skill_raw("NAT", race, background, rounded)
		set_cursor_x(33)
		modify_cursor_y(1)
		print_skill_raw("SOR", race, background, rounded)
		set_cursor_xy(49, 16)
		write("Soul Skills")
		set_cursor_x(49)
		modify_cursor_y(2)
		print_skill_raw("LIF", race, background, rounded)
		set_cursor_x(49)
		modify_cursor_y(1)
		print_skill_raw("DEA", race, background, rounded)
		set_cursor_x(49)
		modify_cursor_y(1)
		print_skill_raw("BLO", race, background, rounded)
	elif tab_swap:
		set_cursor_x(1)
		modify_cursor_y(1)
		write("Armor")
		modify_cursor_x(1)
		write("D PRT", "DimGray")
		set_cursor_x(0)
		modify_cursor_y(1)
		write("-".repeat(80))
		set_cursor_x(1)
		modify_cursor_y(1)
		print_slot_raw("HEA", race, background, rounded)
		set_cursor_x(1)
		modify_cursor_y(1)
		print_slot_raw("CHE", race, background, rounded)
		set_cursor_x(1)
		modify_cursor_y(1)
		print_slot_raw("HAN", race, background, rounded)
		set_cursor_x(1)
		modify_cursor_y(1)
		print_slot_raw("LEG", race, background, rounded)
		set_cursor_xy(17, 16)
		write("Arms")
		modify_cursor_x(2)
		write("D PRT  A DMG", "DimGray")
		set_cursor_x(17)
		modify_cursor_y(2)
		print_slot_raw("MAI", race, background, rounded)
		set_cursor_x(17)
		modify_cursor_y(1)
		print_slot_raw("OFF", race, background, rounded)
		set_cursor_x(17)
		modify_cursor_y(1)
		print_slot_raw("RAN", race, background, rounded)
		set_cursor_xy(49, 16)
		write("Accessories")
		set_cursor_x(49)
		modify_cursor_y(2)
		print_accessory_raw(0, race, background, rounded)
		set_cursor_x(49)
		modify_cursor_y(1)
		print_accessory_raw(1, race, background, rounded)
		set_cursor_x(49)
		modify_cursor_y(1)
		print_accessory_raw(2, race, background, rounded)
	if not just_first_page:
		set_cursor_xy(65, 16)
		write("TAB 2/2" if tab_swap else "TAB 1/2", "White")
#endregion

#region scene_management
# Currently active scene
var current_scene : Script
# Changes the scene to a different one
func set_scene(screen : String, load_selection : bool = false):
	# When loading a saved selection; use the screen filter
	#if load_selection: filter.clear()
	# Save selection for the future prospects
	# if we have a scene already active, the only moment we don't
	# is the start of the game when we set the first scene
	if current_scene != null: current_scene.saved_selection = selection
	# Change the scene to a new one
	var new_scene = load("res://scenes/" + screen + ".gd")
	# Change the scene to a new one if it was successfuly loaded
	if new_scene != null: current_scene = new_scene
	# Reset selection to avoid any weird selection persisting between scenes
	# and potentially load the old selection that was saved in this scene before
	selection = Vector2i(-1, -1) if not load_selection else current_scene.saved_selection
# Draws the current scene
func draw_scene():
	clear_screen()
	current_scene.draw_scene()
	# Hookup to the most top-left selectable that is available
	# in the scene if the selection is out of bounds
	if selection == Vector2i(-1, -1) && selectables.size() > 0:
		var temp = selectables
		temp.sort_custom(func(a, b): return a[0] < b[0])
		selection = temp[0][0]
		draw_scene()
# Current action that will be called on pressing a return key
var current_return_action : Callable
# Changes the return key action
func set_return_action(action : Callable):
	current_return_action = action
#endregion
