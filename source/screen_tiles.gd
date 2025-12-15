extends Node2D

# Initialises the game
func _ready():
	if globals.settings == null:
		globals.settings = { "interface_font": 1, "color_saturation": 1 }
	generate_screen()
	globals.set_scene("scene_menu_a")
	globals.draw_scene()

# Generates the tiles on the screen
func generate_screen():
	for j in range(globals.screen_size[globals.settings["interface_font"]].y):
		globals.tiles.append([])
		for i in range(globals.screen_size[globals.settings["interface_font"]].x):
			var tile = Polygon2D.new()
			tile.color.a = 0
			tile.polygon = PackedVector2Array([
				Vector2(globals.tile_size[globals.settings["interface_font"]].x / -2, globals.tile_size[globals.settings["interface_font"]].y / -2),
				Vector2(globals.tile_size[globals.settings["interface_font"]].x / 2, globals.tile_size[globals.settings["interface_font"]].y / -2),
				Vector2(globals.tile_size[globals.settings["interface_font"]].x / 2, globals.tile_size[globals.settings["interface_font"]].y / 2),
				Vector2(globals.tile_size[globals.settings["interface_font"]].x / -2, globals.tile_size[globals.settings["interface_font"]].y / 2)
			])
			tile.position = Vector2(i * globals.tile_spacing[globals.settings["interface_font"]].x - globals.screen_size[globals.settings["interface_font"]].x / 2 * globals.tile_spacing[globals.settings["interface_font"]].x + globals.tile_spacing[globals.settings["interface_font"]].x / 2, (j + 1) * globals.tile_spacing[globals.settings["interface_font"]].y - globals.screen_size[globals.settings["interface_font"]].y / 2 * globals.tile_spacing[globals.settings["interface_font"]].y - globals.tile_spacing[globals.settings["interface_font"]].y / 2)
			tile.set_script(load("res://source/tile.gd"))
			var tile_fore = Sprite2D.new()
			var tile_back = Sprite2D.new()
			tile_fore.z_index = 1
			tile_fore.texture_filter = TEXTURE_FILTER_NEAREST
			tile_back.texture_filter = TEXTURE_FILTER_NEAREST
			tile_fore.material = ShaderMaterial.new()
			tile_back.material = ShaderMaterial.new()
			globals.tiles[globals.tiles.size() - 1].append([tile, tile_fore, tile_back])
			tile.add_child(tile_fore)
			tile.add_child(tile_back)
			tile_back.position = Vector2(1, 1)
			add_child(tile)
