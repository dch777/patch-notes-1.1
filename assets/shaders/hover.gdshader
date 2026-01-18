shader_type canvas_item;

uniform sampler2D canvas: filter_nearest;
uniform vec2 map_origin;
uniform vec2 global_pos_size;

varying flat vec2 vertex_pos;
varying flat vec2 map_pos;
varying flat vec2 global_pos;
//uniform ivec2 highlighted_cell;
//uniform float reachable;

float within(vec2 pos) {
	float within_x = step(pos.x, vertex_pos.x + 20.0) * step(vertex_pos.x + 12.0, pos.x);
	float within_y = step(pos.y, vertex_pos.y + 20.0) * step(vertex_pos.y + 12.0, pos.y);

	return within_x * within_y;
}

vec2 get_global_pos(vec2 pos) {
	//vec2 local_pos = vec2((pos.x + 0.5) / global_pos_size.x, (pos.y + 0.5) / global_pos_size.y);
	//return texture(global_pos_texture, local_pos).xy;
	//return texelFetch(global_pos_texture, pos, 0).xy;
	return vec2(16.0 * pos.x + 16.0 * pos.y + 16.0, -8.0 * pos.x + 8.0 * pos.y + 8.0);
}

vec4 sample(sampler2D tex, vec2 pos) {
	vec2 local_pos = vec2((pos.x + 0.5) / global_pos_size.x, (pos.y + 0.5) / global_pos_size.y);
	return texture(tex, local_pos);
	//return texelFetch(tex, ivec2(pos), 0);
}

void vertex() {
	vertex_pos = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
	map_pos = vec2(round(vertex_pos.x / 32.0 - vertex_pos.y / 16.0 - 0.5), round(vertex_pos.x / 32.0 + vertex_pos.y / 16.0 + 0.5));
	global_pos = get_global_pos(map_pos);
}

void fragment() {
	//vec2 global_pos = get_global_pos(highlighted_cell);
	float selected = within(global_pos);
	float intensity = 0.1 * (sin(PI * TIME) + 2.0);

	vec4 texture_color = texture(TEXTURE, UV);
	vec4 canvas_color = sample(canvas, map_pos - map_origin);
	//COLOR.rg = (map_pos - map_origin) / 10.0;
	COLOR = mix(texture_color, canvas_color, canvas_color.a * intensity * selected);
	COLOR.a = texture_color.a;
}