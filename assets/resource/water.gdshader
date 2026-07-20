shader_type spatial;
render_mode specular_toon;

uniform sampler2D albedo_texture;
uniform float height_scale = 0.5;
uniform sampler2D noise;
uniform sampler2D normalmap;

varying vec2 tex_position;

void vertex() {
  tex_position = (VERTEX.xz / 2.0 + 0.5) + tan(TIME * 0.0005);
  float height = texture(noise, tex_position).x;
  VERTEX.y += height * height_scale;
}

void fragment() {
	METALLIC = 0.0;
 	ROUGHNESS = 0.01;
	NORMAL_MAP = texture(normalmap, (tex_position * 25.0) + (TIME * 0.005)).xyz;
	ALBEDO = texture(albedo_texture, (UV * 5.0) + (TIME * 0.005)).xyz;
}