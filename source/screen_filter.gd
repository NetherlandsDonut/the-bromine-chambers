extends ColorRect

var clear_material: ShaderMaterial
var blackout_material: ShaderMaterial

func _ready():
	globals.filter = self
	# Shader for the flood fill
	#var blackout_code = "
		#shader_type canvas_item;
		#uniform float threshold = 0.0;
		#float random(vec2 p) {
			#return fract(1e4 * sin(17.0 * p.x + 0.1 * p.y) * (0.1 + abs(sin(13.0 * p.y + p.x))));
		#}
		#void fragment() {
			#float n = random(UV * 1000.0);
			#if (n < threshold) COLOR = vec4(0.0, 0.0, 0.0, 1.0);
			#else COLOR = vec4(0.0, 0.0, 0.0, 0.0);
		#}
	#"
	var blackout_code = "
		shader_type canvas_item;
		uniform float threshold : hint_range(0.0, 1.0) = 0.0;
		uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
		float random(vec2 p) {
		    return fract(1e4 * sin(17.0 * p.x + 0.1 * p.y) * (0.1 + abs(sin(13.0 * p.y + p.x))));
		}
		void fragment() {
		    float border_dist = min(min(UV.x, 1.0 - UV.x), min(UV.y, 1.0 - UV.y));
		    float wipe_edge = threshold * 0.5;
		    float noise = random(UV * 500.0);
		    float noisy_edge = wipe_edge + (noise - 0.5) * 0.1; 
		    if (border_dist < noisy_edge) {
		        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
		    } else {
		        COLOR = texture(SCREEN_TEXTURE, UV);
		    }
		}
	"
	blackout_material = ShaderMaterial.new()
	blackout_material.shader = Shader.new()
	blackout_material.shader.code = blackout_code
	var clear_code = "
		shader_type canvas_item;
		uniform float threshold = 0.0;
		uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
		float random(vec2 p) {
			return fract(1e4 * sin(17.0 * p.x + 0.1 * p.y) * (0.1 + abs(sin(13.0 * p.y + p.x))));
		}
		void fragment() {
			float n = random(UV * 1000.0);
			if (n < threshold) {
		        COLOR = texture(SCREEN_TEXTURE, UV);
			}
			else COLOR = vec4(0.0, 0.0, 0.0, 1.0);
		}
	"
	#var clear_code = "
		#shader_type canvas_item;
		#uniform float threshold : hint_range(0.0, 1.0) = 0.0;
		#float random(vec2 p) {
			#return fract(1e4 * sin(17.0 * p.x + 0.1 * p.y) * (0.1 + abs(sin(13.0 * p.y + p.x))));
		#}
		#void fragment() {
			#float center_dist = max(abs(UV.x - 0.5), abs(UV.y - 0.5));
			#float wipe_radius = threshold * 0.5;
			#float noise = random(UV * 500.0);
			#float noisy_radius = wipe_radius + (noise - 0.5) * 0.1;
			#if (center_dist < noisy_radius) {
				#COLOR = vec4(0.0, 0.0, 0.0, 0.0);
			#} else {
				#COLOR = vec4(0.0, 0.0, 0.0, 1.0);
			#}
		#}
	#"
	clear_material = ShaderMaterial.new()
	clear_material.shader = Shader.new()
	clear_material.shader.code = clear_code
	clear()


func fade_to_black():
	material = blackout_material
	var time = 0.0
	while time < 1.3:
		var t = time / 1.0
		blackout_material.set_shader_parameter("threshold", t)
		await get_tree().process_frame
		time += get_process_delta_time()
	blackout_material.set_shader_parameter("threshold", 1.1)
	ResourceLoader.load_threaded_request("res://Scenes/Main.tscn")
	while ResourceLoader.load_threaded_get_status("res://Scenes/Main.tscn") == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		await get_tree().process_frame
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get("res://Scenes/Main.tscn"))
	
func clear():
	material = clear_material
	var time = 0.0
	while time < 0.2:
		var t = time / 0.2
		clear_material.set_shader_parameter("threshold", t)
		await get_tree().process_frame
		time += get_process_delta_time()
	clear_material.set_shader_parameter("threshold", 1.1)
