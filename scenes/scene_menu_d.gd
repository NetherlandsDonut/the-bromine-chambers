extends Node

# Saved selection for this scene
static var saved_selection : Vector2i = Vector2i(-1, -1)

# Draws the scene
static func draw_scene():
	globals.set_return_action(func():
		if globals.savegame != null: globals.set_scene("scene_menu_c", true)
		else: globals.set_scene("scene_menu_a", true)
	)
	globals.set_cursor_x(1)
	globals.write("These are the game settings, you can modify them freely.", "Yellow")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write("Setting")
	globals.set_cursor_x(33)
	globals.write("Value")
	globals.set_cursor_x(0)
	globals.modify_cursor_y(1)
	globals.write("-".repeat(80))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		if globals.settings["interface_font"] <= 0: globals.settings["interface_font"] = 1
		elif globals.settings["interface_font"] >= 1: globals.settings["interface_font"] = 0
		globals.save_file(globals.settings, "Settings", "settings")
	)
	globals.write("Interface font")
	globals.set_cursor_x(33)
	globals.write("IBM VGA" if globals.settings["interface_font"] == 0 else ("Toshiba Sat" if globals.settings["interface_font"] == 1 else ("IBM BIOS" if globals.settings["interface_font"] == 2 else "IBM CGA Thin")))
	globals.set_cursor_x(1)
	globals.modify_cursor_y(1)
	globals.write_selectable(func():
		if globals.settings["color_saturation"] <= 0: globals.settings["color_saturation"] = 1
		elif globals.settings["color_saturation"] == 1: globals.settings["color_saturation"] = 2
		elif globals.settings["color_saturation"] >= 2: globals.settings["color_saturation"] = 0
		globals.save_file(globals.settings, "Settings", "settings")
	)
	globals.write("Color saturation")
	globals.set_cursor_x(33)
	globals.write("Medium" if globals.settings["color_saturation"] == 1 else ("High" if globals.settings["color_saturation"] == 2 else "Low"))
	globals.set_cursor_xy(59, 21)
	globals.write("a game by Eerie/Luna", "DarkGray")
