extends SubViewportContainer

func _process(_delta):
	if Input.is_action_pressed("ui_toggle_fullscreen"):
		var mode = DisplayServer.window_get_mode()
		var is_window = mode != DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)
	var resolution = get_viewport().get_visible_rect().size
	scale.y = int(resolution.y / size.y)
	scale.x = scale.y
	while scale.y > 1 && scale.y > globals.settings["max_window_scale"]:
		scale.x -= 1
		scale.y -= 1
	position.x = resolution.x / 2 - size.x / 2
	position.y = resolution.y / 2 - size.y / 2
