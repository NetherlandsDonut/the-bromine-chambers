extends Node2D

# Initialises the game
func _ready():
	#region settings
	if globals.settings == null:
		globals.settings = {}
	if not globals.settings.has("max_window_scale"):
		globals.settings["interface_font"] = 1
	elif globals.settings["interface_font"] > 1:
		globals.settings["interface_font"] = 1
	elif globals.settings["interface_font"] < 0:
		globals.settings["interface_font"] = 0
	if not globals.settings.has("max_window_scale"):
		globals.settings["color_saturation"] = 1
	elif globals.settings["color_saturation"] > 3:
		globals.settings["color_saturation"] = 3
	elif globals.settings["color_saturation"] < 0:
		globals.settings["color_saturation"] = 0
	if not globals.settings.has("max_window_scale"):
		globals.settings["max_window_scale"] = 2
	elif globals.settings["max_window_scale"] > 4:
		globals.settings["max_window_scale"] = 4
	elif globals.settings["max_window_scale"] < 1:
		globals.settings["max_window_scale"] = 1
	if not globals.settings.has("effects_volume"):
		globals.settings["effects_volume"] = 0
	elif globals.settings["effects_volume"] > 100:
		globals.settings["effects_volume"] = 100
	elif globals.settings["effects_volume"] < 0:
		globals.settings["effects_volume"] = 0
	if not globals.settings.has("music_volume"):
		globals.settings["music_volume"] = 0
	elif globals.settings["music_volume"] > 100:
		globals.settings["music_volume"] = 100
	elif globals.settings["music_volume"] < 0:
		globals.settings["music_volume"] = 0
	#endregion
	AudioServer.set_bus_layout(preload("res://other/default_bus_layout.tres"))
	globals.stream_effects = AudioStreamPlayer.new()
	globals.stream_effects.bus = "Effects"
	globals.fade_bus_to("Effects", globals.settings["effects_volume"], 0.1)
	add_child(globals.stream_effects)
	globals.stream_music_a = AudioStreamPlayer.new()
	globals.stream_music_b = AudioStreamPlayer.new()
	globals.stream_music_a.bus = "Music"
	globals.stream_music_b.bus = "Music"
	globals.fade_bus_to("Music", globals.settings["music_volume"], 0.1)
	add_child(globals.stream_music_a)
	add_child(globals.stream_music_b)
	globals.play_music(true)
	generate_screen()
	globals.set_scene("scene_menu_a")
	globals.draw_scene()

# When music is close to being finished queue another track
func _process(_delta):
	if globals.stream_music_a.playing && globals.stream_music_a.get_playback_position() > globals.stream_music_a.stream.get_length() - 5.333:
		globals.play_music()
	elif globals.stream_music_b.playing && globals.stream_music_b.get_playback_position() > globals.stream_music_b.stream.get_length() - 5.333:
		globals.play_music()

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
