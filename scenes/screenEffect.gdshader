shader_type canvas_item;
render_mode unshaded, skip_vertex_transform;
const float curvature = 7.0;
const float vignette_mult = 0.15;
uniform sampler2D screentext : hint_screen_texture;

void fragment() {
	vec2 centeredUV = SCREEN_UV * 2.0 - 1.0;
	vec2 offsetUV = centeredUV.yx / curvature;
	vec2 warpedUV = centeredUV + centeredUV * offsetUV * offsetUV;
	vec3 cutoff = vec3(step(abs(warpedUV.x), 1.0) * step(abs(warpedUV.y), 1.0));
	vec3 scanlines = vec3(sin(warpedUV.y * 720.0)) * 0.15 + 0.85;
	vec3 vignette = vec3(length(pow(abs(centeredUV),vec2(4.0)))/3.0);
	vec3 screencolor =  texture(screentext, (warpedUV + 1.0)/2.0).rgb * cutoff * scanlines;
	screencolor = screencolor - vignette * vignette_mult;
	COLOR = vec4(screencolor, 1);
}
