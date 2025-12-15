shader_type canvas_item;

const vec2[4] DIRECTIONS = {
	vec2(1.0, 0.0),
	vec2(0.0, 1.0),
	vec2(-1.0, 0.0),
	vec2(0.0, -1.0)
};

float gtz(float input) { return max(0, sign(input)); }

float check(sampler2D tex, vec2 from, vec2 size) {
	float result = 0.0;
	for (int i = 0; i < 4; i++) {
		result += texture(tex, from + DIRECTIONS[i] * size).a;
	}
	return gtz(result);
}

void fragment() {
	vec4 original = texture(TEXTURE, UV) * COLOR;
	vec4 base = vec4(0.0, 0.0, 0.0, original.a);
	vec4 outline_color = vec4(original.rgb, 1.0);
	COLOR = mix(base, outline_color, check(TEXTURE, UV, TEXTURE_PIXEL_SIZE) * (1.0 - gtz(original.a)));
}