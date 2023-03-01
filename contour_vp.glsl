varying vec3 normal, lightDir, eyeVec;
varying float render;

void main() {
	normal = gl_NormalMatrix * gl_Normal;

	vec3 position = gl_ModelViewMatrix * gl_Vertex;

	lightDir = gl_LightSource[0].position.xyz - position;
	eyeVec = -position;

	gl_Position = ftransform();	
	
	render = 1;
	if (dot(normalize(normal), normalize(eyeVec)) < 0.3) {
		render = 0;
	}
}