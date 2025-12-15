extends Polygon2D

## Checks whether cursor is hovering over this tile
## If such a thing happens, the shader is modified to resemble that
#func _input(event):
	#if is_visible_in_tree():
		#if event.as_text().contains("Mouse motion at position"):
			#var is_hovered_over = Geometry2D.is_point_in_polygon(to_local(event.position), polygon)
			#if is_hovered_over:
				#_highlight()
#
#func _highlight():
	#var children = get_children()
	#Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	#for foo in children:
		#foo.material.shader = load("res://other/highlight.gdshader")
#
#func _unhighlight():
	#var children = get_children()
	#Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	#for foo in children:
		#foo.material.shader = null
