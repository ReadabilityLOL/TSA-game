shader_type spatial;
uniform sampler2D _albedo: source_color;


uniform mat4 cutplane;
varying vec3 wvtx;

void vertex() {
	wvtx = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;
	
}

void fragment() {
	
	vec3 planeNormal = normalize(cutplane[2].xyz);
	float planeDistance = dot(planeNormal,cutplane[3].xyz);
	float vertexDistance = dot(planeNormal, wvtx);
	float dist = vertexDistance - planeDistance;
	
	if (dist < 0.0) discard;
	
	ALBEDO = texture(_albedo, UV).rgb;
	
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
